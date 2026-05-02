package com.jobtracker.controller;

import com.jobtracker.dao.JobApplicationDAO;
import com.jobtracker.model.JobApplication;
import com.jobtracker.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get logged in user
        int userId = (int) session.getAttribute("userId");

        // Fetch data from DB
        JobApplicationDAO applicationDAO = new JobApplicationDAO();

        List<JobApplication> applications =
                applicationDAO.getApplicationsByUserId(userId);

        int totalApplied =
                applicationDAO.getCountByStatus(userId, "APPLIED");
        int totalInterview =
                applicationDAO.getCountByStatus(userId, "INTERVIEW");
        int totalSelected =
                applicationDAO.getCountByStatus(userId, "SELECTED");
        int totalRejected =
                applicationDAO.getCountByStatus(userId, "REJECTED");
        int totalApplications = applications.size();

        // Set as request attributes
        request.setAttribute("applications", applications);
        request.setAttribute("totalApplications", totalApplications);
        request.setAttribute("totalApplied", totalApplied);
        request.setAttribute("totalInterview", totalInterview);
        request.setAttribute("totalSelected", totalSelected);
        request.setAttribute("totalRejected", totalRejected);

        // Forward to dashboard.jsp
        request.getRequestDispatcher(
                "/views/dashboard.jsp").forward(request, response);
    }
}