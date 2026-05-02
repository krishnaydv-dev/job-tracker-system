<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobtracker.model.JobApplication" %>
<%
    // Session check
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");

    List<JobApplication> applications =
        (List<JobApplication>) request.getAttribute("applications");
    int totalApplications = (Integer) request.getAttribute("totalApplications") != null
        ? (Integer) request.getAttribute("totalApplications") : 0;
    int totalApplied = request.getAttribute("totalApplied") != null
        ? (Integer) request.getAttribute("totalApplied") : 0;
    int totalInterview = request.getAttribute("totalInterview") != null
        ? (Integer) request.getAttribute("totalInterview") : 0;
    int totalSelected = request.getAttribute("totalSelected") != null
        ? (Integer) request.getAttribute("totalSelected") : 0;
    int totalRejected = request.getAttribute("totalRejected") != null
        ? (Integer) request.getAttribute("totalRejected") : 0;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #2c3e50;
        }
        .sidebar a {
            color: #ecf0f1;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
        }
        .sidebar a:hover {
            background-color: #34495e;
        }
        .stat-card {
            border-radius: 10px;
            color: white;
            padding: 20px;
        }
    </style>
</head>
<body class="bg-light">

<div class="d-flex">

    <!-- Sidebar -->
    <div class="sidebar p-3" style="width: 220px;">
        <h5 class="text-white mb-4">Job Tracker</h5>
        <a href="${pageContext.request.contextPath}/dashboard">
            🏠 Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/application?action=add">
            ➕ Add Application
        </a>
        <a href="${pageContext.request.contextPath}/application?action=list">
            📋 My Applications
        </a>
        <a href="${pageContext.request.contextPath}/views/uploadResume.jsp">
            📄 Upload Resume
        </a>
        <a href="${pageContext.request.contextPath}/logout"
           class="mt-5" style="color:#e74c3c;">
            🚪 Logout
        </a>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4">

        <!-- Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h4>Welcome back, <%= userName %>! 👋</h4>
        </div>

        <!-- Stats Cards -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-primary">
                    <h6>Total Applications</h6>
                    <h2><%= totalApplications %></h2>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-warning">
                    <h6>Applied</h6>
                    <h2><%= totalApplied %></h2>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-info">
                    <h6>Interviews</h6>
                    <h2><%= totalInterview %></h2>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-success">
                    <h6>Selected</h6>
                    <h2><%= totalSelected %></h2>
                </div>
            </div>
        </div>

        <!-- Recent Applications Table -->
        <div class="card shadow-sm">
            <div class="card-header d-flex
                        justify-content-between align-items-center">
                <h5 class="mb-0">Recent Applications</h5>
                <a href="${pageContext.request.contextPath}/application?action=add"
                   class="btn btn-primary btn-sm">
                   + Add New
                </a>
            </div>
            <div class="card-body">
                <% if (applications == null || applications.isEmpty()) { %>
                    <div class="text-center py-4">
                        <p class="text-muted">
                            No applications yet.
                            Add your first application!
                        </p>
                        <a href="${pageContext.request.contextPath}/application?action=add"
                           class="btn btn-primary">
                           Add Application
                        </a>
                    </div>
                <% } else { %>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Company</th>
                                <th>Job Role</th>
                                <th>Status</th>
                                <th>Date Applied</th>
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
                                    String badgeClass = "bg-secondary";
                                    if ("APPLIED".equals(status))
                                        badgeClass = "bg-warning text-dark";
                                    else if ("INTERVIEW".equals(status))
                                        badgeClass = "bg-info text-dark";
                                    else if ("SELECTED".equals(status))
                                        badgeClass = "bg-success";
                                    else if ("REJECTED".equals(status))
                                        badgeClass = "bg-danger";
                                    %>
                                    <span class="badge <%= badgeClass %>">
                                        <%= status %>
                                    </span>
                                </td>
                                <td><%= app.getDateApplied() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/application?action=edit&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-outline-primary">
                                       Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/application?action=delete&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete this application?')">
                                       Delete
                                    </a>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                <% } %>
            </div>
        </div>

    </div>
</div>

</body>
</html>