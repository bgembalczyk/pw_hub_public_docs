# Guides Fixtures

This directory contains fixture data for the guides app.

## Fixtures Overview

### guides_core.json
Core dataset aligned with the mobile mock-ups:
- 10 guide categories
- 10 guides (PL/EN, published/unpublished)
- 10 contacts (varied contact types)

## Loading Fixtures

Load the fixtures in the correct order to respect foreign key dependencies:

```bash
python manage.py loaddata start_app
python manage.py loaddata guides_core
```

## Notes

- `guides_core.json` depends on `start_app.json` for base users and units
- Some guides are unpublished to cover draft states
