package controller;

import dao.EventDAO;
import dao.ReservationDAO;
import model.Event;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private EventDAO eventDAO;
    private ReservationDAO reservationDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
        reservationDAO = new ReservationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        int totalEvents = eventDAO.getTotalEventsCount();
        int openEvents = eventDAO.getOpenEventsCount();
        int myReservationsCount = reservationDAO.getUserReservationsCount(user.getId());
        List<Event> upcomingEvents = eventDAO.getUpcomingEventsLimit(3);

        request.setAttribute("totalEvents", totalEvents);
        request.setAttribute("openEvents", openEvents);
        request.setAttribute("myReservationsCount", myReservationsCount);
        request.setAttribute("upcomingEvents", upcomingEvents);

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}