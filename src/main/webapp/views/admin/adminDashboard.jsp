<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobtracker.model.User" %>
<%
    // Double check — must be logged in AND admin
    if (session.getAttribute("user") == null ||
        !"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }

    String adminName = (String) session.getAttribute("userName");
    int totalUsers = request.getAttribute("totalUsers") != null
        ? (Integer) request.getAttribute("totalUsers") : 0;
    int totalApplications =
        request.getAttribute("totalApplications") != null
        ? (Integer) request.getAttribute("totalApplications") : 0;
    int totalApplied = request.getAttribute("totalApplied") != null
        ? (Integer) request.getAttribute("totalApplied") : 0;
    int totalInterview =
        request.getAttribute("totalInterview") != null
        ? (Integer) request.getAttribute("totalInterview") : 0;
    int totalSelected =
        request.getAttribute("totalSelected") != null
        ? (Integer) request.getAttribute("totalSelected") : 0;
    int totalRejected =
        request.getAttribute("totalRejected") != null
        ? (Integer) request.getAttribute("totalRejected") : 0;

    List<User> allUsers =
        (List<User>) request.getAttribute("allUsers");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #1a252f;
        }
        .sidebar a {
            color: #ecf0f1;
            text-decoration: none;
            display: block;
            padding: 12px 20px;
        }
        .sidebar a:hover { background-color: #2c3e50; }
        .stat-card {
            border-radius: 10px;
            color: white;
            padding: 20px;
        }
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <!-- Admin Sidebar -->
    <div class="sidebar p-3" style="width: 220px;">
        <h5 class="text-white mb-1">Job Tracker</h5>
        <small style="color:#95a5a6;">Admin Panel</small>
        <hr style="border-color:#2c3e50;">
        <a href="${pageContext.request.contextPath}/admin">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin?action=viewApplicants">
            View Applicants
        </a>
        <a href="${pageContext.request.contextPath}/logout"
           style="color:#e74c3c; margin-top: 20px;">
            Logout
        </a>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4">

        <h4 class="mb-4">Welcome, <%= adminName %>!</h4>

        <!-- Stats Row 1 -->
        <div class="row mb-3">
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-dark">
                    <h6>Total Students</h6>
                    <h2><%= totalUsers %></h2>
                </div>
            </div>
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
        </div>

        <!-- Stats Row 2 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-success">
                    <h6>Selected</h6>
                    <h2><%= totalSelected %></h2>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-danger">
                    <h6>Rejected</h6>
                    <h2><%= totalRejected %></h2>
                </div>
            </div>
        </div>

        <!-- Registered Students Table -->
        <div class="card shadow-sm">
            <div class="card-header d-flex
                        justify-content-between align-items-center">
                <h5 class="mb-0">Registered Students</h5>
                <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
                   class="btn btn-primary btn-sm">
                   View All Applications
                </a>
            </div>
            <div class="card-body">
                <% if (allUsers == null || allUsers.isEmpty()) { %>
                    <p class="text-muted text-center">
                        No students registered yet.
                    </p>
                <% } else { %>
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Phone</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% int i = 1;
                               for (User user : allUsers) { %>
                            <tr>
                                <td><%= i++ %></td>
                                <td><%= user.getFullName() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getPhone() %></td>
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