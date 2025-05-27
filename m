Return-Path: <linux-edac+bounces-4000-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7E0AC4F2F
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 15:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629B017EB0E
	for <lists+linux-edac@lfdr.de>; Tue, 27 May 2025 13:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC824C06A;
	Tue, 27 May 2025 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="H3LZMJsH"
X-Original-To: linux-edac@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022108.outbound.protection.outlook.com [40.107.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BB3271450
	for <linux-edac@vger.kernel.org>; Tue, 27 May 2025 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351034; cv=fail; b=c1TIwu1npQiNcWTytYr/7PfWtukmhmPML12Ef/bWdb9KpNw+Cs+S+/rLyolUz/sjrpnQN0914aBKGcBot2SV4552I99RBq6YkVYhjm3zYvMc063Vn2zEb7kLhRFDbXh4GLY5zRhPvf2QveHvHYT7wHdzOwOvjcn+tvojSs9ck8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351034; c=relaxed/simple;
	bh=359BN2vHbNfkwLFPh6W8Rmpa+rXvmABg2wW4uMDqi9E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SD0PZdm+nt1JjkQe3cT4AKKi0CrVbrYEJu8QD8OJnyJPYim1tzy+Ws4omaBILi1ht2IEIzy+aXsEQ8IIzcEJSwiRQBTwBqr55fXg7UKer9ypebeQKzjYj4F/U6q/5NwjNr13N/8j+h+/nFrZ0UaEWo9h0k/Jt2Ob630lV2Z4k58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=H3LZMJsH; arc=fail smtp.client-ip=40.107.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCPY2cEFqXtuWlm6WpvEzOme41exx5FvrwS+KZBew/Z9cmrE8FYWRyOcLarcly9zItJ6aQWTOvIxGwurO6YeAV0LCRHYi2zilDXEkSIjDupjsea3YZ/QueOdSfgO42p+GoPWiISEvuLBBPmHzYYpf0VHFjQBkDBXfFWfO/lF2KmxXMtZaYpFVacdo++sioJ2yc1mIzQj9OG6USF6TPI1U8qa7B/SgxBqe01DkcL+fndVP4J8gItDMGnQCcnHxglNllwB8T/W/mBUei0ashUjy/W3oVab3uGVuWqvZdH/CdXMLVBkHNTAnQ9NiWyvLhtd7ikUITSbSYHl4eHXHo/w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3PicBpHlDrQjIpMZ/xMSptTk4CjHwfJxsuKzBuBF2I=;
 b=tLNZjqvelpvFSz61IuGrfI0cGxYIfavRV7u/8hR7dxYtEOZ/Ka9nyDPZJVwPyV+YhklM+mwoH9T2HZYueT186y2o9nRL3LKFyhYnc4sCHASUbeoTeebw5XsUltWhAHJsb5wjuu1Vc1FMrydO35+NhrzZjVNlcYs5eV+ijiPWXkXNIlBA52zsyH0gE08Fe5Hk85XSD0O4N1phFMy/qR9TT/aEnmA8ePZoHC9hpRbznseJKpA9R2zneeFTy25XMbXtR/yaaMrcIUqbQmcw0m8r9+0/rfNZGpLsHpTvQQf9AenWyB5OdG/pH9Ak/NUyugwl2FTqYE9LhMAD2mTF0eEqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3PicBpHlDrQjIpMZ/xMSptTk4CjHwfJxsuKzBuBF2I=;
 b=H3LZMJsHodQUne6Q0QfFXZq/bmywvtJGsfHyEnDsO2IxLKv2n1IRdnpdq0djtpmhBRwlWf/jf8YgrSamoOBjZL/xw/mMdcbYx2PiHV6IXYtJ/aYKD33aK+PaNiAbeNwdpuQL+7uGfciXtS7Hp8D6p4MSfFo+kSIQ9REaaVrR1iHbHxVTcx7lAuBU5I+lPQT93B+0sU7tS14TZP3U7+sq/lIMprRlmWRG2LmD4pDXJWsunqiIEsjRZuHSZgi9u4B4PSJ8bFFjEM6WJI/O0O7XnjjVEA+tSKuQR37JXtvIQceWdozUnMdpJmoW3E0YvDUEWq2Ep9AVk/pP3w8xCCFr7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by JH0PR06MB6653.apcprd06.prod.outlook.com
 (2603:1096:990:31::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 13:03:44 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 13:03:42 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: linux-edac@vger.kernel.org,
	ak@linux.intel.com,
	tony.luck@intel.com
Cc: angus.chen@jaguarmicro.com,
	hunter.he@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH mce-test] random_offline: Fix 'syntax error' test failure on AArch64
Date: Tue, 27 May 2025 21:02:29 +0800
Message-Id: <20250527130228.315-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|JH0PR06MB6653:EE_
X-MS-Office365-Filtering-Correlation-Id: acfc35df-cc85-4fb4-7ab8-08dd9d1ee7d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WbHOgTpkYjQHX7TaXckSad3ditzaY83urJXvZrliIkOM+6Vio85b0u0Yh0l?=
 =?us-ascii?Q?ccYVsBLKos0w521bmiQ0ycTkVuW/hZ9aoqtheUsqsSwxfS75s6i97CUdOhGA?=
 =?us-ascii?Q?h0PPJvXUkKz7XQJqFKAxi/pb3iGXsr7R3S27NdHx7phSYFwneq99YmpsdsIF?=
 =?us-ascii?Q?XC7jkL1sHGxWRuiTSkhzyKRtUIk11Ow7cAy/Yz7E+AU+NNs+lLCSCjxPfTIK?=
 =?us-ascii?Q?GcUprl+fCvaUkgjtGKODdZQ7iuEr4RNuyhK/tYnz5CHWcuoFb3MWwpLJ1D3K?=
 =?us-ascii?Q?EIlLV6RGBqKzVJMPVj5JXCYwQz03+IsG7Dv++apX4YwBtvjoaXUlOb2jm5oF?=
 =?us-ascii?Q?vpjHp5IL1ZCaNbZhEOOcb2oLAkhKun1xgOB8RgAuHUQQi3O/HIeS1D2nYIax?=
 =?us-ascii?Q?ologGeWBbXEhyP18T36JXlPSpMdK1w7QbwQjYawzY9tszWoC8xDmw/5xjyuj?=
 =?us-ascii?Q?GVlA+MtBp3xgZ8tnE1r8H9ZyttzXuZErJgt/oHkCuBrucqZtkE2JZDD9CuoF?=
 =?us-ascii?Q?x3JWFDa7plGC4VYxiqhIi5yitRdm8Zu4ZGDPA+m+2aX8cChriTm+BYyzVaBz?=
 =?us-ascii?Q?DuEgPlrTDkeSU7ibHiKTGjRlAOggMaJYUD0Z5biVQealhGIodTQkouvdUlCE?=
 =?us-ascii?Q?Gdbq6NWRZxbuX09eZGh5usQ84FbxD+BQo561xk+xxoV+wQXy23h5TdgRunP0?=
 =?us-ascii?Q?x16WwPt7NIXMm1OMntAYjWkfBzxe/mN9zBJMdYezicaUzIJ0+xvhVAtsUHJ0?=
 =?us-ascii?Q?21diDRAdKwQPC4OUJdX23ga5pLyM7qz812i8JuwAg9NPxp2YEqzZvrBbowCC?=
 =?us-ascii?Q?Aq0OoCqpqhQ5+UFDGLfIygZXc6rAKUdpTwuZXJAySAkGYe5tkWne8I/3CNO8?=
 =?us-ascii?Q?M+jj+zomybCC+t/Ww+RLQ0S4cZmvaWW+ntnS5LAAGnEO6FMVfCSGTxl7AuYR?=
 =?us-ascii?Q?Ey15Ty4PLLRmvnvOC5kJ2dbdF4Liz6XmHjUZl+mUSOmS2PJq00N6j/+RHow8?=
 =?us-ascii?Q?9RKvi499D6YShpsOJooGCeTo2G/RWEMHfEX8mhLRltuyuiXSv+sRnnql777U?=
 =?us-ascii?Q?r+KuEdhRw8FzEHNB5nR37Tf2Epg6e6kprR/nH0kVLDbDfQXSs0x0rm6k0Z9I?=
 =?us-ascii?Q?FJvGPKOvu9mmN2AGIvs7/7mv+oU1VvASGfD57b8JY4xNxg8iejoycYst9leo?=
 =?us-ascii?Q?ofAzxk2/QToRyOOorAiRzOPkS/Yp0YupGp9W+uPXeAhVtNwivE77OtzyR/s9?=
 =?us-ascii?Q?J/9XZCA4L6cpIOs0BsV0Dh1VFDv1HB7YLXrLB2NF5KURjS3fQGoIndnzbm5M?=
 =?us-ascii?Q?soL5MzSzgq3IliNLe++TKQRBZDz1qIYntCfrFdB+Tn2uxYwIRBVs8B+u0IY1?=
 =?us-ascii?Q?yAXlPZ1By1YnuY+DgNDXfIW5uMVR7ptc1x0FXe6ez7110oEC24qBhFpXeWXc?=
 =?us-ascii?Q?L7LiGQpVKVvwlnTNVegRGSZVruyYCt7xC5Y09tHbX5vHx2+/UHOThw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nAx2u3tWOh2cI/ZS4x23m41SdH22bSUAuvg6ZlsP/8L0GMSzA5pdyfNSmYZW?=
 =?us-ascii?Q?w/k8j7/+OVr3X5XtNUtsNx68S1bEVzlHJ6NaJ4F0+T7PkBXJ1JvuxUHPUF0S?=
 =?us-ascii?Q?uGNSvayVAm1QsjAtQU4eFNjakyXzVXIWKZMgoLY2GS3vdNmud0n1IQkIKtuZ?=
 =?us-ascii?Q?lxdJeCbRMNfwR4EhHuBq6JuC5aQzJWjjA+osmma1LDG2TObqEWz6HvGvZxY+?=
 =?us-ascii?Q?H8gkk0jb1vJZikQJ62k4OFIKInP+AoWA6U34wYNj5r62xYyOZnMqA+iLngOH?=
 =?us-ascii?Q?vdknu46YfuRgbLtks7LHZYcRgcpYFPGwb5Wn8Wgafz2n+7Yt1R89a1nQIoPX?=
 =?us-ascii?Q?ICuFOQ3Aaq42jimWf7ELdNhznHRU+0xMt+6E3Gbpi4Uixrd510ChyDZrJ7Yl?=
 =?us-ascii?Q?/lMPw/op+M15qj5j/PjuUYgpFdcVTWTL5v3N9ox7WFI0/rFNTquP88+IIzv8?=
 =?us-ascii?Q?K8JEJXOFTuxOLUkYTwrlKC9Plwq7ODCr43zBIDZgWpqnm2AWa9i+rizuNq2G?=
 =?us-ascii?Q?6Pv/U4h29RWf7oTKaW2QaV1ayoexBMgGZ4hRWbrc6YBt7ySgyBA9pKB9bUK3?=
 =?us-ascii?Q?PzJTnP7hyMOKZ11vy3Pun8399BN3ZpdI+lBiiw5P3MOqu+BSQlDISfeh5bPB?=
 =?us-ascii?Q?ViE5CMcPerW2WeHWYwp1GCYF1CYBfyJ2sBuabV8ZziSVuI8C5aRwqtleT+Kj?=
 =?us-ascii?Q?tdkpIKBiSekTO/A+Tq6gw0Ci/iJ7gpCiqVRWlgxwZnNGC66Hh8+8Q30OD3Kb?=
 =?us-ascii?Q?zpW0EIZOtynUq2cIlEbNoEDfX2pGZryP1S/POsns5IZub9Q7z2dijj09kI1Q?=
 =?us-ascii?Q?XysXuo5E+e+RrTgioleLFwFVYq1Uir2KsWb41CbBLYKAwuzye8rkEo2x1l12?=
 =?us-ascii?Q?5yPckXd/TJlM+vVtS14D3EmKxTfdURKFc/Zsi45K00KgKLFQiXjgHSuumemS?=
 =?us-ascii?Q?SgLVpWfXd2xdxaCM9CBA6L8W6XHbLxbDHAIJTJsM2bm0HDVSu9VVx1Wy3CX+?=
 =?us-ascii?Q?H737mmnEzMlOnQWI7hUZD0fEloeWcR0eSPrpn8/R8qrZcxJ5wh+kTD6hqxbS?=
 =?us-ascii?Q?GHfjEpZHKmC10CBhgsGJzuvZdUtIdR9VveRf6czCeOAR2eGsE9jD7oCgqPG6?=
 =?us-ascii?Q?TTVLtry0cmeybwdLEPEiv6afsYC3bqT6ziFF+fp2SkdDojrhvGWlr3QCd6gh?=
 =?us-ascii?Q?vz+PcW3kAKgirUvatWy5JBxuIFJnPbCwX4Ydskft9ssw50VgZB5QGch2I2pR?=
 =?us-ascii?Q?TPtT9dJJsMdWDDC9hNnNtaSF04v2l9QURgOfzt+uYYR8WHIf3GyOFOgXnBjb?=
 =?us-ascii?Q?uuo3/ECHkUvVwY6Bi2kFV+1LEcJsmq2rZgZMefTZUVwObus0T7UaX7JlF0Mj?=
 =?us-ascii?Q?Ek88emkOPQiy7T2fUwg7y0Z5BwbpKiv2LsLfFQCo+/JFqsls8axu3LSplvve?=
 =?us-ascii?Q?Y5UxD7WstwkRwATS9XgSe+2QP//rkC+Mmbp3rJAWenku7Qy5ODUPg0PS0veB?=
 =?us-ascii?Q?Q6QhbwduHwdnff8+4Xt4itpRBAXVTcXX/g5BtK18wsVuaR5mCLEZqUDaip0e?=
 =?us-ascii?Q?tfPrgVnhDaRwljQp7Eoner5J6W+/7b/D/GyJNX/k?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfc35df-cc85-4fb4-7ab8-08dd9d1ee7d9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 13:03:42.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coK3bC6kL+wOjIR3EiVClVfPNcuyxElgFvV9e9O0K6bzRJIl56oFLO8LGJXMEETAgaLBi6+rIwm3ly35x1ZIzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6653

There is no /sys/firmware/memmap/ for non-x86/x64 platform, so E will be
empty. It will report bellow 'syntax error'. This patch will try to get
end of memory from /proc/iomem if E is empty.

Running random_offline (random soft offline test for 60 seconds)
./random_offline: line 61: /sys/firmware/memmap/*/type: No such file or directory
soft offlining pages upto
Using random seed 1748344561
(standard_in) 1: syntax error
(standard_in) 1: syntax error
...
(standard_in) 1: syntax error
(standard_in) 1: syntax error
time over
soft-poison: success 0 failed 19856 of total 19856
unpoison-failed: success 0 failed 0 of total 0
poisoned before: HardwareCorrupted:     4 kB
poisoned after: HardwareCorrupted:     4 kB
PASS: ./random_offline -t 60

Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
 cases/function/hwpoison/random_offline | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/cases/function/hwpoison/random_offline b/cases/function/hwpoison/random_offline
index 5528dfe5cddf..8c53a882bd3a 100755
--- a/cases/function/hwpoison/random_offline
+++ b/cases/function/hwpoison/random_offline
@@ -73,6 +73,16 @@ end_of_memory() {
 
 E=$(end_of_memory)
 
+# There is no /sys/firmware/memmap/ for arm platform, so E will be empty
+# If E is empty, try to get end of memory from /proc/iomem
+if [ -z "$E" ] && [ -f "/proc/iomem" ]; then
+	k=$(grep "System RAM" /proc/iomem | tail -n1 | awk -F '[- ]' '{print $2}')
+
+	k=${k/0x/}
+	k=$(echo $k | tr a-z A-Z)
+	E=$(echo "ibase=16; $k/1000" | bc)
+fi
+
 echo "soft offlining pages upto $E"
 
 unpoison() {
-- 
2.17.1


