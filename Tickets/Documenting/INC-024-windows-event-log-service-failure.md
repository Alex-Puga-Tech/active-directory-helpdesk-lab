# INC-024 — Windows Event Log Service Failure

## Issue

A user reported that Windows event logs were not being recorded or retrieved correctly from their workstation.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* Windows Event Log service was stopped.
* Attempting to retrieve System event logs returned an RPC server unavailable error.
* System event logs could not be accessed while the Event Log service was stopped.

## Investigation

1. Established the Event Log service baseline.
2. Confirmed EventLog was Running with an Automatic startup type.
3. Simulated a service failure by stopping EventLog.
4. Verified the service was Stopped.
5. Attempted to retrieve recent System events.
6. Get-WinEvent returned an RPC server unavailable error.
7. Confirmed EventLog remained Stopped.
8. Restarted the Event Log service.
9. Verified EventLog returned to Running.
10. Retrieved recent System events successfully.
11. Confirmed five System events were returned.

## Root Cause

The Windows Event Log service was stopped, preventing normal access to the Windows System event log and resulting in an RPC server unavailable error when querying events.

## Resolution

* Restarted the Windows Event Log service.
* Verified the service was Running.
* Successfully retrieved System event logs.
* Confirmed normal event-log functionality was restored.

## Prevention

* Include the Event Log service in workstation health checks.
* Investigate service failures when event logs cannot be retrieved.
* Monitor critical Windows services for unexpected stoppages.
* Verify event-log access after service remediation.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Remote Management: PowerShell
