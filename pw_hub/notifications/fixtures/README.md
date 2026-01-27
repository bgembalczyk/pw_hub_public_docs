# Notifications Fixtures

This directory contains fixture data for the notifications app.

## Fixtures Overview

### notifications_core.json
Core dataset aligned with the mock-ups:
- 10 notifications
- mix of read/unread and push-sent statuses
- some notifications linked to events/announcements via related_object

## Loading Fixtures

Load the fixtures in the correct order to respect foreign key dependencies:

```bash
python manage.py loaddata start_app
python manage.py loaddata announcements_core events_core
python manage.py loaddata notifications_core
```

## Notes

- `notifications_core.json` depends on `start_app.json` for users
- Related object references require `announcements_core` and `events_core` to be loaded first
