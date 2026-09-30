# INC-021 — Windows Firewall Domain Profile Disabled

## Issue

A user reported a potential workstation connectivity issue. Investigation was performed to determine whether the Windows Defender Firewall configuration was affecting the workstation's domain network connectivity.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* Windows Defender Firewall Domain profile was found to be disabled.
* Private and Public firewall profiles remained enabled.
* Workstation was correctly identifying the network as DomainAuthenticated.
* Domain connectivity required verification after firewall remediation.

## Investigation

1. Checked the active network connection profile using `Get-NetConnectionProfile`.
2. Confirmed the workstation was correctly identified as **DomainAuthenticated**.
3. Checked Windows Defender Firewall profiles using `Get-NetFirewallProfile`.
4. Confirmed the Domain, Private, and Public firewall profiles were initially enabled.
5. Simulated a firewall configuration issue by disabling the Domain firewall profile.
6. Verified the Domain profile showed `Enabled = False`.
7. Queried the Domain firewall profile for additional configuration details.
8. Confirmed the Domain profile was disabled while other settings remained not explicitly configured.

## Root Cause

The Windows Defender Firewall **Domain profile was disabled**, leaving the domain network without its expected firewall protection.

The issue was isolated to the Domain firewall profile; the Private and Public profiles were not modified.

## Resolution

* Re-enabled the Domain firewall profile using `Set-NetFirewallProfile`.
* Verified the Domain profile returned to `Enabled = True`.
* Confirmed the workstation remained correctly classified as **DomainAuthenticated**.
* Tested connectivity to DC01 using `Test-Connection`.
* Confirmed two successful replies from `192.168.60.10`.
* Verified normal domain connectivity after remediation.

## Prevention

* Regularly verify Windows Defender Firewall profiles on managed workstations.
* Ensure domain-joined systems use the appropriate Domain firewall profile.
* Include firewall status in endpoint health checks.
* Investigate the active network profile before modifying firewall configuration.
* Verify domain connectivity after firewall changes.

## Environment

Domain: adlab.local
Domain Controller: DC01
DC01 IP: 192.168.60.10
Client: WIN11CLIENT01
Network Profile: DomainAuthenticated
Remote Management: PowerShell
