package com.revature.beans;

/**
 * Created by achen on 12/5/2016.
 */
public class Type {

    int id;
    String type;

    public Type(int id, String type) {
        super();
        this.id = id;
        this.type = type;
    }

    public Type() {
        super();
    }

    @Override
    public String toString() {
        return "Type{" +
                "id=" + id +
                ", type='" + type + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
