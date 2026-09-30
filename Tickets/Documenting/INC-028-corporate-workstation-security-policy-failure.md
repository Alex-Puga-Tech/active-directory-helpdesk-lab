# INC-028 — Corporate Workstation Security Policy Failure

## Issue

Multiple corporate workstations were reported as no longer receiving a security policy that was normally applied through Group Policy.

## User

Multiple users
Workstations: Corporate Workstations

## Symptoms

* `GPO-Workstation-Security` was no longer being applied to affected workstations.
* Other domain policies continued to apply normally.
* `gpresult` identified the security GPO as denied because its link was disabled.

## Investigation

1. Verified `GPO-Workstation-Security` and `GPO-MSP-Test-Workstation` were enabled and linked to the Workstations OU.
2. Confirmed `GPO-Workstation-Security` was initially applied to WIN11CLIENT01.
3. Simulated a central administrative configuration error by disabling the GPO link to the Workstations OU.
4. Forced a Group Policy refresh on WIN11CLIENT01.
5. Used `gpresult /r` to confirm `GPO-Workstation-Security` was no longer applied.
6. Generated an HTML Group Policy report for detailed troubleshooting.
7. Confirmed the report identified the reason as `Denied — Disabled Link`.
8. Re-enabled the GPO link on the Workstations OU.
9. Forced another Group Policy refresh.
10. Confirmed `GPO-Workstation-Security` was successfully reapplied.

## Root Cause

The link between `GPO-Workstation-Security` and the Corporate Workstations OU had been disabled, preventing the security policy from being processed by affected workstations.

## Resolution

* Re-enabled the `GPO-Workstation-Security` link.
* Forced Group Policy processing on the affected workstation.
* Verified the security GPO was successfully reapplied.

## Prevention

* Verify GPO link status when troubleshooting widespread policy failures.
* Review Group Policy reports before modifying security filtering or permissions.
* Restrict GPO management permissions to authorized administrators.
* Document significant GPO configuration changes.
* Periodically verify critical workstation policies are being applied.

## Environment

Domain: adlab.local
Domain Controller: DC01
Affected OU: Corporate-Computers → Workstations
Client: WIN11CLIENT01
Remote Management: PowerShell / Group Policy
