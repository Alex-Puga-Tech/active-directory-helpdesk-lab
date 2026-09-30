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

The lab contains **30 simulated IT support incidents** covering common Active Directory, Windows endpoint, networking, security, and infrastructure problems.

### Active Directory & Authentication

* Active Directory account lockout
* New user provisioning
* Employee offboarding
* Expired domain password
* Local user account disabled
* Domain authentication failure
* Active Directory secure-channel failure

### Group Policy

* Group Policy not applied
* GPO security filtering issue
* GPO link configuration problem
* Workstation security policy failure

### DNS & Networking

* Active Directory DNS resolution failure
* Incorrect DNS server configuration
* Incorrect static IP configuration
* Network adapter failure
* Multi-user internal DNS outage
* Windows Time synchronization issue

### File Shares & Permissions

* Network share access failure
* Department share access failure
* Local NTFS permission issue
* Mapped network drive failure
* Multi-user SMB/file-server outage

### Windows Services & Applications

* Print Spooler service failure
* Windows Event Log service failure
* Windows Update installation failure
* Application startup failure
* Windows user-profile issue
* Windows microphone/device issue

### Endpoint Security & Performance

* High CPU utilization
* Low disk space
* Windows Defender real-time protection disabled
* Windows Firewall profile disabled

Each incident contains investigation notes, troubleshooting steps, root-cause analysis, resolution steps, prevention recommendations, and supporting evidence where applicable.

---

## Key Incident Highlights

### Domain Authentication & Secure Channel Failure

Investigated a workstation that could not locate a Domain Controller and reported a broken Active Directory secure channel.

The investigation included:

* DNS and Active Directory SRV record validation
* Domain Controller discovery
* Netlogon service investigation
* Secure-channel verification
* Active Directory secure-channel repair
* Windows Time synchronization
* Functional domain authentication testing

The issue was traced to the **Netlogon service being stopped on the Domain Controller**, followed by repair of the workstation's machine-account secure channel.

---

### Group Policy Not Applied

Investigated a workstation where a required Group Policy Object was not being applied.

The investigation included:

* `gpresult`
* GPO security filtering
* Group Policy permissions
* OU link configuration
* `gpupdate`
* Verification of the resulting policy application

The lab demonstrates how to distinguish between a GPO configuration problem, an OU-link problem, and a security-filtering/permission problem.

---

### Multi-User File-Server Outage

Investigated a simulated SMB outage affecting multiple departmental file shares.

The investigation included:

* Network connectivity testing
* DNS validation
* TCP port 445 testing
* Windows Server service investigation
* SMB share availability testing
* Authenticated SMB session validation

The troubleshooting process demonstrates how to isolate whether a file-share failure is caused by networking, DNS, the SMB service, authentication, or permissions.

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
    └── [Incident Evidence]/
        ├── Incident 01/
        ├── Incident 02/
        ├── ...
        └── Incident 30/
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
