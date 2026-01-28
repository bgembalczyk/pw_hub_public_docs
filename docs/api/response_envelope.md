# API Response Envelope Standard & Migration Plan

## Purpose

This document defines a **single response envelope** for PW_hub APIs and a
migration plan that avoids breaking existing mobile clients. It also
inventories current endpoints and their response shapes so teams can align
implementation work.

## Inventory of Current Response Shapes (Required)

### Legacy: Raw Payload (no envelope)

These endpoints return a bare JSON object or list without a top-level `data`:

**Guides**
- `GET /api/guides/`
- `GET /api/guides/{id}/`
- `GET /api/guide-categories/`
- `GET /api/guide-categories/{slug}/`
- `GET /api/contacts/`
- `GET /api/contacts/{id}/`

**Announcements**
- `GET /api/announcements/`
- `GET /api/announcements/read/`
- `GET /api/announcements/unread/`
- `GET /api/announcements/{id}/`
- `POST /api/announcements/{id}/mark_read/`

**Events**
- `GET /api/events/{id}/`
- `GET /api/events/calendar/` (custom object with `year`, `month`, `events_by_day`)
- `POST /api/events/{id}/register/`
- `POST /api/events/{id}/unregister/`

**Event Categories & Registrations**
- `GET /api/event-categories/`
- `GET /api/event-categories/{slug}/`
- `GET /api/registrations/`
- `GET /api/registrations/{id}/`

**Tickets**
- `GET /api/tickets/`
- `GET /api/tickets/{id}/`
- `GET /api/tickets/{id}/download/`
- `POST /api/tickets/verify/`

**Notifications**
- `GET /api/notifications/{id}/`
- `POST /api/notifications/{id}/read/`

**Users**
- `GET /api/users/`
- `GET /api/users/{username}/`
- `GET /api/users/me/`
- `GET/PUT/PATCH /api/users/preferences/`

### Legacy: DRF Pagination Envelope

These endpoints return the Django REST Framework pagination envelope
(`count`, `next`, `previous`, `results`), which is **different** from the
proposed standard:

- `GET /api/events/`
- `GET /api/notifications/`

### Legacy Error Shapes (inconsistent)

Common patterns currently found:

- **Validation errors** (DRF default):
  - `{ "field": ["error message"] }`
- **Not found / permission errors** (DRF default):
  - `{ "detail": "..." }`
- **Business-rule errors** (custom):
  - Ticket verification: `{ "valid": false, "message": "..." }`
  - Event registration: `{ "detail": "..." }` with `409` or `400`

**Result:** clients must branch on multiple shapes.

## Standard Response Envelope (Required)

### Success

```json
{
  "data": <payload>,
  "meta": {
    "request_id": "optional",
    "pagination": {
      "count": 123,
      "next": "https://.../page=2",
      "previous": null
    }
  }
}
```

**Rules:**
- `data` is **required** for every successful response.
  - It may be `null` when there is nothing to return.
- `meta` is **optional**, but when present must follow the same structure.
- `meta.pagination` is **optional** and only included for list endpoints.
- `request_id` is optional and only present when the backend provides it.

### Error

```json
{
  "errors": [
    {
      "code": "string",
      "message": "string",
      "field": "optional"
    }
  ],
  "meta": {
    "request_id": "optional"
  }
}
```

**Rules:**
- `errors` is **required** for every error response (4xx/5xx).
- `errors` is always a **list** (even for a single error).
- `field` is only used for validation errors.
- `meta` is optional, same structure as success.

## Envelope Usage Rules (Required)

### Success Responses
- **200 / 201 / 202** → `data` present, `errors` absent.
- **204 No Content** → **discouraged** for public API endpoints; use
  `200` with `data: null` instead.
  - Exception: internal/admin-only endpoints may use 204 if documented.

### Error Responses
- **400 Validation error** → `errors` list with per-field entries.
- **401 Unauthorized** → `errors` list, `code: "unauthorized"`.
- **403 Permission denied** → `errors` list, `code: "permission_denied"`.
- **404 Not found** → `errors` list, `code: "not_found"`.
- **409 Conflict** → `errors` list, `code: "conflict"`.
- **500+ Server errors** → `errors` list, `code: "server_error"`.

### Edge Cases
- **Empty list** → `data: []` (optionally `meta.pagination`).
- **Missing resource** → `404` + errors envelope.
- **Validation error** → `400` + errors envelope (with `field`).
- **Permission errors** → `401/403` + errors envelope.

## Migration Plan (Required)

### Stage 0 — Documentation & Alignment (Now)
- Publish this standard and mark every endpoint as **legacy** or **standard**.
- Align backend + mobile on the target envelope and error codes.

### Stage 1 — Opt-In Envelope (Non-Breaking)
- Add **response negotiation** via a header:
  - **Request:** `Accept: application/vnd.pw-hub.enveloped+json; version=1`
  - **Response:** `X-Response-Envelope: standard|legacy`
- Backend returns the **standard envelope only when the header is present**.
- Mobile clients update to parse **both** formats.

**Impact on mobile:**
- Minimal; the client can detect `data`/`errors` vs raw payload and branch.

### Stage 2 — Default for New Endpoints
- All **new** endpoints must use the standard envelope by default.
- Existing endpoints remain legacy unless the header is supplied.

### Stage 3 — Deprecation & Removal
- Announce deprecation of legacy envelopes with a sunset window.
- Remove legacy envelopes **only after** all active clients send the opt-in
  header for at least one full release cycle.

**Criteria to remove legacy envelopes:**
- Mobile release with envelope support is fully rolled out.
- Server logs show no legacy-only clients for 30+ days.
- Product owner signs off on the deprecation window.

## QA Checklist (Required)

Use this checklist to verify the envelope contract:

1. **Success** responses always include `data` and never include `errors`.
2. **Error** responses always include `errors` (list) and never include `data`.
3. Validation errors include `field` where applicable.
4. Pagination responses include `meta.pagination` (not DRF `results`).
5. All endpoints are labeled **standard** or **legacy** in docs.
6. Clients can reliably detect the envelope type without ambiguity.

## Notes for Implementation (DRF)

- A custom renderer or response wrapper middleware can produce the envelope.
- DRF `exception_handler` should be adapted to emit the `errors` list format.
- Pagination can be standardized by overriding the pagination class response
  shape to output `data` + `meta.pagination`.
