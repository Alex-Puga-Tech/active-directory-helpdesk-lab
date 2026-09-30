# INC-020 — Microsoft Defender Real-Time Protection Disabled

---

## Issue / User Report

A user reported that Microsoft Defender antivirus protection appeared to be disabled on the workstation.

The issue was investigated to determine whether Microsoft Defender was functioning correctly and whether the real-time protection configuration had been changed.

---

## Initial Investigation

On `WIN11CLIENT01`, Windows Security was opened and the following location was inspected:

**Windows Security → Virus & threat protection → Manage settings**

The **Real-time protection** setting was found to be **Off**.

This confirmed that the workstation was not currently configured for normal real-time antivirus monitoring.

---

## Controlled Reproduction

To simulate a realistic endpoint-security incident, Real-time protection was intentionally disabled through the Windows Security interface.

The workstation subsequently displayed Real-time protection as **Off**, reproducing the reported condition.

---

## PowerShell Investigation

An elevated PowerShell session was used to investigate the Defender configuration.

The Microsoft Defender service was checked with:

```powershell
Get-Service -Name WinDefend | Select-Object Name, Status, StartType
```

Result:

* **Name:** WinDefend
* **Status:** Running
* **Start Type:** Automatic

This established that the underlying Microsoft Defender service was operational.

The Defender configuration was then checked with:

```powershell
Get-MpPreference | Select-Object DisableRealtimeMonitoring
```

The result was:

`DisableRealtimeMonitoring = True`

This confirmed that Real-time protection was explicitly disabled in the Defender configuration.

---

## Additional Investigation

The following command was used to determine whether the protection setting had been configured as a permanent disablement:

```powershell
Get-MpPreference | Select-Object DisableRealtimeMonitoring, DisableRealtimeMonitoringPermanent
```

Results:

* `DisableRealtimeMonitoring` — **True**
* `DisableRealtimeMonitoringPermanent` — blank

This indicated that the setting was disabled but was not configured as a permanent Defender disablement.

---

## Initial Remediation Attempt

An elevated PowerShell command was used to attempt to restore real-time protection:

```powershell
Set-MpPreference -DisableRealtimeMonitoring $false
```

The setting initially remained:

`DisableRealtimeMonitoring = True`

This indicated that the PowerShell change had not immediately taken effect.

Rather than repeatedly forcing the configuration, the Windows Security interface was used for the remediation.

---

## Resolution

Windows Security was opened:

**Virus & threat protection → Manage settings**

**Real-time protection** was manually switched back **On**.

The setting successfully enabled.

---

## Verification

PowerShell was used to independently verify the final Defender configuration:

```powershell
Get-MpPreference | Select-Object DisableRealtimeMonitoring
```

Final result:

`DisableRealtimeMonitoring = False`

Windows Security also displayed Real-time protection as **On**.

The Defender service remained operational.

This confirmed that real-time antivirus protection had been successfully restored.

---

## Root Cause

The simulated incident was caused by Microsoft Defender's **Real-time protection** configuration being disabled.

The underlying `WinDefend` service itself was not stopped or disabled.

The investigation therefore distinguished between:

* **Defender service health:** Healthy
* **Real-time protection configuration:** Disabled

---

## Final Status

**Resolved**

Microsoft Defender Real-time Protection was restored and independently verified through both Windows Security and PowerShell.

---

## Environment

**Status:** Resolved
**Priority:** Medium
**Category:** Endpoint Security / Microsoft Defender
**Affected User:** Sarah Mitchell
**Affected Workstation:** WIN11CLIENT01
**Environment:** Windows 11 Pro / Active Directory Domain `adlab.local`



