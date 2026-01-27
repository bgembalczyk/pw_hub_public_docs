# Events Fixtures

This directory contains sample data fixtures for the Events application.

## Available Fixtures

### events_core.json
Core dataset aligned with the mobile mock-ups:
- 10 event categories
- 10 events (PL/EN, with/without registration, varied capacity)
- 10 registrations with different statuses
- 10 accessibility records
- 10 tickets (valid/invalid, scanned/unscanned)
- 10 FAQs
- 10 attachments
- 10 photos
- 10 costs

### sample_events.json
A comprehensive fixture containing:

- **1 Sample User**: `event_organizer` (pk=1000) - used as the creator of events
- **8 Event Categories**: Including Culture, Sports, Science, Integration, Trips, Conferences, Parties, and Technology
- **8 Sample Events**: Various types of student events with realistic Polish and English content

## Loading Fixtures

To load the core events fixtures:

```bash
python manage.py loaddata start_app
python manage.py loaddata events_core
```

To load the legacy sample events fixture:

```bash
# Using uv (recommended for this project)
uv run python manage.py loaddata sample_events

# Or using Django management command directly
python manage.py loaddata sample_events

# Or with Docker
docker compose -f docker-compose.local.yml run --rm django python manage.py loaddata sample_events
```

## Notes

- `events_core.json` depends on `start_app.json` for users and units
- The sample user has pk=1000 to avoid conflicts with existing users
- All events are set with future dates (2026) in `sample_events.json`
- Events include both Polish (PL) and English (EN) language options
- Some events require registration, others don't
- Events have various capacity limits and registration deadlines
- All events are marked as published for immediate visibility

## Clearing Sample Data

If you need to remove the sample data:

```bash
# Delete all events (this will also remove the many-to-many relationships)
uv run python manage.py shell -c "from pw_hub.events.models import Event, EventCategory; Event.objects.all().delete(); EventCategory.objects.all().delete()"

# Delete only the sample user if needed
uv run python manage.py shell -c "from pw_hub.users.models import User; User.objects.filter(pk=1000).delete()"
```

## Using Fixtures in Tests

You can also use this fixture in your tests:

```python
import pytest

@pytest.mark.django_db
class TestWithCoreEvents:
    fixtures = ['start_app', 'events_core']

    def test_events_loaded(self):
        from pw_hub.events.models import Event
        assert Event.objects.count() >= 10
```
