# INC-008 — Employee Offboarding / Account Deactivation

## Issue

An employee was leaving the organization and required their Active Directory account and departmental access to be disabled.

## User

Daniel Brooks
AD account: ADLAB\daniel.brooks
Department: Finance
Workstation: WIN11CLIENT01

## Symptoms

* Employee account was still active.
* User was a member of the Finance security group.
* User had access to Finance departmental resources.

## Investigation

1. Reviewed Daniel's Active Directory account before offboarding.
2. Confirmed the account was enabled.
3. Confirmed membership in `GG-Finance-Users`.
4. Reviewed the user's current access state before making changes.

## Root Cause

The employee required account deactivation as part of the simulated offboarding process.

## Resolution

* Disabled the `daniel.brooks` Active Directory account.
* Removed Daniel from `GG-Finance-Users`.
* Reset the account password.
* Verified the account remained disabled.
* Verified Daniel no longer had departmental security-group membership.
* Preserved the account rather than deleting it to maintain account history and auditability.
* Identified that an existing Windows/SMB session could continue accessing `Finance$` after the account was disabled, demonstrating the importance of terminating active sessions during offboarding.

## Prevention

* Disable departing employee accounts promptly during offboarding.
* Remove departmental and security-group access.
* Reset passwords as an additional security measure.
* Terminate active user sessions and network connections during offboarding.
* Verify resource access after account deactivation.
* Preserve disabled accounts when appropriate for audit and historical purposes.
* Use a standardized employee offboarding checklist to ensure access is removed consistently.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
User OU: Finance
Security Group: GG-Finance-Users
