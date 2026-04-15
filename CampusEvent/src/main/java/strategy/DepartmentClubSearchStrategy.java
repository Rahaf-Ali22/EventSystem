package strategy;

public class DepartmentClubSearchStrategy implements EventSearchStrategy {

    @Override
    public String getQuery() {
        return "SELECT * FROM events WHERE LOWER(department_club) LIKE LOWER(?) ORDER BY event_date";
    }

    @Override
    public boolean needsKeyword() {
        return true;
    }
}
