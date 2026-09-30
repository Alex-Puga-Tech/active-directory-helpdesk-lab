# INC-002 — User Unable to Access Department Share

## Issue
User reported that they could not access the Finance department network share.

## User
Bob Anderson
AD account: ADLAB\bob.anderson
Workstation: WIN11-CLIENT01

## Symptoms
- Access to the Finance share was initially denied.
- User was able to authenticate successfully to the domain.

## Investigation
1. Verified the Finance shared folder permissions.
2. Verified NTFS permissions on the Finance folder.
3. Checked the user's Active Directory group membership.
4. Discovered that James had been incorrectly assigned to `GG-IT-Users`.

## Root Cause
Incorrect Active Directory security-group membership.

## Resolution
- Removed Bob from `GG-IT-Users`.
- Added Bob to `GG-Finance-Users`.
- User signed out and back in to refresh the security token.
- Verified access to `\\DC01\Finance$`.
- User successfully created a test file.

## Validation
- Finance user: Access granted 
- Unauthorized HR access: Access denied 

## Environment
Domain: adlab.local
Domain Controller/File Server: DC01
Client: WIN11-CLIENT01