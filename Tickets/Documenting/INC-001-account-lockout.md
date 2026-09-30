# INC-001 — Active Directory Account Lockout

## Issue
User reported that they were unable to sign in to the Windows workstation.

## User
Terry Shaw
AD account: ADLAB\terry.shaw
Workstation: WIN11-CLIENT01

## Symptoms
- Login attempts returned invalid credential messages.
- After repeated failed attempts, the account became locked.
- Windows delayed subsequent login attempts.

## Investigation
1. Confirmed the user account in Active Directory Users and Computers.
2. Opened the user's Account properties.
3. Confirmed that the account was locked out.
4. Reviewed the domain account lockout policy.

## Root Cause
The domain policy was configured to lock an account after 5 invalid password attempts.

## Resolution
- Unlocked the account in Active Directory.
- User was able to authenticate successfully using the correct password.

## Prevention
- User was advised to verify saved credentials and avoid repeated failed login attempts.
- Account lockout policy remains enabled as a security control.

## Environment
Domain: adlab.local
Domain Controller: DC01
Client: WIN11-CLIENT01