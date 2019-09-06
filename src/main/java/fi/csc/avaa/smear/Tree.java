package fi.csc.avaa.smear;

import java.util.ArrayList;

public class Tree {

    ArrayList<Category> stations = new ArrayList<Category>();

    public void add(Category c) {
        this.stations.add(c);
    }

    public ArrayList<Category> getTree() {
        return stations;
    }
}
