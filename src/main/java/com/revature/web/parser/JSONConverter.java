package com.revature.web.parser;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.revature.beans.Reimbursement;
import com.revature.beans.User;

import java.io.IOException;

/**
 * Created by achen on 12/15/2016.
 */
public class JSONConverter {
    public Reimbursement getReimbursement(String json) throws IOException {
        return new ObjectMapper().readValue(json, Reimbursement.class);
    }
    public User getUser(String json) throws IOException {
        return new ObjectMapper().readValue(json, User.class);
    }

    public String getJSON(Reimbursement reimbursement) throws JsonProcessingException {
        return new ObjectMapper().writeValueAsString(reimbursement);
    }
    public String getJSON(User user) throws JsonProcessingException {
        return new ObjectMapper().writeValueAsString(user);
    }
}
