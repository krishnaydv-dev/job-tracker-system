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
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Applicants - Admin</title>
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
    </style>
</head>
<body class="bg-light">
<div class="d-flex">

    <!-- Sidebar -->
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

        <h4 class="mb-4">All Applicants</h4>

        <!-- Filter Form -->
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <form method="get"
                      action="${pageContext.request.contextPath}/admin"
                      class="row g-3">
                    <input type="hidden"
                           name="action" value="viewApplicants"/>

                    <div class="col-md-4">
                        <label>Filter by Status</label>
                        <select name="filterStatus"
                                class="form-control">
                            <option value="">All Status</option>
                            <option value="APPLIED"
                                <%= "APPLIED".equals(filterStatus)
                                    ? "selected" : "" %>>
                                Applied
                            </option>
                            <option value="INTERVIEW"
                                <%= "INTERVIEW".equals(filterStatus)
                                    ? "selected" : "" %>>
                                Interview
                            </option>
                            <option value="SELECTED"
                                <%= "SELECTED".equals(filterStatus)
                                    ? "selected" : "" %>>
                                Selected
                            </option>
                            <option value="REJECTED"
                                <%= "REJECTED".equals(filterStatus)
                                    ? "selected" : "" %>>
                                Rejected
                            </option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label>Filter by Job Role</label>
                        <input type="text"
                               name="filterRole"
                               class="form-control"
                               value="<%= filterRole %>"
                               placeholder="e.g. developer"/>
                    </div>

                    <div class="col-md-4 d-flex align-items-end gap-2">
                        <button type="submit"
                                class="btn btn-primary">
                            Apply Filter
                        </button>
                        <a href="${pageContext.request.contextPath}/admin?action=viewApplicants"
                           class="btn btn-secondary">
                            Clear
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <!-- Applications Table -->
        <div class="card shadow-sm">
            <div class="card-body">
                <% if (applications == null
                       || applications.isEmpty()) { %>
                    <p class="text-center text-muted">
                        No applications found.
                    </p>
                <% } else { %>
                    <table class="table table-hover">
                        <thead class="table-dark">
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
                               for (JobApplication app
                                    : applications) { %>
                            <tr>
                                <td><%= i++ %></td>
                                <td><%= app.getUserId() %></td>
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
                                    <a href="${pageContext.request.contextPath}/admin?action=shortlist&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-success"
                                       onclick="return confirm('Shortlist this applicant?')">
                                       Shortlist
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin?action=reject&id=<%= app.getId() %>"
                                       class="btn btn-sm btn-danger"
                                       onclick="return confirm('Reject this applicant?')">
                                       Reject
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