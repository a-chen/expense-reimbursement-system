package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;

import javax.naming.AuthenticationException;
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

    public List<Reimbursement> viewReimbursements(User user) {
        return new ReimbursementService().viewReimbursements(user);
    }

    public Reimbursement viewReimbursementById(int reimbursementId) {
        return new ReimbursementService().viewReimbursementById(reimbursementId);
    }

    public void updateStatus(Reimbursement reimbursement) {
        new ReimbursementService().updateStatus(reimbursement);
    }

    public void updateType(Reimbursement reimbursement) {
        new ReimbursementService().updateType(reimbursement);
    }

    public void addReimbursement(Reimbursement reimbursement) {
        new ReimbursementService().addReimbursement(reimbursement);
    }
}
