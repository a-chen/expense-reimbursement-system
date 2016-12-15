package com.revature.beans;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Created by achen on 12/5/2016.
 */
public class Status {

    @JsonProperty
    private int id;
    @JsonProperty
    private String status;

    public Status(int id, String status) {
        super();
        this.id = id;
        this.status = status;
    }

    public Status() {
        super();
    }

    @Override
    public String toString() {
        return "Status{" +
                "id=" + id +
                ", status='" + status + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
