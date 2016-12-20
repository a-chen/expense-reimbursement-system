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
}
