# Power Automate Planner — Flow Schema Reference

JSON payload schema and Planner Graph API field mappings for the PRD-to-Planner flow.

## Payload Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["planId", "tasks"],
  "properties": {
    "planId": {
      "type": "string",
      "description": "The Planner plan ID from the board URL"
    },
    "tasks": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["title", "bucketName"],
        "properties": {
          "title": {
            "type": "string",
            "maxLength": 255,
            "description": "Task card title"
          },
          "bucketName": {
            "type": "string",
            "description": "Bucket name — created automatically if it doesn't exist"
          },
          "priority": {
            "type": "integer",
            "enum": [1, 2, 3, 5],
            "description": "1=Low, 2=Medium, 3=Important, 5=Urgent"
          },
          "progress": {
            "type": "string",
            "enum": ["notStarted", "inProgress", "completed"],
            "default": "notStarted"
          },
          "startDate": {
            "type": ["string", "null"],
            "format": "date",
            "description": "ISO 8601 date (YYYY-MM-DD) or null"
          },
          "dueDate": {
            "type": ["string", "null"],
            "format": "date",
            "description": "ISO 8601 date (YYYY-MM-DD) or null"
          },
          "notes": {
            "type": "string",
            "maxLength": 2048,
            "description": "Task description / notes body"
          },
          "assignedTo": {
            "type": "array",
            "items": { "type": "string", "format": "email" },
            "description": "Email addresses of assignees"
          },
          "checklistItems": {
            "type": "array",
            "maxItems": 20,
            "items": { "type": "string" },
            "description": "Sub-step checklist entries"
          }
        }
      }
    }
  }
}
```

## Field Mapping: JSON → Planner Graph API

| JSON Field | Planner Action | Graph API Property |
|-----------|----------------|-------------------|
| `planId` | Create a task | `planId` |
| `title` | Create a task | `title` |
| `bucketName` | Create a bucket → use returned ID | `bucketId` (resolved) |
| `priority` | Create a task | `priority` (int: 1/2/3/5) |
| `progress` | Create a task | `percentComplete` (0/50/100) |
| `startDate` | Create a task | `startDateTime` |
| `dueDate` | Create a task | `dueDateTime` |
| `notes` | Update task details | `description` |
| `assignedTo` | Create a task | `assignments` (keyed by user ID) |
| `checklistItems` | Update task details | `checklist` (keyed by GUID) |

## Priority Mapping

The Planner Graph API uses non-sequential integers:

| Integer | Planner Label | UI Indicator |
|---------|---------------|-------------|
| `5` | Urgent | Red |
| `3` | Important | Orange |
| `2` | Medium | Yellow |
| `1` | Low | None |

## Progress Mapping

| JSON Value | Graph `percentComplete` | Planner UI |
|-----------|------------------------|------------|
| `notStarted` | `0` | Empty circle |
| `inProgress` | `50` | Half circle |
| `completed` | `100` | Checkmark |

## Bucket Convention

| Bucket | Contains |
|--------|----------|
| **Setup** | Project scaffolding, file creation, token setup |
| **Design** | Color themes, typography, visual design decisions |
| **Build** | Component implementation, page construction, interactions |
| **QA** | Testing, accessibility, responsive checks, browser testing |

## Example Payload

```json
{
  "planId": "ABCdef123456",
  "tasks": [
    {
      "title": "Set up HTML file with M3 design tokens",
      "bucketName": "Setup",
      "priority": 3,
      "progress": "notStarted",
      "startDate": null,
      "dueDate": null,
      "notes": "Scaffold base HTML with Material Web imports, import map, and design tokens.",
      "assignedTo": [],
      "checklistItems": [
        "Create HTML file",
        "Add import map for @material/web",
        "Set color tokens",
        "Add typography classes",
        "Add Material Symbols font link"
      ]
    },
    {
      "title": "Build personal info form — Step 1",
      "bucketName": "Build",
      "priority": 5,
      "progress": "notStarted",
      "startDate": null,
      "dueDate": null,
      "notes": "Step 1 of registration flow — collect attendee personal details.",
      "assignedTo": [],
      "checklistItems": [
        "Full name field",
        "Email field",
        "Company field",
        "Job title field",
        "Form validation"
      ]
    }
  ]
}
```

## Rate Limits

The Planner connector allows ~100 requests/minute per user. For PRDs with 20–30 tasks this is well within limits. For 100+ tasks, add a 1-second delay between task creation actions in the flow.
