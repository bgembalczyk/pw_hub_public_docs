# Model Alignment - Decisions and Changes Summary

## Overview

This document summarizes the decisions made and changes implemented to align Django models with the database schema (database_new.puml) and class diagrams (guides_class_diagram.puml).

## Discrepancies Identified

### Guide Model

**Before:**
- Fields: title, summary, content, category, image, source, created_at, updated_at
- Missing: author, published, published_at, language

**Schema (database_new.puml):**
- Used "excerpt" instead of "summary"
- Had author, published, published_at, language
- Missing: image, source

### GuideCategory Model

**Before:**
- Fields: name, slug, order
- Missing: icon

**Schema (database_new.puml):**
- Had: name, slug, icon
- Missing: order

### Contact Model

**Before:**
- Fields: name, description, email, icon, order, created_at, updated_at
- Missing: contact_type, unit, location, room_number, opening_hours, phone, website

**Schema (database_new.puml):**
- Had all the extended fields
- Missing: order, created_at, updated_at

## Decisions Made

### 1. Guide.summary vs Guide.excerpt
**Decision:** Keep `summary` (current field name in code)
**Rationale:** 
- The field is already used in the codebase and templates
- Updated database schema diagram to use "summary" for consistency
- Changing field names would break existing code and data

### 2. Guide.image and Guide.source
**Decision:** Keep both fields
**Rationale:**
- These fields are present in the current model and class diagram
- They provide useful functionality (visual content and attribution)
- Updated database schema to include these fields

### 3. GuideCategory.icon and GuideCategory.order
**Decision:** Include both fields
**Rationale:**
- `icon` provides visual representation (from schema)
- `order` enables manual sorting (from current model)
- Both serve different purposes and should coexist

### 4. Guide - New Fields
**Decision:** Add all fields from schema
- `author` (ForeignKey to User) - tracks who created the guide
- `published` (BooleanField) - enables publishing workflow
- `published_at` (DateTimeField) - tracks publication time
- `language` (CharField with choices: PL/EN) - supports bilingual content

### 5. Contact - Extended Fields
**Decision:** Add all fields from schema
- `contact_type` (CharField with choices) - categorizes contact
- `unit` (ForeignKey to Unit) - links to organizational structure
- `location` (CharField) - building/general location
- `room_number` (CharField) - specific room
- `opening_hours` (CharField) - service hours
- `phone` (CharField) - phone contact
- `website` (URLField) - official website or contact page

### 6. Contact - Timestamps
**Decision:** Keep created_at and updated_at
**Rationale:**
- Audit trail is important
- Consistent with other models
- Updated schema diagram to include these fields

## Implementation Summary

### New Models
1. **Unit** (units app) - Created to support Contact.unit relationship
   - Fields: name, short_name, description, parent_unit, unit_head, created_at, updated_at

### Modified Models
1. **GuideCategory**
   - Added: icon field

2. **Guide**
   - Added: author, published, published_at, language fields

3. **Contact**
   - Added: contact_type, unit, location, room_number, opening_hours, phone, website fields
   - Modified: description help text

### Migrations Generated
1. `units/migrations/0001_initial.py` - Creates Unit model
2. `guides/migrations/0002_add_fields_align_with_schema.py` - Adds all new fields to guides models

### Tests Updated
1. **units/tests.py** - Complete test coverage for Unit model
2. **guides/tests.py** - Extended tests for:
   - GuideCategory icon field
   - Guide author, published, published_at, language fields
   - Contact all new fields and relationships

### Admin Updated
1. **units/admin.py** - Admin interface for Unit model
2. **guides/admin.py** - Updated to show new fields in list views

### Diagrams Updated
1. **database_new.puml** - Updated to match final model state:
   - Guides.Guide: Changed "excerpt" to "summary", added image/source
   - Guides.Category: Added order field
   - Guides.Contact: Added order, created_at, updated_at

2. **guides_class_diagram.puml** - Updated all model definitions to match implementation

## Migration Instructions

⚠️ **IMPORTANT: Migrations have been generated but NOT executed.**

After pulling these changes, run:
```bash
python manage.py migrate
```

This will:
1. Create the Unit table
2. Add icon field to GuideCategory
3. Add author, published, published_at, language fields to Guide
4. Add contact_type, unit, location, room_number, opening_hours, phone, website fields to Contact

## Next Steps

1. Run migrations in development environment
2. Test the admin interface with new fields
3. Update any frontend templates that display guides/contacts to use new fields
4. Consider adding filters/views for published vs unpublished guides
5. Consider adding language filters for bilingual content support
