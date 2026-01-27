# Units Fixtures

This directory contains fixture data for the units app.

## Fixtures Overview

### units_core.json
Core dataset aligned with the admin panel mock-ups:
- 5 organizational units
- parent/child relationships
- unit heads assigned to base users

## Loading Fixtures

Load the fixtures in the correct order to respect foreign key dependencies:

```bash
python manage.py loaddata start_app
python manage.py loaddata units_core
```

## Notes

- `units_core.json` depends on `start_app.json` for base users
- The base organizational structure lives in `start_app.json`
