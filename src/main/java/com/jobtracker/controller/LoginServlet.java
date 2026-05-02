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

    private UserDAO userDAO = new UserDAO();

    // Show login page
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
                "/views/login.jsp").forward(request, response);
    }

    // Handle login form submission
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        User user = userDAO.loginUser(email, password);

        if (user != null) {
            // Create session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("role", user.getRole());

            // Redirect based on role
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(
                        request.getContextPath() +
                                "/views/admin/adminDashboard.jsp");
            } else {
                response.sendRedirect(
                        request.getContextPath() + "/dashboard");
            }
        } else {
            // Login failed
            request.setAttribute("error",
                    "Invalid email or password. Please try again.");
            request.getRequestDispatcher(
                    "/views/login.jsp").forward(request, response);
        }
    }
}