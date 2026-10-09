# LAB-003 — Provision simulated employees by department

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** Complete;26 accounts independently verified and no-change rerun passed

## Request

Use Kyle's synthetic employee list to demonstrate repeatable account onboarding, departmental organization, security groups, and later role-based file access.

## Source inspection

E08 verifies all26 rows with Enabled, CorrectOU, CorrectDepartment, GroupMember and NewAccountPasswordPolicy true. Summary shows roster26/AD users26/failed rows0/extra accounts0. Department and direct GG user counts both match Accounting5, Design7, Engineering2, IT5 and Sales7. The password-policy column checks pwdLastSet0 for the24 newly imported accounts; it exempts the two existing pilots to preserve their current behavior. The final PASS line is outside the screenshot, but every underlying predicate, failure count and totals are visible. Together with E07's no-change rerun, onboarding is complete. No privileged roles were assigned by this import. Source credential columns were excluded; private temporary password entered interactively. Git commit/publication pending.

## Current outcome

All26 synthetic employees are enabled, correctly placed and attributed, and directly belong to their department global security groups. Existing pilot passwords were preserved. The remaining24 accounts were created with first-logon password-change flags. Preview, apply, independent checks and idempotent rerun are evidenced. Pilot IT/Accounting workstation sessions and share boundaries are tracked in LAB-004/LAB-008; sign-in of all26 employees is not claimed.

E07 verifies saved import rerun finds26 existing/0 new accounts; every row reports EXISTS - NO CHANGE and no password prompt appears. Import validation therefore finds expected OU/UPN, enabled state, Department and direct department group membership for every roster identity. It does not establish absence of extra accounts in the search base or first-logon password flags for new accounts; independent Verify-LabEmployees.ps1 summary remains outstanding. Duplicate avoidance and no-change rerun passed.

E06 shows private masked password prompt, DEPARTMENT UPDATED for amelia/omora, CREATED and GG membership addition for all24 missing roster employees, and processing-finished message with no visible error. Source passwords were not copied or used. Object-state verification and idempotent rerun are next; script progress messages alone are not final validation. Prepared read-only Verify-LabEmployees.ps1 checks every roster account for enabled state, OU, Department and direct GG membership, requires pwdLastSet0 for newly imported accounts, flags extras, and reports counts. Pilot password-policy flags are excluded from the new-account requirement to preserve existing behavior.

E05 verifies actual DC01 saved-script -WhatIf preview with26 roster rows,24 CREATE actions,2 UPDATE METADATA/GROUP actions for amelia and omora, and final no-changes-applied message. No password prompt or errors shown. Apply is next; private temporary password is securely entered for new users only, and first-logon change is required. Existing pilot passwords/first-logon flags remain untouched.

E04 (October7) verifies a fresh DC01 inventory under FischerLab/Users containing only enabled amelia and omora, with both Department attributes blank. Remaining24 users are absent from this search base. Prepared saved-file import uses the public password-free roster, validates all rows and existing identities before mutation, creates missing accounts in their department OUs with first-logon password change, ensures corresponding GG membership, fills pilot Department attributes and never resets existing passwords. Preview and guest execution are pending. Private temporary password is entered securely during apply, not embedded in CSV or portfolio files.

Users.csv contains 26 employee records with FirstName, LastName, Department, Username, and Password columns. Required identity fields are populated; usernames are unique. The supplied Users.xlsx file exists but its contents have not been compared with the CSV. Use CSV as the import source after AD health validation.

| Department | Employees |
|---|---|
| IT | 5 |
| Accounting | 5 |
| Engineering | 2 |
| Design | 7 |
| Sales | 7 |

Original source files remain unchanged. Password values were not displayed or copied into the portfolio. Public sample data/simulated-employees.csv contains only FirstName, LastName, Department, Username; all 26 synthetic rows retained. Credential handling for account creation remains to be implemented.

## Plan

Local PowerShell parser check passed. A mocked AD preview using the sanitized26-row roster produced24 new/2 existing with zero mutation calls and no password prompt. These checks do not verify actual domain execution. Prepare-EmployeeImport.ps1 writes the roster and import script to C:\LabScripts on DC01, then invokes the saved import with -WhatIf to preserve the advanced-script execution context.

1. Validate DC01 AD and DNS first.
2. Create a FischerLab OU hierarchy with Users, Groups, Workstations, and Servers; department user OUs beneath Users.
3. Create departmental global security groups for identity membership. Add file-access domain local groups when FS01 is deployed.
4. Prepare a PowerShell import with input validation, preview mode, existing-account handling, secure password entry, and results without credentials.
5. Provision and verify one test employee before importing the rest.
6. Check account totals, OU placement, group membership, and first-sign-in password-change behavior.
7. Rerun the import to demonstrate that existing accounts are skipped without duplicates or password resets.

## Implementation / troubleshooting / validation

Pending. Do not give simulated IT employees privileged roles automatically. Capture source summary without passwords, preview output, one-account validation, final totals, and rerun results.

Prepared scripts/Initialize-LabDirectory.ps1 with domain guard, WhatIf support, protected OUs, five empty global security groups, and existing-object handling. Expected structure is ten OUs (FischerLab + four containers + five departments). Script execution has not been reported. Keep DC01 in the default Domain Controllers OU.

Subsequent LAB-002 E08 shows all ten OUs and five groups CREATED on first execution and EXISTS on the second execution, with no errors visible. E09 confirms the intended OU tree in AD Users and Computers. Structure creation and rerun validation passed. Next pilot: manually create synthetic employee Aled Melia (amelia) under the IT user OU, UPN amelia@corp.fischerlab.test; set a private temporary password with change at next logon required; add only departmental GG_IT_Users membership. Do not add privileged groups. Account creation and sign-in are not yet verified.

## Git commit

## Actual troubleshooting

Second pilot plan issued: synthetic employee Oran Mora, username omora, UPN omora@corp.fischerlab.test, OU Accounting, departmental membership GG_Accounting_Users plus default Domain Users, private temporary password with first-sign-in change required. Account creation is not yet reported. No privileged memberships requested.

LAB-008 E05/E09 verifies Oran password-change prompt followed by successful domain session, correct Accounting OU, and department/resource group token membership. First-sign-in password requirement demonstrated for Oran; Aled's password-change completion remains unconfirmed. Two of 26 roster accounts demonstrated; remaining 24 unprovisioned by the documented workflow.

Pilot captures E01–E03 under evidence/003-employee-provisioning confirm Aled Melia in IT, UPN amelia@corp.fischerlab.test, sAMAccountName amelia, Domain Users and GG_IT_Users memberships, and change-password-at-next-logon checked. Account enabled flag is outside the visible portion of the dialog; actual employee workstation sign-in is pending. Remaining 25 employees are not yet provisioned by this workflow.

Subsequent LAB-004 E05 verifies a signed-in fischerlab\amelia session and GG_IT_Users token membership. Successful session establishes usable account status at that time. Password change at first sign-in is not independently confirmed. Remaining employee import remains pending.

Kyle attempted the automation by pasting script sections into interactive PowerShell. OU/group loops failed because PSCmdlet was null, before their create commands. A separately executed final message incorrectly appeared to indicate readiness. See [incident record](../docs/troubleshooting/001-directory-script-console-context.md). Corrected saved-file execution is pending; successful directory creation has not been reported. Manual creation remains an acceptable alternative.

Subsequent saved-file execution with -WhatIf succeeded, displaying the expected ten OUs and five groups with no changes made. Test-Path returned True. Execution-context issue resolved; actual creation, duplicate-avoidance rerun, and employee import remain pending. Preview evidence is LAB-002 E07.

Pending.
