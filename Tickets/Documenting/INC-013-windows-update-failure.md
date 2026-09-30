# INC-013 — Windows Update Installation Failure

## Issue
A user reported that Windows Update was failing to install an update on their workstation.

## User
Workstation: WIN11CLIENT01

## Symptoms
- Windows Update had previously failed to install an update.
- Windows Event Log contained a WindowsUpdateClient Event ID 20.
- The installation failure reported error `0x80073D02`.
- The affected update was `MicrosoftWindows.Client.WebExperience`.

## Investigation
1. Checked the Windows Update services on WIN11CLIENT01.
2. Confirmed BITS, Cryptographic Services, and Windows Update were running.
3. Reviewed Windows Update events from the previous seven days.
4. Identified WindowsUpdateClient Event ID 20 reporting installation failure `0x80073D02`.
5. Checked running processes and identified active OneDrive and Windows Widgets components.
6. Checked the Windows Update download cache.
7. Found approximately 3.5 GB of cached data across the SoftwareDistribution download directory.
8. Confirmed there was no active Windows Update activity before remediation.
9. Stopped the Windows Update-related services.
10. Renamed the existing SoftwareDistribution folder to preserve the previous cache.
11. Restarted the Windows Update-related services.
12. Confirmed Windows created a new SoftwareDistribution folder.
13. Confirmed a new Windows Update DataStore database was created.
14. Initiated a fresh Windows Update scan.
15. Checked for new WindowsUpdateClient Event ID 20 errors.
16. No new installation failures were recorded.

## Root Cause
The workstation had a stale or problematic Windows Update cache associated with a previous installation failure.

The original installation failure returned error `0x80073D02`, indicating that required resources were unavailable because they were in use at the time of installation.

## Resolution
- Stopped BITS, Cryptographic Services, and Windows Update.
- Renamed the existing `SoftwareDistribution` cache.
- Restarted the Windows Update components.
- Confirmed Windows rebuilt the update cache and database.
- Initiated a fresh Windows Update scan.
- Verified that no new Windows Update installation failures occurred.

## Prevention
- Monitor Windows Update Event Log entries when users report update failures.
- Verify Windows Update, BITS, and Cryptographic Services are operational.
- Reset the SoftwareDistribution cache when appropriate after confirming that no update is actively installing.
- Preserve the original cache when possible rather than immediately deleting it.
- Verify the result after remediation instead of assuming the issue is resolved.

## Environment
Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Remote Management: PowerShell Remoting
Primary Log: Windows System Event Log