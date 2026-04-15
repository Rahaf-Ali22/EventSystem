package strategy;

public class EventTypeSearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE LOWER(event_type) LIKE LOWER(?) ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return true;
    }
}