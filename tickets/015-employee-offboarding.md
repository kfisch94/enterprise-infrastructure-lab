# LAB-015 — Employee offboarding

**Owner:** Kyle Fischer
**Opened:** October 8, 2026
**Status:** Complete — scoped on-premises offboarding and cleanup verified

## Request

Validate revocation of a temporary IT employee's domain and file-service access. User authorized this exercise after the initial Suricata milestone. Existing employee accounts and firewall policy stay intact.

## Test identity and scope

Use a new synthetic account named Offboarding Test, sAMAccountName offboard.test, UPN offboard.test@corp.fischerlab.test in the FischerLab Users IT OU. Ordinary Domain Users plus GG_IT_Users only; use a private temporary password and require first-logon change. Do not copy an existing account's privileges or publish passwords.

## Procedure and evidence plan

1. Create and verify enabled temporary account, OU and group membership.
2. Sign into CLIENT01 while connected to DC01 as the test user, verify identity/IT membership and mapped I: access. Create/read a uniquely named harmless test file in the IT share. Capture successful baseline and corresponding FS01 SMB session identity.
3. Disable only offboard.test and remove its explicit access-group membership. Record authoritative DC01 state.
4. Close only FS01 SMB sessions belonging to FISCHERLAB\offboard.test; record session inventory and closure. End the test user's CLIENT01 session. Account disable alone is not a claim that every existing token/session is immediately invalidated.
5. Verify fresh online domain sign-in and fresh SMB authentication are rejected with DC01 reachable; distinguish cached offline logon and existing sessions from fresh authentication.
6. Retain evidence, remove the exercise's exact test file, return CLIENT01 to the normal employee session and verify normal IT access. Keep the test identity disabled until documented cleanup; deletion is not an automatic required action.

## Limits

This is on-premises AD/SMB validation. It does not establish cloud-session revocation, removal of every cached credential, recovery of copied data or complete enterprise offboarding. Do not change broad share ACLs, domain password policy or employee memberships to make the test pass.

## Validation

E08 original Amelia session removes only exact LAB-015-offboard-test.txt; Test-PathFalse, existing restore-validation.txt reads FischerLab controlled file recovery test. Normal employee identity/read access and exercise-file cleanup verified. Scoped exercise complete: positive temporary-user baseline, account disable and IT-group removal, matching active SMB session closure, fresh online interactive sign-in rejection, explicit fresh SMB authentication error1331, unaffected Amelia access and cleanup. Test account retained disabled without explicit access groups; no later change supplied. No cloud/offline-cache/global token revocation claims.

E07 CLIENT whoami fischerlab\amelia and read of the preserved exact IT test file returns expected baseline content. New runas /netonly remote credentials FISCHERLAB\offboard.test followed by net use to FS01 IT rejects with system error1331/account currently disabled. This supplies explicit fresh SMB authentication denial distinct from earlier generic PathNotFound, while confirming unaffected normal employee access and file existence. Fresh interactive sign-in rejection already E06. Core exercise passed; close netonly window, remove only exact LAB-015 file from Amelia session, verify absence and normal restored file read. Retain disabled test account without IT membership as audit artifact; no deletion/reenablement required.

E05 current offboard.test session DC01 TCP88 True from10.10.20.100; klist purge succeeds LUID0:0x8ef6f2; exact IT file read fails ItemNotFoundException/PathNotFound. Do not equate generic UNC path failure to a specific authentication error without preserved-file and fresh SMB checks. E06 fresh Offboarding Test sign-in rejected explicitly Your account has been disabled. DC reachable immediately before sign-out, consistent with online disabled-account enforcement. Next Amelia identity/known-file read, separate runas /netonly session using disabled credentials for fresh SMB net use (local launch itself does not validate those credentials), inspect explicit network failure, then exact-file cleanup and normal employee verification.

E03 DC01 Disable-ADAccount exact offboard.test and Remove-ADGroupMember GG_IT_Users completed with no shown error; authoritative query EnabledFalse/MemberOf{}. Empty MemberOf does not mean primary Domain Users removed. E04 FS01 exact-user filter finds SessionId326417514505 from10.10.20.100, NumOpens0; Close-SmbSession -Force runs only for this captured session and subsequent same-user query returns no rows. Establishes scoped revocation/session closure; does not invalidate all cached Kerberos tickets or Windows session tokens. Next current test-user CLIENT01 DC reachability, user ticket purge, fresh IT file read failure and online fresh sign-in denial, followed by normal employee cleanup.

E02 CLIENT whoami fischerlab\offboard.test, GG_IT_Users enabled in session token, exact \\FS01.corp.fischerlab.test\IT\LAB-015-offboard-test.txt write/read with LAB-015 temporary employee access baseline. Positive identity/group/SMB+NTFS access established. Initial password-change action not independently shown. Preserve active session until revocation; next disable exact account/remove IT membership on DC01 and enumerate/close only matching FS01 SMB sessions. Fresh authentication denial not yet tested.

E01 DC01 AD Users and Computers shows Offboarding Test in FischerLab/Users/IT, Member Of Domain Users and GG_IT_Users; Apply inactive. Creation and membership corroborated; exact logon name/enabled/password-change flags not displayed. Next CLIENT01 fresh test-user login, private required password change if prompted, whoami/group token and controlled IT file write/read. No revocation performed or inferred yet.
