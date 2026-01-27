# Announcements Fixtures

This directory contains fixture data for the announcements app.

## Fixtures Overview

### announcements_core.json
Core dataset aligned with the mobile mock-ups:
- 10 categories
- 10 announcements (draft/pending/published, PL/EN, with/without unit author)
- 10 images (primary/secondary)
- 10 read status entries

### categories.json
Contains 7 sample categories:
- Uczelnia (University) - #1E3A8A, university icon
- Kwaterunek (Accommodation) - #15803D, home icon
- Rekrutacja (Recruitment) - #B91C1C, users icon
- Samorząd (Student Council) - #7C2D12, user-group icon
- Wydarzenia (Events) - #A21CAF, calendar icon
- Sport (Sports) - #0891B2, trophy icon
- Stypendium (Scholarship) - #CA8A04, currency-dollar icon

### announcements.json
Contains 6 sample announcements in both Polish and English, covering various categories:
1. Welcome message for winter semester (Polish)
2. Dormitory application deadline (Polish)
3. PhD recruitment (Polish)
4. Student Council elections (English)
5. Beach volleyball tournament (Polish)
6. Minister's scholarship announcement (Polish)

**Note:** These announcements reference `author: 1`, so a User with pk=1 must exist before loading.

### images.json
Contains 3 sample images attached to announcements (primary images only, no actual image files).

## Loading Fixtures

Load the fixtures in the correct order to respect foreign key dependencies:

```bash
# Core fixtures (recommended)
python manage.py loaddata start_app
python manage.py loaddata announcements_core
```

Legacy sample fixtures:
```bash
python manage.py loaddata categories announcements images
```

## Prerequisites

Before loading announcement fixtures, ensure that:
1. Database migrations have been run: `python manage.py migrate`
2. `start_app` is loaded so base users and units exist

## Usage in Tests

The fixtures can be loaded in tests using pytest fixtures:
```python
@pytest.mark.django_db
def test_with_fixtures():
    from django.core.management import call_command
    call_command('loaddata', 'start_app', 'announcements_core')
    # Test code here
```
