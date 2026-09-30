# INC-003 — Print Spooler Service Failure

## Issue

User reported that they were unable to print from the Windows workstation.

## User

Simulated user
Workstation: WIN11-CLIENT01

## Symptoms

* Printing was unavailable from the workstation.
* Remote health check reported the Print Spooler service as stopped.
* Other monitored Windows services remained operational.

## Investigation

1. Ran the remote workstation health-check script from DC01.
2. Confirmed that the Print Spooler service was stopped.
3. Queried the service remotely using PowerShell.
4. Confirmed the service status was `Stopped`.

## Root Cause

The Windows Print Spooler service was not running on WIN11-CLIENT01.

## Resolution

* Remotely started the Print Spooler service using PowerShell Remoting.
* Confirmed the service returned to a `Running` state.
* Re-ran the workstation health check and confirmed the service reported `Running - OK`.

## Prevention

* Include Print Spooler status in routine workstation health checks.
* Monitor critical Windows services to identify service failures before they affect users.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11-CLIENT01
