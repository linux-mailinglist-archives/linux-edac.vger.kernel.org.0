Return-Path: <linux-edac+bounces-4009-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7855AC610B
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 07:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3B81BC1C10
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 05:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16821F417B;
	Wed, 28 May 2025 05:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="VwmKNvhM"
X-Original-To: linux-edac@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022084.outbound.protection.outlook.com [40.107.75.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A7F1E5215
	for <linux-edac@vger.kernel.org>; Wed, 28 May 2025 05:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408728; cv=fail; b=M2eY9kgHkFDfyXDzyg2byHALU/PA23GM4FXL3T2U8ey4HrgwYkFZ1CFjqi/8cOdHVX7wmnZFhfHNPWPBqg3X13T59GSxpYtioo2WNrrpbFWBd2TV4ier6KcpKi383uIQHt8lDkleAWb1zb/SKoyXzJVyznkJyOshoRPfupKZcFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408728; c=relaxed/simple;
	bh=FFuJ7Gq0EjDnyjJWmAjUZWpazVD1bhtDCvLl3qWc2aI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WHrIzKi8qqz2W36kLa6VPaSVY0l7SK40pJjNR5pdiCofX1o3vkNC37ZU/Vu0gjCgMHC8GbfCbb2YaLQHPws2FF8PsC8bCEgH/OMS5OeEayKDIa4lp1vP9FlV4ZtPVzPE055UcqZYlTkVxR8g2USO6raHn9Vp4UTNWCyUMxFgYh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=VwmKNvhM; arc=fail smtp.client-ip=40.107.75.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PROv4tv875zvlSba4Q96lxZukUzKOKcoTJgITHR1JsmCk2N8zJLHgDhbonVm0WAEk9spgM8Ll7n0a34xNW1rgEY0ktcFXUvxPJwmS3iX/GfmEPTxy6tX/xDEAgWVZDe24b9XW/4pJ7KzYA+zSa+j5VOInUIgVyDTkMuMtLJeWbX7sCJSi1oHsWvTRtmYawPQm8Ldb0OOZ940nYhmyqBnjjaKYmBC4bBLKgCXnxS0vesxaV5pXFeFR7L+wjZByqywHYhO+w9O9DvPQtmCG0pSY043ECL5kb3fCvaJzVyc86W8N/J50FZQxKZfn3NT5gjUk0o+9vdT/HxtAYgf8oFPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KVOdjeBbaS3PcT6PmmN+QiPAb+BabEEF0lqtDKsuvE=;
 b=De6FJCdSRDQbJAyhYLi4A/3mnmHfGCT9CNFmr4XX8ey7ZseSOmwoW5zdPottHi41LItkXIf0HZkXuSN5u6441kI0l1SbRie3Nut8V9NL3lObSS9fVAmxiE6S+gTl3IwF+ypMDwjYRW+ETyUOBdxUsH1HcRzijMmX8IdiQJUn/C61LGBp0NQVl1dR034OMWJuFQsbsa8nkSSnUcPBDPjzYGRlPlMTfvCM1oSHa83aKbf51xxyXlzQwhFX1cV8mOexe0Quzn1BdRKjEoWm+vT7MMD76eff5xIkEe1mMHg8T7H7R9762zr4Dgz7ByYVDDDmLrmt5lMVvCDIanyK/UVDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KVOdjeBbaS3PcT6PmmN+QiPAb+BabEEF0lqtDKsuvE=;
 b=VwmKNvhMhhML04ZBxMiuBPG7ehp3jZ/DjbdlXxzAiY1Llst1+LMV8XPIkdO6dLb866G8dlU6gdfn0QshVjL3q3aWpwoq5IojceD6Z4L5wHdnJV8C90naTs5pfRS6sYLoxh69tF5Ye9BViAaGDy01NvI3WiachWW6rrAxRHYx4AZhghr1V1sR4t+0uDbdXGbfGdEE+UZOjiL4vg1zR+vs+c1NLmPb9X+iLjbBIXqLuQcMs4ilrJ12KF0THQX8zwXYlDUctjFQ70/GslBLOEApearxFv4f6aOGYBBBfrdTIifF6VuR78aGt4J16IN96QF+WpkWlOTEvcQZ+KhFasx/IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by SEZPR06MB5479.apcprd06.prod.outlook.com
 (2603:1096:101:a2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Wed, 28 May
 2025 05:05:16 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 05:05:15 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: linux-edac@vger.kernel.org,
	ak@linux.intel.com,
	tony.luck@intel.com
Cc: angus.chen@jaguarmicro.com,
	hunter.he@jaguarmicro.com,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2: mce-test] random_offline: Fix 'syntax error' test failure on AArch64
Date: Wed, 28 May 2025 13:03:46 +0800
Message-Id: <20250528050345.380-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::19) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|SEZPR06MB5479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eca8047-59f0-4732-2b76-08dd9da53bd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8yz+25uJY5GAYJGjka+o4oDiGlKtbUdwcexPwgAuNs/cL6CRMcXWI3HcJlA?=
 =?us-ascii?Q?5zSq6c9qM9y2LxS5BWe55HPtQA2CQpso7Id2g3/EQoufsRuxzPqSMBTrhs1F?=
 =?us-ascii?Q?o1XusV/fwFevTZhVpuUTPneChNCnwkdnmsbwbBDbgHLW4kjBGiTml0yvUthX?=
 =?us-ascii?Q?i9mCvPclE3O51TFYKTNS0rY8idpq0IhQdMABsmY6XOAlkW8Zl162S49KCU85?=
 =?us-ascii?Q?M764bPDsDnmoD9wPu1C1LbpIsG/6EbhVQkDQoKgn0wv6xZMzjzTupos2Sbbz?=
 =?us-ascii?Q?d/iAfZ4R45ejCpEBdcXIBXLpTJZ4BxPk/i+E/it0hKGwL6w1W685xkLw9zxm?=
 =?us-ascii?Q?p/u9Fjs+d/Tb1CoZmCUe8I/aWZxFDk4po4L7fQY8ssq+jBgW8JaUrE076vZ3?=
 =?us-ascii?Q?hGu0uJG5cAUgV5WUVDMAEJb0RliOZUeA2F6SSGXNuw0rSanvcMMZyKa+YUej?=
 =?us-ascii?Q?MAlLcLAY3SfU7tlldjJZpsIYMWINH+ZUSwIRIeYt7DkUddqH639Hh0zImZId?=
 =?us-ascii?Q?4eFG3Z0StVZlEgWroLUnKvPybEP4Zb7AsGGzA6Kc4SBMdUCBhu06r5xsY8/L?=
 =?us-ascii?Q?XEz594GguPi7sMcJUk0QEEaplq365Hu+2mS4XAdl2A1y2/wvS+QFDyaip3z4?=
 =?us-ascii?Q?xgGtsLHjoHDopf7qe2rPa5M/n1zCYTr/DqL+zp5NzwEVjHMymrD5/5IqWjyy?=
 =?us-ascii?Q?B0E2Ry+Y/6nhfqn0T7bllMNb77AHR+PIgzTlSVkZZg4Z/n1ARrcnbBUI2vEB?=
 =?us-ascii?Q?JHnAzRSCUIqg9vuC06rJHvPXVezrad1t51AsqoUeJxDS4pBRwHjd+NQjomNd?=
 =?us-ascii?Q?sqVN9eWaKV+p1/7h7c+62euGHF2ctDL0XXtYz8LVmGOuJO6uJ0lj1yibZGuV?=
 =?us-ascii?Q?fqySBLbHn1tojxlKFhbd74xoILC3a56FiNUjlrAR5EvAzLIXy0NsVlJJ2xrl?=
 =?us-ascii?Q?qpzFDCKMAM9aemYkC9MA+J9qC7cDG4kOFoGjWvAD23gO6TtYemLfJQnpT225?=
 =?us-ascii?Q?H0i0tTW1VkTPJkjW0n57wApTzz9SABgVKDlY7/uf9CEklrn7jhyzPl0+FiZ1?=
 =?us-ascii?Q?NbIxkTacWRI4Kpz5i3fzuBiKx2kO8srcWV24UcVoUO75zY2Pp1l09Z87FEuo?=
 =?us-ascii?Q?ZdK2tR9Vscvium6XetCfDB6uVWcIbNaT03QPldmTumX2bph6UvMYXBaBOdTB?=
 =?us-ascii?Q?cb3PW1XI0rGW6MCCM10IMYuSdtg01aHtvQtYSSDROHh0pJrdMJCJnwhF0ErT?=
 =?us-ascii?Q?PRXeHwVsfaLpBJLLAnsxyumpz64bPGh03KVYVOL6Y5G6GUUphBys0UBDBO2F?=
 =?us-ascii?Q?gqwE7qXRXzKWarXepUm2vl1wgp25DAqOtAKGS3kt0cLSu6pDnQCoEi3An4UO?=
 =?us-ascii?Q?wyJEuAQkrqmDjla5lb4jlTxAYjk+ATNTIbBV/vQ6yRffZDLh1bAxKKj8CGft?=
 =?us-ascii?Q?tAiOL4vCwYGqPUXRVzxNRVd8xFqhCRSTgxu4UvlEwVj7gnE+9GWtxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gJ1R40sj2fOzRPIjv5GV9D8vI34JDBVyfnOyg+4DyynYFtxhN9By+actVjKg?=
 =?us-ascii?Q?xqhhWRTQEhwM0OflumALCdHEDV47qhyLC8KZzUjCNuJFuyCqMwppYm4Vrt8e?=
 =?us-ascii?Q?KbG9VOfwnFJekMtaljSzs5TDDlcBfZtERx8f2PyCJKviX+eYgSh0C1uB3uiN?=
 =?us-ascii?Q?VTqwX3AohWYkpNpRpBkdVUXniIkit7+ankZGV6HyzS6f0nDrNPkOFVP0zJVu?=
 =?us-ascii?Q?uq8y7vBICVpPE1hIZyd83m+37RmUmM1AO8NeG4RNYJTZGtOXRD4Yq9AAZBl0?=
 =?us-ascii?Q?ckvPoTdLehLSt7kjsn8MHag5Wc5tXSojo+oD1CCasuhNgbQRjsK047x5CKuD?=
 =?us-ascii?Q?8jmPBJ7fF4wlazsObQ2TItQI2IqC97rXfIBeojAo0S0tCInL9Zhaa6tv+4Qs?=
 =?us-ascii?Q?7qF8MKDI01H/eYivVn2hmPxrrmvtRSoWfFObLOcH1lxkJepLqcLu1DmqHeyR?=
 =?us-ascii?Q?GOuEDUTgMjQL6n4tiwIoIuF7LxMYwiNcxzieQONaTr0QAO4Cs/tHF0/ty0P/?=
 =?us-ascii?Q?w/+GKDWHUJ2kHujvhQz3xkh+XCUmuVUD21XIMz0famtKQ2cTmHqyzFpmhSXI?=
 =?us-ascii?Q?27i4xTS28aGBBSB7oTzpFAXE0GULdDHanIAt5W3UzvHZ6hgx9rBcQW8Gh2y2?=
 =?us-ascii?Q?B66yf+hDvoNH+pQMPv+u4wxpLkYB4NySmrAF5t+TzkAHPZdWnl93v7okK7xn?=
 =?us-ascii?Q?rn/r8LS3NQVPOSSDCKnFBWGPvlC3S2KZXAJQsQJg6WbnY8waxNeHTl2p/4U9?=
 =?us-ascii?Q?XHmIK/iy0gSlaSGBEPVSWG/d7IYLmOJv8X2vYSf1poQUqt3AgVkKiOup8pQT?=
 =?us-ascii?Q?hRJ4pbj/aN8g6NA4YFGadJ3ho1Qb4pf2SDZvuXASHUXebxpvfkjkwC8Ohw0C?=
 =?us-ascii?Q?N9sLUTMwuRfAkrPikyx751snpQqf9KzbYbH4YYZG+UTxYPb7EXJ3+08C786k?=
 =?us-ascii?Q?m7gNEsijIHGAeRbTQtvRLASKFUesWHGEn3JNnHIsZxM+QwbKJnRZ/TrAlOYf?=
 =?us-ascii?Q?t6+IjDhCpWP3rzlzF3M/RL9+x33s6JLodeJcTMSXvYRiyjyM7mybCMZouVoK?=
 =?us-ascii?Q?zDeZtL0IK6ebGpqw7REF4ex4IfXZ+ruQpYKM0fZOPqGjtqdDa7nCrlCsM8PX?=
 =?us-ascii?Q?PU01HEYItiB1A2UpPMuZ+iwMZj/Ah9UFBvDFrq7uCbkxkPwJO3u/NF4RB91v?=
 =?us-ascii?Q?XtPxUZLwpcafHhtpjd1a9u9bcBrKbmWxTEKkbNJbxPk4BzLlKvsCAMg0JAmg?=
 =?us-ascii?Q?ffmDadY4k+2gqankHkBS8SQum7Qcw1TKvzNL1zq+M8uk3FuYVALiObnUEsfo?=
 =?us-ascii?Q?KfdoAbrtWplVmJHsuEASt8CGDjRoHTUJ9hwss2s4ZZTNquQQD1ENQ8pJxIRF?=
 =?us-ascii?Q?ugjkUMrWm2aCIj0UBxqon5lMeIaVvzCsZzoa0BOnrrLRlPGHcyQefGwZ6/q/?=
 =?us-ascii?Q?cXfcNCwzB5o9JzyRdLXAXxwpviqQWK1xrOmVtpj1BylruzIeX7RGSZc9eCbc?=
 =?us-ascii?Q?tjiQD7XXIPQjo8Q2ZJOFyyzUIRNgafejouBhq/FmlQkz2McoLZE2BKNIG3YN?=
 =?us-ascii?Q?Ohkgj58WcOS8sQ3fQ5I4sZLBPT/7d/CTwX6koh44?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eca8047-59f0-4732-2b76-08dd9da53bd5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 05:05:15.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x1jvSJXJvzWTk6Ao0VMngnxsp7bSksWw5FvioUtJp2bKOwvHo99hVNvpLQYB8nbPRK9X5s5pPAkFYanA5yQYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5479

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
 cases/function/hwpoison/random_offline | 33 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/cases/function/hwpoison/random_offline b/cases/function/hwpoison/random_offline
index 5528dfe5cddf..4ed8e3fa86dc 100755
--- a/cases/function/hwpoison/random_offline
+++ b/cases/function/hwpoison/random_offline
@@ -57,18 +57,27 @@ fi
 [ ! -w $DEBUG/hwpoison/unpoison-pfn ] && fail "no unpoison support in kernel"
 
 end_of_memory() {
-	for i in /sys/firmware/memmap/* ; do
-		case "$(< $i/type)" in
-		"System RAM") ;;
-		*) continue ;;
-		esac
-
-		k=$(< $i/end)
-		k=${k/0x/}
-		k=$(echo $k | tr a-z A-Z)
-
-		echo "ibase=16; $k/1000" | bc
-	done | sort -n | tail -n1
+        if [ -d /sys/firmware/memmap/ ] ; then
+                for i in /sys/firmware/memmap/* ; do
+                        case "$(< $i/type)" in
+                        "System RAM") ;;
+                        *) continue ;;
+                        esac
+
+                        k=$(< $i/end)
+                        k=${k/0x/}
+                        k=$(echo $k | tr a-z A-Z)
+
+                        echo "ibase=16; $k/1000" | bc
+                done | sort -n | tail -n1
+        else
+                # fallback to /proc/iomem for platform that do not have /sys/firmware/memmap/
+                k=$(grep "System RAM" /proc/iomem | tail -n1 | awk -F '[- ]' '{print $2}')
+
+                k=${k/0x/}
+                k=$(echo $k | tr a-z A-Z)
+                echo "ibase=16; $k/1000" | bc
+        fi
 }
 
 E=$(end_of_memory)
-- 
2.17.1


