# PW_hub API Documentation

This directory contains documentation for PW_hub REST APIs.

## Available APIs

### [Guides API](./guides_api.md)

REST API for accessing guides, categories, and contacts with support for:

- Publication status filtering
- Multi-language content
- Optimized for Flutter mobile integration

### [Announcements API](./announcements_api.md)

REST API for published announcements with read/unread tracking and category/language
filters for mobile clients.

### [Events API](./events_api.md)

REST API for events and tickets management, including:

- Ticket listing and details
- QR code generation and retrieval (online/offline)
- Ticket verification for organizers

### [Tickets API](./tickets_api.md)
Dedicated reference for ticket listing, offline download, and verification.

### [Student Profile API](./student_profile_api.md)

REST API for storing and retrieving onboarding profile data, including:

- Faculty, study year, and optional group
- Onboarding profile creation and updates

## API Overview

All APIs are accessible under `/api/` base URL and return JSON responses.

## API Response Envelope

PW_hub is standardizing all API responses into a single, predictable envelope
so every client knows where to find data, metadata, and errors. The standard
also defines how errors and pagination should look, plus a migration plan that
avoids breaking existing mobile clients.

See: [API Response Envelope Standard & Migration Plan](./response_envelope.md)

### General Conventions

- **Authentication**: Default access is **authenticated** (DRF default permission is
  `IsAuthenticated`). Only endpoints that explicitly override permissions are
  public.
- **Response Format**: JSON
- **Timestamps**: ISO 8601 format with UTC timezone
- **Error Responses**: Standard HTTP status codes with a unified error envelope

### Error format (standard)

All error responses MUST follow a single, stable structure:

```json
{
  "errors": [
    {
      "code": "string",
      "message": "string",
      "field": "optional",
      "details": {
        "optional": "object"
      }
    }
  ],
  "meta": {
    "request_id": "optional"
  }
}
```

Rules:
- `errors` is always a list.
- `code` and `message` are required and stable.
- `field` is used only for validation errors.
- `details` must not expose sensitive information.
- The envelope does not enforce `data`/`meta` on success; only errors are standardized.
- `message` should follow API language conventions (currently English in most API responses).

> **Legacy note:** some endpoints still return DRF defaults (`{"detail": ...}` or field maps).
> See **Inventory & legacy endpoints** and **Migration plan** for transition steps.

### Error codes dictionary

| Code | Type | Meaning | Default HTTP |
| --- | --- | --- | --- |
| `AUTH_REQUIRED` | auth | Missing authentication credentials. | 401 |
| `AUTH_INVALID` | auth | Invalid/expired credentials. | 401 |
| `FORBIDDEN` | auth | Authenticated but not authorized. | 403 |
| `NOT_FOUND` | auth | Resource not found or intentionally hidden (anti-enumeration). | 404 |
| `VALIDATION_ERROR` | validation | Request validation failed (field errors). | 400 |
| `INVALID_PARAMETER` | validation | Parameter value invalid or unsupported. | 400 |
| `MALFORMED_REQUEST` | validation | Unparseable body / invalid JSON. | 400 |
| `CONFLICT` | domain | State conflict (e.g., duplicate action). | 409 |
| `ALREADY_USED` | domain | Token or ticket already used/scanned. | 409 |
| `CAPACITY_EXCEEDED` | domain | Capacity full; cannot register. | 409 |
| `WAITLIST_ONLY` | domain | Registration allowed only for waitlist. | 409 |
| `STATE_TRANSITION_NOT_ALLOWED` | domain | Invalid state transition (e.g., registration closed). | 409 |
| `RATE_LIMITED` | infra | Too many requests; retry later. | 429 |
| `SERVICE_UNAVAILABLE` | infra | Dependency unavailable. | 503 |
| `INTERNAL_ERROR` | infra | Unexpected server error. | 500 |

### HTTP status mapping (standard)

| Scenario | Status | error.code | Notes |
| --- | --- | --- | --- |
| Success (read/write) | 200/201 | — | Standard success responses. |
| Success (no content) | 204 | — | Only when no response body is needed. |
| Missing/invalid auth | 401 | `AUTH_REQUIRED`/`AUTH_INVALID` | Do not leak details. |
| Authenticated but forbidden | 403 | `FORBIDDEN` | Use 404 if hiding resource existence. |
| Resource missing / hidden | 404 | `NOT_FOUND` | Anti-enumeration when appropriate. |
| Validation errors | 400 | `VALIDATION_ERROR` | Include `field`. |
| Invalid parameter | 400 | `INVALID_PARAMETER` | For invalid query/path values. |
| Malformed JSON/body | 400 | `MALFORMED_REQUEST` | Unparseable request. |
| State conflict / duplicate | 409 | `CONFLICT`/`ALREADY_USED`/`STATE_TRANSITION_NOT_ALLOWED` | Align to domain meaning. |
| Rate limit | 429 | `RATE_LIMITED` | If rate limiting is enabled. |
| Server error | 500 | `INTERNAL_ERROR` | No sensitive info in body. |
| Dependency outage | 503 | `SERVICE_UNAVAILABLE` | For upstream services. |

> **Note:** HTTP 422 is not used in the current API; validation errors map to 400.

### Authorization & Access Levels

The API distinguishes three access levels:

- **Public**: No authentication required.
- **Authenticated**: User must be logged in (token/session).
- **Role-based**: Authenticated user must additionally meet a role/ownership rule.

**Access failure semantics:**

- `401/403`: Authentication required (depends on auth backend; tests accept both).
- `403`: Authenticated but missing required role/permission.
- `404`: Authenticated but trying to access another user’s resource (owner-only).

### HTTP Status Codes

- `200 OK`: Successful request
- `404 Not Found`: Resource not found or not available
- `400 Bad Request`: Invalid request parameters
- `500 Internal Server Error`: Server error

## Inventory & legacy endpoints (current inconsistencies)

The following behaviors are observed in the codebase and require migration to the
standard error envelope:

1. **DRF default error formats** (dict/`detail`) are still used:
   - Serializer validation uses `raise_exception=True` → DRF returns field maps
     (e.g., `{"field": ["error"]}`) instead of `errors[]`. Examples:
     `EventViewSet.register`, `TicketViewSet.verify`, `UserViewSet.preferences` update.【F:pw_hub/events/api/views.py†L127-L149】【F:pw_hub/events/api/views.py†L349-L382】【F:pw_hub/users/api/views.py†L44-L73】
   - Guide retrieval returns 404 with `{"detail": ...}` for unpublished or
     language mismatch.【F:pw_hub/guides/api/views.py†L103-L132】
2. **Manual `detail` messages** vary by endpoint:
   - Event registration errors return `{"detail": ...}` for 400/409.【F:pw_hub/events/api/views.py†L127-L175】
   - Event unregister uses `{"detail": ...}` for 404.【F:pw_hub/events/api/views.py†L176-L205】
3. **Success status used for failures**:
   - Ticket verification returns 200 with a `status`/`message` payload even when
     invalid or already used, rather than 4xx with `errors[]`.【F:pw_hub/events/api/views.py†L349-L382】

### Legacy endpoints (must be migrated)

- `/api/tickets/verify/` (returns 200 for invalid/used tickets).【F:pw_hub/events/api/views.py†L349-L382】
- `/api/events/{id}/register/` and `/api/events/{id}/unregister/` (manual `detail` errors).【F:pw_hub/events/api/views.py†L127-L205】
- `/api/guides/{id}/` (manual `detail` for not found/unpublished).【F:pw_hub/guides/api/views.py†L103-L132】
- All endpoints relying on DRF defaults for validation/auth errors (e.g., users, tickets).【F:pw_hub/users/api/views.py†L44-L73】【F:pw_hub/events/api/views.py†L349-L382】

## Migration plan (staged, backwards-compatible)

1. **Stage 1 — Documentation & standard (this change)**  
   Define the error format, codes, and mapping. Mark legacy behaviors in docs.
   Mobile clients should accept both the new `errors[]` and legacy `detail`/field maps.
2. **Stage 2 — Central DRF exception handler**  
   Add a custom exception handler to normalize DRF errors into the standard envelope
   (validation/auth/permission/not-found). Provide `code` mappings per exception.
3. **Stage 3 — Endpoint-level migrations**  
   Update endpoints with manual error responses (e.g., events register/unregister,
   ticket verify) to return the standard envelope and correct status codes.
4. **Stage 4 — Deprecate legacy formats**  
   Announce deprecation window for `detail`/field maps and remove fallback handling
   in clients after adoption.

## QA regression checklist (Given/When/Then)

- **Auth required**
  - Given I call a protected endpoint without credentials
  - When the request is processed
  - Then I receive 401 with `errors[0].code = AUTH_REQUIRED`
- **Forbidden vs not found (anti-enumeration)**
  - Given I am authenticated but do not have access to a resource
  - When the policy hides resource existence
  - Then I receive 404 with `errors[0].code = NOT_FOUND`
- **Validation**
  - Given I send an invalid payload
  - When validation fails
  - Then I receive 400 with `errors[0].code = VALIDATION_ERROR` and `field`
- **Conflict**
  - Given I attempt a duplicate/invalid state transition
  - When the request is processed
  - Then I receive 409 with `errors[0].code = CONFLICT` (or specific domain code)
- **Server error**
  - Given the server raises an unexpected exception
  - When the handler responds
  - Then I receive 500 with `errors[0].code = INTERNAL_ERROR` and no sensitive data

## Validation plan

- Review contract changes with backend and mobile teams (error parsing impact).
- Execute the QA regression checklist above, focusing on auth, validation, conflict,
  and server error scenarios.

## Standard error examples

**Internal error (500)**
```json
{
  "errors": [
    {
      "code": "INTERNAL_ERROR",
      "message": "Unexpected server error. Please try again later."
    }
  ]
}
```

## Getting Started

1. Start the development server
2. Access API documentation at `/api/docs/` (Swagger UI)
3. Access API schema at `/api/schema/`
4. Read specific API documentation in this directory

## API Endpoints Summary

| Endpoint                             | Method        | Auth required | Role/ownership required  | Notes                                           |
|--------------------------------------|---------------|---------------|--------------------------|-------------------------------------------------|
| `/api/guides/`                       | GET           | Public        | None                     | List guides (published by default).             |
| `/api/guides/{id}/`                  | GET           | Public        | None                     | 404 for unpublished or language mismatch.       |
| `/api/guide-categories/`             | GET           | Public        | None                     | List guide categories (published by default).   |
| `/api/guide-categories/{slug}/`      | GET           | Public        | None                     | Includes published guides only.                 |
| `/api/contacts/`                     | GET           | Public        | None                     | List contacts (published by default).           |
| `/api/contacts/{id}/`                | GET           | Public        | None                     | Contact details.                                |
| `/api/announcements/`                | GET           | Authenticated | None                     | Published announcements only.                   |
| `/api/announcements/{id}/`           | GET           | Authenticated | None                     | Retrieve announcement.                          |
| `/api/announcements/read/`           | GET           | Authenticated | None                     | Announcements marked read by user.              |
| `/api/announcements/unread/`         | GET           | Authenticated | None                     | Announcements not yet read.                     |
| `/api/announcements/{id}/mark_read/` | POST          | Authenticated | None                     | Idempotent mark-as-read.                        |
| `/api/notifications/`                | GET           | Authenticated | Owner-only               | List notifications for current user.            |
| `/api/notifications/{id}/`           | GET           | Authenticated | Owner-only               | 404 for notifications belonging to other users. |
| `/api/notifications/{id}/read/`      | POST          | Authenticated | Owner-only               | Mark notification as read.                      |
| `/api/events/`                       | GET           | Public        | None                     | List published events.                          |
| `/api/events/{id}/`                  | GET           | Public        | None                     | Event details.                                  |
| `/api/events/{id}/register/`         | POST          | Authenticated | None                     | Register current user for event.                |
| `/api/events/{id}/unregister/`       | POST          | Authenticated | None                     | Unregister current user from event.             |
| `/api/event-categories/`             | GET           | Authenticated | None                     | Event categories.                               |
| `/api/event-categories/{slug}/`      | GET           | Authenticated | None                     | Event category details.                         |
| `/api/registrations/`                | GET           | Authenticated | Owner-only               | Registrations for current user.                 |
| `/api/registrations/{id}/`           | GET           | Authenticated | Owner-only               | 404 for other users’ registrations.             |
| `/api/tickets/`                      | GET           | Authenticated | Owner-only               | Tickets for current user.                       |
| `/api/tickets/{id}/`                 | GET           | Authenticated | Owner-only               | 404 for other users’ tickets.                   |
| `/api/tickets/{id}/download/`        | GET           | Authenticated | Owner-only               | Offline bundle with QR base64.                  |
| `/api/tickets/verify/`               | POST          | Authenticated | Event organizer or staff | 403 if not organizer/staff.                     |
| `/api/users/`                        | GET           | Authenticated | Owner-only               | Returns only current user.                      |
| `/api/users/{username}/`             | GET           | Authenticated | Owner-only               | 404 for other users.                            |
| `/api/users/me/`                     | GET           | Authenticated | Owner-only               | Current user profile.                           |
| `/api/users/preferences/`            | GET/PUT/PATCH | Authenticated | Owner-only               | Manage user preferences.                        |
| `/api/student-profile/`              | GET/PUT/PATCH | Authenticated | Owner-only               | Manage student onboarding profile               |

## Development Notes

- Use Django REST Framework for all API implementations
- Follow the serializer patterns established in existing APIs
- Write comprehensive tests for all new endpoints
- Document all new APIs in this directory
