package fi.csc.avaa.smear;

import java.sql.Timestamp;
import java.util.Hashtable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Future;

/**
 * Cache the data quered from SQL. The data is already formatted as JSON or CSV string in cache.
 * The cache is implemented as array of SIZE
 */
public class Cache {
    public static final int SIZE = 89; //quite random, used also as table array size in Tree
    static Hashtable<String, Integer> htjson = new Hashtable<String, Integer>(SIZE);
    static Hashtable<String, Integer> htcsv = new Hashtable<String, Integer>(SIZE);
    static Hashtable<String, Integer> htvolatile = new Hashtable<String, Integer>(SIZE);
    volatile int[] status = new int[SIZE];
    volatile int currentIndex = 0;
    volatile int jsonIndex = 0;
    volatile int[] csvstatus = new int[SIZE];
    String[] sa;
    String[][] csvsa = new String[SIZE][CSV.TAC];
    String[] wr = new String[SIZE];
    String[] aerosols = new String[SIZE];

    /**
     * The json cache
     *
     * @param c    String windrose or aerosol (two frontpage charts)
     * @param sql  SQL object
     * @param from Timestamp period start
     * @param to   Timestamp period end
     * @return String JSON data either from memory or quering from database
     */
    public synchronized String get(String c, SQL sql, Timestamp from, Timestamp to) {
        String key = Long.toString(from.getTime()) + Long.toString(to.getTime());
        Integer index = htjson.get(key);
        if (null == index) {
            index = jsonIndex;
            htjson.put(key, jsonIndex++);
            if (SIZE == jsonIndex)
                jsonIndex = 0;
        }
        if (0 == status[jsonIndex]) {
            status[jsonIndex] = 1;
            QueryExecutor qe = new QueryExecutor(sql, from, to);
            Future<String> future = qe.aerosols();
            Data d = sql.triquery(from, to);
            //sa = d.getJson();
            wr[jsonIndex] = Windrose.getJson(d.getWindDir());
            try {
                aerosols[jsonIndex] = future.get();
            } catch (InterruptedException e) {// thread was interrupted
                e.printStackTrace();
            } catch (ExecutionException e) {// thread threw an exception
                e.printStackTrace();
            } finally {
                qe.close();
            }
            status[jsonIndex] = 2;
            return paluu(c, jsonIndex);
        } else { // status should be 2
            if (status[jsonIndex] < 2) {
                System.err.println("This should not be possible");
                while (status[jsonIndex] < 2) try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    System.err.println("InterruptedException");
                }
            }
            return paluu(c, jsonIndex);
        }
    }

    static {
        htcsv.put("no", CSV.NO); //System.out.println("Hashtable put NOT working"); return null
        System.out.println("Hashtable put:" + htcsv.put("rh", CSV.RH));
        htcsv.put("glob", CSV.GLOB);
        htcsv.put("ts", CSV.TS);
        htcsv.put("co2", CSV.CO2);
        htcsv.put("so", CSV.SO2);
        htcsv.put("nox", CSV.NOX);
        htcsv.put("flux", CSV.FLUX);
        htcsv.put("et", CSV.ET);
        htcsv.put("t", CSV.T);
        htcsv.put("ws", CSV.WS);
        htcsv.put("p", CSV.P);
        htcsv.put("o3", CSV.O3);
        htcsv.put("tac", CSV.TAC);
    }

    /**
     * The CSV cache
     *
     * @param c String listed above: no, glob, ts...
     * @param sql SQL object
     * @param from Timestamp query  start time
     * @param to Timestamp query end time
     * @return CSV data
     */
    public synchronized String csv(String c, SQL sql, Timestamp from, Timestamp to) {
        String key = Long.toString(from.getTime()) + Long.toString(to.getTime());
        Integer index = htvolatile.get(key);
        if (null == index) {
            index = currentIndex;
            htvolatile.put(key, currentIndex++);
            if (SIZE == currentIndex)
                currentIndex = 0;
        }
        if (0 == csvstatus[index]) {
            csvstatus[index] = 1;
            csvsa[index] = sql.csvs(from, to);
            csvstatus[index] = 2;
            return paluucsv(c, index);
        } else { // status should be 2
            if (csvstatus[index] < 2) {
                System.err.println("This CVS should not be possible");
                while (csvstatus[index] < 2) try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    System.err.println("InterruptedException");
                }
            }
            return paluucsv(c, index);
        }
    }

    /**
     * Code should clean up and remove sa
     *
     * @param c String chartname
     * @param index int the cache slot
     * @return JSON data
     */
    private String paluu(String c, int index) {
        if (c.equals("windrose"))
            return wr[index];
        else if (c.equals("aerosol"))
            return aerosols[index];
        else
            return sa[chart(c)];
    }

    private int chart(String c) {
        if (c.equals("temp")) return SQL.TEMPERATURE;
        else if (c.equals("airp")) return SQL.AIRPRESSURE;
        else if (c.equals("windspeed")) return SQL.WINDSPEED;
        else {
            System.err.println("Api error: v3 call must be temp, airp or windspeed");
            return -1;
        }
    }

    /**
     *
     * @param c String variable, chart
     * @param index int the cache slot
     * @return CSV data
     */
    private String paluucsv(String c, int index) {
        try {
            return csvsa[index][(int) htcsv.get(c.substring(1))];

        } catch (java.lang.NullPointerException e) {
            System.err.println(c + "NullPointerException: " + htcsv.get(c.substring(1)));
            if (null == csvsa)
                System.err.println("csvsa is null " + csvstatus);
            System.err.println("Api error: csv call must be no, rh, glob, ts, co2, so, nox, flux, et, o3, tac");
            return "";
        }
    }
}
