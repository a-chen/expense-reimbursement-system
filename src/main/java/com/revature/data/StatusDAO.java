package com.revature.data;

import com.revature.beans.Status;
import com.revature.beans.Type;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by achen on 12/12/2016.
 */
public class StatusDAO {

    private Connection conn;

    public StatusDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    public List<Status> getStatuses() throws SQLException {

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
