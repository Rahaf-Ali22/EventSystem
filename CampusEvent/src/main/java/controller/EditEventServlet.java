package controller;

import dao.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Event;
import model.User;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/edit-event")
public class EditEventServlet extends HttpServlet {

    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int eventId = Integer.parseInt(request.getParameter("id"));
        Event event = eventDAO.getEventById(eventId);

        request.setAttribute("event", event);
        request.getRequestDispatcher("edit-event.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User organizer = (User) session.getAttribute("loggedInUser");

        try {
            Event event = new Event();

            event.setId(Integer.parseInt(request.getParameter("id")));
            event.setTitle(request.getParameter("title"));
            event.setDescription(request.getParameter("description"));
            event.setEventDate(Date.valueOf(request.getParameter("eventDate")));
            event.setLocation(request.getParameter("location"));
            event.setCapacity(Integer.parseInt(request.getParameter("capacity")));
            event.setSeatsRemaining(event.getCapacity());
            event.setDepartmentClub(request.getParameter("departmentClub"));
            event.setCategory(request.getParameter("category"));
            event.setEventType(request.getParameter("eventType"));
            event.setStatus("OPEN");

            boolean updated = eventDAO.updateEvent(event);

            if (updated) {
                response.sendRedirect("organizer-dashboard?success=updated");
            } else {
                response.sendRedirect("edit-event?id=" + event.getId() + "&error=fail");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("organizer-dashboard?error=invalid");
        }
    }
}