# INC-027 — Multi-User Internal DNS Outage

## Issue

Multiple users reported difficulty accessing internal resources by hostname. Investigation was required to determine whether the issue was caused by workstation connectivity, DNS, or the Domain Controller.

## User

Multiple users
Workstations: WIN11CLIENT01 and affected domain clients

## Symptoms

* Internal hostname resolution failed.
* Direct network connectivity to DC01 remained functional.
* Direct DNS queries to the Domain Controller timed out.
* Existing network share access remained available during the outage.

## Investigation

1. Verified DNS, NTDS, and Netlogon services on DC01 were initially running.
2. Simulated a DNS outage by stopping the DNS Server service on DC01.
3. Confirmed WIN11CLIENT01 could still ping DC01 by IP address.
4. Tested `DC01.adlab.local` resolution and received a DNS timeout.
5. Queried DC01 directly as the DNS server and confirmed the request timed out.
6. Verified the DNS Server service on DC01 was stopped.
7. Started the DNS Server service on DC01.
8. Re-tested DNS resolution from WIN11CLIENT01 and received valid DNS records.
9. Verified `\\DC01\Finance$` remained accessible.

## Root Cause

The DNS Server service on DC01 was stopped, preventing domain clients from resolving internal DNS records. Network connectivity to the Domain Controller remained functional.

## Resolution

* Started the DNS Server service on DC01.
* Verified the service returned to Running.
* Confirmed internal DNS resolution from WIN11CLIENT01.
* Confirmed access to the internal Finance network share.

## Prevention

* Monitor critical Domain Controller services including DNS, NTDS, and Netlogon.
* Include DNS availability in workstation and server health checks.
* Investigate network connectivity and DNS separately when internal resources become unavailable.
* Monitor Domain Controller event logs for DNS service failures.

## Environment

Domain: adlab.local
Domain Controller: DC01
Clients: WIN11CLIENT01 and domain users
DNS Server: DC01 — 192.168.60.10
Remote Management: PowerShell
