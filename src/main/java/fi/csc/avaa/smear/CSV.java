package fi.csc.avaa.smear;

import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;

/**
 * Format data to CSV (Comma Separated Values)
 */
public class CSV {
    public static final String COMMA = ",";
    public static final String LM = "\"";
    public final static String HYYTIÄLÄ = "Hyytiälä";
    public final static String KUMPULA = "Kumpula";
    public final static String VÄRRIÖ = "Värriö";
    public final static int NO = 0; //typpimono-oksidi
    public final static int RH = 1; //relative humidity
    public final static int GLOB = 2; //Global shortwave radiation
    public final static int TS = 3; //Soil temperature
    public final static int CO2 = 4; //carbondioxidi
    public final static int SO2 = 5; //rikkidioxidi
    public final static int NOX = 6; //typenoxidit
    public final static int FLUX = 7; //CO2
    public final static int ET = 8; //Evapotranspiration
    public final static int T = 9; //Temperature 15-16m
    public final static int WS = 10; //Windspeed 15-16m
    public final static int P = 11; //Air pressure
    public final static int O3 = 12; //Ozone
    public final static int TAC = 13; //Total aerosol concentration
    public final static int HALFHOUR = 30; //30min
    static final DateTimeFormatter sdf = DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");

    /**
     * Combine data from two stations to CSV, which should be Highcharts compatible
     *
     * @param tsa1 Timestamp[]  from station1
     * @param tsa1 Timestamp[] from station2
     * @param fa1  float[] from station1
     * @param fa2  float[] from station2
     * @return String CSV-file to return
     */
    public static String toCSV(int eka, Timestamp[] tsa1, Timestamp[] tsa2, float[] fa1, float[] fa2) {
        var sb = new StringBuilder();
        sb.append(LM);
        sb.append("Time");
        sb.append(LM + COMMA + LM);
        if (Data.HYYTIÄLÄ == eka) {
            sb.append(HYYTIÄLÄ);
        } else {
            sb.append(KUMPULA);
        }
        sb.append(LM + COMMA + LM);
        sb.append(VÄRRIÖ);
        sb.append(LM + "\n");
        try {
            if (tsa1.length == tsa2.length) {
                if (fa1.length == fa2.length && tsa1.length == fa1.length) {
                    boolean virhenäytetty = false;
                    int j = 0;
                    for (int i = 0; i < fa1.length - 1; i++) {
                        try {
                            sb.append(/*sdf.format(*/ tsa1[i].toString()/*.toInstant()*/);
                            sb.append(COMMA);
                            sb.append(nan(fa1[i]));
                            sb.append(COMMA);
                            sb.append(nan(fa2[i]));
                            sb.append("\n");
                        } catch (NullPointerException e) {
                            if (!virhenäytetty) {
                                System.err.println(eka + " NullPointerException i=" + i);
                                virhenäytetty = true;
                            }
                            j = i;
                        }
                    }
                    if (virhenäytetty) {
                        System.err.println("Viimeinen NullPointerException i=" + j);
                    }
                } else {
                    System.out.println("CSV fa lengths: " + tsa1.length + " " + fa2.length);
                }
            } else {
                System.out.println("CSV tsa lengths: " + tsa1.length + " " + tsa2.length);
            }
            return sb.toString();
        } catch (java.lang.NullPointerException n) {
            System.err.println("NullPointerException in CSV genaeration (because database timeout)");
            return sb.toString(); //to avoid crash hole server, but will crash client :-(
        }
    }

    public static String toCSV3(Timestamp[] tsa1, Timestamp[] tsa2, float[] fa1, float[] fa2, float[] fa3) {
        var sb = new StringBuilder();
        sb.append(LM);
        sb.append("Time");
        sb.append(LM + COMMA + LM);
        sb.append(HYYTIÄLÄ);
        sb.append(LM + COMMA + LM);
        sb.append(KUMPULA);

        sb.append(LM + COMMA + LM);
        sb.append(VÄRRIÖ);
        sb.append(LM + "\n");
        if (tsa1.length == tsa2.length) {
            if (fa1.length == fa2.length && fa1.length == fa3.length && tsa1.length == fa1.length) {
                tulostus3(sb, tsa1, fa1, fa2, fa3);
            } else { //different lengths like 23040/768 = 30
                int remainder;
                int max;
                if (tsa1.length > tsa2.length) {
                    remainder = tsa1.length % tsa2.length;
                    max = tsa1.length;
                } else {
                    remainder = tsa2.length % tsa1.length;
                    max = tsa2.length;
                }
                if (30 == remainder) {
                    int pitka = tsa1.length * HALFHOUR;
                    boolean virhenäytetty = false;
                    int j = 0;
                    for (int i = 0; i < tsa1.length - 1; i++) {
                        if (!(Float.isNaN(fa1[i]) && Float.isNaN(fa2[i]) && Float.isNaN(fa1[i])))
                            try {
                                sb.append(/*sdf.format(*/ tsa1[i].toString()/*.toInstant()*/);
                                sb.append(COMMA);
                                sb.append(nan(fa1[i]));
                                sb.append(COMMA);
                                sb.append(nan(fa2[i * HALFHOUR]));
                                sb.append(COMMA);
                                sb.append(nan(fa3[i * HALFHOUR]));
                                sb.append("\n");
                            } catch (NullPointerException e) {
                                if (!virhenäytetty) {
                                    System.err.println("NullPointerException3b i=" + i);
                                    virhenäytetty = true;
                                }
                                j = i;
                            }
                    }
                    if (virhenäytetty) {
                        System.err.println("Viimeinen NullPointerException3b i=" + j);
                    }
                    System.out.println("CSV3 fa1 length: " + fa1.length);
                    if (pitka != fa2.length || pitka != fa3.length)
                        System.out.println("CSV3 fa lengths: " + tsa1.length + " " + fa2.length + " " + fa3.length);
                } else { // remainder != 30
                    System.err.println("jakojäännös: " + remainder);
                    if (tsa1.length == max)
                        tulostus3(sb, tsa2, fa1, fa2, fa3);
                    else
                        tulostus3(sb, tsa1, fa1, fa2, fa3);
                }
            }
        } else {
            System.out.println("CSV3 tsa lengths: " + tsa1.length + " " + tsa2.length);
            if (tsa1.length > tsa2.length) {
            	tulostus3(sb, tsa2, fa1, fa2, fa3);
            }else {            
            	 tulostus3(sb, tsa1, fa1, fa2, fa3);
            }
            
        }
        return sb.toString();
    }

    private static String nan(float s) {
        if (Float.isNaN(s))
            return "";
        else
            return Float.toString(s);
    }

    private static void tulostus3(StringBuilder sb, Timestamp[] tsa, float[] fa1, float[] fa2, float[] fa3) {
        boolean virhenäytetty = false;
        int j = 0;
        for (int i = 0; i < tsa.length - 1; i++) {
        	try {
        		if (!(Float.isNaN(fa1[i]) && Float.isNaN(fa2[i]) && Float.isNaN(fa1[i])))
        			try {
        				sb.append(/*sdf.format(*/ tsa[i].toString()/*.toInstant()*/);
        				sb.append(COMMA);
        				sb.append(nan(fa1[i]));
        				sb.append(COMMA);
        				sb.append(nan(fa2[i]));
        				sb.append(COMMA);
        				sb.append(nan(fa3[i]));
        				sb.append("\n");
        			} catch (NullPointerException e) {
        				if (!virhenäytetty) {
        					System.err.println("NullPointerException3 i=" + i);
        					virhenäytetty = true;
        				}
        				j = i;
        			}
        	} catch (ArrayIndexOutOfBoundsException e) {
        		System.err.println("Taulukko loppui kierroksella: "+i);
        		break;
        	}
        }
        if (virhenäytetty) {
            System.err.println("Viimeinen NullPointerException3 i=" + j);
        }
    }
}
