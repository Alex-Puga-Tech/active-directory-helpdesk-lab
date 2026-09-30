# INC-012 — Windows Event Log Investigation

## Issue
A user reported that their Windows workstation appeared to be experiencing recurring system errors.

## User
Workstation: WIN11CLIENT01

## Symptoms
- Initial remote Event Log query using `Get-WinEvent -ComputerName` failed with an RPC error.
- PowerShell Remoting to the workstation was still functional.
- The Windows Event Log service was confirmed to be running.
- Remote Event Log investigation identified multiple DistributedCOM events.

## Investigation
1. Attempted to retrieve System errors remotely using `Get-WinEvent -ComputerName`.
2. Encountered an RPC service unavailable error.
3. Used PowerShell Remoting to execute the Event Log query directly on WIN11CLIENT01.
4. Identified multiple DistributedCOM Event IDs 10000 and 10010.
5. Determined that several events involved the OneDrive `FileCoAuth.exe` component.
6. Checked the workstation and confirmed OneDrive was currently running.
7. Checked for the `FileCoAuth.exe` process and found it was not currently running.
8. Queried the System log for new DCOM 10000/10010 events from the previous 10 minutes.
9. No new DCOM events were found.
10. Queried the System log for Critical-level events from the previous hour.
11. No Critical system errors were found.

## Root Cause
Historical DistributedCOM events associated with the OneDrive/Office collaboration component were present in the System event log.

No evidence of an active or recurring DCOM failure was found during the investigation.

The initial RPC error was related to the remote Event Log query method rather than the Windows Event Log service being stopped.

## Resolution
- Used PowerShell Remoting as an alternative method to retrieve the workstation's Event Logs.
- Identified and reviewed the relevant DistributedCOM events.
- Confirmed OneDrive was currently running.
- Confirmed `FileCoAuth.exe` was not actively running.
- Confirmed no new DCOM 10000/10010 events were occurring.
- Confirmed there were no Critical-level System events during the investigation period.
- No unnecessary system changes were made because no active fault was identified.

## Prevention
- Use Event Viewer and PowerShell Event Log queries when investigating workstation problems.
- Correlate Event Log entries with current user symptoms before taking corrective action.
- Distinguish historical/background application errors from active system failures.
- Avoid making configuration changes solely because an Event Viewer error exists.
- Use PowerShell Remoting as an alternative investigation method when direct remote Event Log queries encounter RPC issues.
- Continue monitoring if the same event begins occurring repeatedly or correlates with a user-facing problem.

## Environment
Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Remote Management: PowerShell Remoting
Primary Log: Windows System Event Log