package com.revature.web;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by achen on 12/8/2016.
 */

public class FrontController {

    public void login(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, ServletException, IOException {
        new MainController().login(request, response);
    }

    public void checkLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new MainController().checkLogin(request, response);
    }

    public void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new MainController().logout(request, response);
    }

    public void doMain(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        new MainController().doMain(request, response);
    }

    public void updateReimbursements(HttpServletRequest request, HttpServletResponse response) {
        new MainController().updateReimbursements(request, response);
    }
}
