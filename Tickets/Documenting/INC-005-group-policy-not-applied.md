# INC-004 — Group Policy Not Applied

## Issue

User reported that a workstation policy was not being applied to the Windows workstation.

## User

Jim Brown
Workstation: WIN11CLIENT01

## Symptoms

* A previously configured Group Policy was no longer being applied.
* `gpresult /r /scope computer` showed `GPO-MSP-Test-Workstation` as filtered out.
* The workstation was successfully communicating with the domain controller.

## Investigation

1. Ran `gpresult /r /scope computer` remotely from DC01.
2. Confirmed that `GPO-MSP-Test-Workstation` was listed under GPOs that were filtered out.
3. Reviewed the GPO security permissions using PowerShell.
4. Confirmed that `Domain Admins` had `GpoApply` permission.
5. Confirmed that the workstation was a member of `Domain Computers` and not `Domain Admins`.
6. Determined that the workstation was therefore being filtered from applying the GPO.

## Root Cause

The GPO security filtering was incorrectly configured to allow `Domain Admins` to apply the policy instead of the workstation's `Domain Computers` security group.

## Resolution

* Granted `Domain Computers` permission to apply `GPO-MSP-Test-Workstation`.
* Forced a Group Policy refresh using PowerShell Remoting.
* Re-ran `gpresult /r /scope computer`.
* Confirmed that `GPO-MSP-Test-Workstation` was successfully applied.

## Prevention

* Verify GPO security filtering when troubleshooting policies that are not applying.
* Ensure computer-based GPOs are assigned to the appropriate computer security groups.
* Use `gpresult` to verify which policies are applied or filtered out.
* Document intentional GPO security filtering changes to prevent configuration errors.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
GPO: GPO-MSP-Test-Workstation
