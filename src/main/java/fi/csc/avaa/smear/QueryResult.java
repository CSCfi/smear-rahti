package fi.csc.avaa.smear;

import java.sql.Timestamp;

public class QueryResult {
    public float[][] faa;
    public Timestamp[] tsa;

    public QueryResult(float[][] faa, Timestamp[] tsa) {
        this.faa = faa;
        this.tsa = tsa;
    }
}
