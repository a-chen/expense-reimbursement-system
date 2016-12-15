package com.revature.middle;

import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;
import org.mindrot.jbcrypt.BCrypt;


import javax.naming.AuthenticationException;

/**
 * Performs authentication for users
 * Created by achen on 12/7/2016.
 */
class UserService {
    User authenticate(String username, String password) throws AuthenticationException {
        DatabaseAccessImplementation databaseAccessObject = new DatabaseAccessImplementation();
        User user = databaseAccessObject.getUserByUserName(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        } else
            throw new AuthenticationException();
    }
}
