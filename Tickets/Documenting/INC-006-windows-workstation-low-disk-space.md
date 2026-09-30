# INC-006 — Windows Workstation Low Disk Space

## Issue

User reported that the Windows workstation was experiencing a storage capacity issue.

## User

Jim Brown
Workstation: WIN11CLIENT01

## Symptoms

* Remote workstation health check reported the C: drive at 90.6% used.
* Available disk space was significantly lower than the workstation's normal operating level.
* The workstation remained accessible remotely.

## Investigation

1. Ran the remote workstation health-check script from DC01.
2. Confirmed that the C: drive was 90.6% used.
3. Investigated files on the workstation using PowerShell Remoting.
4. Identified `C:\MSP-LowDisk-Test.bin` as a large file consuming approximately 18.63 GB.
5. Confirmed the file was responsible for the simulated storage issue.

## Root Cause

A large file had consumed approximately 18.63 GB of disk space on the workstation, causing the C: drive to reach 90.6% utilization.

## Resolution

* Remotely removed the unnecessary file using PowerShell Remoting.
* Re-ran the workstation health check.
* Confirmed C: drive utilization returned to approximately 59%.

## Prevention

* Monitor workstation disk utilization as part of routine endpoint health checks.
* Investigate large files when disk utilization reaches a critical threshold.
* Remove unnecessary files through approved maintenance procedures.
* Maintain sufficient free disk space to prevent application and Windows performance issues.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
