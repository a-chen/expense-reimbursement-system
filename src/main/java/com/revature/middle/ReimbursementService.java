package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;

import java.util.List;

/**
 * Created by achen on 12/9/2016.
 */
class ReimbursementService {

    List<Reimbursement> viewAllReimbursements() {
        return new DatabaseAccessImplementation().getAllReimbursements();
    }

    List<Reimbursement> viewReimbursementsById(int id) {
        List<Reimbursement> reimbursements = new DatabaseAccessImplementation().getReimbursementsByUserId(id);

        return reimbursements;
    }

    List<Reimbursement> viewReimbursements(User user) {
        List<Reimbursement> reimbursements;
        DatabaseAccessImplementation databaseAccess = new DatabaseAccessImplementation();
        if (user.getRole().getRole().equals("HR") || user.getRole().getRole().equals("Admin")) {
            reimbursements = databaseAccess.getAllReimbursements();
        } else {
            reimbursements = databaseAccess.getReimbursementsByUserId(user.getId());
        }
        return reimbursements;
    }
    public Reimbursement viewReimbursementById(int reimbursementId) {
        return new DatabaseAccessImplementation().getReimbursementById(reimbursementId);
    }

    void updateStatus(Reimbursement reimbursement) {
        new DatabaseAccessImplementation().updateStatus(reimbursement);

    }

    public void updateType(Reimbursement reimbursement) {
        new DatabaseAccessImplementation().updateType(reimbursement);
    }


    public void addReimbursement(Reimbursement reimbursement) {
        new DatabaseAccessImplementation().addReimbursement(reimbursement);
    }
}
