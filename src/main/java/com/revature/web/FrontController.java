package com.revature.web;

import com.revature.beans.Reimbursement;
import com.revature.beans.User;
import com.revature.middle.BusinessDelegate;
import com.revature.middle.UserService;

import javax.naming.AuthenticationException;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by achen on 12/8/2016.
 */

public class FrontController {

    public void login(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException, ServletException, IOException {
        new MainController().login(request, response);
    }



}
