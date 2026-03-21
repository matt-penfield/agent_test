---
name: daily-report
description: '**WORKFLOW SKILL** — Automatically generate daily project summary reports from git activity. USE FOR: daily standup reports; end-of-day summaries; change logs; project status updates; tracking what was done today; automated reporting. DO NOT USE FOR: release notes (too detailed); sprint retrospectives; manual time tracking.'
argument-hint: 'Optional: specify a date range or custom report format'
---

# Daily Report

Automatically summarize daily project activity into a markdown report based on git commits, file changes, and diffs. Runs at 2:45 PM PST via Windows Task Scheduler. Skips report generation if no changes were made.

## When to Use

- Generating an end-of-day summary of project work
- Reviewing what changed in the project today
- Catching up on recent activity after being away
- Setting up or troubleshooting the automated daily schedule

## Automated Schedule

Reports are generated automatically at **2:45 PM PST** every day via a Windows Scheduled Task. If no git changes exist for the day, no report is created.

- **Reports location:** `reports/daily/YYYY-MM-DD.md`
- **Script:** [generate-report.ps1](./scripts/generate-report.ps1)
- **Scheduler setup:** [setup-scheduler.ps1](./scripts/setup-scheduler.ps1)

## Procedure

### Step 1 — Initial Setup (One Time)

Run the scheduler setup script to register the daily task:

```powershell
.\.github\skills\daily-report\scripts\setup-scheduler.ps1
```

This creates a Windows Scheduled Task named `DailyProjectReport` that runs at 2:45 PM PST.

To verify the task was created:
```powershell
Get-ScheduledTask -TaskName "DailyProjectReport"
```

### Step 2 — How the Report Is Generated

The [generate-report.ps1](./scripts/generate-report.ps1) script:

1. Checks for git commits made today by the current user
2. If no commits exist, exits without creating a report
3. If commits exist, gathers:
   - List of commits with messages and timestamps
   - Files added, modified, and deleted
   - Summary of insertions/deletions (lines changed)
4. Writes a markdown report to `reports/daily/YYYY-MM-DD.md`

### Step 3 — Manual Report Generation

To generate a report on demand:

```powershell
.\.github\skills\daily-report\scripts\generate-report.ps1
```

Or for a specific date:
```powershell
.\.github\skills\daily-report\scripts\generate-report.ps1 -Date "2026-03-20"
```

### Step 4 — Report Format

Reports follow the [template](./assets/report-template.md) and include:

- **Date and author**
- **Summary stats** (commits, files changed, lines added/removed)
- **Commits list** with timestamps and messages
- **Files changed** grouped by status (added/modified/deleted)
- **Diff summary** with per-file line counts

### Step 5 — Managing the Schedule

**Disable the scheduled task:**
```powershell
Disable-ScheduledTask -TaskName "DailyProjectReport"
```

**Re-enable:**
```powershell
Enable-ScheduledTask -TaskName "DailyProjectReport"
```

**Remove entirely:**
```powershell
Unregister-ScheduledTask -TaskName "DailyProjectReport" -Confirm:$false
```

**Change the time** — edit the trigger in `setup-scheduler.ps1` and re-run it.
