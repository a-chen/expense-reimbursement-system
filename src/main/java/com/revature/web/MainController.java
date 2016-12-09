package com.revature.web;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.middle.BusinessDelegate;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        //adds User object to Session scope
        request.getSession().setAttribute("currentUser", user);

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
                request.getSession().setAttribute("reimbursements", reimbursements);
            }
        }

        // GOTO next page
        request.getRequestDispatcher("index.jsp")
                .forward(request, response);
    }
}
