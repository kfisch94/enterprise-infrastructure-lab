# LAB-008 — Map department drives with Group Policy

**Owner:** Kyle Fischer\
**Opened:** October 7, 2026\
**Status:** IT and Accounting mapping/access pilots validated; Q reconnect configuration corrected; lifecycle tests deferred

## Request

Automatically map I: to the IT share for employees in GG_IT_Users. Mapping is convenience; access remains enforced by SMB and NTFS permissions.

## Plan

Create FL-Users-DepartmentDrives and link to FischerLab/Users (the parent OU containing department employee OUs). Retain default Authenticated Users security filtering. Under User Configuration / Preferences / Windows Settings / Drive Maps create an Update item: location \\FS01.corp.fischerlab.test\IT, label IT Department, drive letter I:, Reconnect checked.

On Common, check Item-level targeting. Add a Security Group condition: user is a member of FISCHERLAB\GG_IT_Users. Drive Maps uses user context automatically; Run in logged-on user's security context may be unavailable, which is expected. Leave Apply once and Remove this item when it is no longer applied unchecked for this initial Update mapping. Cleanup behavior will be configured and tested separately. Do not use alternate credentials or stored passwords. Save and capture mapping and targeting.

## Validation

On CLIENT01 in ordinary amelia session, run gpupdate /target:user /force and gpresult /scope user /r. Sign out/in if mapping does not appear. Verify I: remote path via net use I:, and read I:\IT-access-test.txt. Capture GPO applied, drive connection, and file read. No manual mapping should substitute for the Group Policy validation. User drives may not appear in a separate elevated administrator session; test in the employee session.

## Remaining work

E04–E11 validate Accounting mapping/targeting, omora identity and Accounting OU, applied FL-Users-DepartmentDrives, group nesting in the token, Q connection, Accounting write/read, and explicit IT denial. Q Reconnect is unchecked, unlike the plan; request enabling and saving it. Main mapping and department-access acceptance checks passed for two pilots. Reconnect persistence after restart, group-removal cleanup, and the other department rollout are separate unvalidated behaviors. Do not repeat successful file-access tests solely for this checkbox correction.

E12 subsequently confirms Q Reconnect checked, with intended path/action/label/letter unchanged. Configuration discrepancy resolved. Main two-department pilot mapping checks are complete; later reconnect-after-restart and group-removal cleanup tests remain outside the captured results.

E01–E03 verify IT group targeting, Update I: configuration, and Status OK plus successful file readback. Guided workflow association is amelia; identity/gpresult frame was not supplied. Next configure a second Update mapping Q: to \\FS01.corp.fischerlab.test\Accounting, label Accounting Department, Reconnect checked, targeting User in FISCHERLAB\GG_Accounting_Users. Then manually provision pilot Oran Mora (omora) in Accounting, require initial password change, add GG_Accounting_Users, and validate its user GPO, Q: mapping, Accounting write/read, and IT denial. No results yet for Accounting.

Mapping execution and tests pending. Later add Accounting mapping and confirm employees receive only their intended department mapping; test group removal/cleanup separately. Existing file permission tests are LAB-007.
