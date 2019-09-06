package fi.csc.avaa.smear;

/**
 * The leaf of the tree
 */
public class Leaf {

    String variable;
    String column;
    String unit;
    String source;
    String table;
    String available; //date
    String color;
    private String name;
    private int id;


    public Leaf(String name, int id, String variable, String column, String unit, String source, String table, String available) {
        this.name = name;
        this.id = id;
        this.variable = variable;
        this.column = column;
        this.unit = unit;
        this.source = source;
        this.table = table;
        this.available = available;
        this.color = "black";
    }
}
