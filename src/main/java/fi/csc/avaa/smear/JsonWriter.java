/**
 * 
 */
package fi.csc.avaa.smear;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObject;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

//import java.util.stream.Stream;

/**
 * @author pj
 *
 */
public class JsonWriter {

	/*
	 * { "cols": [{"label": "Time",  "type": "datetime"},
         {"label": "glob",  "type": "number"},
         {"label": "muu",  "type": "number"}
  ],
  "rows": [{"c":[{"v": "Date(2019,0,27,0,01,0)"}, {"v": 0.139408},
             {"v": 0.33151}]},
         {"c":[{"v": "Date(2019,0,27,0,02,0)"}, {"v": -0.02874},
             {"v": 0.307805}]},

	 * 
	 */
	
	JsonArrayBuilder jab;
	static JsonArrayBuilder ab = Json.createArrayBuilder();
	String label;
	
	public JsonWriter(String label) {
		this.label = label;
		this.jab = Json.createArrayBuilder();
	}

	public String googlechart() {
		String json = Json.createObjectBuilder()
				.add("cols", Json.createArrayBuilder()
						.add(labeltype("Time", "datetime"))
						.add(labeltype(label, "number"))
						.build()
				)
				.add("rows", content())
				.build()
				.toString();
		return json;
	}

	/**
	 *
	 * @param i int NOT in use, just differ upper version without int
	 * @return String google chart json
	 */
	public String googlechart(int i) {
		String json = Json.createObjectBuilder()
				.add("cols", Json.createArrayBuilder()
						.add(labeltype("Time", "datetime"))
                        .add(labeltype(CSV.HYYTIÄLÄ, "number"))
                        .add(labeltype(CSV.KUMPULA, "number"))
                        .add(labeltype(CSV.VÄRRIÖ, "number"))
						.build()
				)
				.add("rows", content())
				.build()
				.toString();
		return json;
	}
	
	public void add(Timestamp samptime, float variable) {
			jab.add(Json.createObjectBuilder()
				.add("c", Json.createArrayBuilder()
						.add(vo1(samptime))
						.add(vo2(variable))
						.build())
				.build());

	}

	/**
	 * Triquery version of the add one time variables
	 *
	 * @param samptime Timestamp time
	 * @param v1 float Hyytiälä value
	 * @param v2 float Kumpula value
	 * @param v3 float Värriö value
	 */
	public void add(Timestamp samptime, float v1, float v2, float v3) {
			jab.add(Json.createObjectBuilder()
				.add("c", Json.createArrayBuilder()
						.add(vo1(samptime))
						.add(vo2(v1))
						.add(vo2(v2))
						.add(vo2(v3))
						.build())
				.build());

	}
	
	private JsonArray content() {	
		/*long now = System.currentTimeMillis();
		int lkm = fc.map(f -> mapper(jab, f)).mapToInt(Integer::intValue).sum();
		System.out.println(lkm+"kpl, ms/kpl: "+(System.currentTimeMillis()-now)/lkm); //irrelevant but mandatory or optimized away
		*/return jab.build();
	}



	JsonObject labeltype(String label, String type) {
	     return Json.createObjectBuilder()
			.add("label", label)
			.add("type", type)	
			.build();
	}
	
	JsonObject vo1(Date value) {
		LocalDateTime utc = value.toInstant().atZone(ZoneId.of( "UTC" )).toLocalDateTime();
        String json = "Date(" + utc.getYear() + CSV.COMMA +
                (utc.getMonthValue() - 1) + CSV.COMMA +
                utc.getDayOfMonth() + CSV.COMMA +
                utc.getHour() + CSV.COMMA +
                utc.getMinute() + CSV.COMMA +
				"0)";
	    return Json.createObjectBuilder()
			.add("v", json)
			.build();
	}
	JsonObject vo2(float value) {
	    return Json.createObjectBuilder()
			.add("v", value)
			.build();
	}		


	public static String windrose(int[] ph,int[] pk, int[] pv ){
     JsonArrayBuilder jabh = Json.createArrayBuilder();
        JsonArrayBuilder jabk = Json.createArrayBuilder();
        JsonArrayBuilder jabv = Json.createArrayBuilder();
		for (int i = 0; i < ph.length; i++) {
            jabh.add(Json.createArrayBuilder()
                    .add(i)
					.add(ph[i])
                    .build());
            jabk.add(Json.createArrayBuilder()
                    .add(i)
                    .add(pk[i])
                    .build());
            jabv.add(Json.createArrayBuilder()
                    .add(i)
                    .add(pv[i])
                    .build());
        }
        return Json.createArrayBuilder()
                .add(Json.createObjectBuilder()
                        .add("data", jabh.build())
                        .add("name", "Hyytiälä")
                        .build())
                .add(Json.createObjectBuilder()
                        .add("data", jabk.build())
                        .add("name", "Kumpula")
                        .build())
                .add(Json.createObjectBuilder()
                        .add("data", jabv.build())
                        .add("name", "Värriö")
                        .build())
                .build().toString();
	}


	private static JsonArray olio(long time, float f, int y) {
		return Json.createArrayBuilder()
				.add(time)
				.add(y)
				.add(DMPS.value(f))
				//.add("name", DMPS.column(y))
				//.add("color", DMPS.color(f))
				.build();
	}

	public static void addAerosols(int x, float[] fa) {
		//long time = timestamp.getTime() / 1000;
        //String time = timestamp.toString();
		for (int y = 1; y < fa.length + 1; y++)
			ab.add(olio(x, fa[y - 1], y));
	}

	public static String getAerosol() {
		return ab.build().toString();
	}
}
