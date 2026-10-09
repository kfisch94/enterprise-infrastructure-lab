# LAB-006 — Apply a workstation Group Policy baseline

**Owner:** Kyle Fischer\
**Opened:** October 6, 2026\
**Status:** GPO configuration, application, and sign-in notice verified; idle lock user-reported, credential-on-wake confirmation pending

## Request

Demonstrate centrally managed workstation settings with a visible sign-in notice and an inactivity lock. This is a small lab policy, not a complete security baseline.

## Plan

Create FL-Workstations-Baseline and link only to FischerLab/Workstations. Retain default Authenticated Users filtering; do not link at the domain root or modify Default Domain Policy. Configure under Computer Configuration / Policies / Windows Settings / Security Settings / Local Policies / Security Options:

- Interactive logon: Message title for users attempting to log on = FischerLab Enterprise Lab.
- Interactive logon: Message text for users attempting to log on = Authorized lab accounts only. This environment contains simulated company data.
- Interactive logon: Machine inactivity limit = 600 seconds.

## Validation

Pending GPMC scope/link and settings screenshots, CLIENT01 gpupdate /force, elevated gpresult /scope computer /r showing the GPO applied, registry values, displayed sign-in notice, and actual ten-minute idle lock. Configuration verification alone is not proof of the timed lock behavior. Domain controller remains outside this GPO's target OU.

## Troubleshooting / Git

E03 verifies the visible sign-in notice on CLIENT01. Kyle reports a black screen after ten minutes and says the lock works, but did not capture the timed event. User-reported idle-lock result recorded; request confirmation that waking required authentication because display timeout alone is not a session-lock test. Do not describe this screenshot as evidence of the lock timer.

E01 verifies the three intended policy values. E02 verifies gpupdate success and FL-Workstations-Baseline in CLIENT01's applied computer GPOs, with correct workstation OU and DC01 policy source. No application failure is shown. Empty Local Group Policy filtering is expected for an empty local policy, not a fault in this domain GPO.

Next tests: sign out and begin a new sign-in to capture notice; sign in as amelia, note start time, leave the guest running without keyboard/mouse input for at least ten minutes, and record whether it automatically locks. Guest sleep or manual lock does not validate this inactivity policy. Record actual times and outcome; do not assert that a lock-screen screenshot alone proves the timeout cause. Client registry inspection remains optional if troubleshooting requires it.

Pending.

## References

- https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-machine-inactivity-limit
- https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/interactive-logon-message-text-for-users-attempting-to-log-on
