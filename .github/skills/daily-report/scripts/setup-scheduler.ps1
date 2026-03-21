<#
.SYNOPSIS
    Registers a Windows Scheduled Task to run the daily report at 2:45 PM PST.
.DESCRIPTION
    Creates a scheduled task named "DailyProjectReport" that triggers
    the generate-report.ps1 script every day at 2:45 PM Pacific Time.
    If the task already exists, it is replaced.
#>

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$GenerateScript = Join-Path $ScriptDir "generate-report.ps1"

if (-not (Test-Path $GenerateScript)) {
    Write-Host "Error: generate-report.ps1 not found at $GenerateScript" -ForegroundColor Red
    exit 1
}

$TaskName = "DailyProjectReport"

# Remove existing task if present
$existing = Get-ScheduledTask -TaskName $TaskName -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "Removing existing task '$TaskName'..." -ForegroundColor Yellow
    Unregister-ScheduledTask -TaskName $TaskName -Confirm:$false
}

# Build the action: run PowerShell with the generate script
$Action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$GenerateScript`""

# Trigger: daily at 2:45 PM Pacific Time
# Windows Task Scheduler uses the system's local time zone.
# Convert 2:45 PM PST (UTC-8) / PDT (UTC-7) to the local time if needed.
# If this machine is already set to Pacific Time, 14:45 is correct as-is.
$PacificTZ = [System.TimeZoneInfo]::FindSystemTimeZoneById("Pacific Standard Time")
$PacificTime = [datetime]::Parse("14:45:00")
$LocalTime = [System.TimeZoneInfo]::ConvertTime(
    [System.DateTime]::Today.Add($PacificTime.TimeOfDay),
    $PacificTZ,
    [System.TimeZoneInfo]::Local
)

$Trigger = New-ScheduledTaskTrigger -Daily -At $LocalTime.ToString("HH:mm")

# Settings
$Settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 10)

# Register the task (runs as current user)
Register-ScheduledTask `
    -TaskName $TaskName `
    -Action $Action `
    -Trigger $Trigger `
    -Settings $Settings `
    -Description "Generates a daily project report from git activity at 2:45 PM PST" `
    | Out-Null

$RegisteredTask = Get-ScheduledTask -TaskName $TaskName
$TriggerInfo = $RegisteredTask.Triggers[0]

Write-Host ""
Write-Host "Scheduled task '$TaskName' created successfully." -ForegroundColor Green
Write-Host "  Trigger: Daily at $($LocalTime.ToString('h:mm tt')) (local time) = 2:45 PM PST" -ForegroundColor Cyan
Write-Host "  Script:  $GenerateScript" -ForegroundColor Cyan
Write-Host ""
Write-Host "Manage with:" -ForegroundColor Gray
Write-Host "  Get-ScheduledTask -TaskName '$TaskName'          # Check status" -ForegroundColor Gray
Write-Host "  Start-ScheduledTask -TaskName '$TaskName'        # Run now" -ForegroundColor Gray
Write-Host "  Disable-ScheduledTask -TaskName '$TaskName'      # Pause" -ForegroundColor Gray
Write-Host "  Unregister-ScheduledTask -TaskName '$TaskName'   # Remove" -ForegroundColor Gray
