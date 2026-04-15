package strategy;

public class AvailabilitySearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE seats_remaining > 0 ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return false;
    }
}