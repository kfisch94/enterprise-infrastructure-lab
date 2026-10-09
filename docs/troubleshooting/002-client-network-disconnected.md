# Incident — CLIENT01 disconnected network link

**Date:** October 6, 2026\
**Related ticket:** LAB-004\
**Status:** Connectivity restored and validated; exact adapter correction not captured

## Symptoms and evidence

CLIENT01 IPv4 properties show intended static values, but Ethernet0 displays Network cable unplugged (E02). hostname reports CLIENT01. DNS query to 10.10.10.10 returns no response; TCP 445 and ping fail with no SourceAddress shown (E03). E01 shows the OFFICE bootstrap pass rule applied for 10.10.20.50 to 10.10.10.10, any IPv4 protocol, zero states at capture time.

## Diagnosis

The guest reports a disconnected link. Checking VMware adapter attachment is the first corrective step. The screenshots do not yet prove whether the Connected checkbox is off, whether the wrong VMnet is selected, or whether another virtual-link issue exists. This is not evidence that AD or DC01 DNS is broken.

## Requested correction

In the running CLIENT01 VMware settings, select its network adapter; confirm Custom VMnet3, Connected, and Connect at power on. Save settings. Confirm the guest no longer reports Network cable unplugged. Leave the static address temporarily for this recovery test, then switch to automatic address and DNS after the Windows DHCP scope and pfSense relay are ready.

## Retest

Inside CLIENT01: ipconfig /all, ping 10.10.20.1, nslookup corp.fischerlab.test 10.10.10.10, and Test-NetConnection 10.10.10.10 -Port 445. Capture actual results. An OFFICE rule to DC01 alone does not authorize ping to the firewall's OFFICE address; a failed gateway ping with successful DNS/TCP is not proof of continued link failure.

## Outcome

Recovery screenshot E04 shows CLIENT01 resolving corp.fischerlab.test through 10.10.10.10 and reaching DC01 TCP 445 successfully. Test-NetConnection shows Ethernet0 and SourceAddress 10.10.20.50. Tested client connectivity is restored. The actual VMware settings change was not captured, so the record does not assert which checkbox or connection change corrected the issue. DHCP configuration is a subsequent task; it cannot correct a disconnected virtual link.
