package com.revature.data;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

/**
 * Created by achen on 12/2/2016.
 */
public class DatabaseAccessImplementation implements DatabaseAccess {


    @Override
    public List<Type> getTypes() {
        Connection conn = null;
        List<Type> types = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();
            conn.setAutoCommit(false); // enables transaction

            TypeDAO typeDAO = new TypeDAO(conn);

            types = typeDAO.getTypes();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return types;
    }

    @Override
    public List<Status> getStatuses() {
        Connection conn = null;
        List<Status> statuses = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();
            conn.setAutoCommit(false); // enables transaction

            StatusDAO statusDAO = new StatusDAO(conn);

            statuses = statusDAO.getStatuses();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return statuses;
    }

    @Override
    public User getUserByUserName(String username) {
        Connection conn = null;
        User user = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();
            conn.setAutoCommit(false); // enables transaction

            UserDAO userDAO = new UserDAO(conn);

            user = userDAO.getUserByUserName(username);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }

    @Override
    public List<Reimbursement> getAllReimbursements() {

        Connection conn = null;
        List<Reimbursement> reimbursements = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();
            conn.setAutoCommit(false); // enables transaction

            ReimbursementDAO reimbursementDAO = new ReimbursementDAO(conn);

            reimbursements = reimbursementDAO.viewAllReimbursements();


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reimbursements;
    }

    public List<Reimbursement> getReimbursementsById(int id) {
        Connection conn = null;
        List<Reimbursement> reimbursements = null;

        try {
            conn = ServiceLocator.getERSDatabase().getConnection();
            conn.setAutoCommit(false); // enables transaction

            ReimbursementDAO reimbursementDAO = new ReimbursementDAO(conn);

            reimbursements = reimbursementDAO.viewReimbursementsById(id);


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return reimbursements;
    }

    @Override
    public void changeReimbursementStatus(Reimbursement reimbursement) {

    }

    @Override
    public void addReimbursement(Reimbursement reimbursement) {

    }

    @Override
    public void updateReimbursementDescription(Reimbursement reimbursement) {

    }

    @Override
    public void updateUsername(User user) {

    }

    @Override
    public void updatePassword(User user) {

    }

    @Override
    public void updateEmail(User user) {

    }



}
