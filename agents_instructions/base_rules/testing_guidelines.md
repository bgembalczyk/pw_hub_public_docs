# Testing Guidelines for PW_hub

## Overview

**CRITICAL**: Every piece of code MUST have corresponding tests. This is a non-negotiable requirement.

## Test Structure

### Use pytest

The project uses pytest-django for testing. All tests should follow pytest conventions.

### Browser tests with BeautifulSoup (HTML/UI)

**CRITICAL**: Anything that happens through the UI (all behavior visible in rendered HTML, excluding API calls) must be covered with browser-style tests using BeautifulSoup. These tests are **more important** than unit tests for UI flows.

**Scope**:
- All view/page behaviors: templates, context-driven rendering, form flows, user-visible messages.
- Excludes pure API endpoints (those keep API tests).

**Required approach**:
1. Use Django test client to fetch pages.
2. Parse HTML with BeautifulSoup.
3. Assert on DOM structure, text, and critical attributes (links, buttons, forms, errors).

Example:
```python
from bs4 import BeautifulSoup
from django.urls import reverse


def test_announcements_list_browser(client):
    url = reverse("announcements:list")
    response = client.get(url)
    soup = BeautifulSoup(response.content, "html.parser")

    assert response.status_code == 200
    assert soup.select_one("h1").get_text(strip=True) == "Announcements"
    assert soup.select("article.announcement")
```

### Use Factory Boy

Use Factory Boy for creating test data. The project has user factories in `pw_hub.users.tests.factories`.

### Test Organization

- **Test files**: Name test files as `test_*.py` or `tests.py`
- **Organization**: Group tests in a `tests/` directory for larger apps
- **Markers**: Use `@pytest.mark.django_db` for database tests

## Test Coverage Requirements

For every feature, write tests for:

### 1. Models

- Creation and validation
- String representation (`__str__` method)
- Methods and properties
- Constraints and unique fields
- Related objects (ForeignKey, ManyToMany)
- Custom managers
- Model methods

Example:
```python
import pytest
from pw_hub.announcements.models import Announcement
from pw_hub.users.tests.factories import UserFactory


@pytest.mark.django_db
class TestAnnouncementModel:
    def test_create_announcement(self):
        user = UserFactory()
        ann = Announcement.objects.create(
            author=user,
            title="Test",
            content="Content"
        )
        assert ann.pk is not None
        assert ann.title == "Test"

    def test_str_representation(self):
        user = UserFactory()
        ann = Announcement.objects.create(
            author=user,
            title="Test Announcement",
            content="Content"
        )
        assert str(ann) == "Test Announcement"

    def test_get_absolute_url(self):
        user = UserFactory()
        ann = Announcement.objects.create(
            author=user,
            title="Test",
            content="Content"
        )
        url = ann.get_absolute_url()
        assert url == f"/announcements/{ann.pk}/"
```

### 2. Views

- Authentication requirements
- Permission checks
- GET/POST requests
- Form validation
- Success/error flows
- Context data
- Redirects

Example:
```python
import pytest
from django.urls import reverse
from pw_hub.users.tests.factories import UserFactory


@pytest.mark.django_db
class TestAnnouncementViews:
    def test_list_view_requires_login(self, client):
        url = reverse("announcements:list")
        resp = client.get(url)
        assert resp.status_code in (302, 301)

    def test_list_view_authenticated(self, client):
        user = UserFactory()
        client.force_login(user)
        url = reverse("announcements:list")
        resp = client.get(url)
        assert resp.status_code == 200

    def test_create_view_post(self, client):
        user = UserFactory()
        client.force_login(user)
        url = reverse("announcements:create")
        data = {
            "title": "New Announcement",
            "content": "Test content"
        }
        resp = client.post(url, data)
        assert resp.status_code == 302
        assert Announcement.objects.filter(title="New Announcement").exists()
```

### 3. API Endpoints (if applicable)

- All HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Authentication and permissions
- Serialization/deserialization
- Validation errors
- Edge cases
- Pagination
- Filtering

Example:
```python
import pytest
from rest_framework.test import APIClient
from django.urls import reverse
from pw_hub.users.tests.factories import UserFactory


@pytest.mark.django_db
class TestAnnouncementAPI:
    def test_list_announcements(self):
        client = APIClient()
        user = UserFactory()
        client.force_authenticate(user=user)
        url = reverse("api:announcements-list")
        resp = client.get(url)
        assert resp.status_code == 200

    def test_create_announcement(self):
        client = APIClient()
        user = UserFactory()
        client.force_authenticate(user=user)
        url = reverse("api:announcements-list")
        data = {
            "title": "API Test",
            "content": "Test content"
        }
        resp = client.post(url, data, format="json")
        assert resp.status_code == 201
        assert resp.data["title"] == "API Test"
```

### 4. Business Logic

- Services and utilities
- Edge cases and error handling
- Integration between components
- Complex algorithms
- Data transformations

## Error Testing Requirement

**CRITICAL**: If an agent encounters an error in the prompt, it means that scenario was not properly tested. When this happens:

1. **Identify the missing test scenario** - Determine what test case would have caught this error
2. **Create the test case** - Write a test that validates the correct behavior
3. **Fix the code** - Make the necessary code changes
4. **Verify the test passes** - Ensure the new test passes with the fix
5. **Run all tests** - Ensure no regressions were introduced

This ensures that the same error won't occur again and improves the overall test coverage.

## Running Tests

### Run all tests
```bash
uv run pytest
```

### Run specific test file
```bash
uv run pytest pw_hub/announcements/tests/test_models.py
```

### Run specific test class
```bash
uv run pytest pw_hub/announcements/tests/test_models.py::TestAnnouncementModel
```

### Run specific test method
```bash
uv run pytest pw_hub/announcements/tests/test_models.py::TestAnnouncementModel::test_create_announcement
```

### Run with coverage
```bash
uv run coverage run -m pytest
uv run coverage html
# View coverage report at htmlcov/index.html
```

### Run with verbose output
```bash
uv run pytest -v
```

### Run with print statements
```bash
uv run pytest -s
```

## Test Coverage Goals

- **Minimum coverage**: 80%
- **Target coverage**: 90%+
- **Critical paths**: 100%

Use coverage reports to identify untested code paths.

## Best Practices

1. **Test one thing at a time** - Each test should validate one specific behavior
2. **Use descriptive names** - Test names should clearly describe what they test
3. **Arrange-Act-Assert** - Structure tests with setup, action, and verification
4. **Use factories** - Don't create test data manually
5. **Isolate tests** - Tests should not depend on each other
6. **Test edge cases** - Don't just test the happy path
7. **Mock external services** - Don't make real API calls in tests
8. **Keep tests fast** - Slow tests won't be run frequently

## Common Pytest Fixtures

```python
# Built-in fixtures
@pytest.fixture
def client():
    """Django test client"""
    from django.test import Client
    return Client()

@pytest.fixture
def admin_client():
    """Django admin client"""
    from django.test import Client
    return Client()

@pytest.fixture
def rf():
    """Request factory"""
    from django.test import RequestFactory
    return RequestFactory()

# Custom fixtures (in conftest.py)
@pytest.fixture
def user():
    """Create a regular user"""
    from pw_hub.users.tests.factories import UserFactory
    return UserFactory()

@pytest.fixture
def admin_user():
    """Create an admin user"""
    from pw_hub.users.tests.factories import UserFactory
    return UserFactory(is_staff=True, is_superuser=True)
```

## Testing Checklist

Before considering code complete:

- [ ] All models have tests
- [ ] All views have tests
- [ ] All API endpoints have tests (if applicable)
- [ ] All business logic has tests
- [ ] Edge cases are covered
- [ ] Error conditions are tested
- [ ] Authentication/permissions are tested
- [ ] All tests pass
- [ ] Coverage is above minimum threshold
- [ ] No skipped tests without good reason
