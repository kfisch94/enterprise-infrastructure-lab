# LAB-007 — Department file services on FS01

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** Two-department allowed/denied access validated; file-role installation capture and Git commit outstanding

## Request

Provide department shares and validate allowed and denied access through domain groups, using FS01 as a dedicated member file server.

## Preparation plan

Verify FS01 actual hostname, Windows Server edition, and existing domain membership before renaming or joining. VMware adapter remains on VMnet2. Set static IPv4 10.10.10.20/24, gateway 10.10.10.1, preferred DNS 10.10.10.10, alternate blank. If standalone and named FS01, join corp.fischerlab.test, restart, and move its computer account into FischerLab/Servers. Do not install AD DS on FS01.

## File service plan

Initial group design: GG_IT_Users nests into DL_FS01_IT_Modify; GG_Accounting_Users nests into DL_FS01_Accounting_Modify. New groups are Domain Local / Security in FischerLab/Groups. No file permission is granted until the resource groups are assigned to actual share/NTFS ACLs. Group creation instructions issued; results pending.

Begin with one IT share and one non-IT share plus a second department user to prove allow/deny behavior. Use departmental global membership groups nested into resource-specific domain local access groups (AGDLP), with documented share and NTFS permissions. Preserve SYSTEM and administrative management rights. Expand to all departments after validation. Allow OFFICE SMB to FS01 with a separate destination-specific rule; do not expand the temporary DC01 rule to all servers. Map drives using targeted Group Policy after direct UNC access passes.

## Validation and evidence

October 7 E05–E09 confirm resource group scope/type and department nesting as displayed, FS01 address 10.10.10.20, gateway 10.10.10.1, DNS 10.10.10.10. Accounting screenshots show Apply enabled; ensure settings are saved before resource tests. File Server role is Available, not Installed. No shares or ACL results yet.

Share design issued: C:\Shares\IT shared as IT, group DL_FS01_IT_Modify; C:\Shares\Accounting shared as Accounting, group DL_FS01_Accounting_Modify. On each new department folder only, convert inherited NTFS entries to explicit, retain SYSTEM and local Administrators Full Control, remove broad nonadministrative entries, and grant matching resource group Modify for this folder/subfolders/files. SMB permissions: local Administrators Full Control and matching resource group Change (with Read). Remove default Everyone share access. No explicit Deny is needed; absent Allow supplies department separation. Do not modify C:\ or parent folder ACLs. Actual configuration pending.

Pending server identity/IP/domain membership, server OU placement, filesystem path and ACLs, group nesting, share permissions, OFFICE firewall rule, permitted create/read/edit tests, denied cross-department test, and mapped-drive result. Domain join or directory settings are not yet reported complete for FS01.

## Troubleshooting / Git

Kyle reports "Administrators not found" while adding the local group to share permissions. NTFS E10/E11 show the local FS01 Administrators group exists. Object-picker search location and object-type filters are not captured; check Locations=FS01 and Object Types includes Groups, then resolve Administrators. Keep the individual Administrator entry until the group is successfully added. Do not create a replacement AD group with this name. Resolution pending.

E16 subsequently shows location corp.fischerlab.test and Groups included. Current domain search scope is confirmed; local FS01 selection remains the corrective action. If FS01 is absent in Locations, inspect that dialog and confirm the operation is being performed inside FS01 rather than substituting the DC's Builtin Administrators group.

Resolved: E17/E18 show FS01\Administrators Full Control on both shares, with individual Administrator removed and department groups retained. Wrong object-picker search location was identified from E16; successful revised principal selection verified. No customer/production impact; this is lab troubleshooting. OFFICE SMB rule and actual allowed/denied access remain pending.

E19 confirms dedicated OFFICE SMB TCP445 rule to FS01 and OFFICE net source on temporary DC01 rule. E20 verifies amelia identity and TCP445 success from leased 10.10.20.100. E21 verifies IT browsing and test-file presence. E22 shows an Accounting access problem while diagnostics are still running; conclusive authorization-denial result is not captured. Next read/append/read test uses only IT-access-test.txt, followed by Get-ChildItem on Accounting to expose the precise error. Do not call an unrelated path/network failure a passed permissions test.

Subsequent E23 supplies the final explicit no-permission error for Accounting. Cross-department negative test passed in the ongoing amelia context, correlated with E20 identity/connectivity. No duplicate Accounting command test is needed. Pending explicit IT read/append/read results complete the positive operation-level test.

E24 confirms amelia identity, initial PathNotFound for the exact test path, successful Add-Content creating the file, and successful final readback. File creation and read tests passed. This first append command created a missing file rather than modifying an existing one; request one subsequent append/read to verify modification. Do not claim a proven filename-extension cause for the initial discrepancy. The File Server role installation output remains uncaptured, although functional SMB operation is established.

E25 completes IT existing-file modification verification: a second Add-Content succeeds and Get-Content shows both lines in the amelia session. Pilot IT allow and Accounting deny acceptance checks passed. Accounting positive access with an Accounting employee, File Server role-install capture, and Git commit remain outstanding; do not present the whole department rollout as complete.

LAB-008 E09–E11 subsequently validate Oran's Accounting write/read and explicit IT denial, with identity, policy, and nested groups corroborated. Two-department allow/deny pilot completed. No claim is made for Engineering/Design/Sales shares, delete operations, or recovery tests.

E10–E15 show intended department NTFS Modify and SMB Change/Read entries with no Everyone. NTFS retains SYSTEM/local Administrators Full Control. SMB administrative entry instead uses individual FS01\Administrator. Requested correction: add FS01 local Administrators Full Control first, then remove individual Administrator, preserving department entries. Ensure Accounting NTFS Apply/OK saved. Role install output still missing; inspect actual Get-WindowsFeature FS-FileServer if needed.

Next network/access plan: add OFFICE IPv4 TCP pass rule from OFFICE net to 10.10.10.20 destination port 445 only. Keep DC01 enrollment rule separate. On CLIENT01 sign out/back in as amelia to refresh membership, test TCP 445, access \\FS01.corp.fischerlab.test\IT, create/read/edit a harmless text file, then test \\FS01.corp.fischerlab.test\Accounting expecting Access denied. Do not enter administrator credentials into the employee session. Negative test is valid only after server/network reachability is established.

E01–E04 verify initial standalone state, Windows Server 2022 Standard, domain welcome, final PartOfDomain=True, and FS01 in Servers OU. Actual static IP, file-server role state, secure channel, and existing shares/ACLs remain unverified. Next preflight commands: Get-NetIPConfiguration and Get-WindowsFeature FS-FileServer on FS01. These commands inspect configuration without changing it.

Pending.
