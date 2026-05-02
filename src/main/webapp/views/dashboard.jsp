<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Session check
    if (session.getAttribute("user") == null) {
        response.sendRedirect(request.getContextPath() + "/views/login.jsp");
        return;
    }
    String userName = (String) session.getAttribute("userName");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - Job Tracker</title>
    <link rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Welcome, <%= userName %>! 👋</h2>
    <p>You are logged in successfully.</p>
    <a href="${pageContext.request.contextPath}/logout"
       class="btn btn-danger">Logout</a>
</div>
</body>
</html>