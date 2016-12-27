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

    public void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new MainController().updateStatus(request, response);
    }

    public void updateType(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new MainController().updateType(request, response);
    }

    public void addReimbursement(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new MainController().addReimbursement(request, response);
    }

    public void validateAmount(HttpServletRequest request, HttpServletResponse response) throws IOException {
        new MainController().validateAmount(request, response);
    }

}
