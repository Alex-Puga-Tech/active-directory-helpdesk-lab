# INC-026 — Windows Microphone Not Working

## Issue

A user reported that other participants could not hear them during a Teams/Zoom-style call.

## User

Sarah Mitchell
Workstation: WIN11CLIENT01

## Symptoms

* Microphone was unavailable for audio input.
* Device Manager showed the microphone device as disabled.
* PowerShell reported the microphone endpoint with `Status: Error` and `Problem: Disabled`.

## Investigation

1. Verified the microphone was initially healthy with `Status: OK` and no reported problem.
2. Simulated the issue by disabling `Microphone (High Definition Audio Device)` through Device Manager.
3. Verified the microphone endpoint changed to `Status: Error` with `Problem: Disabled`.
4. Confirmed the failure was caused by the microphone device being disabled.

## Root Cause

The microphone audio endpoint had been disabled, preventing Windows from using the device for audio input.

## Resolution

* Re-enabled `Microphone (High Definition Audio Device)` through Device Manager.
* Verified the device returned to `Status: OK`.
* Confirmed the device reported no problem after remediation.

## Prevention

* Verify audio input devices are enabled when troubleshooting microphone issues.
* Check Device Manager for disabled or faulty audio devices.
* Include microphone and audio endpoint status in endpoint troubleshooting procedures.
* Avoid disabling audio devices unless required for troubleshooting or configuration.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Remote Management: PowerShell / Device Manager
