<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.jobtracker.model.JobApplication" %>
<%
    if (session.getAttribute("user") == null ||
        !"ADMIN".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath()
            + "/views/login.jsp");
        return;
    }
    List<JobApplication> applications =
        (List<JobApplication>) request.getAttribute("applications");
    String filterStatus = (String) request.getAttribute("filterStatus");
    String filterRole = (String) request.getAttribute("filterRole");
    if (filterStatus == null) filterStatus = "";
    if (filterRole == null) filterRole = "";
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Applicants - Admin</title>
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
        .sidebar a:hover { background-color: #2c3e50; color: white; }
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
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <div class="sidebar p-0" style="width: 240px; min-width: 240px;">
        <span class="brand">
            <i class="bi bi-briefcase-fill me-2"></i>Job Tracker
            <span class="badge-admin">ADMIN</span>
        </span>
        <div class="mt-2">
            <a href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-speedometer2"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
               class="active">
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

    <div class="flex-grow-1 p-4">

        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h4 class="mb-0">All Applicants</h4>
                <small class="text-muted">
                    View, filter and manage all applications
                </small>
            </div>
        </div>

        <% if ("noResume".equals(error)) { %>
            <div class="alert alert-warning d-flex align-items-center">
                <i class="bi bi-exclamation-triangle me-2"></i>
                This student has not uploaded a resume yet.
            </div>
        <% } else if ("resumeNotFound".equals(error)) { %>
            <div class="alert alert-danger d-flex align-items-center">
                <i class="bi bi-x-circle me-2"></i>
                Resume file not found on server.
            </div>
        <% } %>

        <div class="card shadow-sm mb-4">
            <div class="card-header bg-white py-3">
                <h6 class="mb-0 fw-bold">
                    <i class="bi bi-funnel me-2"></i>Filter Applicants
                </h6>
            </div>
            <div class="card-body">
                <form method="get"
                      action="${pageContext.request.contextPath}/admin"
                      class="row g-3 align-items-end">
                    <input type="hidden" name="action" value="viewApplicants"/>
                    <div class="col-md-4">
                        <label class="form-label" style="font-size:14px;">
                            Status
                        </label>
                        <select name="filterStatus" class="form-control">
                            <option value="">All Status</option>
                            <option value="APPLIED"
                                <%= "APPLIED".equals(filterStatus) ? "selected" : "" %>>
                                Applied
                            </option>
                            <option value="INTERVIEW"
                                <%= "INTERVIEW".equals(filterStatus) ? "selected" : "" %>>
                                Interview
                            </option>
                            <option value="SELECTED"
                                <%= "SELECTED".equals(filterStatus) ? "selected" : "" %>>
                                Selected
                            </option>
                            <option value="REJECTED"
                                <%= "REJECTED".equals(filterStatus) ? "selected" : "" %>>
                                Rejected
                            </option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label" style="font-size:14px;">
                            Job Role
                        </label>
                        <input type="text" name="filterRole"
                               class="form-control"
                               value="<%= filterRole %>"
                               placeholder="e.g. developer"/>
                    </div>
                    <div class="col-md-4 d-flex gap-2">
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-funnel me-1"></i> Apply Filter
                        </button>
                        <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
                           class="btn btn-outline-secondary">Clear</a>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white d-flex
                        justify-content-between align-items-center py-3">
                <h6 class="mb-0 fw-bold">
                    <i class="bi bi-table me-2"></i>Applications
                    <% if (!filterStatus.isEmpty() || !filterRole.isEmpty()) { %>
                        <span class="badge bg-danger ms-2">Filtered</span>
                    <% } %>
                </h6>
                <span class="text-muted" style="font-size:13px;">
                    Total: <%= applications != null ? applications.size() : 0 %> results
                </span>
            </div>
            <div class="card-body p-0">
                <% if (applications == null || applications.isEmpty()) { %>
                    <div class="text-center py-5">
                        <i class="bi bi-inbox"
                           style="font-size:3rem; color:#dee2e6;"></i>
                        <p class="text-muted mt-2">No applications found.</p>
                    </div>
                <% } else { %>
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th>#</th>
                                <th>User ID</th>
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
                                <td>
                                    <span class="badge bg-secondary">
                                        #<%= app.getUserId() %>
                                    </span>
                                </td>
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
                                    <a href="${pageContext.request.contextPath}/admin?action=viewResume&userId=<%= app.getUserId() %>"
                                       class="btn btn-sm btn-outline-info mb-1"
                                       target="_blank">
                                        <i class="bi bi-file-earmark-pdf"></i> Resume
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin?action=shortlist&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-outline-success mb-1"
                                       onclick="return confirm('Shortlist this applicant?')">
                                        <i class="bi bi-check-circle"></i> Shortlist
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin?action=reject&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-outline-danger mb-1"
                                       onclick="return confirm('Reject this applicant?')">
                                        <i class="bi bi-x-circle"></i> Reject
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