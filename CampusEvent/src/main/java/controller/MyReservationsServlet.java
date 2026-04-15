package controller;

import dao.ReservationDAO;
import model.Event;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

public class MyReservationsServlet extends HttpServlet {

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

        ReservationDAO reservationDAO = new ReservationDAO();
        List<Event> myEvents = reservationDAO.getUserReservations(user.getId());

        request.setAttribute("myEvents", myEvents);
        request.getRequestDispatcher("my-reservations.jsp").forward(request, response);
    }
}