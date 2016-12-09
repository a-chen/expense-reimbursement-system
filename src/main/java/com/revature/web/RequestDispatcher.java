package com.revature.web;

import com.revature.middle.UserService;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by achen on 12/8/2016.
 */
public class RequestDispatcher extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        String requestURI = request.getRequestURI();
        switch(requestURI){
            case "/ers/login.do":{
                try {
                    new FrontController().login(request, response);
                } catch (AuthenticationException e) {
                    e.printStackTrace();
                }
                break;
            }
            default:{
                response.setStatus(404);
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}
