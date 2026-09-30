# INC-029 — Multi-User File-Share Outage

## Issue

Multiple users reported that departmental network shares were unavailable. Investigation was required to determine whether the outage was caused by network connectivity, DNS, SMB, share configuration, or permissions.

## User

Multiple users
Workstations: WIN11CLIENT01 and affected domain clients

## Symptoms

* Finance, HR, and Sales network shares were inaccessible by hostname.
* Network connectivity to DC01 remained functional.
* DNS resolution of DC01 remained functional.
* TCP port 445 remained reachable.
* SMB2 was enabled on the file server.
* All departmental shares remained present on DC01.
* Share permissions remained correctly configured.

## Investigation

1. Verified the LanmanServer service and departmental SMB shares on DC01.
2. Simulated an SMB service interruption on the Domain Controller.
3. Confirmed affected clients could still reach DC01 by IP address.
4. Confirmed DNS resolution of DC01 remained functional.
5. Confirmed TCP port 445 remained reachable from WIN11CLIENT01.
6. Verified SMB2 was enabled on DC01.
7. Confirmed Finance$, HR$, and Sales$ shares still existed.
8. Verified Finance$ share permissions were intact.
9. Confirmed direct access using `\\192.168.60.10\Finance$` succeeded.
10. Confirmed access using the DC01 hostname initially failed.
11. Established a new authenticated SMB session using `net use \\DC01\Finance$ /user:ADLAB\Administrator`.
12. Re-tested the hostname-based share and confirmed access was restored.
13. Verified Finance$, HR$, and Sales$ were all accessible.

## Root Cause

A temporary SMB service interruption resulted in affected clients losing usable SMB session state. Although network connectivity, DNS, TCP 445, SMB configuration, share availability, and permissions remained functional, clients were unable to access the departmental shares until a new SMB session was established.

## Resolution

* Confirmed the SMB service had recovered on DC01.
* Established a new authenticated SMB session from the affected workstation.
* Verified hostname-based access to the Finance share.
* Confirmed access to Finance$, HR$, and Sales$ was restored.

## Prevention

* Monitor the LanmanServer service on file servers hosting critical departmental shares.
* Include SMB connectivity and share availability in endpoint health checks.
* Distinguish network, DNS, SMB, share, and permission failures during troubleshooting.
* Monitor client SMB sessions when investigating widespread file-share outages.
* Document service interruptions and client session recovery procedures.

## Environment

Domain: adlab.local
Domain Controller / File Server: DC01
Affected Clients: WIN11CLIENT01 and domain clients
Departmental Shares: Finance$, HR$, Sales$
Remote Management: PowerShell / SMB
