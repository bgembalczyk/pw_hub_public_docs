# Users Fixtures

This directory contains fixture data for the users app.

## Fixtures Overview

### users_core.json
Core dataset aligned with the admin panel mock-ups:
- 5 additional user accounts (student profiles)
- 5 preferences with varied notification settings

## Loading Fixtures

Load the fixtures in the correct order to respect foreign key dependencies:

```bash
python manage.py loaddata start_app
python manage.py loaddata users_core
```

## Notes

- `users_core.json` depends on `start_app.json` for base users and units
- Preferences reference units defined in `start_app.json`
