package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;

import javax.naming.AuthenticationException;
import java.sql.SQLException;
import java.util.List;

/**
 * Connects front end to backend
 * Created by achen on 12/7/2016.
 */
public class BusinessDelegate {
    public User login(String user, String pass) throws AuthenticationException {
        return new UserService().authenticate(user, pass);
    }

    public List<Type> getType() {
        return new TypeService().getTypes();
    }

    public List<Status> getStatus() {
        return new StatusService().getStatuses();
    }

    public List<Reimbursement> viewReimbs(User user) {
        return new ReimbursementService().viewReimbs(user);
    }


}
