package factory;

import model.Event;

public class EventFactory {

    public static Event createEvent(String eventType) {
        Event event = new Event();

        if (eventType == null) {
            event.setEventType("General");
            return event;
        }

        switch (eventType.toLowerCase()) {
            case "workshop":
                event.setEventType("Workshop");
                break;

            case "seminar":
                event.setEventType("Seminar");
                break;

            case "club social event":
                event.setEventType("Club Social Event");
                break;

            case "sports activity":
                event.setEventType("Sports Activity");
                break;

            default:
                event.setEventType("General");
                break;
        }

        return event;
    }
}