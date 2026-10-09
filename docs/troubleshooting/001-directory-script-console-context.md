# Incident — Directory script pasted into an interactive console

**Date:** October 6, 2026\
**Related ticket:** LAB-003\
**Status:** Resolved; saved-file preview, creation, and rerun validated

## Symptom

Kyle pasted script sections directly into Administrator PowerShell. Both OU and group loops failed at `$PSCmdlet.ShouldProcess(...)` with:

```text
You cannot call a method on a null-valued expression.
FullyQualifiedErrorId : InvokeMethodOnNull
```

The final section, pasted separately afterward, printed `Directory structure ready. Employee import is a separate step.` This message does not establish success because the earlier sections failed.

## Diagnosis

The script uses CmdletBinding and ShouldProcess to implement preview support in a saved advanced script. Pasting its parameter declaration and subsequent statements as separate interactive commands does not establish that script execution context. `$PSCmdlet` was null when the loops called ShouldProcess.

Both supplied loops stopped before their New-ADOrganizationalUnit or New-ADGroup calls. They did not create missing objects. The output does not establish whether objects already existed from manual work.

## Correction

Save the complete original script as C:\Lab\Initialize-LabDirectory.ps1 inside DC01, with All Files selected in Notepad. Invoke the saved file in elevated Windows PowerShell with -WhatIf first. Do not execute script sections individually or remove ShouldProcess to bypass the error.

## Validation to collect

1. Test-Path confirms the saved file exists with the correct extension.
2. Preview completes without errors and shows the expected ten OUs and five groups, or EXISTS for previously created objects.
3. Apply completes without errors.
4. Rerun reports EXISTS without duplicates.
5. AD Users and Computers shows the expected structure.

Corrected run supplied: Test-Path returned True, and the saved script executed with -WhatIf without the previous error. It displayed all ten intended OUs and five department groups and ended with Preview complete. No directory changes made. The execution-context error is resolved. Apply and rerun results remain pending; no created objects are claimed from this preview.

Evidence: [saved-script preview](../../evidence/002-active-directory/007-directory-structure-preview.png).

Final verification: E08 shows ten OUs and five groups created on the first saved-file run, then all reported EXISTS on rerun without visible errors. E09 confirms the OU tree in AD Users and Computers. The intended correction is validated. Employee onboarding is separate from this resolved incident.
