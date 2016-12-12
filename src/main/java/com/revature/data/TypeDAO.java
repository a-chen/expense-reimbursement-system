package com.revature.data;

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
public class TypeDAO {

    private Connection conn;

    public TypeDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    public List<Type> getTypes() throws SQLException {

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
}
