package fi.csc.avaa.smear;

public class Data {
    public final static int HYYTIÄLÄ = 0;
    public final static int KUMPULA = 1;
    public final static int VÄRRIÖ = 2;
    private String[] sa;
    private float[][] fa;

    public Data(String[] sa, float[][] fa) {
        this.sa = sa;
        this.fa = fa;
    }

    public String[] getJson() {
        return this.sa;
    }

    public float[][] getWindDir() {
        return this.fa;
    }
}
