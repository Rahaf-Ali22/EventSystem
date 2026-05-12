package controller;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/delete-event")
public class DeleteEventServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User organizer = (User) session.getAttribute("loggedInUser");

        if (!"organizer".equalsIgnoreCase(organizer.getRole())) {
            response.sendRedirect("home");
            return;
        }

        try {
            int eventId = Integer.parseInt(request.getParameter("id"));

            boolean deleted = eventDAO.deleteEventByOrganizer(eventId, organizer.getId());

            if (deleted) {
                response.sendRedirect("organizer-dashboard?success=deleted");
            } else {
                response.sendRedirect("organizer-dashboard?error=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("organizer-dashboard?error=invalid");
        }
    }
}