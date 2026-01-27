# Announcements API

The announcements API provides read-only access to published announcements and
lets authenticated users track read/unread status.

## Base URL

`/api/announcements/`

## Authentication

All endpoints require authentication.

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

### List read announcements

`GET /api/announcements/read/`

Example:

```
GET /api/announcements/read/?category=updates&language=PL
```

### List unread announcements

`GET /api/announcements/unread/`

Example:

```
GET /api/announcements/unread/?category=updates&language=EN
```

### Retrieve announcement

`GET /api/announcements/<id>/`

Retrieve does not apply category/language filters so IDs always resolve when the
announcement exists.
