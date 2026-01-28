# Announcements API

The announcements API provides read-only access to published announcements and
lets authenticated users track read/unread status.

## Base URL

`/api/announcements/`

## Authentication

All endpoints require authentication.

**Response Envelope Status:** **Legacy (raw payload)** — to be migrated to the
standard envelope. See [API Response Envelope](./response_envelope.md).

## Error responses (standard)

### Auth required (401)

```json
{
  "errors": [
    {
      "code": "AUTH_REQUIRED",
      "message": "Authentication credentials were not provided."
    }
  ]
}
```

## Query Parameters

Announcements support the following optional query parameters (aligned with the
web filters and helper logic):

- `category=<slug>`: filter by category slug
- `language=<PL|EN>`: filter by language code

> Tip: language values are normalized to upper-case, but `PL`/`EN` remain the
> standard values.

## Endpoints

### List announcements

`GET /api/announcements/`

Example:

```
GET /api/announcements/?category=updates&language=PL
```

**Envelope:** Legacy (raw list)

**Example Response (legacy):**
```json
[
  {
    "id": 12,
    "title": "Schedule update",
    "content": "Full announcement content...",
    "excerpt": "Short summary...",
    "created_at": "2024-02-01T12:00:00Z",
    "updated_at": "2024-02-01T12:00:00Z",
    "published_at": "2024-02-01T12:00:00Z",
    "language": "PL",
    "status": "PUBLISHED",
    "author_username": "admin",
    "unit_author_name": "Dean's Office",
    "categories": [
      { "id": 1, "name": "Updates", "slug": "updates", "color": "#FFAA00", "icon": "bell" }
    ],
    "images": [],
    "is_read": false
  }
]
```

### List read announcements

`GET /api/announcements/read/`

Example:

```
GET /api/announcements/read/?category=updates&language=PL
```

**Envelope:** Legacy (raw list)

**Example Response (legacy):** Same shape as list.

### List unread announcements

`GET /api/announcements/unread/`

Example:

```
GET /api/announcements/unread/?category=updates&language=EN
```

**Envelope:** Legacy (raw list)

**Example Response (legacy):** Same shape as list.

### Retrieve announcement

`GET /api/announcements/<id>/`

Retrieve does not apply category/language filters so IDs always resolve when the
announcement exists.

**Envelope:** Legacy (raw object)

**Example Response (legacy):**
```json
{
  "id": 12,
  "title": "Schedule update",
  "content": "Full announcement content...",
  "excerpt": "Short summary...",
  "created_at": "2024-02-01T12:00:00Z",
  "updated_at": "2024-02-01T12:00:00Z",
  "published_at": "2024-02-01T12:00:00Z",
  "language": "PL",
  "status": "PUBLISHED",
  "author_username": "admin",
  "unit_author_name": "Dean's Office",
  "categories": [],
  "images": [],
  "is_read": true
}
```

### Mark announcement as read

`POST /api/announcements/<id>/mark_read/`

**Envelope:** Legacy (raw object)

**Example Response (legacy):** Same shape as retrieve.

## Error Responses (Legacy Shape)

Typical authentication error:

```json
{
  "detail": "Authentication credentials were not provided."
}
```
