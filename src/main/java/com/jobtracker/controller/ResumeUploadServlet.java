package com.jobtracker.controller;

import com.jobtracker.dao.ResumeDAO;
import com.jobtracker.model.Resume;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.FileOutputStream;

@WebServlet("/uploadResume")
// This annotation is REQUIRED for file upload handling
// maxFileSize = 5MB, maxRequestSize = 10MB
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 10 * 1024 * 1024
)
public class ResumeUploadServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // Check session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(
                    request.getContextPath() + "/views/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        // Get the uploaded file from request
        // "resumeFile" matches the name attribute in the form input
        Part filePart = request.getPart("resumeFile");

        // Get original file name from the uploaded file
        String originalFileName = filePart.getSubmittedFileName();

        // Validate — only allow PDF files
        if (!originalFileName.toLowerCase().endsWith(".pdf")) {
            request.setAttribute("error", "Only PDF files are allowed.");
            request.getRequestDispatcher(
                    "/views/uploadResume.jsp").forward(request, response);
            return;
        }

        // Create unique file name to avoid overwriting
        // e.g. 1234567890_resume.pdf
        String uniqueFileName = System.currentTimeMillis()
                + "_" + originalFileName;

        // Get the real path of uploads/resumes folder on server
        String uploadDir = getServletContext()
                .getRealPath("/uploads/resumes");

        // Create the directory if it doesn't exist
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Save file to the uploads/resumes folder
        String filePath = uploadDir + File.separator + uniqueFileName;

        try (InputStream input = filePart.getInputStream();
             FileOutputStream output = new FileOutputStream(filePath)) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }

        // Save file info to database
        // First delete old resume if exists
        ResumeDAO resumeDAO = new ResumeDAO();
        resumeDAO.deleteResumeByUserId(userId);

        // Save new resume record
        Resume resume = new Resume();
        resume.setUserId(userId);
        resume.setFileName(originalFileName);
        // Store relative path for DB
        resume.setFilePath("/uploads/resumes/" + uniqueFileName);

        resumeDAO.saveResume(resume);

        // Redirect back with success message
        response.sendRedirect(request.getContextPath()
                + "/views/uploadResume.jsp?success=true");
    }
}