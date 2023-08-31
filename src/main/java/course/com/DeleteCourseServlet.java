package com;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/com.DeleteCourseServlet")
public class DeleteCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String courseSeq = request.getParameter("courseSeq");
        
        try {
            DBConnectionMgr dbMgr = DBConnectionMgr.getInstance();
            Connection conn = dbMgr.getConnection();
            Statement stmt = conn.createStatement();

            String deleteQuery = "DELETE FROM course WHERE course_seq = " + courseSeq;
            int rowsAffected = stmt.executeUpdate(deleteQuery);

            stmt.close();
            dbMgr.freeConnection(conn);

            if (rowsAffected > 0) {
                response.setContentType("text/plain");
                response.getWriter().write("success");
            } else {
                response.setContentType("text/plain");
                response.getWriter().write("error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().write("error");
        }
    }

}