# INC-022 — Windows Network Adapter Disabled

## Issue

A user reported that their Windows workstation had lost network connectivity and could no longer access internal network resources.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* Workstation network connectivity was simulated as unavailable.
* Ethernet network adapter was found to be disabled.
* No active IP configuration was available for the disabled adapter.
* Network connectivity to the domain controller was unavailable while the adapter was disabled.

## Investigation

1. Established a normal network adapter baseline using `Get-NetAdapter`.
2. Confirmed the `Ethernet` adapter was initially in an **Up** state.
3. Simulated the network failure by disabling the Ethernet adapter.
4. Verified the adapter status changed to **Disabled**.
5. Attempted to retrieve the adapter's IP configuration and confirmed no active configuration was available while the adapter was disabled.
6. Queried the adapter directly and confirmed the Ethernet adapter was disabled while retaining its MAC address and 1 Gbps link capability.
7. Re-enabled the Ethernet adapter.
8. Verified the adapter returned to an **Up** state.
9. Checked the IP configuration and confirmed the expected address and DNS configuration were restored.
10. Tested connectivity to the domain controller using `Test-Connection`.
11. Confirmed two successful replies from DC01 at `192.168.60.10`.

## Root Cause

The Ethernet network adapter on WIN11CLIENT01 was disabled, preventing the workstation from maintaining active network connectivity and IP configuration.

## Resolution

* Re-enabled the `Ethernet` network adapter using `Enable-NetAdapter`.
* Confirmed the adapter returned to an **Up** state.
* Verified the workstation recovered its expected IP configuration:

  * IP address: `192.168.60.20`
  * DNS server: `192.168.60.10`
* Tested connectivity to DC01.
* Confirmed successful communication with `192.168.60.10`.

## Prevention

* Verify network adapter status when troubleshooting workstation connectivity issues.
* Include network adapter state in routine endpoint health checks.
* Confirm IP configuration after re-enabling a network adapter.
* Test connectivity to critical infrastructure after network remediation.
* Investigate whether adapters are being disabled intentionally before making configuration changes.

## Environment

Domain: adlab.local
Domain Controller: DC01
DC01 IP: 192.168.60.10
Client: WIN11CLIENT01
Client IP: 192.168.60.20
DNS: 192.168.60.10
Remote Management: PowerShell
