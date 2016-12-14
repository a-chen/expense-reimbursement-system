package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;

import java.util.List;

/**
 * Created by achen on 12/9/2016.
 */
class ReimbursementService {

    public List<Reimbursement> viewAllReimbursements() {
        return new DatabaseAccessImplementation().getAllReimbursements();
    }

    public List<Reimbursement> viewReimbursementsById(int id) {
        List<Reimbursement> reimbursements = new DatabaseAccessImplementation().getReimbursementsById(id);

        return reimbursements;
    }

    public List<Reimbursement> viewReimbs(User user) {
        List<Reimbursement> reimbursements;
        DatabaseAccessImplementation databaseAccess = new DatabaseAccessImplementation();
        System.out.println(user.getRole().getRole() + " " + user.getId());
        if (user.getRole().getRole().equals("HR") || user.getRole().getRole().equals("Admin")) {
            reimbursements = databaseAccess.getAllReimbursements();
        } else {
            reimbursements = databaseAccess.getReimbursementsById(user.getId());
        }
        return reimbursements;
    }
}
