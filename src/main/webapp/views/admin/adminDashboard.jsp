<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobtracker.model.User" %>
<%
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
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #1a252f;
            position: sticky;
            top: 0;
        }
        .sidebar .brand {
            color: white;
            font-size: 18px;
            font-weight: 600;
            padding: 20px;
            border-bottom: 1px solid #2c3e50;
            display: block;
        }
        .sidebar .badge-admin {
            background: #e74c3c;
            color: white;
            font-size: 10px;
            padding: 2px 8px;
            border-radius: 10px;
            margin-left: 8px;
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
        .sidebar a:hover {
            background-color: #2c3e50;
            color: white;
        }
        .sidebar a.active {
            background-color: #2c3e50;
            color: white;
            border-left: 3px solid #e74c3c;
        }
        .sidebar .logout-link { color: #e74c3c !important; }
        .sidebar .logout-link:hover {
            background-color: #c0392b !important;
            color: white !important;
        }
        .stat-card {
            border-radius: 10px;
            color: white;
            padding: 20px;
            transition: transform 0.2s;
        }
        .stat-card:hover { transform: translateY(-3px); }
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <!-- Sidebar -->
    <div class="sidebar p-0" style="width: 240px; min-width: 240px;">
        <span class="brand">
            <i class="bi bi-briefcase-fill me-2"></i>Job Tracker
            <span class="badge-admin">ADMIN</span>
        </span>
        <div class="mt-2">
            <a href="${pageContext.request.contextPath}/admin"
               class="active">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=viewApplicants">
                <i class="bi bi-people"></i> View Applicants
            </a>
        </div>
        <div style="position: absolute; bottom: 20px; width: 240px;">
            <a href="${pageContext.request.contextPath}/logout"
               class="logout-link">
                <i class="bi bi-box-arrow-right"></i> Logout
            </a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="flex-grow-1 p-4">

        <!-- Header -->
        <div class="d-flex justify-content-between
                    align-items-center mb-4">
            <div>
                <h4 class="mb-0">Welcome, <%= adminName %>!</h4>
                <small class="text-muted">
                    Here is the overall system summary
                </small>
            </div>
            <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
               class="btn btn-danger">
                <i class="bi bi-people me-1"></i> View Applicants
            </a>
        </div>

        <!-- Stats Row 1 -->
        <div class="row mb-3">
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-dark">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Total Students
                            </p>
                            <h2 class="mb-0"><%= totalUsers %></h2>
                        </div>
                        <i class="bi bi-mortarboard"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-primary">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Total Applications
                            </p>
                            <h2 class="mb-0"><%= totalApplications %></h2>
                        </div>
                        <i class="bi bi-collection"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-warning">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Applied
                            </p>
                            <h2 class="mb-0"><%= totalApplied %></h2>
                        </div>
                        <i class="bi bi-send"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-info">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Interviews
                            </p>
                            <h2 class="mb-0"><%= totalInterview %></h2>
                        </div>
                        <i class="bi bi-people"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Stats Row 2 -->
        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-success">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Selected
                            </p>
                            <h2 class="mb-0"><%= totalSelected %></h2>
                        </div>
                        <i class="bi bi-check-circle"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="stat-card bg-danger">
                    <div class="d-flex justify-content-between">
                        <div>
                            <p class="mb-1" style="font-size:13px;">
                                Rejected
                            </p>
                            <h2 class="mb-0"><%= totalRejected %></h2>
                        </div>
                        <i class="bi bi-x-circle"
                           style="font-size:2rem; opacity:0.7;"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Registered Students Table -->
        <div class="card shadow-sm">
            <div class="card-header bg-white d-flex
                        justify-content-between align-items-center py-3">
                <h6 class="mb-0 fw-bold">
                    <i class="bi bi-people me-2"></i>
                    Registered Students
                </h6>
                <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
                   class="btn btn-outline-danger btn-sm">
                    View All Applications
                </a>
            </div>
            <div class="card-body p-0">
                <% if (allUsers == null || allUsers.isEmpty()) { %>
                    <div class="text-center py-5">
                        <i class="bi bi-people"
                           style="font-size:3rem; color:#dee2e6;"></i>
                        <p class="text-muted mt-2">
                            No students registered yet.
                        </p>
                    </div>
                <% } else { %>
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
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
                                <td>
                                    <div class="d-flex align-items-center gap-2">
                                        <div style="width:32px; height:32px;
                                             border-radius:50%;
                                             background:#3498db;
                                             color:white;
                                             display:flex;
                                             align-items:center;
                                             justify-content:center;
                                             font-size:13px;
                                             font-weight:500;">
                                            <%= user.getFullName()
                                                .substring(0,1)
                                                .toUpperCase() %>
                                        </div>
                                        <%= user.getFullName() %>
                                    </div>
                                </td>
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