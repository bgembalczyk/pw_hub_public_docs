# Django Best Practices for PW_hub

## Project Structure

```
pw_hub/
├── app_name/              # Django app (e.g., announcements, events, users)
│   ├── __init__.py
│   ├── admin.py          # Admin interface configuration
│   ├── apps.py           # App configuration
│   ├── models.py         # Database models
│   ├── views.py          # View logic
│   ├── urls.py           # URL routing
│   ├── serializers.py    # DRF serializers (if API exists)
│   ├── forms.py          # Django forms (if needed)
│   ├── managers.py       # Custom model managers (if needed)
│   ├── services.py       # Business logic layer (if complex)
│   ├── tests/            # Tests directory
│   │   ├── __init__.py
│   │   ├── test_models.py
│   │   ├── test_views.py
│   │   ├── test_api.py
│   │   └── factories.py  # Factory Boy factories
│   ├── migrations/       # Database migrations
│   └── templates/        # App-specific templates
└── config/               # Project configuration
```

## Models

### Best Practices

- **Use explicit imports**: Import specific classes from `django.db.models`
  ```python
  from django.db.models import CharField, TextField, Model
  ```
- **Add docstrings**: Every model should have a clear docstring
- **Use verbose_name**: Use `gettext_lazy` for translatable field labels
- **Define `__str__`**: Always implement a meaningful string representation
- **Add `get_absolute_url`**: For models that have detail views
- **Use Meta class**: Define ordering, verbose names, indexes, and constraints
- **Timestamps**: Use `DateTimeField` with `auto_now_add` and `auto_now` for created_at/updated_at

### Example

```python
from django.db.models import CharField, DateTimeField, Model
from django.urls import reverse
from django.utils.translation import gettext_lazy as _


class Announcement(Model):
    """
    Represents a student announcement in the PW_hub system.
    """

    title = CharField(_("Announcement Title"), max_length=255)
    created_at = DateTimeField(auto_now_add=True)
    updated_at = DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-created_at"]
        verbose_name = _("Announcement")
        verbose_name_plural = _("Announcements")

    def __str__(self) -> str:
        return self.title

    def get_absolute_url(self) -> str:
        return reverse("announcements:detail", kwargs={"pk": self.pk})
```

## Views

### Best Practices

- **Use Class-Based Views (CBVs)**: Prefer generic CBVs for CRUD operations
- **Follow the pattern**: ListView, DetailView, CreateView, UpdateView, DeleteView
- **Use mixins**: `LoginRequiredMixin`, `SuccessMessageMixin`, etc.
- **Order mixins correctly**: Authentication mixins first, then functionality mixins, then base view
- **Override `get_context_data`**: Add custom context data in a clean way
- **Override `get_queryset`**: For filtering and permissions
- **Set template_name**: Be explicit about template paths
- **Use function-based views**: Create view instances with `.as_view()`

### Example

```python
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin
from django.views.generic import ListView, CreateView
from django.utils.translation import gettext_lazy as _

from .models import Announcement


class AnnouncementListView(LoginRequiredMixin, ListView):
    model = Announcement
    context_object_name = "announcements"
    paginate_by = 20
    template_name = "announcements/announcement_list.html"

    def get_context_data(self, **kwargs):
        ctx = super().get_context_data(**kwargs)
        ctx.update({"page_title": _("Announcements")})
        return ctx


announcement_list_view = AnnouncementListView.as_view()
```

## URLs

### Best Practices

- **Use namespaces**: Every app should have a namespace
- **Use descriptive names**: URL patterns should have clear, descriptive names
- **Follow conventions**: `list`, `detail`, `create`, `update`, `delete` for CRUD

### Example

```python
from django.urls import path
from . import views

app_name = "announcements"

urlpatterns = [
    path("", views.announcement_list_view, name="list"),
    path("<int:pk>/", views.announcement_detail_view, name="detail"),
    path("create/", views.announcement_create_view, name="create"),
    path("<int:pk>/update/", views.announcement_update_view, name="update"),
    path("<int:pk>/delete/", views.announcement_delete_view, name="delete"),
]
```

## Forms

### Best Practices

- **Use ModelForms**: For forms tied to models
- **Add help_text**: Provide helpful field descriptions
- **Use widgets**: Customize form field rendering
- **Add validation**: Implement `clean_<field>` and `clean` methods
- **Use placeholders**: Add placeholder text for better UX

### Example

```python
from django import forms
from django.utils.translation import gettext_lazy as _
from .models import Announcement


class AnnouncementForm(forms.ModelForm):
    class Meta:
        model = Announcement
        fields = ["title", "content", "category"]
        widgets = {
            "content": forms.Textarea(attrs={"rows": 5}),
        }
        help_texts = {
            "title": _("A short, descriptive title for the announcement"),
        }

    def clean_title(self):
        title = self.cleaned_data.get("title")
        if len(title) < 5:
            raise forms.ValidationError(_("Title must be at least 5 characters"))
        return title
```

## Serializers (Django REST Framework)

### Best Practices

- **Use ModelSerializer**: For serializers tied to models
- **Define fields explicitly**: Use `fields` or `exclude` in Meta
- **Add validation**: Implement `validate_<field>` and `validate` methods
- **Use nested serializers**: For related objects
- **Add read-only fields**: Use `read_only_fields` for fields that shouldn't be updated

### Example

```python
from rest_framework import serializers
from .models import Announcement


class AnnouncementSerializer(serializers.ModelSerializer):
    author_name = serializers.CharField(source="author.username", read_only=True)

    class Meta:
        model = Announcement
        fields = [
            "id",
            "title",
            "content",
            "author",
            "author_name",
            "created_at",
            "updated_at",
        ]
        read_only_fields = ["id", "created_at", "updated_at"]

    def validate_title(self, value):
        if len(value) < 5:
            raise serializers.ValidationError("Title must be at least 5 characters")
        return value
```

## Admin Interface

### Best Practices

- **Customize list display**: Show relevant fields in the admin list
- **Add filters**: Use `list_filter` for common filtering
- **Add search**: Use `search_fields` for searchable fields
- **Customize forms**: Use `fields` or `fieldsets` to organize forms
- **Add readonly fields**: Protect fields that shouldn't be edited
- **Use inlines**: For related objects

### Example

```python
from django.contrib import admin
from .models import Announcement


@admin.register(Announcement)
class AnnouncementAdmin(admin.ModelAdmin):
    list_display = ["title", "author", "created_at", "is_published"]
    list_filter = ["is_published", "created_at", "category"]
    search_fields = ["title", "content"]
    readonly_fields = ["created_at", "updated_at"]
    date_hierarchy = "created_at"

    fieldsets = (
        ("Content", {
            "fields": ("title", "content", "category")
        }),
        ("Publication", {
            "fields": ("is_published", "author")
        }),
        ("Metadata", {
            "fields": ("created_at", "updated_at"),
            "classes": ("collapse",)
        }),
    )
```

## Managers

### Best Practices

- **Use custom managers**: For common queries
- **Use QuerySet methods**: For chainable filters
- **Add convenience methods**: For frequently used queries

### Example

```python
from django.db import models
from django.db.models import QuerySet


class AnnouncementQuerySet(QuerySet):
    def published(self):
        return self.filter(is_published=True)

    def recent(self, days=7):
        from django.utils import timezone
        from datetime import timedelta
        cutoff = timezone.now() - timedelta(days=days)
        return self.filter(created_at__gte=cutoff)


class AnnouncementManager(models.Manager):
    def get_queryset(self):
        return AnnouncementQuerySet(self.model, using=self._db)

    def published(self):
        return self.get_queryset().published()

    def recent(self, days=7):
        return self.get_queryset().recent(days)


class Announcement(models.Model):
    # fields...

    objects = AnnouncementManager()
```

## Migrations

**IMPORTANT**: Do NOT run migrations yourself. Instead, inform the user that migrations need to be run after pulling your changes.

### Best Practices

- **Always review migrations**: Check generated migrations before committing
- **Use data migrations**: For data transformations
- **Keep migrations small**: Split large changes into multiple migrations
- **Don't edit migrations**: After they're committed and deployed
- **Use RunPython**: For complex data migrations
- **Don't run `migrate`**: Let users run migrations after pulling

### Agent Responsibilities

**DO**:
- Generate migrations with `python manage.py makemigrations` when models change
- Review the generated migration files
- Commit migration files to version control
- Document what migrations were created in your commit message
- Inform the user that migrations need to be run

**DON'T**:
- Run `python manage.py migrate` to apply migrations
- Assume migrations have been applied
- Delete or modify existing migration files

### After Completing Your Task

Include this in your final message to the user:

```
⚠️ MIGRATIONS CREATED

The following migrations were generated and committed:
- app_name/migrations/0002_add_field.py

After pulling these changes, please run:
  python manage.py migrate

Or using Docker:
  docker compose run --rm django python manage.py migrate
```

### Example Data Migration

```python
# Generated migration file

from django.db import migrations


def populate_categories(apps, schema_editor):
    Announcement = apps.get_model("announcements", "Announcement")
    Category = apps.get_model("announcements", "Category")

    general = Category.objects.create(name="General")
    Announcement.objects.filter(category__isnull=True).update(category=general)


def reverse_populate_categories(apps, schema_editor):
    # Reverse migration logic
    pass


class Migration(migrations.Migration):
    dependencies = [
        ("announcements", "0001_initial"),
    ]

    operations = [
        migrations.RunPython(populate_categories, reverse_populate_categories),
    ]
```

## Security

### Best Practices

- **Validate input**: Always validate and sanitize user input
- **Use Django's built-in security**: CSRF protection, SQL injection prevention
- **Check permissions**: Always verify permissions before allowing actions
- **Use authentication**: Require authentication for sensitive operations
- **Avoid raw SQL**: Use the ORM when possible
- **Escape output**: Use Django templates for HTML escaping

## Performance

### Best Practices

- **Use select_related**: For foreign key relationships
- **Use prefetch_related**: For many-to-many and reverse foreign key relationships
- **Use indexes**: Add `db_index=True` or `Meta.indexes` for frequently queried fields
- **Use pagination**: Don't load all records at once
- **Cache queries**: Use Django's caching framework
- **Optimize queries**: Use `only()` and `defer()` to limit fields

### Example

```python
# Bad - N+1 query problem
announcements = Announcement.objects.all()
for announcement in announcements:
    print(announcement.author.username)  # Hits DB for each iteration

# Good - Single query with join
announcements = Announcement.objects.select_related("author").all()
for announcement in announcements:
    print(announcement.author.username)  # No additional DB queries
```

## Internationalization

### Best Practices

- **Use gettext_lazy**: For all user-facing strings
- **Mark strings**: Use `_()` function
- **Provide context**: Use `pgettext()` for ambiguous strings
- **Translate model fields**: Use `verbose_name` and `verbose_name_plural`

### Example

```python
from django.utils.translation import gettext_lazy as _

class Announcement(models.Model):
    title = models.CharField(_("Title"), max_length=255)
    content = models.TextField(_("Content"))

    class Meta:
        verbose_name = _("Announcement")
        verbose_name_plural = _("Announcements")
```
