package com.jobtracker.controller;

import com.jobtracker.dao.JobApplicationDAO;
import com.jobtracker.dao.UserDAO;
import com.jobtracker.model.JobApplication;
import com.jobtracker.model.User;
import com.jobtracker.dao.ResumeDAO;
import com.jobtracker.model.Resume;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();
    private JobApplicationDAO applicationDAO = new JobApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Step 1 — check login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Step 2 — check admin role
        // Students should never access admin pages
        String role = (String) session.getAttribute("role");
        if (!"ADMIN".equals(role)) {
            response.sendRedirect(
                    request.getContextPath() + "/dashboard");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) action = "dashboard";

        switch (action) {

            case "dashboard":
                // Fetch stats for admin dashboard
                List<User> allUsers = userDAO.getAllUsers();
                List<JobApplication> allApplications =
                        applicationDAO.getAllApplications();

                // Count total applications by status
                int totalApplied = 0, totalInterview = 0,
                        totalSelected = 0, totalRejected = 0;

                for (JobApplication app : allApplications) {
                    switch (app.getStatus()) {
                        case "APPLIED": totalApplied++; break;
                        case "INTERVIEW": totalInterview++; break;
                        case "SELECTED": totalSelected++; break;
                        case "REJECTED": totalRejected++; break;
                    }
                }

                request.setAttribute("allUsers", allUsers);
                request.setAttribute("totalUsers", allUsers.size());
                request.setAttribute("totalApplications",
                        allApplications.size());
                request.setAttribute("totalApplied", totalApplied);
                request.setAttribute("totalInterview", totalInterview);
                request.setAttribute("totalSelected", totalSelected);
                request.setAttribute("totalRejected", totalRejected);

                request.getRequestDispatcher(
                                "/views/admin/adminDashboard.jsp")
                        .forward(request, response);
                break;

            case "viewApplicants":
                // Get filter parameters from URL if any
                // e.g. /admin?action=viewApplicants&status=APPLIED
                String filterStatus =
                        request.getParameter("filterStatus");
                String filterRole =
                        request.getParameter("filterRole");

                List<JobApplication> applications;

                // If filters applied, filter the list
                // Otherwise get all applications
                applications = applicationDAO.getAllApplications();

                // Apply filters in Java
                if (filterStatus != null
                        && !filterStatus.isEmpty()) {
                    applications.removeIf(app ->
                            !app.getStatus().equals(filterStatus));
                }
                if (filterRole != null
                        && !filterRole.isEmpty()) {
                    applications.removeIf(app ->
                            !app.getJobRole().toLowerCase()
                                    .contains(filterRole.toLowerCase()));
                }

                request.setAttribute("applications", applications);
                request.setAttribute("filterStatus", filterStatus);
                request.setAttribute("filterRole", filterRole);

                request.getRequestDispatcher(
                                "/views/admin/viewApplicants.jsp")
                        .forward(request, response);
                break;

            case "shortlist":
                // Get application id from URL
                int appId = Integer.parseInt(
                        request.getParameter("id"));

                // Update status to SELECTED
                JobApplication app =
                        applicationDAO.getApplicationById(appId);
                if (app != null) {
                    app.setStatus("SELECTED");
                    applicationDAO.updateApplication(app);
                }

                response.sendRedirect(request.getContextPath()
                        + "/admin?action=viewApplicants");
                break;

            case "reject":
                // Get application id and update to REJECTED
                int rejectId = Integer.parseInt(
                        request.getParameter("id"));

                JobApplication rejectApp =
                        applicationDAO.getApplicationById(rejectId);
                if (rejectApp != null) {
                    rejectApp.setStatus("REJECTED");
                    applicationDAO.updateApplication(rejectApp);
                }

                response.sendRedirect(request.getContextPath()
                        + "/admin?action=viewApplicants");
                break;

            case "viewResume":
                // Get userId from URL
                // e.g. /admin?action=viewResume&userId=3
                int resumeUserId = Integer.parseInt(
                        request.getParameter("userId"));

                // Fetch resume from DB
                ResumeDAO resumeDAO = new ResumeDAO();
                Resume resume = resumeDAO.getResumeByUserId(resumeUserId);

                if (resume != null) {
                    // Get actual file path on server
                    String filePath = getServletContext()
                            .getRealPath(resume.getFilePath());

                    java.io.File file = new java.io.File(filePath);

                    if (file.exists()) {
                        // Tell browser this is a PDF file
                        response.setContentType("application/pdf");
                        // Open in browser instead of downloading
                        response.setHeader("Content-Disposition",
                                "inline; filename=\"" + resume.getFileName() + "\"");
                        response.setContentLength((int) file.length());

                        // Stream file to browser
                        try (java.io.FileInputStream fis =
                                     new java.io.FileInputStream(file);
                             java.io.OutputStream os =
                                     response.getOutputStream()) {

                            byte[] buffer = new byte[1024];
                            int bytesRead;
                            while ((bytesRead = fis.read(buffer)) != -1) {
                                os.write(buffer, 0, bytesRead);
                            }
                        }
                    } else {
                        // File not found on server
                        response.sendRedirect(request.getContextPath()
                                + "/admin?action=viewApplicants&error=resumeNotFound");
                    }
                } else {
                    // No resume in DB for this user
                    response.sendRedirect(request.getContextPath()
                            + "/admin?action=viewApplicants&error=noResume");
                }
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/admin");
        }
    }
}