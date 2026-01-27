# Unit Panel (Panel Jednostki)

## Overview

The Unit Panel is a dedicated web interface for unit staff at Warsaw University of Technology to independently manage their unit's content without using Django Admin.

## Purpose

This panel allows unit staff members to:
- Manage events organized by their unit
- Publish and manage announcements
- View statistics and reports
- Manage unit users
- Configure permissions and content visibility

## Technology Stack

- **Framework**: Django
- **Templates**: Django Template Language (DTL)
- **Views**: Class-Based Views (CBVs)
- **Data Access**: Django ORM
- **Authentication**: Session-based (Django + SSO)
- **Permissions**: django-rules
- **Architecture**: Server-side rendering (no API/DRF layer)

## Features

### 1. Dashboard (`/panel-jednostki/`)
- Overview of unit statistics
- Recent activities (events and announcements)
- Quick action buttons
- Notifications

### 2. Event Management (`/panel-jednostki/wydarzenia/`)
- List all events
- Filter by status, category, date
- Search functionality
- Event status management (draft, published, archived)
- Participant management (planned)

### 3. Announcement Management (`/panel-jednostki/aktualnosci/`)
- List all announcements
- Filter by status, category, priority
- Search in title and content
- Priority management (placeholder in UI)
- View counting (planned)

### 4. Statistics & Reports (`/panel-jednostki/statystyki/`)
- General metrics
- Top 5 events and announcements
- Time range selection
- Export to PDF/Excel (planned)

### 5. User Management (`/panel-jednostki/uzytkownicy/`)
- List unit users
- Filter by role and status
- User activation/deactivation (planned)
- Role and permission management (planned)

## Permissions

Access to the unit panel is controlled by the `unit_panel.access_panel` permission, implemented using django-rules.

### Who Has Access

Users have access to the unit panel if they meet **any** of these criteria:

1. **Unit Head**: User is assigned as `unit_head` on any `Unit` model instance
2. **Permission Group**: User is assigned to a `PermissionGroup` with the `unit_panel.access_panel` permission

### Permission Implementation

The permission logic is defined in `pw_hub/unit_panel/permissions.py` using the `is_unit_panel_member` predicate.

All views require the `unit_panel.access_panel` permission through the `UnitPanelRequiredMixin`.

The menu item for the unit panel is only visible to users who have this permission.

### Granting Access

**Method 1: Set as Unit Head**
```python
from pw_hub.units.models import Unit
from pw_hub.users.models import User

unit = Unit.objects.get(short_name="WEiTI")
user = User.objects.get(username="john.doe")
unit.unit_head = user
unit.save()
```

**Method 2: Add to Permission Group**
```python
from pw_hub.users.models import PermissionGroup, PermissionSchema
from django.contrib.contenttypes.models import ContentType

# Create or get a permission schema
schema, _ = PermissionSchema.objects.get_or_create(
    name="Unit Panel Access",
    defaults={
        "description": "Grants access to unit panel",
        "permissions": ["unit_panel.access_panel"]
    }
)

# Create permission group
group = PermissionGroup.objects.create(
    schema=schema,
    name="WEiTI Panel Users",
    description="Users with access to WEiTI unit panel"
)

# Assign user to group
group.assigned_users.add(user)
```

### Future Enhancements

- Per-unit access control (user sees only their unit's data)
- Different roles within unit panel (admin, editor, viewer)
- Integration with organizational structure hierarchy

## Templates

Templates are located in `pw_hub/unit_panel/templates/unit_panel/`:
- `base.html` - Base layout with sidebar navigation
- `dashboard.html` - Dashboard view
- `events.html` - Event management
- `announcements.html` - Announcement management
- `statistics.html` - Statistics and reports
- `users.html` - User management

## URL Structure

```
/panel-jednostki/               - Dashboard
/panel-jednostki/wydarzenia/    - Events
/panel-jednostki/aktualnosci/   - Announcements
/panel-jednostki/statystyki/    - Statistics
/panel-jednostki/uzytkownicy/   - Users
```

## Development

### Running Tests

```bash
# Run all unit panel tests
just pytest pw_hub/unit_panel/tests/

# Run specific test file
just pytest pw_hub/unit_panel/tests/test_views.py

# Run with coverage
just coverage
```

### Code Quality

```bash
# Run pre-commit hooks
just precommit

# Type checking
just mypy
```

## Mockups

PlantUML mockups are available in `docs/mock_django/unit_panel/`:
- `unit_panel_overview.puml` - Dashboard mockup
- `event_management.puml` - Event management mockup
- `announcement_management.puml` - Announcement management mockup
- `statistics_view.puml` - Statistics mockup
- `user_management.puml` - User management mockup

## Future Enhancements

- [ ] Export functionality (PDF, Excel, CSV)
- [ ] Email notifications
- [ ] Activity log
- [ ] Bulk operations
- [ ] File upload for events/announcements
- [ ] Calendar view for events
- [ ] Permissions management UI
- [ ] Unit membership management

## Related Documentation

- [Main Project README](../../README.md)
- [Development Guidelines](../../agents.md)
- [Django Best Practices](../../agents_instructions/base_rules/django_best_practices.md)
- [Testing Guidelines](../../agents_instructions/base_rules/testing_guidelines.md)
- [Mockups Documentation](../../docs/mock_django/README.md)
