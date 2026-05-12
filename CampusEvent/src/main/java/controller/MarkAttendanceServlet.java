package controller;

import dao.ReservationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/mark-attendance")
public class MarkAttendanceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String status = request.getParameter("status");

        ReservationDAO dao = new ReservationDAO();
        dao.markAttendance(id, status);

        response.sendRedirect("organizer-dashboard");
    }
}