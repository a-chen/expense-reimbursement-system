package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.data.DatabaseAccessImplementation;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

    /**
     * Checks amount to make sense, returns false if
     *  amount is negative or 0
     *  does not match the syntax x.xx, x.x, or x
     * @param inputAmount
     * @return if amount is correct syntax
     */
    boolean validateAmount(double inputAmount) {
        System.out.println("inputAmount is " + inputAmount);
        if (inputAmount <= 0) {
            System.out.println("less than 0, returning false");
            return false;
        }
        // String to be scanned to find the pattern.
        String amount = Double.toString(inputAmount);
        return amount.matches("^[+-]?[0-9]{1,3}(?:,?[0-9]{3})*(?:\\.[0-9]{1}[0-9]?)?$");
    }
}
