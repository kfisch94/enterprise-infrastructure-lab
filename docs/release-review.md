# Release review

Pre-publication review for the public repository `kfisch94/enterprise-infrastructure-lab`. The original first-release target was October 11, 2026.

## Prepared locally

- Front page summarizes current verified results and links to a curated evidence set.
- Architecture reflects deployed addressing, services, DNS policy, IDS and monitoring.
- Validation summary retains failures and explicit evidence limits.
- LAB-014/015/016 record IDS, offboarding and post-reboot acceptance.
- Local Markdown links are checked automatically; actual GitHub rendering remains a publication-time check.
- Synthetic roster contains FirstName, LastName, Department and Username; no password column.
- Encrypted configuration exports remain in private host storage; portfolio includes only metadata and properties screenshots.

## Before publication

1. Review the automated local audit report and any flagged script/file findings.
2. Completed local OCR for all 283 evidence screenshots and visual overview of 32 contact sheets. No plaintext credentials or unrelated personal information were identified; review limits are recorded in the audit.
3. Repository owner, name and public visibility approved. No open-source license has been selected. Do not publish vendor rule-feed payloads or private configuration exports.
4. Create the repository history and review the exact staged file set. Keep VM disks, source credential spreadsheets, backup XML, secrets and temporary files excluded.
5. Publish after the local result is reviewed, then confirm the rendered README, relative links, diagram and evidence in GitHub. Record actual commit/release references only after they exist.

## Local audit

See [audit findings](release-audit.md). The audit checks local Markdown targets, file types, roster headers and selected secret-pattern indicators. Separate screenshot OCR and visual overview are recorded there. The review does not validate every external URL or guarantee absence of private data.
