package controller;

import dao.EventDAO;
import dao.ReservationDAO;
import model.Event;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ReserveEventServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        if (eventIdParam == null || eventIdParam.trim().isEmpty()) {
            response.sendRedirect("view-events?error=invalid");
            return;
        }

        int eventId;

        try {
            eventId = Integer.parseInt(eventIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("view-events?error=invalid");
            return;
        }

        ReservationDAO reservationDAO = new ReservationDAO();

        // منع الحجز المكرر
        if (reservationDAO.isAlreadyReserved(user.getId(), eventId)) {
            response.sendRedirect("view-events?error=already");
            return;
        }

        EventDAO eventDAO = new EventDAO();
        Event event = eventDAO.getEventById(eventId);

        // إذا الحدث غير موجود
        if (event == null) {
            response.sendRedirect("view-events?error=invalid");
            return;
        }

        // إذا الحدث مش مفتوح للحجز
        if (!"OPEN".equals(event.getStatus())) {
            response.sendRedirect("view-events?error=closed");
            return;
        }

        // إذا المقاعد خلصت
        if (event.getSeatsRemaining() <= 0) {
            response.sendRedirect("view-events?error=full");
            return;
        }

        boolean success = reservationDAO.createReservation(user.getId(), eventId);

        if (success) {
            response.sendRedirect("view-events?success=1");
        } else {
            response.sendRedirect("view-events?error=fail");
        }
    }
}