package com.revature.data;


import com.revature.beans.Reimbursement;
import com.revature.beans.User;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by achen on 12/2/2016.
 */
public class ExpenseReimbursementSystem {
    public static void main(String[] args) throws SQLException {
        System.out.println("ERS started!");

        DatabaseAccessImplementation facade = new DatabaseAccessImplementation();
        List<Reimbursement> list = facade.getAllReimbursements();

        for (Reimbursement reimbursement : list) {
            System.out.println(reimbursement);
        }

        System.out.println("ERS finshed!");
    }
}
