package com.revature.data;

import com.revature.beans.Role;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by achen on 12/7/2016.
 */
public class RoleDAO {

    private Connection conn;

    public RoleDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * Returns Role object that has the provided ID
     *
     * @param id
     * @return Role object
     * @throws SQLException
     */
    public Role getRoleById(int id) throws SQLException {

        String sql = "SELECT ers_user_role_id, user_role " +
                "FROM ers_user_roles " +
                "WHERE ers_user_role_id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        //map ResultSet to User object
        rs.next();
        Role role = new Role(
                rs.getInt("ers_user_role_id"),
                rs.getString("user_role"));

        return role;
    }
}
