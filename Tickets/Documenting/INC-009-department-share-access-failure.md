# INC-009 — Department Share Access Failure

## Issue

A Finance employee was unable to access the departmental Finance network share after being assigned to the Finance department.

## User

Sarah Mitchell
AD account: ADLAB\sarah.mitchell
Department: Finance
Workstation: WIN11CLIENT01

## Symptoms

* Sarah was unable to access `\\DC01\Finance$`.
* Sarah's account was located in the Finance OU.
* The Finance security group was initially missing from her account.
* After being added to the Finance security group, access remained denied during her existing Windows session.

## Investigation

1. Confirmed Sarah's account existed in the Finance OU.
2. Logged into WIN11CLIENT01 as Sarah.
3. Tested access to `\\DC01\Finance$` and confirmed access was denied.
4. Added Sarah to `GG-Finance-Users`.
5. Retested the Finance share while Sarah remained logged in.
6. Confirmed access was still denied.
7. Determined that Sarah's existing Windows authentication token did not contain her newly assigned group membership.

## Root Cause

Sarah had been added to the correct Active Directory security group, but her existing Windows logon session had been established before the group membership change.

The existing authentication token therefore did not contain the newly assigned `GG-Finance-Users` membership.

## Resolution

* Added Sarah to `GG-Finance-Users`.
* Signed Sarah out of WIN11CLIENT01.
* Signed Sarah back into the domain.
* Retested `\\DC01\Finance$`.
* Confirmed Finance share access was successfully granted.

## Prevention

* Add users to role-based security groups rather than assigning permissions directly.
* After group membership changes, have users sign out and sign back in to refresh their authentication token.
* Verify access from the user's workstation after making permission changes.
* Document the group responsible for each departmental resource.
* Use least-privilege access when assigning departmental permissions.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
User OU: Finance
Security Group: GG-Finance-Users
Network Share: Finance$
