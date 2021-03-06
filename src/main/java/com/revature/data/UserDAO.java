package com.revature.data;

import com.revature.beans.Role;
import com.revature.beans.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by achen on 12/2/2016.
 */
class UserDAO {

    private Connection conn;

    UserDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * Gets user by provided input,
     * returns User upon matching username or email
     * @param username
     * @return
     * @throws SQLException
     */
    User getUserByUserName(String username) throws SQLException {

        String sql =    "SELECT ers_user_id, " +
                            "ers_username, " +
                            "ers_password, " +
                            "user_first_name, " +
                            "user_last_name, " +
                            "user_email, " +
                            "user_role_id, " +
                            "user_role " +
                        "FROM ers_user " +
                            "JOIN ers_user_roles " +
                                "ON user_role_id = ers_user_role_id " +
                        "WHERE ers_username = ? " +
                            "OR user_email = ?";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, username);
        stmt.setString(2, username);

        ResultSet rs = stmt.executeQuery();

        List<User> users = new ArrayList<>();
        mapUsers(rs, users);

        if (users == null) {
            return null;
        }
        return users.get(0);
    }

    /**
     * Maps each row of ResultSet to User objects
     * @param rs
     * @param users
     * @throws SQLException
     */
    private void mapUsers(ResultSet rs, List<User> users) throws SQLException {

        while (rs.next()) {
            int id = rs.getInt("ers_user_id");
            String username = rs.getString("ers_username");
            String password = rs.getString("ers_password");
            String lastName = rs.getString("user_first_name");
            String firstName = rs.getString("user_first_name");
            String email = rs.getString("user_email");
            int roleId = rs.getInt("user_role_id");
            String role = rs.getString("user_role");

            Role roleObj = new Role();
            roleObj.setId(roleId);
            roleObj.setRole(role);

            //map ResultSet to User object
            User user = new User(id, username, password, lastName, firstName, email, roleObj);
            users.add(user);
        }
    }

    void insert(User user) {

    }

    void hashExistingPassword(User user)throws SQLException {

        String unhashedPass = user.getPassword();
        String hashedPass = BCrypt.hashpw(unhashedPass, BCrypt.gensalt());

        String sql = "UPDATE ers_user " +
                     "SET ers_password = ? " +
                     "WHERE ers_user_id = ?";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, hashedPass);
        stmt.setInt(2, user.getId());

        stmt.executeQuery();
    }

}
