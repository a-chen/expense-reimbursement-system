package com.revature.web;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;
import com.revature.web.parser.JSONConverter;
import com.revature.middle.BusinessDelegate;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.List;

/**
 * Created by achen on 12/8/2016.
 */
class MainController {

    /**
     * Matches the username or email with password
     * On match, will load some preliminary data
     *  before passing to main page handler
     * @param request
     * @param response
     * @throws AuthenticationException
     * @throws ServletException
     * @throws IOException
     */
    void login(HttpServletRequest request, HttpServletResponse response) throws
            AuthenticationException,
            ServletException,
            IOException {

        //authenticating
        BusinessDelegate businessDelegate = new BusinessDelegate();

        User user = businessDelegate.login(
                request.getParameter("username").trim(),
                request.getParameter("password").trim());

        //stores user data in cookie
        if (user != null) {
            //adds session-wide values
            HttpSession session = request.getSession(true);

            //adds User object to Session scope
            session.setAttribute("user", user);
            //gets list of types and statuses
            List<Type> types = businessDelegate.getType();
            List<Status> statuses = businessDelegate.getStatus();

            //sets types and statuses list to session scope
            session.setAttribute("types", types);
            session.setAttribute("statuses", statuses);

            Cookie cookie = new Cookie("username", user.getUsername());
            cookie.setMaxAge(9999999);
            response.addCookie(cookie);

        }

        // GOTO next page
//        request.getRequestDispatcher("/").forward(request, response);
        response.sendRedirect("main");
    }

    void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session != null)
            session.invalidate();
        response.sendRedirect("login");
    }

    /**
     * Checks if user is logged in
     *
     * @param request
     * @param response
     * @return Boolean if user is logged in
     */
    Boolean checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("user") != null);
    }

    /**
     * Checks if user is logged in, if not, redirect to login page
     * If user is logged in, then it will populate the page depending on the user
     * Admin and HR personnel will see all reimbursements
     * Other user roles will just see their own
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    void doMain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //if not logged in, redirect to login page
        if (!checkLogin(request, response)) {
            response.sendRedirect("login");
        } else {
            populateReimbursements(request, response);
            request.getRequestDispatcher("/WEB-INF/secure/main.jsp").forward(request, response);
        }
    }

    /**
     * Puts Reimbursement list to request scope if user is Admin or HR
     * Otherwise, display a user's own reimbursements
     * @param request
     * @param response
     */
    void populateReimbursements(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        List<Reimbursement> reimbursements = new BusinessDelegate().viewReimbursements(user);
        request.setAttribute("reimbursements", reimbursements);
    }

    /**
     * Maps data from http request body into a Reimbursement object
     * and stores in database, in this case, only status
     *
     * Also adds a
     * @param request
     * @param response
     * @throws IOException
     */
    void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //extract Status from request body
        InputStream requestBody = request.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(requestBody));

        Reimbursement reimbursement = new JSONConverter().getReimbursement(reader.readLine());
        User user = (User) request.getSession().getAttribute("user");
        reimbursement.setResolver(user);
        BusinessDelegate businessDelegate = new BusinessDelegate();
        businessDelegate.updateStatus(reimbursement);

        //Converts Reimbursement object to JSON and passes it with request
        Reimbursement fetchedReimbursement = businessDelegate.viewReimbursementById(reimbursement.getId());

        String json = new JSONConverter().getJSON(fetchedReimbursement);
        response.setContentType("application/json");
        response.getWriter().print(json);

    }

    /**
     * Maps data from http request body into a Reimbursement object
     * and stores in database, in this case, only type
     * @param request
     * @param response
     * @throws IOException
     */
    public void updateType(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //extract Status from request body
        InputStream requestBody = request.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(requestBody));

        Reimbursement reimbursement = new JSONConverter().getReimbursement(reader.readLine());
        new BusinessDelegate().updateType(reimbursement);
    }

    /**
     * Adds new reimbursement to database
     * @param request
     * @param response
     * @throws IOException
     */
    public void addReimbursement(HttpServletRequest request, HttpServletResponse response) throws IOException {
        InputStream requestBody = request.getInputStream();
        BufferedReader reader = new BufferedReader(new InputStreamReader(requestBody));

        Reimbursement reimbursement = new JSONConverter().getReimbursement(reader.readLine());

        /**
         * Finds a match between reimbursement type and types in the types list
         * Will set the id of reimbursement type with the one that matches
         */
        List<Type> types = (List<Type>) request.getSession().getAttribute("types");
        for (Type temp : types) {
            if (reimbursement.getType().getType().equals(temp.getType())) {
                reimbursement.getType().setId(temp.getId());
            }
        }
        /*
        setting Reimbursement ID just so it has a value,
        actual ID will be generated from sequence in db
         */
        reimbursement.setId(999);
        reimbursement.setAuthor((User) request.getSession().getAttribute("user"));
        //all new reimbursement have status set to pending
        reimbursement.setStatus(new Status(3, "Pending"));
        System.out.println(reimbursement);

        new BusinessDelegate().addReimbursement(reimbursement);

        //return Reimbursement object, update the table with new reimbursement
        String json = new JSONConverter().getJSON(reimbursement);
        response.setContentType("application/json");
        response.getWriter().print(json);
    }

    public void errorPage(HttpServletRequest request, HttpServletResponse response, String error) throws ServletException, IOException {
        if(error.equals("403"))
            request.getRequestDispatcher("/403.html").forward(request, response);
        if(error.equals("404"))
            request.getRequestDispatcher("/404.html").forward(request, response);
        if(error.equals("500"))
            request.getRequestDispatcher("/500.html").forward(request, response);
    }
}