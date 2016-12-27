package com.revature.web;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by achen on 12/8/2016.
 */
public class RequestDispatcher extends HttpServlet {



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String requestURI = request.getRequestURI();
        switch (requestURI) {
            case "/ers/login": {
                request.getRequestDispatcher("WEB-INF/secure/login.jsp").forward(request, response);
                break;
            }
            case "/ers/login.do": {
                try {
                    new FrontController().login(request, response);
                } catch (AuthenticationException e) {
                    e.printStackTrace();
                }
                break;
            }
            case "/ers/logout.do": {
                new FrontController().logout(request, response);
                break;
            }
            case "/ers/main": {
                new FrontController().doMain(request, response);
                break;
            }
            case "/ers/index.html": {
                new FrontController().doMain(request, response);
                break;
            }
            case "/ers/updateStatus.do": {
                new FrontController().updateStatus(request, response);
                break;
            }
            case "/ers/updateType.do": {
                new FrontController().updateType(request, response);
                break;
            }
            case "/ers/addReimbursement.do": {
                new FrontController().addReimbursement(request, response);
                break;
            }
            case "/ers/validateInputAmount.do": {
                new FrontController().validateAmount(request, response);
                break;
            }

            default: {
                response.setStatus(404);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
