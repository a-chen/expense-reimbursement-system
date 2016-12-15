package com.revature.data;

import com.revature.beans.Reimbursement;
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
class TypeDAO {

    private Connection conn;

    TypeDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    List<Type> getTypes() throws SQLException {

        String sql = "SELECT reimb_type_id, " +
                            "reimb_type " +
                     "FROM ers_reimbursement_type";

        PreparedStatement stmt = conn.prepareStatement(sql);

        ResultSet rs = stmt.executeQuery();

        List<Type> types = new ArrayList<>();

        while (rs.next()) {
            int id = rs.getInt("reimb_type_id");
            String type = rs.getString("reimb_type");

            //map ResultSet to User object
            Type typeObj = new Type(id, type);
            types.add(typeObj);
        }
        return types;
    }

    /**
     * Updates a reimbursement of given id
     * with the provided type
     * @param reimbursement
     * @throws SQLException
     */
    void updateType(Reimbursement reimbursement) throws SQLException {
        String sql = "UPDATE ers_reimbursement r " +
                     "SET r.reimb_type_id = " +
                         "(SELECT s.reimb_type_id " +
                         "FROM ers_reimbursement_type s " +
                         "WHERE reimb_type = ?) " +
                     "WHERE reimb_id = ?";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, reimbursement.getType().getType());
        stmt.setInt(2, reimbursement.getId());

        stmt.executeQuery();
    }
}
