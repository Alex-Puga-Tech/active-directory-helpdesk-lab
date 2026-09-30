# Active Directory MSP / IT Help Desk Lab

## Project Overview

A hands-on, simulated IT support environment built with **Windows Server, Active Directory, Group Policy, DNS, PowerShell, and a domain-joined Windows 11 workstation**.

This project was designed to simulate real-world MSP and internal IT support scenarios. Each incident follows a structured troubleshooting process covering **symptom identification, investigation, root-cause analysis, resolution, verification, and prevention**.

The goal was to build practical experience with Windows infrastructure administration, endpoint troubleshooting, remote support, PowerShell automation, and technical documentation.

---

## Lab Environment

| Component          | Configuration                            |
| ------------------ | ---------------------------------------- |
| Domain             | `adlab.local`                            |
| Domain Controller  | `DC01`                                   |
| Client Workstation | `WIN11CLIENT01`                          |
| Server OS          | Windows Server 2022                      |
| Client OS          | Windows 11 Pro                           |
| Virtualization     | VirtualBox                               |
| Directory Services | Active Directory Domain Services (AD DS) |
| DNS                | Windows Server DNS                       |
| Group Policy       | Active Directory Group Policy            |
| Remote Management  | PowerShell Remoting / WinRM              |
| Networking         | VirtualBox Host-Only Network             |
| Automation         | PowerShell                               |


## Lab Architecture

```text
                    ┌─────────────────────────┐
                    │          DC01           │
                    │    Windows Server 2022  │
                    │                         │
                    │  Active Directory       │
                    │  DNS                    │
                    │  Group Policy           │
                    │  File Shares             │
                    │  PowerShell Remoting    │
                    │                         │
                    │  192.168.60.10          │
                    └────────────┬────────────┘
                                 │
                         adlab.local
                                 │
                    ┌────────────▼────────────┐
                    │      WIN11CLIENT01      │
                    │       Windows 11 Pro    │
                    │                         │
                    │       192.168.60.20     │
                    │                         │
                    │   Domain-Joined Endpoint│
                    └─────────────────────────┘
```


### Active Directory Structure

The lab includes a structured Active Directory environment with:

* Organizational Units (OUs) for users and computers
* Department-based user organization
* Security groups
* Domain-joined workstations
* Group Policy Objects (GPOs)
* Departmental file shares
* Role-based access through Active Directory security groups

---

## Skills Demonstrated

### Active Directory

* Active Directory administration
* User and computer account management
* Security group management
* Organizational Unit (OU) design
* User onboarding and offboarding
* Account lockout troubleshooting
* Password and authentication troubleshooting
* Domain Controller discovery
* Secure channel troubleshooting
* Domain authentication troubleshooting

### Group Policy

* GPO creation and configuration
* GPO security filtering
* GPO permissions
* OU-based GPO linking
* Group Policy troubleshooting with `gpresult`
* Policy refresh using `gpupdate`
* Verification of applied policies

### Windows Infrastructure

* Windows Server administration
* Windows service management
* DNS administration and troubleshooting
* SMB file-share administration
* NTFS permissions
* Network configuration
* Windows Firewall configuration
* Microsoft Defender configuration
* Windows Update troubleshooting
* Windows user-profile troubleshooting
* Windows Time synchronization

### PowerShell & Remote Support

* PowerShell administration
* PowerShell Remoting
* WinRM
* Remote service management
* Remote process management
* Remote system information gathering
* Endpoint health checks
* Troubleshooting automation
* Command-line diagnostics

### IT Support Practices

* Incident investigation
* Root-cause analysis
* Structured troubleshooting
* Service restoration
* Verification testing
* Preventive recommendations
* Technical documentation
* Evidence collection

---

## Incident Portfolio

The lab contains **30 simulated IT support incidents** covering Active Directory, authentication, Group Policy, DNS, networking, file shares, Windows services, endpoint security, and workstation troubleshooting.

### Incident Summary

| Incident                                                                                                                                | Category                 | Skills Demonstrated                                           |
| --------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ | ------------------------------------------------------------- |
| [INC-001 — Account Lockout](Tickets/Documenting/INC-001-account-lockout.md)                                                             | Active Directory         | Account management, authentication, lockout troubleshooting   |
| [INC-002 — Network Share Access](Tickets/Documenting/INC-002-network-share-access.md)                                                   | File Shares              | SMB, permissions, access troubleshooting                      |
| [INC-003 — Print Spooler Service Failure](Tickets/Documenting/INC-003-print-spooler-service-failure.md)                                 | Windows Services         | PowerShell Remoting, service management                       |
| [INC-004 — Active Directory DNS Resolution](Tickets/Documenting/INC-004-active-directory-dns-resolution.md)                             | DNS                      | DNS troubleshooting, AD name resolution                       |
| [INC-005 — Group Policy Not Applied](Tickets/Documenting/INC-005-group-policy-not-applied.md)                                           | Group Policy             | GPO filtering, permissions, `gpresult`, `gpupdate`            |
| [INC-006 — Low Disk Space](Tickets/Documenting/INC-006-windows-workstation-low-disk-space.md)                                           | Endpoint Monitoring      | Disk monitoring, PowerShell, remediation                      |
| [INC-007 — New User Onboarding](Tickets/Documenting/INC-007-new-user-onboarding.md)                                                     | Active Directory         | User provisioning, security groups, access control            |
| [INC-008 — Employee Offboarding](Tickets/Documenting/INC-008-employee-offboarding-account-deactivation.md)                              | Active Directory         | Account deactivation, group removal, access control           |
| [INC-009 — Department Share Access Failure](Tickets/Documenting/INC-009-department-share-access-failure.md)                             | File Shares              | SMB, security groups, permissions                             |
| [INC-010 — Workstation Performance Issue](Tickets/Documenting/INC-010-windows-workstation-performance-issue.md)                         | Endpoint Performance     | CPU troubleshooting, process management, PowerShell           |
| [INC-011 — Time Synchronization / Domain Authentication](Tickets/Documenting/INC-011-time-synchronization-domain-authentication.md)     | Active Directory         | Windows Time, NTP, domain authentication                      |
| [INC-012 — Windows Event Log Investigation](Tickets/Documenting/INC-012-windows-event-log-investigation.md)                             | Windows Troubleshooting  | Event Viewer, PowerShell, remote log collection               |
| [INC-013 — Windows Update Failure](Tickets/Documenting/INC-013-windows-update-failure.md)                                               | Windows Troubleshooting  | Windows Update, service management, remediation               |
| [INC-014 — Mapped Network Drive Failure](Tickets/Documenting/INC-014-mapped-network-drive-failure.md)                                   | Networking               | SMB, mapped drives, PowerShell                                |
| [INC-015 — Windows User Profile Issue](Tickets/Documenting/INC-015-windows-user-profile-issue.md)                                       | Windows Troubleshooting  | User profiles, Event Viewer, profile recovery                 |
| [INC-016 — Incorrect Static IP Configuration](Tickets/Documenting/INC-016-incorrect-static-ip-configuration.md)                         | Networking               | IP configuration, DNS, connectivity troubleshooting           |
| [INC-017 — Application Startup Issue](Tickets/Documenting/INC-017-windows-application-startup-issue.md)                                 | Endpoint Troubleshooting | Startup applications, user sessions, Windows troubleshooting  |
| [INC-018 — Expired User Password](Tickets/Documenting/INC-018-expired-user-password.md)                                                 | Active Directory         | Password policy, authentication, account management           |
| [INC-019 — Local NTFS Permission Issue](Tickets/Documenting/INC-019-local-ntfs-permission-issue.md)                                     | File Permissions         | NTFS permissions, access control, security principals         |
| [INC-020 — Defender Real-Time Protection Disabled](Tickets/Documenting/INC-020-windows-defender-real-time-protection-disabled.md)       | Endpoint Security        | Microsoft Defender, security configuration                    |
| [INC-021 — Windows Firewall Domain Profile Disabled](Tickets/Documenting/INC-021-windows-firewall-domain-profile-disabled.md)           | Endpoint Security        | Windows Firewall, network security                            |
| [INC-022 — Windows Network Adapter Disabled](Tickets/Documenting/INC-022-windows-network-adapter-disabled.md)                           | Networking               | Network adapters, IP configuration, connectivity              |
| [INC-023 — Incorrect DNS Server Configuration](Tickets/Documenting/INC-023-incorrect-dns-server-configuration.md)                       | DNS                      | DNS configuration, name resolution, troubleshooting           |
| [INC-024 — Windows Event Log Service Failure](Tickets/Documenting/INC-024-windows-event-log-service-failure.md)                         | Windows Services         | Windows services, Event Viewer, remote troubleshooting        |
| [INC-025 — Local User Account Disabled](Tickets/Documenting/INC-025-local-user-account-disabled.md)                                     | Windows Accounts         | Local account management, authentication                      |
| [INC-026 — Windows Microphone Not Working](Tickets/Documenting/INC-026-windows-microphone-not-working.md)                               | Endpoint Troubleshooting | Device management, Windows troubleshooting                    |
| [INC-027 — Multi-User Internal DNS Outage](Tickets/Documenting/INC-027-multi-user-internal-dns-outage.md)                               | DNS / Infrastructure     | DNS services, multi-user outage investigation                 |
| [INC-028 — Corporate Workstation Security Policy Failure](Tickets/Documenting/INC-028-corporate-workstation-security-policy-failure.md) | Group Policy             | GPO links, policy application, `gpresult`                     |
| [INC-029 — Multi-User File Server Outage](Tickets/Documenting/INC-029-multi-user-file-server-outage.md)                                 | File Server / SMB        | SMB, TCP 445, authentication, service troubleshooting         |
| [INC-030 — Domain Authentication & Secure Channel Failure](Tickets/Documenting/INC-030-domain-authentication-secure-channel-failure.md) | Active Directory         | Netlogon, DC discovery, secure-channel repair, authentication |

### Incident Coverage

The 30 incidents provide hands-on experience across:

* **Active Directory & Authentication** — account management, onboarding/offboarding, passwords, domain authentication, secure channels, and time synchronization
* **Group Policy** — GPO application, security filtering, OU linking, and workstation security policies
* **DNS & Networking** — DNS resolution, incorrect DNS configuration, IP configuration, network adapters, and infrastructure outages
* **File Shares & Permissions** — SMB access, departmental shares, mapped drives, NTFS permissions, and multi-user file-server outages
* **Windows Services & Troubleshooting** — Print Spooler, Event Log, Windows Update, user profiles, application startup, and endpoint devices
* **Endpoint Security & Performance** — Microsoft Defender, Windows Firewall, CPU utilization, and disk-space monitoring

Each incident contains investigation notes, troubleshooting steps, root-cause analysis, resolution steps, prevention recommendations, and supporting evidence where applicable.


---

## PowerShell Automation

The lab includes PowerShell-based remote workstation health checks designed to give an IT support technician a quick overview of endpoint health.

The health-check workflow remotely evaluates:

* Computer name and domain
* Operating system
* System uptime
* RAM utilization
* Disk utilization
* Critical Windows services
* Network connectivity
* DNS resolution
* IP configuration
* DNS server configuration
* Domain connectivity

The script was also used during several simulated incidents to quickly identify abnormal endpoint conditions and verify that systems returned to a healthy state after remediation.

---

## Troubleshooting Approach

The incidents in this lab follow a repeatable IT support methodology:

**1. Identify**
Understand the reported symptoms and affected system.

**2. Verify**
Confirm the problem using appropriate Windows, PowerShell, Active Directory, DNS, or networking tools.

**3. Isolate**
Determine whether the problem is related to the endpoint, network, authentication, permissions, services, or infrastructure.

**4. Remediate**
Apply the appropriate corrective action.

**5. Verify**
Confirm that the original problem has been resolved.

**6. Document**
Record the symptoms, investigation, root cause, resolution, and prevention steps.

This approach is intended to mirror the structured troubleshooting process used in professional IT support environments.

---

## Repository Structure

```text
AD Lab/
│
├── README.md
├── .gitignore
│
└── Tickets/
    │
    ├── Documenting/
    │   ├── INC-001-account-lockout.md
    │   ├── INC-002-network-share-access.md
    │   ├── ...
    │   └── INC-030-domain-authentication-secure-channel-failure.md
    │
    ├── Infra/
    │   ├── AD DS installed.png
    │   ├── OU Structure.png
    │   ├── GPO on Workstations.png
    │   ├── CLIENT01 under workstations.png
    │   └── ...
    │
    ├── 1.Account-Lockout/
    │   ├── troubleshooting evidence...
    │   └── screenshots...
    │
    ├── 2.Network-Share-Access/
    │   ├── troubleshooting evidence...
    │   └── screenshots...
    │
    ├── ...
    │
    └── 30.Domain-Authentication-And-Secure-Channel-Failure/
        ├── troubleshooting evidence...
        └── screenshots...
```

---

## Technologies & Tools

* Windows Server 2022
* Windows 11 Pro
* Active Directory Domain Services
* Group Policy
* Windows Server DNS
* PowerShell
* PowerShell Remoting
* WinRM
* SMB
* NTFS
* Windows Firewall
* Microsoft Defender
* Windows Event Viewer
* Windows Time Service
* VirtualBox
* Git
* GitHub

---

## Project Goals

This project was built to develop and demonstrate practical skills relevant to:

* IT Help Desk
* Technical Support
* MSP Support
* Desktop Support
* Windows Administration
* Junior Systems Administration
* Cloud Support

It also provides a foundation for expanding into cloud and infrastructure technologies such as **AWS, Azure, Linux, networking, and automation**.

---

## Disclaimer

This repository represents a **simulated home lab environment** created for learning and portfolio purposes.

No production infrastructure, customer systems, or real user accounts were used. All users, incidents, configurations, and troubleshooting scenarios were created specifically for this lab.

---

## Author

**Alex Puga**

GitHub: [Alex-Puga-Tech](https://github.com/Alex-Puga-Tech)

---

**Project status:** Completed — 30 simulated IT support incidents documented and published.
