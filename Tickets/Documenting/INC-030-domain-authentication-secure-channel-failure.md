# INC-030 — Domain Authentication and Secure Channel Failure

## Issue

Multiple domain authentication failures were reported on a corporate workstation. Investigation was required to determine whether the issue was related to DNS, Domain Controller availability, time synchronization, or the workstation's Active Directory secure channel.

## User

Multiple users
Workstation: WIN11CLIENT01

## Symptoms

* Domain Controller discovery initially failed with `ERROR_NO_SUCH_DOMAIN`.
* The workstation could not locate a logon server.
* `Test-ComputerSecureChannel` reported that the secure channel was broken.
* Windows Time initially reported `Local CMOS Clock` with Stratum 0.
* Domain authentication was unavailable.

## Investigation

1. Verified DC01 was synchronized with `pool.ntp.org` and operating at Stratum 3.
2. Verified WIN11CLIENT01 could communicate with DC01 using NTP.
3. Verified the workstation's DNS configuration pointed to DC01.
4. Confirmed the required Active Directory DNS SRV records existed on DC01.
5. Cleared the workstation's DNS cache and confirmed normal AD SRV resolution.
6. Confirmed `nltest /dsgetdc:adlab.local` was still failing.
7. Tested the workstation's secure channel and received `False`.
8. Used `nltest /sc_verify:adlab.local` and received `ERROR_NO_LOGON_SERVERS`.
9. Investigated DC01 and discovered the Netlogon service was stopped.
10. Started the Netlogon service on DC01.
11. Confirmed the workstation could successfully discover DC01 using `nltest /dsgetdc:adlab.local`.
12. Attempted to repair the workstation secure channel.
13. Repaired the computer's Active Directory secure channel using domain credentials.
14. Verified `Test-ComputerSecureChannel` returned `True`.
15. Resynchronized Windows Time and confirmed the workstation was using the domain time hierarchy with Stratum 4.
16. Performed a functional domain authentication test using `ADLAB\sarah.mitchell`.
17. Confirmed `whoami` returned `adlab\sarah.mitchell`.

## Root Cause

The Netlogon service on DC01 was stopped, preventing the Domain Controller from providing normal domain logon and secure-channel services. This caused the workstation to report `ERROR_NO_LOGON_SERVERS` and resulted in a broken Active Directory secure channel. The workstation's machine-account secure channel required repair after Netlogon was restored.

## Resolution

* Restored the Netlogon service on DC01.
* Verified successful Domain Controller discovery.
* Repaired the WIN11CLIENT01 computer account secure channel.
* Verified the secure channel returned `True`.
* Restored domain-based Windows Time synchronization.
* Confirmed successful authentication using a domain user account.

## Prevention

* Monitor the Netlogon service on Domain Controllers.
* Monitor Domain Controller health and availability.
* Include secure-channel and DC discovery checks in workstation troubleshooting procedures.
* Monitor domain time synchronization because authentication depends on accurate time.
* Use `nltest`, secure-channel tests, DNS diagnostics, and event logs to distinguish AD failures from network or DNS problems.
* Verify successful domain authentication after repairing Active Directory connectivity issues.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
DNS Server: DC01 — 192.168.60.10
Affected Services: Netlogon / Windows Time
Remote Management: PowerShell / Active Directory / Windows diagnostic tools
