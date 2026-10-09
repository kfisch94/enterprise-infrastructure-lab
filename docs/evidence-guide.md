# Evidence capture guide

Capture screenshots at requested checkpoints. Use a readable guest window, avoid unrelated desktop content, and exclude passwords, tokens, personal notifications, and license keys. Private lab addresses and VMware MAC addresses are useful for this lab's evidence.

## First ticket checkpoints

| ID | Capture | What it proves | Suggested filename |
|---|---|---|---|
| E01 | Virtual Network Editor with all network rows; selected internal network settings | Subnets and VMware DHCP / host adapter settings | 001-network-editor.png |
| E02 | FW01 adapter-to-VMnet settings and MAC addresses, using multiple captures if needed | Virtual wiring and interface identity | 002-fw01-adapter-1.png through 002-fw01-adapter-4.png |
| E03 | pfSense available interface list with interface names and MAC addresses | Correct guest-to-VMware interface mapping | 003-fw01-interface-identification.png |
| E04 | pfSense console after address configuration | Assigned interface addresses and WAN lease | 004-fw01-interface-addresses.png |
| E05 | Later: guest addressing plus gateway / internet / DNS checks | Observed connectivity, not just configuration | 005-connectivity-validation.png |
| E06 | DC01 IPv4 properties | Entered bootstrap address, mask, gateway, and temporary DNS | 006-dc01-ipv4-settings.png |
| E07 | pfSense dashboard from DC01 | Authenticated management access, CPU/RAM correction, interface labels | 007-fw01-dashboard-from-dc01.png |

Save approved portfolio captures under `evidence/001-network-foundation/`. Captures supplied in chat are reviewed first; final documentation will reference actual saved files. These paths are reserved and do not imply screenshots already exist.

For every published capture include a short caption: objective, relevant visible result, and limitation. Example after successful validation: “FW01 console showing configured internal gateways and its VMware NAT WAN lease. Firewall access policy is validated separately.”

## Later checkpoints

Domain join and sign-in; DNS results; DHCP lease; applied GPO; allowed and denied file access; firewall allow/deny tests; automation output; dashboard healthy/stale/failure states; incident recovery.

## GitHub and VS Code

We will use VS Code to browse this folder and edit Markdown. Start with the README preview. Git commits will be introduced at verified milestones, with plain-language guidance before each operation. Publishing to GitHub comes after reviewing the local files and evidence.
