package com.revature.web;

import com.revature.beans.Reimbursement;
import com.revature.beans.Status;
import com.revature.beans.Type;
import com.revature.beans.User;
import com.revature.middle.BusinessDelegate;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Created by achen on 12/8/2016.
 */
public class MainController {

    public void login(HttpServletRequest request, HttpServletResponse response) throws
            AuthenticationException,
            ServletException,
            IOException {

        //authenticating
        BusinessDelegate businessDelegate = new BusinessDelegate();

        User user = businessDelegate.login(
                request.getParameter("username"),
                request.getParameter("password"));

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
        doMain(request, response);
        checkLogin(request, response);
    }

    /**
     * Checks if user is logged in
     *
     * @param request
     * @param response
     * @return Boolean
     */
    public Boolean checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        return (session != null && session.getAttribute("user") != null);
    }

    public void doMain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //if not logged in, redirect to login page
        if (!checkLogin(request, response)) {
            response.sendRedirect("login.jsp");
        } else {
            populateReimbursements(request, response);
            request.getRequestDispatcher("main.jsp").forward(request, response);
        }
    }

    //@todo
    public void updateReimbursements(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("reimbursementTable.do clicked");


    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if(session != null)
            session.invalidate();
        System.out.println(request.getSession(false));
        response.sendRedirect("login.jsp");
    }


    /**
     * Puts Reimbursement list to request scope if user is Admin or HR
     * Otherwise, display a user's own reimbursements
     * @param request
     * @param response
     */
    void populateReimbursements(HttpServletRequest request, HttpServletResponse response) {
        User user = (User) request.getSession().getAttribute("user");
        List<Reimbursement> reimbursements = new BusinessDelegate().viewReimbs(user);
        request.setAttribute("reimbursements", reimbursements);
    }



}