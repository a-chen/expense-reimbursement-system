package com.revature.data;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by achen on 12/12/2016.
 */
class StatusDAO {

    private Connection conn;

    StatusDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * returns a List of the different types of statuses that
     * a reimbursement can have
     * @return list of Statuses
     * @throws SQLException
     */
    List<Status> getStatuses() throws SQLException {

        String sql = "SELECT reimb_status_id, " +
                            "reimb_status " +
                     "FROM ers_reimbursement_status";

        PreparedStatement stmt = conn.prepareStatement(sql);

        ResultSet rs = stmt.executeQuery();

        List<Status> statuses = new ArrayList<>();

        while (rs.next()) {
            int id = rs.getInt("reimb_status_id");
            String status = rs.getString("reimb_status");

            //map ResultSet to User object
            Status statusObj = new Status(id, status);
            statuses.add(statusObj);
        }
        return statuses;
    }

    /**
     * Updates a reimbursement of given id
     * with the provided status
     * @param reimbursement
     * @throws SQLException
     */
     void updateStatus(Reimbursement reimbursement) throws SQLException {
         String status = reimbursement.getStatus().getStatus();
         User resolver = reimbursement.getResolver();
         String sql;

         PreparedStatement stmt = null;

         /*
         updates resolver and resolve date if status
         is set to something other than pending
          */
         if ( !status.equals("Pending")) {
             Timestamp currentTime = new Timestamp(System.currentTimeMillis());
             sql =  "UPDATE ers_reimbursement r " +
                    "SET r.reimb_status_id = " +
                        "(SELECT s.reimb_status_id " +
                        "FROM ers_reimbursement_status s " +
                        "WHERE reimb_status = ?), " +
                    "reimb_resolved = ?, " +
                    "reimb_resolver = ? " +
                    "WHERE reimb_id = ?";

             stmt = conn.prepareStatement(sql);

             stmt.setString(1, reimbursement.getStatus().getStatus());
             stmt.setTimestamp(2, currentTime);
             stmt.setInt(3, resolver.getId());
             stmt.setInt(4, reimbursement.getId());

         } else {
             sql =  "UPDATE ers_reimbursement r " +
                    "SET r.reimb_status_id = " +
                        "(SELECT s.reimb_status_id " +
                        "FROM ers_reimbursement_status s " +
                        "WHERE reimb_status = ?) " +
                    "WHERE reimb_id = ?";
             stmt = conn.prepareStatement(sql);

             stmt.setString(1, reimbursement.getStatus().getStatus());
             stmt.setInt(2, reimbursement.getId());
         }

         stmt.executeQuery();
    }
}
