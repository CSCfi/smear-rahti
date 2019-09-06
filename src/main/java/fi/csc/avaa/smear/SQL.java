/**
 * 
 */
package fi.csc.avaa.smear;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Arrays;

import static java.lang.Float.NaN;

/**
 * @author pj
 *
 */
public class SQL {

    // Keskiarvo ym. funktio tyypit
    public final static int NONE = 0;
    public final static int GEOM = 1;
    public final static int MEAN = 2;
    public final static int SUMM = 3;
    public static final int MEDIAN = 4;
    public static final int MIN = 5;
    public static final int MAX = 6;
    public final static String GEOMETRIC = "exp(avg(ln(";
    private final static String CS = " ";
    private final static String[] AVG = {CS, CS + GEOMETRIC, CS + "avg(", CS + "sum(", CS, CS + "min(", CS + "max("};
    private final static String[] LOPPUSULUT = {"", ")))", ")", ")", "", ")", ")"};
	public final static int TEMPERATURE = 0;
	public final static int AIRPRESSURE = 1;
	public final static int WINDSPEED = 2;
	public final static int DMPS = 17;
	private final static String SELECT = "SELECT samptime, ";
    private final static String SELECTV = "SELECT SAMPTIME, ";
	private final static String FROM = " FROM ";
	private final static String EHTO = " WHERE samptime > ? AND samptime < ?";
    private final static String EHTOV = " WHERE SAMPTIME > ? AND SAMPTIME < ?";
    private final static String GROUP = " GROUP BY floor(timestampdiff(minute, '1990-1-1', samptime) / ?)";
    private final static String HYY_META = "HYY_META"; //tables
    private final static String KUM_META = "KUM_META";
    private final static String VAR_META = "VAR_META";
    private final static String HYY_EDDYMAST = "HYY_EDDYMAST";
    private final static String KUM_EDDY = "KUM_EDDY";
    private final static String VAR_EDDY = "VAR_EDDY";
    final static String AA = "[";
    final static String AE = "]";

	DataSource db;

	public SQL(DataSource db) {
		this.db = db;
	}

    /**
     * Kysyy tietokannasta yhden muuttujan tietyltä ajanjaksolta ja mahdollisesti keskiarvoistaa sen.
     * Vastauksena palautetaan JSON merkkijono
     *
     * @param table    String tietokannan taulu
     * @param variable String muuttuja
     * @param from     Timestamp kyselyn rajauksen alkuaika
     * @param to       Timestamp kyselyn rajauksen loppuaika
     * @param avg      int keskiarvon laskenta ajan pituus minuutteina
     * @return String JSON Highchart data
     */
    public String query(String table, String variable, Timestamp from, Timestamp to, int avg, int funktio, int quality) {
        long alkuaika = System.currentTimeMillis();
        try {
            var connection = db.getConnection();
            PreparedStatement statement = null;
            var laatuEnd = "";
            var variablecase = variable;
            if (Saatavuus.QUALITYCHECKED == quality) {
                variablecase = "CASE WHEN " + variable + "_EMEP = 2 THEN " + variable + " ELSE NULL END";
                laatuEnd = " AS " + variable;
            }
            if (NONE == funktio || MEDIAN == funktio) {
                statement = connection.prepareStatement(
                        SELECT + variablecase + laatuEnd + FROM + table + EHTO);
            } else {
                statement = connection.prepareStatement(
                        SELECT + AVG[funktio] + variablecase + LOPPUSULUT[funktio] + laatuEnd + FROM + table + EHTO + GROUP);
                statement.setInt(3, avg);
            }
            statement.setTimestamp(1, from);
            statement.setTimestamp(2, to);
            StringBuilder sb = new StringBuilder();
            sb.append(AA);
            try (var resultSet = statement.executeQuery()) {
                if ((MEDIAN == funktio) && (avg > 1))
                    keskiarvota(resultSet, avg, sb);
                else {
                    while (resultSet.next()) {
                        float f = resultSet.getFloat(2);
                        if (!resultSet.wasNull()) {
                            sb.append(AA);
                            sb.append(resultSet.getTimestamp(1).getTime());
                            sb.append(CSV.COMMA);
                            sb.append(f);
                            sb.append(AE);
                            sb.append(CSV.COMMA);
                        }
                    }
                }
            }
            sb.deleteCharAt(sb.length() - 1); //CSV.COMMA
            sb.append(AE);
            System.out.println(variable + " loppuaika: " + (System.currentTimeMillis() - alkuaika));
            statement.close();
            connection.close();
            return sb.toString();
        } catch (SQLException e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    /**
     * Tämä koodi enimmäkseen kopiota "vanhasta" smartSMEAR koodista. Laskee mediaanin.
     *
     * @param resultSet ResultSet
     * @param avg       int laskenta-ajan pituus esim 30 tai 60 min
     * @param sb        StringBuilder tulos tallennetaan tänne
     */
    private void keskiarvota(ResultSet resultSet, int avg, StringBuilder sb) {
        int i = 0;
        try {
            resultSet.afterLast();
            int size = resultSet.getRow();
            float[] fa = new float[size];
            long[] la = new long[size];
            resultSet.beforeFirst();
            while (resultSet.next()) {
                la[i] = resultSet.getTimestamp(1).getTime();
                fa[i++] = resultSet.getFloat(2);
            }
            long interval = (la[1] - la[0]) / (1000 * 60);
            if (0 == interval) {
                System.err.println("interval aiheuttaa ongelmia: ");
            }
            int average = (int) (avg / interval);
            if (average > 1) {
                for (int k = 0; k + average < size; k = k + average) {
                    float a[] = new float[average];
                    int m = 0;
                    for (int j = k; j < k + average; j++) {
                        a[m++] = fa[j];
                    }
                    Arrays.sort(a);
                    float median_val;
                    if (a.length % 2 == 0) {
                        median_val = ((float) a[average / 2] + (float) a[(average / 2 - 1)]) / 2;
                    } else {
                        median_val = (float) a[average / 2];

                    }
                    sb.append(AA);
                    sb.append(la[k]);
                    sb.append(CSV.COMMA);
                    sb.append(median_val);
                    sb.append(AE);
                    sb.append(CSV.COMMA);
                }
            }
            resultSet.beforeFirst();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	/* NOT in use
	public String googlecharquery(String table, String variable, Timestamp from, Timestamp to) {
		try (var connection = db.getConnection();
			 var statement =
					 connection.prepareStatement(
							 SELECT + variable + FROM + table + EHTO)) {
			statement.setTimestamp(1, from);
			statement.setTimestamp(2, to);
			var jw = new JsonWriter(variable);
			try (var resultSet = statement.executeQuery()) {
				while (resultSet.next()) {
					jw.add(resultSet.getTimestamp(1), resultSet.getFloat(2));
				}
			}
			return jw.googlechart();
		} catch (SQLException e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
    */
	/**
	 * Temperature, Air pressure and windspeed query/ies target to 3 table
	 * Should test how this really should to: different queries to different tables or one query to 3 table
	 *
	 * @param from Timestamp minimum samptime
	 * @param to Timestamp maximum samptime
	 * @return String[] googlechart json
	 */
	public Data triquery(Timestamp from, Timestamp to) {
		String[] json = new String[3];
		float[][] fa = null;
		long alkuaika = System.currentTimeMillis();
		try {
			var connection = db.getConnection();
			var statement = connection.prepareStatement("SELECT h.samptime, "+
                    "h.T672, k.Tower_T_16m, v.TDRY0, h.WSU168, k.ws, v.WS0, h.Pamb0, k.p, v.P, h.WDU168, k.Tower_WDIR_32m, v.WDIR"
                    + FROM + HYY_META + " h, " + KUM_META + " k, " + VAR_META + " v WHERE h.samptime > ? AND h.samptime < ?" +
					"  AND h.samptime = k.samptime AND k.samptime = v.SAMPTIME");
			statement.setTimestamp(1, from);
			statement.setTimestamp(2, to);


			var jt = new JsonWriter("Temperature 15-16m");
			var jws = new JsonWriter("Windspeed 15-16m");
			var jp = new JsonWriter("Air pressure");
			try (var resultSet = statement.executeQuery()) {
				resultSet.afterLast();
				fa = new float[resultSet.getRow()][3];
				int i = 0;
				resultSet.beforeFirst();
				while (resultSet.next()) {
					jt.add(resultSet.getTimestamp(1), resultSet.getFloat(2), resultSet.getFloat(3), resultSet.getFloat(4));
					jws.add(resultSet.getTimestamp(1), resultSet.getFloat(5), resultSet.getFloat(6), resultSet.getFloat(7));
					jp.add(resultSet.getTimestamp(1), resultSet.getFloat(8), resultSet.getFloat(9), resultSet.getFloat(10));
					fa[i][Data.HYYTIÄLÄ] =  resultSet.getFloat(11);
					fa[i][Data.KUMPULA] =  resultSet.getFloat(12);
					fa[i++][Data.VÄRRIÖ] =  resultSet.getFloat(13);
				}
			}
			json[TEMPERATURE] = jt.googlechart(TEMPERATURE);
			json[AIRPRESSURE] = jp.googlechart(AIRPRESSURE);
			json[WINDSPEED] = jws.googlechart(WINDSPEED);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("triquery time: " + (System.currentTimeMillis()-alkuaika));
		return new Data(json, fa);
	}

	public String aerosolsize(Timestamp from, Timestamp to) {
		long alkuaika = System.currentTimeMillis();
		try {
			var connection = db.getConnection();
			var statement = connection.prepareStatement("SELECT * FROM HYY_DMPS " + EHTO);
			statement.setTimestamp(1, from);
			statement.setTimestamp(2, to);
			float[] fa = new float[50];
			try (var resultSet = statement.executeQuery()) {
			    int x = 0;
				while (resultSet.next()) {
					for (int i = DMPS; i < DMPS + fa.length; i++)
						fa[i - DMPS] = resultSet.getFloat(i);
                    JsonWriter.addAerosols(x++ /*resultSet.getTimestamp(1)*/, fa);
				}
			}
            connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println("aerosol time: " + (System.currentTimeMillis() - alkuaika));
		return JsonWriter.getAerosol();
	}

    public String[] csvs(Timestamp from, Timestamp to) {
        long alkuaika = System.currentTimeMillis();
        float[][] fah = null, fak = null, fav = null, fahe = null, fake = null, fave = null, faa = null;
        Timestamp[] tsah = null, tsak = null, tsav = null, tsahe = null, tsake = null, tsave = null, tsaa = null;
        QueryResult qr = null;
        try {
            var connection = db.getConnection();
            qr = arrayQuery("NO168, Glob67, tsoil_A, O3168, SO2168, NOx168, RH168, T672, WSU168, Pamb0, WDU168", 10,
                    HYY_META, EHTO, from, to, connection);
            fah = qr.faa;
            tsah = qr.tsa;

            System.out.println("csv väliaika: " + (System.currentTimeMillis() - alkuaika));
            qr = arrayQuery("rh, SO_2, NO_x, O_3, Tower_GLOB_32m, Tower_T_16m, ws, p, Tower_WDIR_32m, cn", 9,
                    KUM_META, EHTO, from, to, connection);
            fak = qr.faa;
            tsak = qr.tsa;

            qr = arrayQuery("NO_1, RH0, GLOB, ST, O3_1, NOX_1, TDRY0, WS0, P, WDIR, CPC1", 10, VAR_META, EHTOV, from, to, connection);
            fav = qr.faa;
            tsav = qr.tsa;

            qr = arrayQuery("av_c_270, F_c_270, E_270", 3, HYY_EDDYMAST, EHTO, from, to, connection);
            fahe = qr.faa;
            tsahe = qr.tsa;

            qr = arrayQuery("av_c, F_c, E", 3, KUM_EDDY, EHTO, from, to, connection);
            fake = qr.faa;
            tsake = qr.tsa;

            qr = arrayQuery("av_c, F_c, E", 3, VAR_EDDY, EHTO, from, to, connection);
            fave = qr.faa;
            tsave = qr.tsa;

            qr = arrayQuery("cn", 1,
                    "HYY_AERO", EHTO, from, to, connection);
            faa = qr.faa;
            tsaa = qr.tsa;
            System.out.println("csv väliaika2: " + (System.currentTimeMillis() - alkuaika));
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        // toCSV
        String[] sa = new String[14];
        sa[CSV.NO] = CSV.toCSV(Data.HYYTIÄLÄ, tsah, tsav, fah[0], fav[0]);
        sa[CSV.RH] = CSV.toCSV3(tsak, tsav, fah[6], fak[0], fav[1]);
        sa[CSV.GLOB] = CSV.toCSV3(tsah, tsav, fah[1], fak[4], fav[2]);
        sa[CSV.TS] = CSV.toCSV(Data.HYYTIÄLÄ, tsah, tsav, fah[2], fav[3]);
        sa[CSV.SO2] = CSV.toCSV(Data.HYYTIÄLÄ, tsah, tsak, fah[4], fak[1]);
        sa[CSV.CO2] = CSV.toCSV3(tsahe, tsave, fahe[0], fake[0], fave[0]);
        sa[CSV.NOX] = CSV.toCSV3(tsah, tsav, fah[5], fak[2], fav[5]);
        sa[CSV.FLUX] = CSV.toCSV3(tsahe, tsave, fahe[1], fake[1], fave[1]);
        sa[CSV.ET] = CSV.toCSV3(tsahe, tsave, fahe[2], fake[2], fave[2]);
        sa[CSV.T] = CSV.toCSV3(tsah, tsav, fah[7], fak[5], fav[6]);
        sa[CSV.WS] = CSV.toCSV3(tsah, tsav, fah[8], fak[6], fav[7]);
        sa[CSV.P] = CSV.toCSV3(tsah, tsav, fah[9], fak[7], fav[8]);
        sa[CSV.O3] = CSV.toCSV3(tsah, tsav, fah[3], fak[3], fav[4]);
        sa[CSV.TAC] = CSV.toCSV3(tsak, tsaa, faa[0], fak[8], fav[9]);
        System.out.println("csv loppuaika: " + (System.currentTimeMillis() - alkuaika));
        return sa;
    }

    /**
     * Kysyy tietokannasta listan muuttujia 3. parmetrina määritellystä taulusta tietyltä aikaväliltä
     *
     * @param query String comma separated veriable list
     * @param no    int number of veriables
     * @param table String table name
     * @param ehto  String " WHERE samptime > ? AND samptime < ?"
     * @param from  Timestamp begin time
     * @param to    Timestamp end time
     * @param conn  Connection
     * @return float[][]
     */
    private QueryResult arrayQuery(String query, int no, String table, String ehto, Timestamp from, Timestamp to, Connection conn) {
        float[][] faa = null;
        Timestamp[] tsa = null;
        try {
            var statement = conn.prepareStatement(SELECT + query + FROM + table + ehto);
            statement.setTimestamp(1, from);
            statement.setTimestamp(2, to);
            try (var resultSet = statement.executeQuery()) {
                resultSet.afterLast();
                if (resultSet.getRow() < 1) {
                    System.out.println("resultSet.getRow() < 1 : " + resultSet.getRow());
                }
                faa = new float[no][resultSet.getRow()];
                tsa = new Timestamp[resultSet.getRow()];
                int i = 0;
                resultSet.beforeFirst();
                //ResultSet.CONCUR_READ_ONLY
                while (resultSet.next()) {
                    tsa[i] = resultSet.getTimestamp(1);
                    for (int j = 0; j < no; j++) {
                        faa[j][i] = resultSet.getFloat(j + 2);
                        if (resultSet.wasNull()) {
                            faa[j][i] = NaN;
                        }

                    }
                    i++;
                }
            }
            statement.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new QueryResult(faa, tsa);
    }

}
