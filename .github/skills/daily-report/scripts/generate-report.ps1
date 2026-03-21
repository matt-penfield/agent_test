<#
.SYNOPSIS
    Generates a daily project report from git activity.
.DESCRIPTION
    Checks for git commits made today (or a specified date) and produces
    a markdown summary in reports/daily/YYYY-MM-DD.md.
    If no commits are found, exits without creating a report.
.PARAMETER Date
    Optional date string (YYYY-MM-DD). Defaults to today.
#>
param(
    [string]$Date
)

$ErrorActionPreference = "Stop"

# Resolve project root (navigate up from script location to repo root)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = (git -C $ScriptDir rev-parse --show-toplevel 2>$null)
if (-not $ProjectRoot) {
    Write-Host "Error: Not inside a git repository." -ForegroundColor Red
    exit 1
}
Set-Location $ProjectRoot

# Determine the target date
if ($Date) {
    $TargetDate = [datetime]::ParseExact($Date, "yyyy-MM-dd", $null)
} else {
    $TargetDate = Get-Date
}

$DateStr = $TargetDate.ToString("yyyy-MM-dd")
$Since = "$DateStr 00:00:00"
$Until = $TargetDate.AddDays(1).ToString("yyyy-MM-dd") + " 00:00:00"

# Get the current git user
$GitUser = git config user.name 2>$null
if (-not $GitUser) { $GitUser = $env:USERNAME }

# Check for commits on the target date
$Commits = git log --after="$Since" --before="$Until" --pretty=format:"%H|%h|%ai|%s" 2>$null
if (-not $Commits) {
    Write-Host "No commits found for $DateStr. Skipping report." -ForegroundColor Yellow
    exit 0
}

$CommitList = $Commits -split "`n" | Where-Object { $_ -ne "" }
$CommitCount = $CommitList.Count

Write-Host "Found $CommitCount commit(s) for $DateStr. Generating report..." -ForegroundColor Green

# Get diff stats for the day
$FirstCommit = ($CommitList | Select-Object -Last 1).Split("|")[0]
$LastCommit = ($CommitList | Select-Object -First 1).Split("|")[0]

# Get shortstat
$ShortStat = git diff --shortstat "$FirstCommit~1" "$LastCommit" 2>$null
if (-not $ShortStat) {
    $ShortStat = git diff --shortstat "$FirstCommit" "$LastCommit" 2>$null
}

# Get file change details
$DiffNameStatus = git diff --name-status "$FirstCommit~1" "$LastCommit" 2>$null
if (-not $DiffNameStatus) {
    $DiffNameStatus = git diff --name-status "$FirstCommit" "$LastCommit" 2>$null
}

# Get per-file stats
$DiffNumStat = git diff --numstat "$FirstCommit~1" "$LastCommit" 2>$null
if (-not $DiffNumStat) {
    $DiffNumStat = git diff --numstat "$FirstCommit" "$LastCommit" 2>$null
}

# Parse file changes
$Added = @()
$Modified = @()
$Deleted = @()
if ($DiffNameStatus) {
    foreach ($line in ($DiffNameStatus -split "`n")) {
        if ($line -match "^A\s+(.+)") { $Added += $Matches[1] }
        elseif ($line -match "^M\s+(.+)") { $Modified += $Matches[1] }
        elseif ($line -match "^D\s+(.+)") { $Deleted += $Matches[1] }
    }
}

# Build the report
$ReportDir = Join-Path $ProjectRoot "reports" "daily"
if (-not (Test-Path $ReportDir)) {
    New-Item -ItemType Directory -Path $ReportDir -Force | Out-Null
}

$ReportPath = Join-Path $ReportDir "$DateStr.md"

$Report = @"
# Daily Report — $DateStr

**Author:** $GitUser
**Generated:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

---

## Summary

| Metric | Count |
|--------|-------|
| Commits | $CommitCount |
| Files Added | $($Added.Count) |
| Files Modified | $($Modified.Count) |
| Files Deleted | $($Deleted.Count) |

$(if ($ShortStat) { "**Changes:** $($ShortStat.Trim())" })

---

## Commits

| Time | Message |
|------|---------|
"@

foreach ($commit in $CommitList) {
    $parts = $commit.Split("|")
    $time = ($parts[2] -split " ")[1]
    $message = $parts[3]
    $Report += "| ``$time`` | $message |`n"
}

$Report += @"

---

## Files Changed

"@

if ($Added.Count -gt 0) {
    $Report += "`n### Added`n"
    foreach ($f in $Added) { $Report += "- ``$f```n" }
}

if ($Modified.Count -gt 0) {
    $Report += "`n### Modified`n"
    foreach ($f in $Modified) { $Report += "- ``$f```n" }
}

if ($Deleted.Count -gt 0) {
    $Report += "`n### Deleted`n"
    foreach ($f in $Deleted) { $Report += "- ``$f```n" }
}

if ($DiffNumStat) {
    $Report += @"

---

## Diff Summary

| File | Lines Added | Lines Removed |
|------|-------------|---------------|
"@
    foreach ($line in ($DiffNumStat -split "`n")) {
        if ($line -match "^(\d+)\s+(\d+)\s+(.+)") {
            $Report += "| ``$($Matches[3])`` | +$($Matches[1]) | -$($Matches[2]) |`n"
        }
    }
}

# Write the report
$Report | Out-File -FilePath $ReportPath -Encoding utf8

Write-Host "Report saved to: $ReportPath" -ForegroundColor Green
