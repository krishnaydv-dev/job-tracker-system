package com.jobtracker.controller;

import com.jobtracker.dao.UserDAO;
import com.jobtracker.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    // Show register page
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(
                "/views/register.jsp").forward(request, response);
    }

    // Handle register form submission
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");

        UserDAO userDAO = new UserDAO();

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error",
                    "Email already registered. Please use a different email.");
            request.getRequestDispatcher(
                    "/views/register.jsp").forward(request, response);
            return;
        }

        // Create user object
        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setRole("STUDENT");

        // Save to database
        boolean success = userDAO.registerUser(user);

        if (success) {
            request.setAttribute("success",
                    "Registration successful! Please login.");
            request.getRequestDispatcher(
                    "/views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error",
                    "Registration failed. Please try again.");
            request.getRequestDispatcher(
                    "/views/register.jsp").forward(request, response);
        }
    }
}