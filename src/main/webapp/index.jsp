<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // If already logged in, redirect to dashboard
    if (session.getAttribute("user") != null) {
        String role = (String) session.getAttribute("role");
        if ("ADMIN".equals(role)) {
            response.sendRedirect("views/admin/adminDashboard.jsp");
        } else {
            response.sendRedirect("views/dashboard.jsp");
        }
        return;
    }
    // Otherwise redirect to login
    response.sendRedirect("views/login.jsp");
%>