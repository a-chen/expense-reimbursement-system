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


        //adds session-wide values
            HttpSession session = request.getSession();

            //adds User object to Session scope
            session.setAttribute("currentUser", user);
            //set login status
            Boolean loggedIn = true;
            session.setAttribute("loggedIn", loggedIn);

            List<Type> types = businessDelegate.getType();
            List<Status> statuses = businessDelegate.getStatus();

            //sets types and statuses list to session scope
            session.setAttribute("types", types);
            session.setAttribute("statuses", statuses);


        //stores user data in cookie
        if (user != null) {
            Cookie cookie = new Cookie("username",
                    request.getParameter("username"));
            cookie.setMaxAge(999);
            response.addCookie(cookie);

            /*
            @todo need to move this to right location
            puts Reimbursement list to session scope if user is Admin or HR
             */
            if(user.getRole().getRole().equals("HR") || user.getRole().getRole().equals("Admin")){
                List<Reimbursement> reimbursements = businessDelegate.viewAllReimbursements();
                session.setAttribute("reimbursements", reimbursements);
            }
        }

        // GOTO next page
        request.getRequestDispatcher("index.jsp")
                .forward(request, response);
    }

    /**
     * Redirects user to main page if User object is still in session(logged in)
     * else redirect to login
     *
     * Also returns boolean
     *
     * @param request
     * @param response
     * @return Boolean
     */
    public void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Boolean loggedIn = (Boolean) request.getSession().getAttribute("loggedIn");
        if (loggedIn != null && loggedIn == true) {
            request.getRequestDispatcher("main.jsp").forward(request, response);

        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*Boolean loggedIn = false;
        request.getSession().setAttribute("loggedIn", loggedIn);*/
        HttpSession session = request.getSession();
        if (session != null) {
            session.invalidate();
            response.sendRedirect("login.jsp");
        }

//        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
