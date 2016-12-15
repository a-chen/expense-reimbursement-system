package com.revature.data;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;

import java.sql.SQLException;
import java.util.List;

/**
 * Created by achen on 12/7/2016.
 */
public interface DatabaseAccess {

    List<Type> getTypes();

    User getUserByUserName(String username) throws SQLException;

    /**
     * For use by Finance Managers to see all reimbursements
     * @return
     */
    List<Reimbursement> getAllReimbursements() throws SQLException;

    void changeReimbursementStatus(Reimbursement reimbursement);

    void addReimbursement(Reimbursement reimbursement);

    void updateReimbursementDescription(Reimbursement reimbursement);

    void updateUsername(User user);

    void updatePassword(User user);

    void updateEmail(User user);

    List<Status> getStatuses();

    void updateStatus(Reimbursement reimbursement);

    void updateType(Reimbursement reimbursement);
}
