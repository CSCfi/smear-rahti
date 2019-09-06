package fi.csc.avaa.smear;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Luokitellaan tuulensuunnst 16 luokkaan ja piirretään kauanko kustakin suunnasta on tuullut.
 *
 * Luultavasti kannattaa sijoittaa cachen sisälle että lasketaan vain kerran
 *
 * @author pj
 *
 */

public class Windrose {

    public static final String[] ILMANSUUNNAT = {"N", "NNE", "NE", "ENE", "E", "ESE","SE", "SSE",
		"S","SSW", "SW", "WSW", "W", "WNW", "NW",  "NNW"};
	private static final int LUOKAT = 16;
	private static final float JAKAJA = 22.5f; // 360/16
    private static final Logger log = LoggerFactory.getLogger(Windrose.class);

    public static String getJson(float[][] fa) {
        int[] luokitteluh = new int[LUOKAT];
        int[] luokitteluk = new int[LUOKAT];
        int[] luokitteluv = new int[LUOKAT];
		/*int[] prosentith; //= new int[LUOKAT];
		int[] prosentitk; //= new int[LUOKAT];
		int[] prosentitv; //= new int[LUOKAT];*/

		for (int i= 0; i < fa.length; i++) {
		    luokitteluh[tarkistaluokka((int)Math.floor(fa[i][Data.HYYTIÄLÄ]/JAKAJA))]++;
		    luokitteluk[tarkistaluokka((int)Math.floor(fa[i][Data.KUMPULA]/JAKAJA))]++;
		    luokitteluv[tarkistaluokka((int)Math.floor(fa[i][Data.VÄRRIÖ]/JAKAJA))]++;
        }
		var prosentith = muutaprosenteiksi(luokitteluh);
		var prosentitk = muutaprosenteiksi(luokitteluk);
		var prosentitv = muutaprosenteiksi(luokitteluv);
        return JsonWriter.windrose(prosentith, prosentitk, prosentitv);
    }

    private static int[] muutaprosenteiksi(int[] luokittelu) {
        int[] prosentit = new int[LUOKAT];
			int sum = 0;
			for (int i = 0; i < LUOKAT; i++) {
				sum += luokittelu[i];
			}
			for (int i = 0; i < LUOKAT; i++) {
				prosentit[i] = 100*luokittelu[i]/sum; 	//lasketaan prosentit
			}
		return prosentit;
    }

    /**
	     * Siivoaa tapaukset, joissa tuuli ei osunut luokitteluun
	     * Pohjoistuuli, 360 astetta = 0 astetta, joksi muunnamme sen.
	     *
	     * @param luokka int
	     * @return luokka int
	     */
    private static int tarkistaluokka(int luokka) {
        if (LUOKAT == luokka) {
				luokka = 0;
				return luokka;
			}
	    	if ((luokka <= -LUOKAT ) || luokka > LUOKAT ) {
	    		luokka = luokka % LUOKAT; // jakojäännös
	    		log.warn("Tuulen suunta ei ollut 0- ja 360-asteen välillä");
	    		// tässä ei ole return, koska seuraavakin täytyy tarkistaa
	    	}
	    	if (luokka < 0) { // tämä ehto toimii yhdessä edellisen kanssa
	    		luokka +=  LUOKAT; // tulkitaan -10 astetta = 350 astetta
	    		log.warn("Tuulen suunta negatiivinen");
	    	}
	    	return luokka;
    }


}
