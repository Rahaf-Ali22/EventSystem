package dao;

import model.Event;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean createReservation(int userId, int eventId) {

        String sql = "INSERT INTO reservations (user_id, event_id) VALUES (?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);

            int rows = stmt.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean isAlreadyReserved(int userId, int eventId) {

        String sql = "SELECT * FROM reservations WHERE user_id = ? AND event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);

            ResultSet rs = stmt.executeQuery();

            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean cancelReservation(int userId, int eventId) {

        String sql = "DELETE FROM reservations WHERE user_id = ? AND event_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            stmt.setInt(2, eventId);

            int rows = stmt.executeUpdate();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Event> getUserReservations(int userId) {

        List<Event> reservedEvents = new ArrayList<>();

        String sql = "SELECT e.* FROM reservations r " +
                     "JOIN events e ON r.event_id = e.id " +
                     "WHERE r.user_id = ? " +
                     "ORDER BY r.reservation_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Event event = new Event();

                event.setId(rs.getInt("id"));
                event.setTitle(rs.getString("title"));
                event.setDescription(rs.getString("description"));
                event.setEventDate(rs.getDate("event_date"));
                event.setLocation(rs.getString("location"));
                event.setCapacity(rs.getInt("capacity"));
                event.setCreatedBy(rs.getInt("created_by"));
                event.setCreatedAt(rs.getTimestamp("created_at"));

                reservedEvents.add(event);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return reservedEvents;
    }
}