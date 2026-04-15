package dao;

import model.Event;
import util.DBConnection;
import strategy.EventSearchStrategy;
import strategy.EventSearchStrategyFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public void updateExpiredEvents() {
        String sql = "UPDATE events SET status = 'EXPIRED' WHERE event_date < CURRENT_DATE AND status = 'OPEN'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Event> searchEvents(String keyword, String filterType) {
        updateExpiredEvents();

        List<Event> events = new ArrayList<>();

        EventSearchStrategy strategy = EventSearchStrategyFactory.getStrategy(filterType);

        if (strategy == null) {
            return getAllEvents();
        }

        String sql = strategy.getQuery();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (strategy.needsKeyword()) {
                stmt.setString(1, "%" + keyword + "%");
            }

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Event event = mapEvent(rs);
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    public List<Event> getAllEvents() {
        updateExpiredEvents();

        List<Event> events = new ArrayList<>();
        String sql = "SELECT * FROM events ORDER BY event_date";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Event event = mapEvent(rs);
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    public Event getEventById(int eventId) {
        Event event = null;
        String sql = "SELECT * FROM events WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                event = mapEvent(rs);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return event;
    }

    // ✅ عدد كل الأحداث
    public int getTotalEventsCount() {
        updateExpiredEvents();

        String sql = "SELECT COUNT(*) FROM events";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
 // Delete Event
    public boolean deleteEvent(int eventId) {
        String sql = "DELETE FROM events WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, eventId);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
 // Update Event by Admin
    public boolean updateEvent(Event event) {
        String sql = "UPDATE events SET title = ?, description = ?, event_date = ?, location = ?, capacity = ?, seats_remaining = ?, department_club = ?, category = ?, event_type = ?, status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, event.getTitle());
            stmt.setString(2, event.getDescription());
            stmt.setDate(3, new java.sql.Date(event.getEventDate().getTime()));
            stmt.setString(4, event.getLocation());
            stmt.setInt(5, event.getCapacity());
            stmt.setInt(6, event.getSeatsRemaining());
            stmt.setString(7, event.getDepartmentClub());
            stmt.setString(8, event.getCategory());
            stmt.setString(9, event.getEventType());
            stmt.setString(10, event.getStatus());
            stmt.setInt(11, event.getId());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
 // Check if user created events
    public boolean userHasCreatedEvents(int userId) {
        String sql = "SELECT COUNT(*) FROM events WHERE created_by = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
    // ✅ عدد الأحداث المفتوحة
    public int getOpenEventsCount() {
        updateExpiredEvents();

        String sql = "SELECT COUNT(*) FROM events WHERE status = 'OPEN'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    // ✅ أقرب أحداث قادمة
    public List<Event> getUpcomingEventsLimit(int limit) {
        updateExpiredEvents();

        List<Event> events = new ArrayList<>();

        String sql = "SELECT * FROM events WHERE status = 'OPEN' AND event_date >= CURRENT_DATE ORDER BY event_date ASC LIMIT ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Event event = mapEvent(rs);
                events.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return events;
    }

    // ✅ helper method
    private Event mapEvent(ResultSet rs) throws Exception {
        Event event = new Event();

        event.setId(rs.getInt("id"));
        event.setTitle(rs.getString("title"));
        event.setDescription(rs.getString("description"));
        event.setEventDate(rs.getDate("event_date"));
        event.setLocation(rs.getString("location"));
        event.setCapacity(rs.getInt("capacity"));
        event.setCreatedBy(rs.getInt("created_by"));
        event.setCreatedAt(rs.getTimestamp("created_at"));
        event.setStatus(rs.getString("status"));
        event.setSeatsRemaining(rs.getInt("seats_remaining"));
        event.setDepartmentClub(rs.getString("department_club"));
        event.setCategory(rs.getString("category"));
        event.setEventType(rs.getString("event_type"));

        return event;
    }
}