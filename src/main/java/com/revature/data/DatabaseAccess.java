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

    public List<Type> getTypes();

    public User getUserByUserName(String username) throws SQLException;

    /**
     * For use by Finance Managers to see all reimbursements
     * @return
     */
    public List<Reimbursement> getAllReimbursements() throws SQLException;

    public void changeReimbursementStatus(Reimbursement reimbursement);

    public void addReimbursement(Reimbursement reimbursement);

    public void updateReimbursementDescription(Reimbursement reimbursement);

    public void updateUsername(User user);

    public void updatePassword(User user);

    public void updateEmail(User user);

    List<Status> getStatuses();
}
