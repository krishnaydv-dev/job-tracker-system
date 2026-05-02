package com.jobtracker.controller;

import com.jobtracker.dao.UserDAO;
import com.jobtracker.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
                "/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, password);

        System.out.println("User returned: " + user);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("role", user.getRole());

            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(
                        request.getContextPath() + "/admin");
            } else {
                response.sendRedirect(
                        request.getContextPath() + "/dashboard");
            }
        } else {
            request.setAttribute("error",
                    "Invalid email or password. Please try again.");
            request.getRequestDispatcher(
                    "/views/login.jsp").forward(request, response);
        }
    }
}