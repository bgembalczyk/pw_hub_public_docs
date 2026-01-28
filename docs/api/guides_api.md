# Guides API Documentation

## Overview

The Guides API provides RESTful endpoints for accessing guides, categories, and contacts. It's designed for Flutter integration with filtering by publication status and language.

**Base URL:** `/api/`

**Format:** JSON

**Authentication:** Public read access (no auth required)

**Response Envelope Status:** **Legacy (raw payload)** — to be migrated to the
standard envelope. See [API Response Envelope](./response_envelope.md).

## Query Parameters

### Publication Filter
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `published` | boolean | `true` | Filter by publication status. Set to `false` to include unpublished items |

### Language Filter
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `language` | string | `pl` | Filter by language code (e.g., 'en', 'pl'). Applies to guides only |

## Endpoints

### 1. List Guides

**GET** `/api/guides/`

Returns a list of guides with minimal data for efficient list display.

**Envelope:** Legacy (raw list)

**Query Parameters:**
- `published` (optional, default: `true`)
- `language` (optional, default: `pl`)

**Example Request:**
```http
GET /api/guides/?language=pl&published=true
```

**Example Response (legacy):**
```json
[
  {
    "id": 1,
    "title": "How to Register for Courses",
    "slug": "how-to-register-for-courses",
    "summary": "A complete guide to course registration process",
    "category_name": "Academic",
    "category_slug": "academic",
    "language": "pl",
    "source": "Dean's Office",
    "created_at": "2024-01-15T10:00:00Z",
    "updated_at": "2024-01-15T10:00:00Z"
  }
]
```

### 2. Get Guide Details

**GET** `/api/guides/{id}/`

Returns detailed information about a specific guide.

**Envelope:** Legacy (raw object)

**Path Parameters:**
- `id` (required): Guide ID (integer)

**Query Parameters:**
- `language` (optional, default: `pl`)

**Example Request:**
```http
GET /api/guides/1/?language=pl
```

**Example Response (legacy):**
```json
{
  "id": 1,
  "title": "How to Register for Courses",
  "slug": "how-to-register-for-courses",
  "summary": "A complete guide to course registration process",
  "content": "## Step 1\n\nDetailed guide content here...",
  "category": {
    "id": 1,
    "name": "Academic",
    "slug": "academic",
    "order": 1,
    "guides_count": 5
  },
  "language": "pl",
  "image": "/media/guides/images/registration.jpg",
  "source": "Dean's Office",
  "created_at": "2024-01-15T10:00:00Z",
  "updated_at": "2024-01-15T10:00:00Z"
}
```

**Error Responses:**
- `404 Not Found`: Guide not found, not published, or not available in requested language

```json
{
  "errors": [
    {
      "code": "NOT_FOUND",
      "message": "Guide not found or not published."
    }
  ]
}
```

> **Legacy note:** the current implementation still returns DRF-style
> `{"detail": ...}` responses for these cases and should be migrated to the
> standard envelope.【F:pw_hub/guides/api/views.py†L103-L132】

### 3. List Categories

**GET** `/api/categories/`

Returns a list of guide categories with count of published guides.

**Envelope:** Legacy (raw list)

**Query Parameters:**
- `published` (optional, default: `true`)

**Example Request:**
```http
GET /api/categories/?published=true
```

**Example Response (legacy):**
```json
[
  {
    "id": 1,
    "name": "Academic",
    "slug": "academic",
    "order": 1,
    "guides_count": 5
  },
  {
    "id": 2,
    "name": "Student Life",
    "slug": "student-life",
    "order": 2,
    "guides_count": 3
  }
]
```

### 4. Get Category Details

**GET** `/api/categories/{slug}/`

Returns detailed category information including its published guides.

**Envelope:** Legacy (raw object)

**Path Parameters:**
- `slug` (required): Category slug (string)

**Query Parameters:**
- `language` (optional, default: `pl`): Filter guides by language

**Example Request:**
```http
GET /api/categories/academic/?language=pl
```

**Example Response (legacy):**
```json
{
  "id": 1,
  "name": "Academic",
  "slug": "academic",
  "order": 1,
  "guides": [
    {
      "id": 1,
      "title": "How to Register for Courses",
      "slug": "how-to-register-for-courses",
      "summary": "A complete guide to course registration process",
      "category_name": "Academic",
      "category_slug": "academic",
      "language": "pl",
      "source": "Dean's Office",
      "created_at": "2024-01-15T10:00:00Z",
      "updated_at": "2024-01-15T10:00:00Z"
    }
  ]
}
```

### 5. List Contacts

**GET** `/api/contacts/`

Returns a list of contacts with minimal data.

**Envelope:** Legacy (raw list)

**Query Parameters:**
- `published` (optional, default: `true`)

**Example Request:**
```http
GET /api/contacts/?published=true
```

**Example Response (legacy):**
```json
[
  {
    "id": 1,
    "name": "Dean's Office",
    "description": "Room 120, Mon-Fri 9:00-13:00",
    "icon": "bi-building",
    "order": 1
  }
]
```

### 6. Get Contact Details

**GET** `/api/contacts/{id}/`

Returns detailed information about a specific contact.

**Envelope:** Legacy (raw object)

**Path Parameters:**
- `id` (required): Contact ID (integer)

**Example Request:**
```http
GET /api/contacts/1/
```

**Example Response (legacy):**
```json
{
  "id": 1,
  "name": "Dean's Office",
  "description": "Room 120, Mon-Fri 9:00-13:00",
  "email": "dean@pw.edu.pl",
  "icon": "bi-building",
  "order": 1,
  "contact_link": "mailto:dean@pw.edu.pl",
  "created_at": "2024-01-15T10:00:00Z",
  "updated_at": "2024-01-15T10:00:00Z"
}
```

## Data Models

### Guide

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer | read-only | Unique identifier |
| title | string (255) | yes | Guide title |
| slug | string (255) | auto | URL-friendly identifier, auto-generated from title |
| summary | text | yes | Short description for list views |
| content | text | no | Full guide content (supports Markdown) |
| category | object | yes | Related GuideCategory |
| language | string (10) | yes | Language code (default: "pl") |
| is_published | boolean | yes | Publication status (default: false) |
| image | image | no | Optional image |
| source | string (255) | no | Author or source organization |
| created_at | datetime | auto | Creation timestamp |
| updated_at | datetime | auto | Last update timestamp |

### GuideCategory

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer | read-only | Unique identifier |
| name | string (100) | yes | Category name |
| slug | string (100) | yes | URL-friendly identifier |
| is_published | boolean | yes | Publication status (default: true) |
| order | integer | yes | Display order (default: 0, lower first) |

### Contact

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| id | integer | read-only | Unique identifier |
| name | string (255) | yes | Contact name |
| description | text | yes | Details about location, hours, services |
| email | email | no | Email address |
| icon | string (50) | yes | Bootstrap icon class (default: "bi-building") |
| is_published | boolean | yes | Publication status (default: true) |
| order | integer | yes | Display order (default: 0, lower first) |
| created_at | datetime | auto | Creation timestamp |
| updated_at | datetime | auto | Last update timestamp |

## Flutter Integration Guide

### Efficient Data Loading

**For List Views:**
- Use `/api/guides/` endpoint which returns minimal data
- Only essential fields are included to minimize payload size
- Perfect for scrollable lists and grid views

**For Detail Views:**
- Use `/api/guides/{id}/` endpoint for full content
- Includes complete data with nested related objects
- Load this only when user taps on a guide

### Language Support

1. **Default Language**: Polish (`pl`) is the default
2. **Language Selection**: Pass `?language=en` for English guides
3. **Language Fallback**: If a guide doesn't exist in requested language, you'll get a 404
4. **Multi-language Strategy**: 
   - Store user's preferred language in app settings
   - Pass language parameter on all guide requests
   - Show appropriate message when content unavailable in selected language

### Publication Rules

**Automatic Filtering:**
- By default, only published items are returned
- No need to handle unpublished items in Flutter app
- Backend ensures data integrity

**Admin/Preview Mode:**
- If you need to preview unpublished content, pass `?published=false`
- Requires appropriate authentication (to be implemented)

### Offline Support Recommendations

1. **Cache Categories**: Categories change rarely, cache them locally
2. **Cache Guide Lists**: Cache guide lists per category and language
3. **Cache Guide Details**: Cache full guide content after first view
4. **Update Strategy**: 
   - Check for updates using `updated_at` timestamps
   - Implement pull-to-refresh for manual updates
   - Background sync for new content

### Example Flutter Implementation

```dart
// Fetching guides list
final response = await http.get(
  Uri.parse('https://hub.pw.edu.pl/api/guides/'),
  headers: {
    'Accept': 'application/json',
  },
  queryParameters: {
    'language': userPreferredLanguage,
    'published': 'true',
  },
);

// Fetching guide details
final guideResponse = await http.get(
  Uri.parse('https://hub.pw.edu.pl/api/guides/$guideId/'),
  queryParameters: {
    'language': userPreferredLanguage,
  },
);

// Fetching category with guides
final categoryResponse = await http.get(
  Uri.parse('https://hub.pw.edu.pl/api/categories/$categorySlug/'),
  queryParameters: {
    'language': userPreferredLanguage,
  },
);
```

## Best Practices

### API Usage

1. **Minimize Requests**: Use list endpoints for browsing, detail endpoints only when needed
2. **Cache Responses**: Cache category and guide data to reduce API calls
3. **Handle Errors**: Always check for 404 responses and handle gracefully
4. **Respect Timestamps**: Use `updated_at` to determine if cached data is stale

### Performance

1. **List Pagination**: Future versions may add pagination; prepare your UI for paginated results
2. **Image Loading**: Guide images are optional; handle null values gracefully
3. **Lazy Loading**: Load guide details only when user navigates to detail view

### Error Handling

```dart
try {
  final response = await fetchGuide(guideId, language);
  if (response.statusCode == 404) {
    // Guide not found or not published
    showMessage('Guide not available in selected language');
  } else if (response.statusCode == 200) {
    // Success
    final guide = Guide.fromJson(json.decode(response.body));
  }
} catch (e) {
  // Network error
  showMessage('Please check your internet connection');
}
```

## Testing

### Example cURL Commands

```bash
# List all published Polish guides
curl "https://hub.pw.edu.pl/api/guides/?language=pl&published=true"

# Get specific guide
curl "https://hub.pw.edu.pl/api/guides/1/?language=pl"

# List all categories
curl "https://hub.pw.edu.pl/api/categories/"

# Get category with its guides
curl "https://hub.pw.edu.pl/api/categories/academic/?language=pl"

# List all contacts
curl "https://hub.pw.edu.pl/api/contacts/"

# Get specific contact
curl "https://hub.pw.edu.pl/api/contacts/1/"
```

## Future Enhancements

Potential improvements to be added in future versions:

- Pagination for large result sets
- Full-text search across guides
- Filtering by category in guide list
- Sorting options (by date, title, etc.)
- Related guides suggestions
- Guide versioning and history
- Authentication for private guides
- Rate limiting for API protection
