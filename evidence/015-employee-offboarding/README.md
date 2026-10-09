# LAB-015 evidence

- `001-test-account-it-membership.png`: DC01 AD Users and Computers shows Offboarding Test in FischerLab/Users/IT with Domain Users and GG_IT_Users membership; Apply appears inactive. Logon name, enabled state and first-logon password flag are not shown.

- `002-test-user-it-write-read-baseline.png`: CLIENT test session whoami fischerlab\offboard.test, GG_IT_Users in enabled token, writes/reads exact IT share file LAB-015-offboard-test.txt with expected content. Required initial password-change event not captured.

- `003-account-disabled-it-membership-removed.png`: Disable-ADAccount and removal from GG_IT_Users completed; offboard.test Enabled False, MemberOf empty (primary Domain Users membership is not represented in MemberOf).
- `004-test-smb-session-closed.png`: FS01 finds FISCHERLAB\offboard.test from10.10.20.100, SessionId326417514505/NumOpens0, closes this session and returns no matching sessions on follow-up query.

- `005-ticket-purge-dc-reachable-file-path-error.png`: offboard.test session, DC01 TCP88 reachable from10.10.20.100, current-session ticket purge succeeds; IT file read yields ItemNotFound/PathNotFound. This generic failure is not explicit SMB authentication denial.
- `006-disabled-account-sign-in-rejected.png`: Offboarding Test fresh sign-in rejected with account-disabled message.

- `007-amelia-read-disabled-smb-auth-rejected.png`: Amelia identity and preserved test-file read succeed. Separate netonly session using offboard.test credentials fails FS01 IT net use with error1331/account disabled. Explicit fresh SMB denial and unaffected employee access verified.

- `008-exact-file-cleanup-normal-access.png`: Original Amelia session removes exact test file, Test-PathFalse, existing restore-validation.txt reads expected content.

Scoped offboarding exercise complete: positive baseline, account disable/group removal, scoped SMB session closure, fresh interactive and SMB authentication rejection, unaffected Amelia access and exact test-file cleanup verified. Test account retained disabled; no cloud/offline-cache/global token revocation claims. Passwords excluded.
