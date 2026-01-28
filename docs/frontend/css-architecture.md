# CSS Architecture & Layering

## Purpose & audience
This document defines how we layer CSS in PW_hub to prevent style leaks, keep component boundaries clear, and prefer Bootstrap utilities over custom rules.

## Layering rules (in order)
1. **Global**
   - Resets and tokens only (colors, spacing, typography variables).
   - No styling of HTML elements (`h1`, `p`, `button`, etc.).
2. **Utilities**
   - Bootstrap utilities (`m-*`, `p-*`, `fw-*`, `d-flex`, `gap-*`, etc.).
   - Prefer utilities for layout and spacing before adding custom CSS.
3. **Components**
   - Local, component-scoped classes (BEM-style when appropriate).
   - No dependency on DOM structure (avoid `.row .col .btn`).
4. **Overrides**
   - Only explicit, local exceptions when Bootstrap/tokens cannot cover the need.
   - Must be small, scoped, and documented in the component file.

## Global selector audit

| Selector | File | Problem | Proposed action |
| --- | --- | --- | --- |
| `main` | `pw_hub/static/css/content_admin.css` | Global element selector affects all pages. | Replace with `.content-admin-main` class scoped to content admin layout. |
| `.event-title a` | `pw_hub/static/css/events.css` | Element selector depends on DOM structure. | Add `.event-title-link` class to anchors. |
| `.event-date-actions .btn` | `pw_hub/static/css/events.css` | Structure-dependent selector tied to `.btn`. | Add `.event-date-action-button` class to action links. |
| `.event-photo-card figcaption` | `pw_hub/static/css/events.css` | Element selector; styling relies on `figcaption`. | Add `.event-photo-caption` class to captions. |
| `.event-costs-table td` | `pw_hub/static/css/events.css` | Element selector applies to all table cells in a component. | Add `.event-costs-cell` class to target cells. |
| `.event-costs-label i` | `pw_hub/static/css/events.css` | Element selector tied to icon markup. | Add `.event-costs-icon` class on icons. |
| `.event-detail-table th` | `pw_hub/static/css/events.css` | Element selector for table headers. | Add `.event-detail-label` class on header cells. |

## Anti-patterns (do not do)
- Global element selectors (e.g., `h1 {}` or `button {}`).
- Deep structural selectors (e.g., `.row .col .btn`).
- Layout/spacing in custom CSS when Bootstrap utilities can express it.
- Increasing specificity to "win" over other styles.

## Component styling checklist
- ✅ Uses Bootstrap utilities for layout and spacing.
- ✅ Custom CSS is scoped to a component root class.
- ✅ No reliance on DOM structure (classes describe role, not container nesting).
- ✅ No global element selectors.

## Source of truth
- Component styles: `pw_hub/static/css/*.css`
- Templates: `pw_hub/templates/**`
