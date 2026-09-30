# INC-015 — Windows User Profile Issue

## Issue

A user reported that Windows was unable to load their normal user profile and displayed a message indicating that they were being signed in with a temporary profile.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* User was unable to load their normal Windows profile.
* Windows displayed the message:
  "We can't sign you in to your account."
* Windows subsequently loaded a temporary profile.
* Windows Event Viewer recorded User Profile Service Event ID 1511.
* User's normal desktop environment and profile data were unavailable.

## Investigation

1. Signed out of the affected user account and logged into WIN11CLIENT01 using an administrator account.
2. Opened Event Viewer using `eventvwr.msc`.
3. Navigated to **Windows Logs → Application**.
4. Located a **User Profile Service Event ID 1511**.
5. Confirmed that Windows could not locate the user's local profile and had loaded a temporary profile.
6. Checked `C:\Users` using File Explorer.
7. Found the user's original profile directory preserved as:
   `C:\Users\sarah.mitchell.old`
8. Confirmed Windows had also created a temporary profile directory.
9. Determined that the original profile data was still intact.

## Root Cause

The user's original Windows profile directory was unavailable under its expected path.

The profile directory had been renamed from:

`C:\Users\sarah.mitchell`

to:

`C:\Users\sarah.mitchell.old`

As a result, Windows could not locate the expected profile and loaded a temporary profile instead.

## Resolution

* Logged into the workstation using an administrator account.
* Restored the original profile directory name from:
  `sarah.mitchell.old`
  to:
  `sarah.mitchell`
* Left the temporary profile directory intact to avoid unnecessary deletion.
* Signed out of the administrator account.
* Logged back in as Sarah Mitchell.
* Confirmed Windows successfully loaded the original profile.
* Verified that the user's original files and profile data were accessible.
* Confirmed `Sarah-Mitchell-Notes.txt` was still present in the user's `Important-User-Files` folder.

## Prevention

* Investigate User Profile Service events when users report temporary-profile or login problems.
* Avoid deleting affected user profiles until the user's data has been preserved and the root cause is understood.
* Preserve the original profile directory when possible during troubleshooting.
* Verify successful user login and access to important files after remediation.
* Document profile-related errors and Event IDs for future troubleshooting.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Affected User: Sarah Mitchell
Primary Log: Windows Application Event Log
Event ID: 1511
Remote Management: Not required — troubleshooting performed locally through the Windows GUI
