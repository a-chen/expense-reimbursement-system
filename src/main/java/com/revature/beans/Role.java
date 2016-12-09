package com.revature.beans;

/**
 * Created by achen on 12/5/2016.
 */
public class Role {

    int id;
    String role;

    public Role(int id, String role) {
        super();
        this.id = id;
        this.role = role;
    }

    public Role() {
        super();
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", role='" + role + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
