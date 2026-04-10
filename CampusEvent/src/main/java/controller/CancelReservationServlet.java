package controller;

import dao.ReservationDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class CancelReservationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int eventId = Integer.parseInt(request.getParameter("eventId"));

        ReservationDAO reservationDAO = new ReservationDAO();
        boolean success = reservationDAO.cancelReservation(user.getId(), eventId);

        if (success) {
            response.sendRedirect("my-reservations?cancel=success");
        } else {
            response.sendRedirect("my-reservations?cancel=fail");
        }
    }
}