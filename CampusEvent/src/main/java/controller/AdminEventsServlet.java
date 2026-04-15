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

@WebServlet("/admin-events")
public class AdminEventsServlet extends HttpServlet {

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

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (!"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect("home");
            return;
        }

        String action = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (action != null && idParam != null) {
            try {
                int eventId = Integer.parseInt(idParam);

                if ("delete".equalsIgnoreCase(action)) {

                    if (reservationDAO.eventHasReservations(eventId)) {
                        response.sendRedirect("admin-events?error=hasReservations");
                        return;
                    }

                    boolean result = eventDAO.deleteEvent(eventId);
                    response.sendRedirect("admin-events?" + (result ? "success=deleted" : "error=fail"));
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("admin-events?error=invalid");
                return;
            }
        }

        List<Event> events = eventDAO.getAllEvents();
        request.setAttribute("eventsList", events);
        request.getRequestDispatcher("admin-events.jsp").forward(request, response);
    }
}