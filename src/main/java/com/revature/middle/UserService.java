package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;

import javax.naming.AuthenticationException;
import java.sql.SQLException;
import java.util.List;

/**
 * Performs authentication for users
 * Created by achen on 12/7/2016.
 */
class UserService {
    public User authenticate(String username, String password) throws AuthenticationException {
        DatabaseAccessImplementation databaseAccessObject = new DatabaseAccessImplementation();
        User user = databaseAccessObject.getUserByUserName(username);
        if (user == null) {
            throw new AuthenticationException();
        }
        if (user.getPassword().equals(password)) {
            return user;
        } else
            throw new AuthenticationException();

    }
}
