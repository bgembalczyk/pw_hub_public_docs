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

## API Overview

All APIs are accessible under `/api/` base URL and return JSON responses.

### General Conventions

- **Authentication**: Currently, read operations are publicly accessible
- **Response Format**: JSON
- **Timestamps**: ISO 8601 format with UTC timezone
- **Error Responses**: Standard HTTP status codes with error messages

### HTTP Status Codes

- `200 OK`: Successful request
- `404 Not Found`: Resource not found or not available
- `400 Bad Request`: Invalid request parameters
- `500 Internal Server Error`: Server error

## Getting Started

1. Start the development server
2. Access API documentation at `/api/docs/` (Swagger UI)
3. Access API schema at `/api/schema/`
4. Read specific API documentation in this directory

## API Endpoints Summary

| Endpoint | Description |
|----------|-------------|
| `/api/guides/` | List and retrieve guides |
| `/api/categories/` | List and retrieve guide categories |
| `/api/contacts/` | List and retrieve contacts |
| `/api/announcements/` | List and retrieve announcements |
| `/api/users/` | User management endpoints |

## Development Notes

- Use Django REST Framework for all API implementations
- Follow the serializer patterns established in existing APIs
- Write comprehensive tests for all new endpoints
- Document all new APIs in this directory
