# INC-014 — Mapped Network Drive Failure

## Issue
A user reported that their Finance network drive had disappeared from File Explorer and they could no longer access their usual Finance files.

## User
Workstation: WIN11CLIENT01

## Symptoms
- The Finance mapped drive `F:` was missing.
- The underlying `\\DC01\Finance$` network share remained available.
- The user could not access Finance resources through the mapped drive.

## Investigation
1. Checked the workstation's existing filesystem drives.
2. Confirmed the Finance share was mapped to drive `F:`.
3. Verified that `F:\` was accessible before the incident.
4. Simulated the failure by removing the client-side `F:` mapping.
5. Confirmed the `F:` drive was no longer available.
6. Tested the underlying SMB path using `Test-Path "\\DC01\Finance$"`.
7. Confirmed the Finance share was still reachable.
8. Determined that the issue was isolated to the client-side drive mapping rather than the server, network, or share permissions.

## Root Cause
The Finance network share remained operational, but the user's persistent client-side mapping to `F:` had been removed.

## Resolution
- Recreated the `F:` drive mapping using:
  `net use F: "\\DC01\Finance$" /persistent:yes`
- Verified the mapping appeared in `net use`.
- Confirmed `F:\` was accessible.
- Confirmed the Finance share contents were accessible through the restored mapping.

## Prevention
- Use persistent drive mappings for frequently accessed departmental resources.
- Verify the underlying UNC path before troubleshooting permissions or server availability.
- Distinguish client-side drive mapping problems from SMB share and NTFS permission problems.
- Document standard departmental drive mappings for faster help-desk troubleshooting.
- Verify both the mapping and actual file access after remediation.

## Environment
Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Network Share: \\DC01\Finance$
Mapped Drive: F:
Remote Management: PowerShell Remoting