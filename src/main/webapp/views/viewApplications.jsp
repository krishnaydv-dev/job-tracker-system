<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobtracker.model.JobApplication" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
    List<JobApplication> applications =
        (List<JobApplication>) request.getAttribute("applications");
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Applications - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h4>My Applications</h4>
        <div>
            <a href="${pageContext.request.contextPath}/application?action=add"
               class="btn btn-primary btn-sm">+ Add New</a>
            <a href="${pageContext.request.contextPath}/dashboard"
               class="btn btn-secondary btn-sm">Dashboard</a>
        </div>
    </div>

    <% if (applications == null || applications.isEmpty()) { %>
        <div class="alert alert-info">
            No applications found. Add your first one!
        </div>
    <% } else { %>
        <table class="table table-bordered table-hover bg-white">
            <thead class="table-dark">
                <tr>
                    <th>#</th>
                    <th>Company</th>
                    <th>Job Role</th>
                    <th>Status</th>
                    <th>Date Applied</th>
                    <th>Experience</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% int i = 1;
                   for (JobApplication app : applications) { %>
                <tr>
                    <td><%= i++ %></td>
                    <td><%= app.getCompanyName() %></td>
                    <td><%= app.getJobRole() %></td>
                    <td>
                        <%
                        String status = app.getStatus();
                        String badge = "bg-secondary";
                        if ("APPLIED".equals(status))
                            badge = "bg-warning text-dark";
                        else if ("INTERVIEW".equals(status))
                            badge = "bg-info text-dark";
                        else if ("SELECTED".equals(status))
                            badge = "bg-success";
                        else if ("REJECTED".equals(status))
                            badge = "bg-danger";
                        %>
                        <span class="badge <%= badge %>">
                            <%= status %>
                        </span>
                    </td>
                    <td><%= app.getDateApplied() %></td>
                    <td><%= app.getExperienceYears() %> yrs</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/application?action=edit&id=<%= app.getId() %>"
                           class="btn btn-sm btn-outline-primary">
                           Edit
                        </a>
                        <a href="${pageContext.request.contextPath}/application?action=delete&id=<%= app.getId() %>"
                           class="btn btn-sm btn-outline-danger"
                           onclick="return confirm('Are you sure?')">
                           Delete
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } %>
</div>
</body>
</html>