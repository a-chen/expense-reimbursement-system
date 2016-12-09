package com.revature.beans;

import java.sql.Timestamp;

/**
 * Created by achen on 12/2/2016.
 */
public class Reimbursement {
    private int id;
    private double amount;
    private Timestamp submitted; //Timestamp(SYSTEM.currentMillitime)
    private Timestamp resolved;
    private String description;
    //takes in pictures, implement in the future
    private Receipt receipt;
    //reference user objects instead of fields
    private User author;
    private User resolver;
    private Status status;
    private Type type;

    /**
     * Only requires NOT NULL fields
     * @param id
     * @param amount
     * @param submitted
     * @param author
     * @param status
     * @param type
     */
    public Reimbursement(int id,
                         double amount,
                         Timestamp submitted,
                         User author,
                         Status status,
                         Type type) {
        super();
        this.id = id;
        this.amount = amount;
        this.submitted = submitted;
        this.author = author;
        this.status = status;
        this.type = type;
    }

    public Reimbursement() {
        super();
    }

    @Override
    public String toString() {
        return "Reimbursement{" +
                "id=" + id +
                ", amount=" + amount +
                ", submitted=" + submitted +
                ", resolved=" + resolved +
                ", description='" + description + '\'' +
                ", receipt=" + receipt +
                ", author=" + author +
                ", resolver=" + resolver +
                ", status=" + status +
                ", type=" + type +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Timestamp getSubmitted() {
        return submitted;
    }

    public void setSubmitted(Timestamp submitted) {
        this.submitted = submitted;
    }

    public Timestamp getResolved() {
        return resolved;
    }

    public void setResolved(Timestamp resolved) {
        this.resolved = resolved;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Receipt getReceipt() {
        return receipt;
    }

    public void setReceipt(Receipt receipt) {
        this.receipt = receipt;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public User getResolver() {
        return resolver;
    }

    public void setResolver(User resolver) {
        this.resolver = resolver;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
}
