# INC-017 — Application Startup Failure

## Issue

A user reported that Microsoft OneDrive was not starting automatically when they signed into their Windows workstation.

## User

Alex Freeman
Workstation: WIN11CLIENT01

## Symptoms

* Microsoft OneDrive was not running after the user signed into Windows.
* The application had previously been available during the Windows session.
* The issue reproduced after signing out and signing back in.
* OneDrive was not listed as a running process following the fresh login.

## Investigation

1. Opened **Task Manager** on WIN11CLIENT01.
2. Navigated to **Startup apps**.
3. Located **Microsoft OneDrive**.
4. Confirmed that its startup status was **Disabled**.
5. Signed out of Windows and signed back in to reproduce the reported issue.
6. Checked **Task Manager → Processes**.
7. Confirmed that Microsoft OneDrive was not running after the fresh login.
8. Determined that the application itself was not necessarily malfunctioning; its Windows startup entry had been disabled.

## Root Cause

Microsoft OneDrive had been disabled in the Windows **Startup apps** configuration.

Because the startup entry was disabled, Windows did not automatically launch OneDrive when the user signed in.

## Resolution

* Opened **Task Manager → Startup apps**.
* Located Microsoft OneDrive.
* Changed its startup status from **Disabled** to **Enabled**.
* Signed out of Windows.
* Signed back in to initiate a fresh Windows session.

## Verification

After signing back in:

* Microsoft OneDrive automatically launched.
* OneDrive appeared as a running process in Task Manager.
* The original startup issue was resolved.

## Prevention

* Verify application startup configuration when users report that applications do not launch after sign-in.
* Check Windows **Startup apps** before reinstalling or repairing an application.
* Avoid disabling required business applications from startup without understanding their purpose.
* Confirm application behavior after a fresh user login following remediation.

## Environment

Domain: `adlab.local`
Domain Controller: `DC01`
Client: `WIN11CLIENT01`
Affected Application: Microsoft OneDrive
Troubleshooting Tool: Windows Task Manager
