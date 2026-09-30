# INC-016 — Incorrect Static IP Configuration

## Issue

A user reported that their Windows workstation could not connect to internal network resources or communicate with the domain controller.

## User

Simulated user
Workstation: WIN11CLIENT01

## Symptoms

* Workstation could not communicate with the domain controller.
* Ping to `192.168.60.10` returned:
  `General failure`
* Internal DNS resolution failed.
* `nslookup adlab.local` reported:
  `No response from server`
* The workstation remained connected to the local network but was unable to reach resources on the domain network.

## Investigation

1. Checked the workstation's network configuration using `ipconfig /all`.
2. Found the workstation configured with:

   * IPv4 Address: `192.168.61.99`
   * Subnet Mask: `255.255.255.0`
   * DNS Server: `192.168.60.10`
3. Confirmed the domain controller's IP address:

   * DC01: `192.168.60.10`
4. Determined that the workstation was incorrectly configured for the `192.168.61.0/24` subnet while the domain controller was located on the `192.168.60.0/24` subnet.
5. Tested connectivity from WIN11CLIENT01 to DC01:
   `ping 192.168.60.10`
6. The ping failed with a general failure.
7. Tested internal DNS resolution:
   `nslookup adlab.local`
8. DNS queries failed because the workstation could not reach the DNS server at `192.168.60.10`.

## Root Cause

The workstation had an incorrect static IPv4 address.

WIN11CLIENT01 was configured as:

`192.168.61.99/24`

while the lab network and domain controller use:

`192.168.60.0/24`

This placed the workstation on the wrong subnet and prevented it from communicating with DC01 and the internal DNS service.

## Resolution

1. Removed the incorrect IP address:
   `192.168.61.99`
2. Restored the workstation's correct static IP:
   `192.168.60.20/24`
3. Preserved the existing DNS configuration:
   `192.168.60.10`
4. Verified the corrected network configuration.
5. Tested connectivity to DC01 using:
   `ping 192.168.60.10`
6. Confirmed the ping was successful.
7. Tested internal DNS resolution using:
   `nslookup adlab.local`
8. Confirmed `adlab.local` successfully resolved to:
   `192.168.60.10`

## Verification

After remediation:

* WIN11CLIENT01 IP: `192.168.60.20` — OK
* Subnet: `192.168.60.0/24` — OK
* DC01 connectivity — Successful
* Internal DNS resolution — Successful
* `adlab.local` resolution — Successful
* Workstation restored to normal domain network connectivity

## Prevention

* Maintain documented static IP assignments for infrastructure and lab systems.
* Verify IP address and subnet configuration when a workstation cannot reach domain resources.
* Ensure DNS points to the organization's internal DNS server.
* Avoid assigning addresses outside the workstation's designated subnet.
* Include IP configuration checks as part of standard endpoint troubleshooting.

## Environment

Domain: `adlab.local`
Domain Controller: `DC01`
Domain Controller IP: `192.168.60.10`
Client: `WIN11CLIENT01`
Client IP: `192.168.60.20`
Network: `192.168.60.0/24`
DNS Server: `192.168.60.10`
Remote Management: PowerShell / Windows networking tools
