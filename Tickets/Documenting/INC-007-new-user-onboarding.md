# INC-007 — New User Provisioning / Onboarding

## Issue

A new employee required a domain account and access to the appropriate departmental resources.

## User

Daniel Brooks
AD account: ADLAB\daniel.brooks
Department: Finance
Workstation: WIN11CLIENT01

## Symptoms

* New employee required access to company resources.
* User required access to Finance resources.
* User should not have access to other departmental shares.

## Investigation

1. Reviewed the existing Active Directory OU structure.
2. Created the user account in the Finance OU.
3. Configured the user's department and job title.
4. Added the user to `GG-Finance-Users`.
5. Verified the user's AD attributes and group membership.
6. Reviewed SMB share permissions for `Finance$`.
7. Reviewed NTFS permissions on the Finance folder.
8. Logged in as the new user and tested access to departmental resources.

## Root Cause

The user account had not yet been provisioned because the employee was a new simulated hire.

## Resolution

* Created and enabled the AD user account.
* Added the user to `GG-Finance-Users`.
* Verified that the group had appropriate share and NTFS permissions.
* Confirmed Daniel could access `Finance$` and create files.
* Confirmed Daniel was denied access to HR and other departmental shares.

## Prevention

* Use security groups rather than assigning permissions directly to individual users.
* Follow least-privilege principles when provisioning new accounts.
* Verify both share-level and NTFS permissions during onboarding.
* Validate resource access after account creation.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
User OU: Finance
Security Group: GG-Finance-Users
