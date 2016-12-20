package com.revature.data;


import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by achen on 12/2/2016.
 */
public class ExpenseReimbursementSystem {
    public static void main(String[] args) throws SQLException {
        System.out.println("ERS started!");

        Connection conn = null;
        List<Status> statuses = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();

            Reimbursement reimbursement = null;

            new ReimbursementDAO(conn).updateStatus(reimbursement);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        System.out.println("ERS finshed!");
    }
}
