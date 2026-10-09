# Lab scripts

## Initialize-LabDirectory.ps1

Run in elevated Windows PowerShell on DC01, not on the VMware host. Requires AD management tools and permission to create objects in corp.fischerlab.test.

1. Copy this script into C:\Lab\Initialize-LabDirectory.ps1 on DC01.
   Open the source file, copy all contents into Notepad inside DC01, and use Save as type: All Files. Do not paste script sections directly into PowerShell: its ShouldProcess support requires the saved script's execution context. Use `Test-Path C:\Lab\Initialize-LabDirectory.ps1` to confirm the file exists.
2. Preview: `C:\Lab\Initialize-LabDirectory.ps1 -WhatIf`
3. If the preview matches the plan, apply: `C:\Lab\Initialize-LabDirectory.ps1`
4. Run again: expected output is EXISTS for all ten OUs and five groups.

Creates protected FischerLab OU, four child OUs, five departmental user OUs, and five empty global security groups. It checks domain identity and skips existing objects. Unexpected group collisions stop execution. It does not import employees, reset passwords, move the domain controller, or grant privileges.

Static PowerShell syntax checked on the host. AD execution, permission checks, preview behavior, and rerun behavior require actual lab validation. If execution policy blocks the script, preserve the error and review it before changing policy.

Actual lab validation subsequently passed: saved-file WhatIf preview, first-run object creation, and second-run EXISTS results are captured in LAB-002 E07–E09 (activities for LAB-003).

Known execution mistake and recovery: [interactive-console context incident](../docs/troubleshooting/001-directory-script-console-context.md).
