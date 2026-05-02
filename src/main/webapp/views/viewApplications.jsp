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
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #2c3e50;
            position: sticky;
            top: 0;
        }
        .sidebar .brand {
            color: white;
            font-size: 18px;
            font-weight: 600;
            padding: 20px;
            border-bottom: 1px solid #34495e;
            display: block;
        }
        .sidebar a {
            color: #bdc3c7;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 20px;
            font-size: 14px;
            transition: all 0.2s;
        }
        .sidebar a:hover { background-color: #34495e; color: white; }
        .sidebar a.active {
            background-color: #34495e;
            color: white;
            border-left: 3px solid #3498db;
        }
        .sidebar .logout-link { color: #e74c3c !important; }
        .sidebar .logout-link:hover {
            background-color: #c0392b !important;
            color: white !important;
        }
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <div class="sidebar p-0" style="width: 240px; min-width: 240px;">
        <span class="brand">
            <i class="bi bi-briefcase-fill me-2"></i>Job Tracker
        </span>
        <div class="mt-2">
            <a href="${pageContext.request.contextPath}/dashboard">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/application?action=add">
                <i class="bi bi-plus-circle"></i> Add Application
            </a>
            <a href="${pageContext.request.contextPath}/application?action=list"
               class="active">
                <i class="bi bi-list-ul"></i> My Applications
            </a>
            <a href="${pageContext.request.contextPath}/views/uploadResume.jsp">
                <i class="bi bi-file-earmark-arrow-up"></i> Upload Resume
            </a>
        </div>
        <div style="position: absolute; bottom: 20px; width: 240px;">
            <a href="${pageContext.request.contextPath}/logout"
               class="logout-link">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>

    <div class="flex-grow-1 p-4">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="mb-0">My Applications</h4>
                <small class="text-muted">
                    All your job applications in one place
                </small>
            </div>
            <a href="${pageContext.request.contextPath}/application?action=add"
               class="btn btn-primary">
                <i class="bi bi-plus-circle me-1"></i> Add New
            </a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <% if (applications == null || applications.isEmpty()) { %>
                    <div class="text-center py-5">
                        <i class="bi bi-inbox"
                           style="font-size:3rem; color:#dee2e6;"></i>
                        <p class="text-muted mt-2">
                            No applications found.
                        </p>
                        <a href="${pageContext.request.contextPath}/application?action=add"
                           class="btn btn-primary btn-sm">
                            Add your first application
                        </a>
                    </div>
                <% } else { %>
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
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
                                <td><strong><%= app.getCompanyName() %></strong></td>
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
                                        <i class="bi bi-pencil"></i> Edit
                                    </a>
                                    <a href="${pageContext.request.contextPath}/application?action=delete&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-outline-danger"
                                       onclick="return confirm('Delete this application?')">
                                        <i class="bi bi-trash"></i> Delete
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