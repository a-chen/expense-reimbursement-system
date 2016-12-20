package com.revature.data;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by achen on 12/2/2016.
 */
class ReimbursementDAO {

    private Connection conn;

    ReimbursementDAO(Connection conn) {
        super();
        this.conn = conn;
    }

    /**
     * Fetches all reimbursements to be shown to reimbursement manager
     * @return
     * @throws SQLException
     */
    List<Reimbursement> viewAllReimbursements() throws SQLException {
        return viewReimbursements("", "");
    }

    /**
     * Fetch a reimbursement with specified reimbursement ID
     * @param reimbursementId
     * @return
     * @throws SQLException
     */
    public Reimbursement viewReimbursementById(int reimbursementId) throws SQLException {
        List<Reimbursement> reimbursements =
                viewReimbursements("reimbId", reimbursementId);

        return reimbursements.get(0);
    }

    /**
     * Fetch all Reimbusements for a particular user ID
     * @param userId
     * @return
     * @throws SQLException
     */
    List<Reimbursement> viewReimbursementsByUserId(int userId) throws SQLException {
        return viewReimbursements("userId", userId);
    }

    /**
     * Overloaded viewReimbursements, accepts and converts int to string
     * @param sqlCondition
     * @param id
     * @return
     * @throws SQLException
     */
    List<Reimbursement> viewReimbursements(String sqlCondition, int id) throws SQLException {
        return viewReimbursements(sqlCondition, Integer.toString(id));
    }
    /**
     * Returns list of Reimbursements, able to accept various conditions
     * @param sqlCondition
     * @param condition
     * @return
     * @throws SQLException
     */
    List<Reimbursement> viewReimbursements(String sqlCondition, String condition) throws SQLException {
        //list to be returned
        List<Reimbursement> result = new ArrayList<>();

        String sql = "SELECT " +
                "r.reimb_id, " +
                "r.reimb_amount, " +
                "r.reimb_submitted, " +
                "r.reimb_resolved, " +
                "r.reimb_description, " +
                "r.reimb_author, " +
                "u.user_first_name, " +
                "u.user_last_name, " +
                "u.user_email, " +
                "r.reimb_resolver, " +
                "resolver.ers_user_id resolver_id, " +
                "resolver.user_first_name resolver_first_name, " +
                "resolver.user_last_name resolver_last_name, " +
                "resolver.user_email resolver_email, " +
                "s.reimb_status_id, reimb_status, " +
                "t.reimb_type_id, reimb_type " +
                "FROM ers_reimbursement r " +
                "LEFT JOIN ers_user u " +
                "ON r.reimb_author = u.ers_user_id " +
                "LEFT JOIN ers_reimbursement_status s " +
                "ON r.reimb_status_id = s.reimb_status_id " +
                "LEFT JOIN ers_reimbursement_type t " +
                "ON r.reimb_type_id = t.reimb_type_id " +
                "LEFT JOIN (" +
                "SELECT " +
                "ers_user_id, " +
                "user_first_name, " +
                "user_last_name, " +
                "user_email " +
                "FROM ers_user) resolver " +
                "ON r.reimb_resolver = resolver.ers_user_id ";

        PreparedStatement stmt;

        switch (sqlCondition) {
            case "userId": {
                sql += "WHERE r.reimb_author = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(condition));
                break;
            }
            case "reimbId": {
                sql += "WHERE r.reimb_id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, Integer.parseInt(condition));
                break;
            }
            //for viewAllReimbursements
            default:
                stmt = conn.prepareStatement(sql);
                break;
        }

        ResultSet rs = stmt.executeQuery();

        //maps ResultSet into Reimbursement object
        while (rs.next()) {
            //take in resultset data
            //reimb and author data
            int id = rs.getInt("reimb_id");
            double amount = rs.getDouble("reimb_amount");
            Timestamp submitted = rs.getTimestamp("reimb_submitted");
            Timestamp resolved = rs.getTimestamp("reimb_resolved");
            String description = rs.getString("reimb_description");
            int authorId = rs.getInt("reimb_author");
            String authorFirstName = rs.getString("user_first_name");
            String authorLastName = rs.getString("user_last_name");
            String authorEmail = rs.getString("user_email");

            //resolver data
            int resolverId = rs.getInt("reimb_resolver");
            String resolverFirstName = rs.getString("resolver_first_name");
            String resolverLastName = rs.getString("resolver_last_name");
            String resolverEmail = rs.getString("resolver_email");

            //reimb data
            int statusId = rs.getInt("reimb_status_id");
            String status = rs.getString("reimb_status");

            int typeId = rs.getInt("reimb_type_id");
            String type = rs.getString("reimb_type");

            //assign data
            //creates all objects to be used
            Reimbursement reimbursement = new Reimbursement();
            User author = new User();
            User resolver = new User();
            Status statusObj = new Status();
            Type typeObj = new Type();

            reimbursement.setId(id);
            reimbursement.setAmount(amount);
            reimbursement.setSubmitted(submitted);
            reimbursement.setResolved(resolved);
            reimbursement.setDescription(description);

            author.setId(authorId);
            author.setFirstName(authorFirstName);
            author.setLastName(authorLastName);
            author.setEmail(authorEmail);
            reimbursement.setAuthor(author); //sets User object to author field

            resolver.setId(resolverId);
            resolver.setFirstName(resolverFirstName);
            resolver.setLastName(resolverLastName);
            resolver.setEmail(resolverEmail);
            reimbursement.setResolver(resolver); //sets User object to resolver field

            statusObj.setId(statusId);
            statusObj.setStatus(status);
            reimbursement.setStatus(statusObj); //sets Status object to status field

            typeObj.setId(typeId);
            typeObj.setType(type);
            reimbursement.setType(typeObj); //sets Type object to type field

            result.add(reimbursement);
        }
        return result;
    } // viewReimbursements

    /**
     * Inserts new reimbursement into database
     * Requires:
     *  reimbId
     *  amount
     *  submitTime(current time)
     *  author
     *  status (new reimbursements will give 3 for pending)
     *  type
     * @param reimbursement
     * @throws SQLException
     */
    void insertReimbursement(Reimbursement reimbursement) throws SQLException {
        String sql = "INSERT INTO ers_reimbursement (" +
                        "reimb_id, " +
                        "reimb_amount, " +
                        "reimb_submitted, " +
                        "reimb_description, " +
                        "reimb_author, " +
                        "reimb_status_id, " +
                        "reimb_type_id) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);

        //ID will be fetched from db auto sequence
        //fetched id does not matter
        stmt.setInt(1, reimbursement.getId());
        stmt.setDouble(2, reimbursement.getAmount());

        //uses current system time as Timestamp input
        Timestamp currentTime = new Timestamp(System.currentTimeMillis());
        stmt.setTimestamp(3, currentTime);
        stmt.setString(4, reimbursement.getDescription());
        stmt.setInt(5, reimbursement.getAuthor().getId());
        stmt.setInt(6, reimbursement.getStatus().getId());
        stmt.setInt(7, reimbursement.getType().getId());

        stmt.executeUpdate();
//         todo need to get generated key to fetch the inserted row by id
        ResultSet rs = stmt.getGeneratedKeys();
        if (rs.next()) {
            System.out.println("Generated key: " + rs.getString(1));
        }
    } //insertReimbursement

    /**
     * Updates a reimbursement of given id
     * with the provided status
     * @param reimbursement
     * @throws SQLException
     */
    void updateStatus(Reimbursement reimbursement) throws SQLException {
        String status = reimbursement.getStatus().getStatus();
        User resolver = reimbursement.getResolver();
        String sql;

        PreparedStatement stmt = null;

         /*
         updates resolver and resolve date if status
         is set to something other than pending
          */
        if ( !status.equals("Pending")) {
            Timestamp currentTime = new Timestamp(System.currentTimeMillis());
            sql =  "UPDATE ers_reimbursement r " +
                    "SET r.reimb_status_id = " +
                    "(SELECT s.reimb_status_id " +
                    "FROM ers_reimbursement_status s " +
                    "WHERE reimb_status = ?), " +
                    "reimb_resolved = ?, " +
                    "reimb_resolver = ? " +
                    "WHERE reimb_id = ?";

            stmt = conn.prepareStatement(sql);

            stmt.setString(1, reimbursement.getStatus().getStatus());
            stmt.setTimestamp(2, currentTime);
            stmt.setInt(3, resolver.getId());
            stmt.setInt(4, reimbursement.getId());

        } else {
            sql =  "UPDATE ers_reimbursement r " +
                    "SET r.reimb_status_id = " +
                    "(SELECT s.reimb_status_id " +
                    "FROM ers_reimbursement_status s " +
                    "WHERE reimb_status = ?) " +
                    "WHERE reimb_id = ?";
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, reimbursement.getStatus().getStatus());
            stmt.setInt(2, reimbursement.getId());
        }

        stmt.executeQuery();
    } //updateStatus

    /**
     * Updates a reimbursement of given id
     * with the provided type
     * @param reimbursement
     * @throws SQLException
     */
    void updateType(Reimbursement reimbursement) throws SQLException {
        String sql = "UPDATE ers_reimbursement r " +
                "SET r.reimb_type_id = " +
                "(SELECT s.reimb_type_id " +
                "FROM ers_reimbursement_type s " +
                "WHERE reimb_type = ?) " +
                "WHERE reimb_id = ?";

        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, reimbursement.getType().getType());
        stmt.setInt(2, reimbursement.getId());

        stmt.executeQuery();
    } //updateType


}
