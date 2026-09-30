@"

\# Active Directory MSP Help Desk Lab



\## Project Overview



A hands-on simulated MSP/help desk environment built with Windows Server, Active Directory, Group Policy, DNS, PowerShell, and a domain-joined Windows 11 workstation.



The lab was designed to simulate real-world IT support scenarios and document the investigation, troubleshooting, resolution, and prevention of recurring endpoint and domain infrastructure issues.



\## Lab Environment



\- \*\*Domain:\*\* adlab.local

\- \*\*Domain Controller:\*\* DC01

\- \*\*Client Workstation:\*\* WIN11CLIENT01

\- \*\*Server OS:\*\* Windows Server 2022

\- \*\*Client OS:\*\* Windows 11 Pro

\- \*\*Virtualization:\*\* VirtualBox

\- \*\*Remote Management:\*\* PowerShell Remoting / WinRM

\- \*\*Directory Services:\*\* Active Directory Domain Services

\- \*\*DNS:\*\* Windows Server DNS

\- \*\*Group Policy:\*\* Active Directory Group Policy

\- \*\*Networking:\*\* Host-only virtual network

\- \*\*Automation:\*\* PowerShell



\## Skills Demonstrated



\- Active Directory administration

\- User and group management

\- Organizational Unit design

\- Group Policy configuration and troubleshooting

\- DNS troubleshooting

\- Windows networking

\- SMB file-share administration

\- NTFS permissions

\- Windows service management

\- PowerShell automation

\- PowerShell Remoting

\- Endpoint health monitoring

\- Windows security configuration

\- Domain authentication troubleshooting

\- Secure channel troubleshooting

\- Incident investigation and documentation



\## Incident Portfolio



This lab contains \*\*30 simulated IT support incidents\*\* covering:



\- Active Directory account lockouts

\- User onboarding and offboarding

\- Password and authentication issues

\- Group Policy failures

\- DNS outages and configuration errors

\- Network configuration problems

\- File-share access and SMB failures

\- NTFS permission issues

\- Windows service failures

\- Windows Update problems

\- Endpoint performance issues

\- Windows Firewall and Defender issues

\- User profile problems

\- Network drive failures

\- Domain authentication and secure-channel failures



Each incident includes investigation steps, root cause analysis, resolution, prevention recommendations, and supporting evidence where applicable.



\## Example Incidents



\### Domain Authentication \& Secure Channel Failure



Investigated a workstation that could not locate a Domain Controller and reported a broken Active Directory secure channel.



The investigation involved:



\- DNS and Active Directory SRV record validation

\- Domain Controller discovery

\- Netlogon service investigation

\- Secure channel verification

\- Secure channel repair

\- Windows Time synchronization

\- Functional domain authentication testing



\### Group Policy Not Applied



Investigated a workstation where a required Group Policy Object was not being applied.



The investigation included:



\- `gpresult`

\- GPO security filtering

\- Group Policy permissions

\- OU link configuration

\- `gpupdate`

\- Verification of the resulting policy application



\### Multi-User File Server Outage



Investigated a simulated SMB outage affecting multiple departmental file shares.



The investigation included:



\- Network connectivity testing

\- DNS validation

\- SMB/TCP 445 testing

\- Windows Server service investigation

\- Share availability testing

\- Authenticated SMB session validation



\## PowerShell Automation



The lab also includes PowerShell-based remote workstation health checks designed to give an IT support technician a quick overview of endpoint health.



The health check evaluates:



\- Computer and domain information

\- Operating system

\- System uptime

\- RAM utilization

\- Disk utilization

\- Critical Windows services

\- Network connectivity

\- DNS resolution

\- IP configuration

\- Domain DNS configuration



\## Repository Structure



```text

AD Lab/

├── README.md

├── .gitignore

└── Tickets/

&#x20;   ├── Documenting/

&#x20;   │   ├── INC-001-account-lockout.md

&#x20;   │   ├── INC-002-network-share-access.md

&#x20;   │   ├── ...

&#x20;   │   └── INC-030-domain-authentication-secure-channel-failure.md

&#x20;   │

&#x20;   ├── Infra/

&#x20;   │   ├── AD DS installed.png

&#x20;   │   ├── OU Structure.png

&#x20;   │   ├── GPO on Workstations.png

&#x20;   │   └── ...

&#x20;   │

&#x20;   └── \[Incident Evidence]

