package strategy;

public class EventSearchStrategyFactory {

    public static EventSearchStrategy getStrategy(String filterType) {

        if ("title".equals(filterType)) {
            return new TitleSearchStrategy();
        } else if ("date".equals(filterType)) {
            return new DateSearchStrategy();
        } else if ("availability".equals(filterType)) {
            return new AvailabilitySearchStrategy();
        } else if ("department".equals(filterType)) {
            return new DepartmentClubSearchStrategy();
        } else if ("category".equals(filterType)) {
            return new CategorySearchStrategy();
        } else if ("type".equals(filterType)) {
            return new EventTypeSearchStrategy();
        }

        return null;
    }
}