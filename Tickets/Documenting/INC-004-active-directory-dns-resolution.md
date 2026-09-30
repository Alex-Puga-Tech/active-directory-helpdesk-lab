# INC-004 — Active Directory DNS Resolution

## Issue

User reported a simulated domain-resource connectivity issue. DNS resolution was investigated to determine whether the workstation could resolve the internal Active Directory domain.

## User

Jim Brown
Workstation: WIN11-CLIENT01

## Symptoms

* Internal domain name resolution was tested from the workstation.
* `adlab.local` successfully resolved when using the domain controller's DNS server.
* Resolution failed when using an external public DNS server.

## Investigation

1. Remotely tested DNS resolution from WIN11-CLIENT01.
2. Queried `adlab.local` using the domain controller DNS server at `192.168.60.10`.
3. Confirmed successful resolution of `adlab.local` to `192.168.60.10`.
4. Tested the same query against public DNS server `8.8.8.8`.
5. Confirmed that the public DNS server could not resolve the private `adlab.local` domain.

## Root Cause

The private Active Directory domain requires the internal DNS service provided by DC01. Public DNS servers such as `8.8.8.8` do not contain records for the private `adlab.local` domain.

## Resolution

* Confirmed WIN11-CLIENT01 was configured to use `192.168.60.10` as its DNS server.
* Successfully resolved `adlab.local` through the domain controller.
* Confirmed internal DNS functionality was operating correctly.

## Prevention

* Ensure domain-joined workstations use the organization's internal DNS server.
* Avoid configuring domain clients to use public DNS servers as their primary DNS resolver.
* Include DNS configuration and resolution checks in workstation troubleshooting procedures.

## Environment

Domain: adlab.local
Domain Controller: DC01
DNS Server: 192.168.60.10
Client: WIN11-CLIENT01
