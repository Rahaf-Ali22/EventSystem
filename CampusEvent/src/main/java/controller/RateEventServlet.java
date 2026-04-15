package controller;

import util.DBConnection;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class RateEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String eventIdParam = request.getParameter("eventId");
        String ratingParam = request.getParameter("rating");

        if (eventIdParam == null || ratingParam == null ||
            eventIdParam.trim().isEmpty() || ratingParam.trim().isEmpty()) {
            response.sendRedirect("view-events?rateerror=1");
            return;
        }

        int eventId;
        int rating;

        try {
            eventId = Integer.parseInt(eventIdParam);
            rating = Integer.parseInt(ratingParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("view-events?rateerror=1");
            return;
        }

        // التقييم يجب أن يكون من 1 إلى 5
        if (rating < 1 || rating > 5) {
            response.sendRedirect("view-events?rateerror=1");
            return;
        }

        String sql = "INSERT INTO event_ratings (user_id, event_id, rating) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, user.getId());
            stmt.setInt(2, eventId);
            stmt.setInt(3, rating);

            stmt.executeUpdate();

            response.sendRedirect("view-events?ratesuccess=1");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view-events?rateerror=1");
        }
    }
}