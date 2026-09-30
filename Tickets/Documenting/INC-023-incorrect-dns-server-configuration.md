# INC-023 — Incorrect DNS Server Configuration

## Issue

A user reported that they could reach internal resources by IP address but were unable to reliably access them by hostname.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* Internal DNS configuration was incorrect.
* Workstation was configured to use `8.8.8.8` instead of the domain controller for DNS.
* Direct DNS resolution of the internal `adlab.local` domain failed.
* Connectivity to the domain controller by IP remained available.

## Investigation

1. Verified the baseline DNS configuration.
2. Confirmed Ethernet was using `192.168.60.10` for DNS.
3. Simulated an endpoint DNS configuration failure by changing the DNS server to `8.8.8.8`.
4. Verified the incorrect DNS configuration.
5. Tested connectivity to DC01 by hostname and IP.
6. Performed a direct DNS query against `8.8.8.8`.
7. DNS resolution of `DC01.adlab.local` failed with a socket/network error.
8. Confirmed the workstation was configured to use `8.8.8.8`.
9. Restored the DNS server to `192.168.60.10`.
10. Verified the correct DNS configuration.
11. Successfully resolved `DC01.adlab.local`.
12. Successfully tested connectivity to DC01.

## Root Cause

WIN11CLIENT01 was configured to use the public DNS server `8.8.8.8` instead of the internal domain controller DNS server `192.168.60.10`, preventing reliable resolution of internal `adlab.local` resources.

## Resolution

* Restored the Ethernet DNS configuration to `192.168.60.10`.
* Verified successful resolution of `DC01.adlab.local`.
* Confirmed connectivity to DC01 was restored.

## Prevention

* Verify endpoint DNS configuration when troubleshooting hostname resolution.
* Domain-joined workstations should use the organization's internal DNS infrastructure.
* Include DNS server configuration in endpoint health checks.
* Distinguish DNS configuration issues from DNS server availability issues.
* Verify both hostname and IP connectivity during troubleshooting.

## Environment

Domain: adlab.local
Domain Controller: DC01
DC01 IP: 192.168.60.10
Client: WIN11CLIENT01
Client DNS: 192.168.60.10
Remote Management: PowerShell
