# INC-011 — Windows Time Synchronization / Domain Authentication Issue

## Issue
A domain-joined Windows workstation was experiencing a Windows Time synchronization issue and was not successfully synchronizing with the domain time hierarchy.

## User
Alex Freeman
Workstation: WIN11CLIENT01

## Symptoms
- WIN11CLIENT01 identified `DC01.adlab.local` as its configured time source.
- `w32tm /query /status` initially reported:
  - Stratum: 0
  - Leap Indicator: 3 (not synchronized)
- The workstation could communicate with DC01 but was not successfully synchronizing time.

## Investigation
1. Checked the Windows Time service on DC01 and confirmed it was running.
2. Identified DC01 as the domain's PDC Emulator using `netdom query fsmo`.
3. Checked the PDC's current time source.
4. Determined that DC01 was using the local CMOS clock and did not have a functioning upstream NTP synchronization source.
5. Reviewed the Windows Time configuration on DC01.
6. Configured DC01 to use `pool.ntp.org` as its upstream NTP source.
7. Restarted the Windows Time service and forced synchronization.
8. Verified that DC01 successfully synchronized with `pool.ntp.org`.
9. Tested communication between WIN11CLIENT01 and DC01 using `w32tm /stripchart`.
10. Confirmed that the workstation could receive time samples from DC01.
11. Reconfigured WIN11CLIENT01 to use the Active Directory domain hierarchy.
12. Restarted the Windows Time service and forced rediscovery/synchronization.

## Root Cause
The domain's PDC Emulator did not have a functioning upstream NTP synchronization source, while the workstation was also in an unsynchronized state.

Although WIN11CLIENT01 correctly identified `DC01.adlab.local` as its domain time source, its Windows Time service was reporting Stratum 0 and `Leap Indicator: 3 (not synchronized)`.

## Resolution
- Configured the PDC Emulator (DC01) to synchronize with `pool.ntp.org`.
- Marked DC01 as a reliable time source for the domain.
- Successfully synchronized DC01 with the upstream NTP source.
- Verified that WIN11CLIENT01 could communicate with DC01 over the Windows Time protocol.
- Reconfigured the workstation to use the AD domain hierarchy.
- Restarted the Windows Time service on WIN11CLIENT01.
- Forced a time synchronization and rediscovery.
- Confirmed the workstation reached:
  - Stratum: 4
  - Leap Indicator: 0 (no warning)
  - Source: DC01

## Prevention
- Ensure the PDC Emulator has a reliable upstream NTP source.
- Monitor Windows Time synchronization on domain controllers.
- Ensure domain-joined workstations use the Active Directory time hierarchy.
- Investigate Stratum 0 or `Leap Indicator: 3` conditions promptly.
- Verify UDP 123 connectivity when troubleshooting NTP issues.
- Include time synchronization in domain health checks.
- Maintain accurate system time because Kerberos authentication depends on synchronized clocks.

## Environment
Domain: adlab.local
Domain Controller: DC01
PDC Emulator: DC01
Client: WIN11CLIENT01
Upstream NTP: pool.ntp.org
Remote Management: PowerShell Remoting