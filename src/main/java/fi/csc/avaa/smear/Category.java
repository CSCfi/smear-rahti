package fi.csc.avaa.smear;

import java.util.Collection;

/**
 * tree
 */
public class Category {
    private String name;
    private int id;
    private Collection children;
    private boolean selectable = false;

    public Category(String name, Integer id, Collection children) {
        this.name = name;
        this.id = id;
        this.children = children;
    }
}
