/**
 * 
 */
package fi.csc.avaa.smear;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Deque;

/**
 * Vaikka ei liene sen turvattomampaa ottaa taulun nimi suoraan, kuin ottaa muuttujan nimi suoraan kyselystä,
 * tässä nyt yritetään käyttää yhteistä nimeämisskeemaa asemille. Huono puoli on että uusi asema vaatii lisäyksen koodiin,
 * samoin uusi taulutyppi.
 *
 * @author pj
 *
 */
public class ParameterParser {
	
	static final  String UNKNOWN = "UNKNOWN"; 
	static final  String META = "META";
	
	static final  DateTimeFormatter sdf =  DateTimeFormatter.ofPattern("uuuu-MM-dd HH:mm:ss");


    public Timestamp datetime(Deque<String> dt) {
		if (null == dt) return null;
		String f = dt.getFirst();
		if (null == f || f.isEmpty() || f.isBlank()) {
			System.err.println("Ei aikaa");
		} else {
				LocalDateTime d = LocalDateTime.parse(f, sdf);
				return Timestamp.valueOf(d);
		}
		return null;
	}

    /**
     * The request contains SMEAR station station names like Hyytiälä, Kumpula, Värriö and variables as path elements
     * which are combined to database tables and columns. There is 3 different request syntax: original, v2 and v3
     *
     * @param rpath String path of the HTTPS request
     * @return String[] 0 index is station and index 1 table [2 station, 3 variable...]
     */
	public String[] stationvariable(String rpath) {
		
		String[] dirs = rpath.substring(1).split("/");
		if (dirs[0].equals("v2")) {
			if (dirs.length < 4) {
				String[] sa = {"The right path is station1/variable1/station2/variable2."};
				return sa;
			}
			String[] sa = new String[4];
			System.err.println(dirs[0] + "-" + dirs[dirs.length - 1]);
			sa[0] = station(dirs[1]) + META;
			sa[1] = dirs[2];
			sa[2] = station(dirs[3]) + META;
			sa[3] = dirs[4];
			return sa;
		} else if (dirs[0].equals("v3")) {
			String[] sa = new String[1];
			sa[0] = dirs[1];
			return sa;
		} else {
			String[] sa = new String[2];
			sa[1] = dirs[dirs.length-1]; //variable
			sa[0] = station(dirs[0]) + table(dirs);
			return sa;
		}
	}

	/*public String variables(String path) {
	    System.out.println("Tehnen yksinkertaisen APIn: "+path);
	    return path;
    }*/

	private String table(String[] dirs) {
		if (3 == dirs.length) {
            return again(dirs[1]);
		} else { //4 == dirs.length
			switch (dirs[2]) {
				case "233":
					return "EDDY233";
				case "MAST":
					return "EDDYMAST";
				case "SUB":
					return "EDDYSUB";
				case "TOW":
					return "EDDYTOW";
				case "FLOW":
					return "TREEFLOW";
			}
            switch (dirs[1]) {
                case "1":
                    return "1_" + again(dirs[2]);
                case "2":
                    return "2_" + again(dirs[2]);
            }
		}
		return UNKNOWN;
	}

    private String again(String s) {
        switch (s) {
            case "meta":
                return META;
            case "eddy":
                return "EDDY";
            case "dmps":
                return "DMPS";
            case "dmpst":
                return "DMPST";
            case "aero":
                return "AERO";
            case "tree":
                return "TREE";
            case "aps":
                return "APS";
            case "augrea":
                return "AUG_REA";
            case "slow":
                return "SLOW";
            case "hourly":
                return "HOURLY";
            default:
                return s; //puijo
        }
    }

    private String station(String asema) {
        switch (asema) {
            case "hyytiälä":
            case "hyytiala":
                return "HYY_";
            case "kumpula":
                return "KUM_";
            case "värriö":
            case "varrio":
                return "VAR_";
            case "puijo":
                return "PUI_";
            case "erottaja":
                return "ERO_";
            case "torni":
                return "TOR_";
            case "siikaneva":
                return "SII";
            case "kuivajärvi":
            case "kuivajarvi":
                return "KJV_";
            case "dome":
                return "DOME_";
        }
        return UNKNOWN;
    }


    public boolean tree(String relativePath) {
        if (relativePath.startsWith("/tree"))
            return true;
        else
            return false;

    }

    public String saatavuus(String relativePath) {
        if (relativePath.startsWith("/saatavuus")) {
            String[] ta = relativePath.substring(1).split("/");
            if (ta.length > 1)
                return ta[1];
        }
        return "";

    }

    public Integer kl(Deque<String> avg) {
        if (null == avg) return null;
        String f = avg.getFirst();
        if (null == f || f.isEmpty() || f.isBlank()) {
            System.err.println("Ei keskiarvoa");
        } else {
            return Integer.parseInt(f);
        }
        return null;
    }

    public String merkkijono(Deque<String> s) {
        if (null == s) return null;
        String f = s.getFirst();
        if (null == f || f.isEmpty() || f.isBlank()) {
            System.err.println("variables nimisellä parametrillä EI arvoa, raportoi ParemeterParser");
        } else {
            return f;
        }
        return null;
    }
}
