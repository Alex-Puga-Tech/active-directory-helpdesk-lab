# INC-019 — Local NTFS Permission Issue

## Issue / User Report

User Sarah Mitchell reported that she was unable to access a local folder on her workstation that she should have been able to access.

**Affected path:**

`C:\MSP-Restricted`

The folder contained:

`Confidential-IT-Notes.txt`

When Sarah attempted to open the folder, Windows displayed a permissions error stating that she did not have permission to access the folder.

---

## Initial Investigation

The workstation was accessed using an administrator account.

The folder and test file were verified:

`C:\MSP-Restricted\Confidential-IT-Notes.txt`

The **Security** tab initially showed that the local `Users` group had inherited **Read & Execute** permissions.

Sarah was then specifically investigated because her account was receiving an access-denied message despite belonging to the local Users group.

---

## Advanced Permission Investigation

The **Advanced Security Settings** for `C:\MSP-Restricted` were reviewed.

An explicit permission entry was found for:

`ADLAB\sarah.mitchell`

The entry contained:

* **Permission:** Deny
* **Access:** Read & Execute
* **Inherited from:** None

This confirmed that the permission was explicitly assigned to Sarah rather than inherited from the parent folder.

---

## Root Cause

The root cause was an **explicit NTFS Deny permission** assigned directly to Sarah's domain account.

The folder also contained an inherited Allow permission through the local `Users` group:

`Users → Read & Execute`

However, the explicit **Deny** assigned directly to Sarah took precedence over the inherited Allow permission.

This prevented Sarah from accessing the folder even though the inherited Users permission appeared to grant her access.

---

## Resolution

The explicit Deny entry for:

`ADLAB\sarah.mitchell`

was removed from the folder's **Advanced Security Settings**.

The inherited `Users → Read & Execute` permission was left unchanged.

Inheritance was **not disabled**, avoiding unnecessary changes to the folder's existing permission structure.

---

## Verification

Sarah signed back into `WIN11CLIENT01` using her domain account.

She successfully accessed:

`C:\MSP-Restricted`

She was also able to access:

`Confidential-IT-Notes.txt`

This confirmed that the NTFS permission issue had been successfully resolved.

---

## Final Status

**Resolved**

User access was restored without modifying the folder's inherited permission structure.

---

## Environment

**Status:** Resolved
**Priority:** Medium
**Category:** Windows / File System / Permissions
**Affected User:** Sarah Mitchell
**Affected Workstation:** WIN11CLIENT01
**Environment:** Windows 11 Pro / Active Directory Domain `adlab.local`

