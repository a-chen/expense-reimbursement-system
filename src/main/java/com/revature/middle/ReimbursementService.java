package com.revature.middle;

import com.revature.beans.Reimbursement;
import com.revature.data.DatabaseAccessImplementation;

import java.util.List;

/**
 * Created by achen on 12/9/2016.
 */
class ReimbursementService {

    public List<Reimbursement> viewAllReimbursements() {
        return new DatabaseAccessImplementation().getAllReimbursements();
    }
}
