package com.jobtracker.controller;

import com.jobtracker.util.DBConnection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        Connection connection = DBConnection.getConnection();

        if (connection != null) {
            out.println("<h2 style='color:green'>✅ Database Connected Successfully!</h2>");
        } else {
            out.println("<h2 style='color:red'>❌ Database Connection Failed!</h2>");
        }
    }
}