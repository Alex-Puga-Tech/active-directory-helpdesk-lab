# INC-025 — Local User Account Disabled

## Issue

A user was unable to sign in to the Windows workstation. Investigation determined that the local user account had been disabled.

## User

MSPTestUser
Workstation: WIN11CLIENT01

## Symptoms

* Local user account was unable to authenticate.
* Windows displayed the message: "Your account has been disabled, please see your system administrator."
* Other workstation functionality remained available.

## Investigation

1. Created a temporary local test account named MSPTestUser.
2. Confirmed the account was initially enabled.
3. Simulated the account failure by disabling MSPTestUser.
4. Verified the account showed Enabled=False.
5. Attempted to sign in using `.\MSPTestUser`.
6. Windows rejected the sign-in and displayed the account-disabled message.
7. Re-enabled MSPTestUser.
8. Verified the account showed Enabled=True.
9. Tested authentication again.
10. Confirmed successful login.

## Root Cause

The local Windows user account had been disabled, preventing the user from authenticating to the workstation.

## Resolution

* Re-enabled the local user account.
* Verified the account status.
* Successfully authenticated using the restored account.
* Removed the temporary test account after completing the incident simulation.

## Prevention

* Verify local account status when investigating authentication failures.
* Confirm whether an account is intentionally disabled before re-enabling it.
* Maintain appropriate account-management procedures.
* Remove temporary test accounts after completing troubleshooting exercises.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Account Type: Local Windows User
Remote Management: PowerShell
