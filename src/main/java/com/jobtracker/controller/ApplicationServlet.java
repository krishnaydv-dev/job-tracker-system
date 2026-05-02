package com.jobtracker.controller;

import com.jobtracker.dao.JobApplicationDAO;
import com.jobtracker.model.JobApplication;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/application")
public class ApplicationServlet extends HttpServlet {

    private JobApplicationDAO applicationDAO = new JobApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // Always check session first
        // If not logged in, send back to login
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/views/login.jsp");
            return;
        }

        // Get the action parameter from URL
        // e.g. /application?action=add → action = "add"
        String action = request.getParameter("action");

        if (action == null) action = "list";

        switch (action) {

            case "add":
                // Just forward to the add form page
                // No DB call needed — just show empty form
                request.getRequestDispatcher(
                                "/views/addApplication.jsp")
                        .forward(request, response);
                break;

            case "edit":
                // Get the application id from URL
                // e.g. /application?action=edit&id=3
                int editId = Integer.parseInt(
                        request.getParameter("id"));

                // Fetch that specific application from DB
                JobApplication app =
                        applicationDAO.getApplicationById(editId);

                // Put it in request so JSP can display it
                request.setAttribute("application", app);

                // Forward to edit form with pre-filled data
                request.getRequestDispatcher(
                                "/views/editApplication.jsp")
                        .forward(request, response);
                break;

            case "delete":
                // Get id and delete from DB
                int deleteId = Integer.parseInt(
                        request.getParameter("id"));
                applicationDAO.deleteApplication(deleteId);

                // Go back to dashboard after delete
                response.sendRedirect(
                        request.getContextPath() + "/dashboard");
                break;

            case "list":
                // Get logged in user's id from session
                int userId = (int) session.getAttribute("userId");

                // Fetch all their applications
                List<JobApplication> applications =
                        applicationDAO.getApplicationsByUserId(userId);

                // Put list in request for JSP to display
                request.setAttribute("applications", applications);

                request.getRequestDispatcher(
                                "/views/viewApplications.jsp")
                        .forward(request, response);
                break;

            default:
                response.sendRedirect(
                        request.getContextPath() + "/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/views/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("save".equals(action)) {
            // Collect form data
            // request.getParameter gets value from HTML form field
            int userId = (int) session.getAttribute("userId");
            String companyName = request.getParameter("companyName");
            String jobRole = request.getParameter("jobRole");
            String status = request.getParameter("status");
            String dateApplied = request.getParameter("dateApplied");
            int experienceYears = Integer.parseInt(
                    request.getParameter("experienceYears"));
            String jobDescription = request.getParameter("jobDescription");
            String notes = request.getParameter("notes");

            // Build JobApplication object from form data
            JobApplication application = new JobApplication();
            application.setUserId(userId);
            application.setCompanyName(companyName);
            application.setJobRole(jobRole);
            application.setStatus(status);
            application.setDateApplied(dateApplied);
            application.setExperienceYears(experienceYears);
            application.setJobDescription(jobDescription);
            application.setNotes(notes);

            // Save to DB via DAO
            applicationDAO.addApplication(application);

            // Redirect to dashboard to see updated stats
            response.sendRedirect(
                    request.getContextPath() + "/dashboard");

        } else if ("update".equals(action)) {
            // Same as save but we also get the id
            // because we need to know WHICH application to update
            int id = Integer.parseInt(request.getParameter("id"));
            String companyName = request.getParameter("companyName");
            String jobRole = request.getParameter("jobRole");
            String status = request.getParameter("status");
            String dateApplied = request.getParameter("dateApplied");
            int experienceYears = Integer.parseInt(
                    request.getParameter("experienceYears"));
            String jobDescription = request.getParameter("jobDescription");
            String notes = request.getParameter("notes");

            // Build object with updated data
            JobApplication application = new JobApplication();
            application.setId(id);
            application.setCompanyName(companyName);
            application.setJobRole(jobRole);
            application.setStatus(status);
            application.setDateApplied(dateApplied);
            application.setExperienceYears(experienceYears);
            application.setJobDescription(jobDescription);
            application.setNotes(notes);

            // Update in DB
            applicationDAO.updateApplication(application);

            // Back to dashboard
            response.sendRedirect(
                    request.getContextPath() + "/dashboard");
        }
    }
}