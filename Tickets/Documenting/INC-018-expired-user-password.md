# INC-018 — Expired Domain User Password

## Issue

A user reported being unable to complete a normal domain sign-in because Windows required them to change their expired password.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* User attempted to sign into the domain.
* Windows displayed a password-expiration prompt requiring the user to change their password.
* The user could not continue normal sign-in until the password was changed.
* Active Directory confirmed that the user's password was expired.

## Investigation

1. Opened **Active Directory Users and Computers** on DC01.
2. Located Sarah Mitchell under:
   `Corporate-Users → Finance`
3. Checked the user's **Account** properties.
4. Confirmed **Password never expires** was unchecked, meaning Sarah's password was subject to the domain password-expiration policy.
5. Checked the domain password policy using PowerShell.
6. Confirmed the maximum password age was **42 days**.
7. For the simulated incident, marked Sarah's account to require a password change at the next logon.
8. Verified the account state using Active Directory:
   `PasswordExpired = True`
9. Signed into WIN11CLIENT01 as Sarah using her existing password.
10. Windows displayed the password-expiration prompt.
11. Confirmed the authentication was a domain logon against DC01.
12. Repeated the login workflow and completed the required password change.

## Root Cause

Sarah's domain password had reached its expiration state according to the organization's Active Directory password policy.

The domain policy specifies a maximum password age of **42 days**.

## Resolution

* User signed into WIN11CLIENT01 with the existing password.
* Windows prompted the user to change the expired password.
* Sarah successfully created a new password that met the domain password requirements.
* Windows completed the authentication process and allowed Sarah to access the workstation.

## Verification

After the password change, the account was checked from DC01 using Active Directory PowerShell.

The account reported:

```text
PasswordExpired : False
```

The `PasswordLastSet` value was updated to a new timestamp, confirming that the password had successfully been changed.

Sarah was able to log into WIN11CLIENT01 successfully using the new password.

## Prevention

* Communicate password-expiration requirements to users before passwords reach their expiration date.
* Encourage users to change passwords before the expiration deadline.
* Verify the user's Active Directory password state when troubleshooting authentication problems.
* Avoid disabling password expiration unless there is a documented administrative reason.
* Maintain an appropriate domain password policy based on organizational security requirements.

## Environment

Domain: `adlab.local`
Domain Controller: `DC01`
Client: `WIN11CLIENT01`
Affected User: Sarah Mitchell
Password Maximum Age: 42 days
Authentication: Active Directory domain authentication
Troubleshooting Tools: Active Directory Users and Computers, PowerShell
