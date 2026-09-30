# INC-010 — Windows Workstation High CPU / Performance Issue

## Issue

A user reported that their Windows workstation was experiencing poor performance and applications were responding slowly.

## User

Simulated user
Workstation: WIN11CLIENT01

## Symptoms

* Workstation performance was simulated as degraded.
* CPU utilization increased significantly above the normal baseline.
* Remote monitoring identified an unusually high CPU-consuming process.

## Investigation

1. Established a normal CPU baseline of approximately 14%.
2. Simulated a high-CPU workload on WIN11CLIENT01.
3. Remotely monitored CPU utilization from DC01.
4. CPU utilization increased to approximately 31%.
5. Enumerated running processes using remote performance data.
6. Identified `powershell.exe` (PID 2008) as the primary CPU-consuming process.
7. Queried the process remotely and confirmed the command line contained the simulated CPU-intensive PowerShell loop.

## Root Cause

A PowerShell process was continuously executing a CPU-intensive loop, causing elevated processor utilization and simulated workstation performance degradation.

## Resolution

* Attempted to terminate the process remotely using `Stop-Process`.
* Identified that `Stop-Process` does not support the `-ComputerName` parameter.
* Used PowerShell Remoting with `Invoke-Command` to terminate PID 2008 remotely.
* Rechecked CPU utilization.
* Confirmed CPU utilization returned to 0%.

## Prevention

* Monitor endpoint CPU utilization as part of routine workstation health checks.
* Investigate high-resource processes before terminating them.
* Confirm the process command line when investigating suspicious resource usage.
* Use PowerShell Remoting for remote remediation when a cmdlet does not support direct remote execution.
* Document resource-related incidents and the processes responsible for them.

## Environment

Domain: adlab.local
Domain Controller: DC01
Client: WIN11CLIENT01
Remote Management: PowerShell Remoting
