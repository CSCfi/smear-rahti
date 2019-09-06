package fi.csc.avaa.smear;

public class DMPS {
    private static final String[] COLORMAP = {"0202AA", "0202B6", "0202C1", "0202CC", "0202D8", "0202E3", "0202EE",
            "0202FA", "0202FF", "0202FF", "0202FF", "0202FF", "020BFF", "0217FF", "0222FF", "022DFF",
            "0239FF", "0244FF", "024FFF", "025BFF", "0266FF", "0271FF", "027DFF", "0288FF", "0294FF",
            "029FFF", "02AAFF", "02B6FF", "02C1FF", "02CCFF", "02D8FF", "02E3FF", "02EEFF", "02FAFF",
            "02FFFF", "02FFFF", "02FFFF", "02FFFF", "0BFFFF", "17FFFF", "22FFFF", "2DFFFA", "39FFEE",
            "44FFE3", "4FFFD8", "5BFFCC", "66FFC1", "71FFB6", "7DFFAA", "88FF9F", "94FF94", "9FFF88",
            "AAFF7D", "B6FF71", "C1FF66", "CCFF5B", "D8FF4F", "E3FF44", "EEFF39", "FAFF2D", "FFFF22", "FFFF17", "FFFF0B",
            "FFFF02", "FFFF02", "FFFF02", "FFFF02", "FFFA02", "FFEE02", "FFE302", "FFD802", "FFCC02", "FFC102", "FFB602",
            "FFAA02", "FF9F02", "FF9402", "FF8802", "FF7D02", "FF7102", "FF6602", "FF5B02", "FF4F02", "FF4402", "FF3902",
            "FF2D02", "FF2202", "FF1702", "FF0B02", "FF0202", "FF0202", "FF0202", "FF0202", "FA0202", "EE0202", "E30202",
            "D80202", "CC0202", "C10202", "B60202", "AA0202"};

    private static final String[] COLUMNS = {"d282e1",
            "d316e1",
            "d355e1",
            "d398e1",
            "d447e1",
            "d501e1",
            "d562e1",
            "d631e1",
            "d708e1",
            "d794e1",
            "d891e1",
            "d100e2",
            "d112e2",
            "d126e2",
            "d141e2",
            "d158e2",
            "d178e2",
            "d200e2",
            "d224e2",
            "d251e2",
            "d282e2",
            "d316e2",
            "d355e2",
            "d398e2",
            "d447e2",
            "d501e2",
            "d562e2",
            "d631e2",
            "d708e2",
            "d794e2",
            "d891e2",
            "d100e3",
            "d112e3",
            "d126e3",
            "d141e3",
            "d158e3",
            "d178e3",
            "d200e3",
            "d224e3",
            "d251e3",
            "d282e3",
            "d316e3",
            "d355e3",
            "d398e3",
            "d447e3",
            "d501e3",
            "d562e3",
            "d631e3",
            "d708e3",
            "d794e3",
            "d891e3"};

    /**
     * Yes, this number come from COLUMNSnames.
     */
    private static final float[] SIZES = {2.82f,
            3.16f,
            3.55f,
            3.98f,
            4.47f,
            5.01f,
            5.62f,
            6.31f,
            7.08f,
            7.94f,
            8.91f,
            10.0f,
            11.2f,
            12.6f,
            14.1f,
            15.8f,
            17.8f,
            20.0f,
            22.4f,
            25.1f,
            28.2f,
            31.6f,
            35.5f,
            39.8f,
            44.7f,
            50.1f,
            56.2f,
            63.1f,
            70.8f,
            79.4f,
            89.1f,
            100,
            112,
            126,
            141,
            158,
            178,
            200,
            224,
            251,
            282,
            316,
            355,
            398,
            447,
            501,
            562,
            631,
            708,
            794,
            891};

    public static String color(float f) {
        if (f < 1) {
            f = 1;
        }
        double logDat = Math.log10(f);
        if (logDat > 4) {
            logDat = 4;
        }
        if (logDat < 0.1) {
            logDat = 0.1;
        }
        int ind = (int) Math.round(logDat * 25);
        if (f < 0.01) {
            return "ffffff";
        } else {
            return COLORMAP[ind];
        }
    }

    /**
     * This is about same as color
     * @param f float data value from database
     * @return int "heat"
     */
    public static int value(float f) {
        if (f < 1) {
            f = 1;
        }
        double logDat = Math.log10(f);
        if (logDat > 4) {
            logDat = 4;
        }
        if (logDat < 0.1) {
            logDat = 0.1;
        }
        int ind = (int) Math.round(logDat * 25);
        if (f < 0.01) {
            return 100;
        } else {
            return ind;
        }
    }

    public static float size(int i) {
        return SIZES[i];
    }


    public static String column(int i) {
        return COLUMNS[i];
    }
}
