Return-Path: <linux-edac+bounces-3065-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5828DA34A97
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0698C7A630A
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930F9242929;
	Thu, 13 Feb 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ud/VwPhc"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48824167A;
	Thu, 13 Feb 2025 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465197; cv=fail; b=NPccm1NsblQdLBi/9QxSIPZ+0KPraRkiyiLs7zsQ6/dV4aAXBbRAsYRt6gUNi6GTJMq2H9ZqAdcHa20Ftdo3GhyKpaQndcFVUTBgjPpOQ81oB1/FCCy987G3GY45y41WkmiJVoOkTXaDXLkMwr8sVy46irbuWsn6w+W2kzC5wMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465197; c=relaxed/simple;
	bh=JbP71n3S9Shqg2TJB+J7jyPMEuxwUnk3AvjCZ/vZc4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=crBF283Duqqh0ZqNI2HpNSgJSQRmQmxdmDmv+H0C+f+joOCup1WdYOieNitH0okbj+rFVf0j9GBYQ4d7zS4kJGUhM1NpRdiqE9qXR0wV0AE1heJDzinEo6TojeBP90VbNbSSjMdyaPjlsyHuNFNFjhSAK2xhJ5cNZdqbrNbRcYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ud/VwPhc; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUj+Nd+M/vP5CeCW3US+n8cf06VR+1SjDF8hI2+ixB6+dgqVrFyOMK3JnlrZuEn1fDKjrcYhB6OFu+rvI3ozsbqtpsAmVa5bvCofgzASFNGPv268/jotQl5HvgJ4E/Jq1yip6M97X7CIHxjZbcRzOoBKzP1WbVHEjfwnVdlG7NZRDOgwWxxlxYitvqIgdTPcfe6CotDbGY+OLRYw7TfdOVyJES9xG0DZj+bMRYb2dqlMK8xPEbkIwMzVeUmio0UxlrFVcIHgwg4CB7jDTUPTX2FhPnRg5M+irYy/fqygJVBMpWwPewNGEXTJL6EQlZvOyVMriyzjCYdqQNKdXszQlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My3mE0qKd1QNNNmBGBLGtywRlzLm+Yx6cSd2tHQUta8=;
 b=NU/F3uVCmX33/GBjY7LNOs6qsMXRdAaHyXh+GM04JaAPt4G6Tp4KYl0F2Z0Qh4QyWicHSuWPkEM5YCFOA9/q1Ys82w22DOTQ7R6kb+SMMMCa/gZJY3aeIAj99l/Zt5iqqUypi0NI+w6wV6Wc2LTCq8MTPOGqiO/ADvTymGWMaj6A88Td/wie49WfKjx7jF8HKRdqdk6FgVfP2PHapdGpOsz7Mqxg+sFHqVNU9JtUiQ2PHbWA3AYxu34m9i4LkzPk8xO1LHW9ixoFv9DpAZIX7yI+qmRLrhaj4MA34+AJZZxjgErM+zJ7t284oUV2jhFJFTepYlhnm79BtCPILje0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My3mE0qKd1QNNNmBGBLGtywRlzLm+Yx6cSd2tHQUta8=;
 b=Ud/VwPhcW1cnrWF5nYD7Hl9bZZ77FpC4jUOpKybLq1ssE4pi38SvTPhP1nNGivcTGbPckbmdWaqOH0Ez2TTZ4uezLsEZ76j4Bu0TtJHnja51Wd6AekZ3s4PvBeAT+m8QOf9OJn2EFiEi7hDroqtcF1AM95dLahmENI+W0Tls1XA=
Received: from DM6PR11CA0011.namprd11.prod.outlook.com (2603:10b6:5:190::24)
 by BY5PR12MB4116.namprd12.prod.outlook.com (2603:10b6:a03:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 16:46:33 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::cb) by DM6PR11CA0011.outlook.office365.com
 (2603:10b6:5:190::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:32 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:29 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:46:00 +0000
Subject: [PATCH v2 11/16] x86/mce: Move machine_check_poll() status checks
 to helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-11-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|BY5PR12MB4116:EE_
X-MS-Office365-Filtering-Correlation-Id: fc2bc03e-2809-4655-f8d3-08dd4c4df8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEJKMGNRbktzSGtZdVhMUER6bFVYQVJtRXN2Ly9sQWZ0emlnL3pXWnhyaThY?=
 =?utf-8?B?QzVUZUhKeVpMUDJseHFMNXRsYW5IN0tLWWQ3b3FuQXM1UVdmUFBjQ1hTQnlI?=
 =?utf-8?B?NUQ2Y2FlRkdHTDdBbE5WUzFrRWpuUU1MM2FmVVdSUXlDeWl1N0tFMkc3VjBO?=
 =?utf-8?B?VSt5WjdoamJPRkhNQWFNVE9lSm5CZE40cnRMN1dPVmNRSnV4WWxLUGhjdnBn?=
 =?utf-8?B?cllqcVpjQmpvaWwzTzIxRldCeGpRR2ZxSmlyQWtMVlFHNmRZM1cvR1ZwQm16?=
 =?utf-8?B?NFdlU21KdUR2YTVRTHZJcjcxQlhnem9sVldPMnl5OFRrOU4waXhvOXM0RUMr?=
 =?utf-8?B?dkdyTU80dUx1TkRQYUU0blQxbFhtcGUrTkZ4amFtQlZLZkQxU2JqZUM5cThz?=
 =?utf-8?B?ZDl0VDRiL1hneUduZXpVRTJFaUtEUit3dVVWTWZmR3U4akNWMStOTldtSzla?=
 =?utf-8?B?SVZlRndSYlVETnhWWkJRU1NnRy9TU1ZvL1dEOWh0eDZIRWo1Nk5WckRFc1Vz?=
 =?utf-8?B?Z2orTXk5T1l1Vi9wTUhRUEVINnhMU3lGRWVGSEhUMlY2R0VubHNxRHMxN2Qv?=
 =?utf-8?B?OTd4VjF0S2YwUCt3RytyeUU5bUVmYTZ3UjJraS9rbWhlR3JnY2hMeGVPZXgw?=
 =?utf-8?B?L0tRQWt3R1YzdXhWVU1DeFNUd1J2RUluek91MHlBeGNjeVZJWTZRYmdPRG1h?=
 =?utf-8?B?RmZIeFNhYkhoWVExQWhKRmVNTTh2ZHhMdUVubTk1LzJFL3BITUpwaytqSlp2?=
 =?utf-8?B?UjdmN3RLL1NrOEF1bENlYzlTc1RpWHJOdlg5TGJPNmlsTW92RGltVHU1MGdE?=
 =?utf-8?B?NUJ4SmhYQjNqbS9EUXlYc3N5OHpxRDQwVzJOT2N0K0MreFYzUlRIMW54citR?=
 =?utf-8?B?UUg4NUlBcDU4YVBDZG5LNDhUQzF6ekdtcG9Nc2JtU0wxdUx5OFlWQmxhQ0RN?=
 =?utf-8?B?aUVyaTF2a2lBK2Z6TWZtR3hYck9JdVFHaVFSd0FvKzUxcnRtWVRyZXJxVEpo?=
 =?utf-8?B?SVdDalRYMjd5V0JXMjN1b0czZnEvK2g5bkNGdW1sUXEwenJreDd3dVg4cGVG?=
 =?utf-8?B?Z1kxSmVjb1dDUnN2K3JzcTFVNC9QajY1ZmYrTDViajlQWElqSmU1VW8wam95?=
 =?utf-8?B?SmFxSlZPbVA2Zk5LRDhneGlEdXRyTFh0R0pPTlppUWM1TDQrWG56MWNCcU1a?=
 =?utf-8?B?NmZtek03ZEdXOFd6dHdoSnJPbzZzaC9ISFBUa2hLL1VnZTlhblBTZ3FWcEgv?=
 =?utf-8?B?VkljUmkwcnRvQkkvZ1FJSTFnaThSMWtKZHBEWVZqNXFlZkx1c09JaE0xZ2ZL?=
 =?utf-8?B?VFdzMWxDQUc4QXV5TjJ6T01XeHlvNXBDQVZhbEJUenR3TEFtd28zNkpHd1Ny?=
 =?utf-8?B?dTlFSktLSVhKbmVZMmtnc0Z3cHJsbjRrSWdjYVk1OUR3MHNBbUI4MjFiVVlu?=
 =?utf-8?B?cFVUNHJ5dDZ1RGZoa2dBRjk5RExaTm1oVGJoTFBUbW9sb1NXVDQxZzhFYTRQ?=
 =?utf-8?B?elJYZ0c3dkZRc2RUellkb1B5V1g3cWJuckt1bVhkME10LzkwS1dKTjNzVG5X?=
 =?utf-8?B?czF3KzQ2M1czaWFqZ3M3S2pQei9NZnFUdEJURjBvVGs4eVFicEU2V1J3ZE0y?=
 =?utf-8?B?REFBUitodWFxKzZEaFJwZkdqM1FzV01uNGo1L3ZEZXoralRuSFN4aGdMdmht?=
 =?utf-8?B?TlZ2c05Bd2FQNUprUjQrMk4rVVA5UHkvQmhqRGxSelZZVFNEa1BEdHU3WnJF?=
 =?utf-8?B?NXVDQXpiY2NDb2pSN2kzOG1IVkorK05mOUJSNmFlaWR6d3BJUlIrNjR5ajV3?=
 =?utf-8?B?Rkx2THloQkE4N3pJUXNyaUN0MG1Wanh4ZUpYU0gzRzM0b3pGQWRHWERRanZO?=
 =?utf-8?B?MVRuNGhPYkVHc1puaWd6anE2SEdQWU1BYVhTYVpKQUs3Z3ZkVGg4RHVmYmMz?=
 =?utf-8?B?aEFXblpHeHJ0RXFBQktZb1RGeHRwS1kwUFBxTTZnSGJNK1QrRlI0ZzBMMW9z?=
 =?utf-8?Q?I83GwIbLGetkJ0raNCWBSqovjJwh5A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:32.6536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc2bc03e-2809-4655-f8d3-08dd4c4df8df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4116

There are a number of generic and vendor-specific status checks in
machine_check_poll(). These are used to determine if an error should be
skipped.

Move these into helper functions. Future vendor-specific checks will be
added to the helpers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20240523155641.2805411-5-yazen.ghannam@amd.com
    
    v1->v2:
    * Change log_poll_error() to should_log_poll_error().
    * Keep code comment.

 arch/x86/kernel/cpu/mce/core.c | 88 +++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1ea52f6259a4..372e8b078dd5 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -692,6 +692,52 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * Newer Intel systems that support software error
+ * recovery need to make additional checks. Other
+ * CPUs should skip over uncorrected errors, but log
+ * everything else.
+ */
+static bool ser_should_log_poll_error(struct mce *m)
+{
+	/* Log "not enabled" (speculative) errors */
+	if (!(m->status & MCI_STATUS_EN))
+		return true;
+
+	/*
+	 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+	 * UC == 1 && PCC == 0 && S == 0
+	 */
+	if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
+		return true;
+
+	return false;
+}
+
+static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/* If this entry is not valid, ignore it. */
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	/*
+	 * If we are logging everything (at CPU online) or this
+	 * is a corrected error, then we must log it.
+	 */
+	if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
+		return true;
+
+	if (mca_cfg.ser)
+		return ser_should_log_poll_error(m);
+
+	if (m->status & MCI_STATUS_UC)
+		return false;
+
+	return true;
+}
+
 /*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
@@ -743,48 +789,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(m);
 
-		/* If this entry is not valid, ignore it */
-		if (!(m->status & MCI_STATUS_VAL))
+		/* Verify that the error should be logged based on hardware conditions. */
+		if (!should_log_poll_error(flags, &err))
 			continue;
 
-		/*
-		 * If we are logging everything (at CPU online) or this
-		 * is a corrected error, then we must log it.
-		 */
-		if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
-			goto log_it;
-
-		/*
-		 * Newer Intel systems that support software error
-		 * recovery need to make additional checks. Other
-		 * CPUs should skip over uncorrected errors, but log
-		 * everything else.
-		 */
-		if (!mca_cfg.ser) {
-			if (m->status & MCI_STATUS_UC)
-				continue;
-			goto log_it;
-		}
-
-		/* Log "not enabled" (speculative) errors */
-		if (!(m->status & MCI_STATUS_EN))
-			goto log_it;
-
-		/*
-		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
-		 * UC == 1 && PCC == 0 && S == 0
-		 */
-		if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
-			goto log_it;
-
-		/*
-		 * Skip anything else. Presumption is that our read of this
-		 * bank is racing with a machine check. Leave the log alone
-		 * for do_machine_check() to deal with it.
-		 */
-		continue;
-
-log_it:
 		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*

-- 
2.43.0


