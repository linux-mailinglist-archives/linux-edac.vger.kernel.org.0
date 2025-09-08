Return-Path: <linux-edac+bounces-4750-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A1EB493E4
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27DE20579A
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07530FF39;
	Mon,  8 Sep 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D7oMVl63"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52C30F53B;
	Mon,  8 Sep 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346067; cv=fail; b=VzEH+yHxJ5ErnaO1R8UEMQOJR/IbBMqtle+yUznjV8iECyQnHqIgn+KMC0i6LRX02Bene2V+/L4P3V1Tm7XTpbLwVcDc6ykHElTgbS+zL4yQaZ7AlN3EsnY+9gBEoiPtCdD7ytVnf6eSZvvyxovGFQonID9BpkRy1lW3zzpcLz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346067; c=relaxed/simple;
	bh=DnP5dIsCL/uUORcjgeLDvuNE2dplQ1SdqwdWBQf2kGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WeGN/V+VZridmdxSEadvoYvchwq09NJxGx3KTsuOB4vXIGfwT/cgXKxW8SENGdcTD6BNRI4DGD1KHVb50WuKV34X3KP9NHPFdrvp0OSnAcyUCQebEpAOFlKDsBiwpIhufJOFljqgCOYUjGela9OOGBuNgY8zZAkTOdmq4v7TUfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D7oMVl63; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbGwsv7p+fFKwhgAjqPPbBvQAg3lNCEjDDabWaFz00p1yc20akU1NNBeWgNCTpXS+CFPKCz3DLimsyMuoYpR1iu+sAuoyp/8CArA2++jCOzk41b/pNvUnduJdV1MoVYtV5uwNPBHJtBi44vOQqItOLBuFNcCDoLfvIK4v5kM6pNBsM0rs8GB3y5u85yQsHIy04T8+CMS2jbPEKraoRsbWTPiXT4WId9pvpvZOMfAmOaNmgP9w1udk/RsqqzGmlqIBg7Td/hZcOd0nCY0x+UtbJ4qtA6hSSzcUkHXwV88CxtOatnuaB39J2IV/wmCWLbOo9LZXIeNdsnuZxF0oPPaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1s2grU9IgV1V9Iz8liZAOvJeBb1rty6Kpt26tyv4Ik=;
 b=ugP/sldFiPtSDyDGn1ycahngCar3J95eiEFDcQH8wtFhO057zh3c3V2s+VwEDjQF9RgRt2lpmNYVbhRs1gecm124YtseCrkHQ7r1Wl3/UNU8FpbvfFWgBIeyoaxM3byVGA+oCpQEMJKdmyGXyB/CO0CeSZ5Cn0Ho0mlBtL6NmYk0u+c3MU5zs5oxinFmJGDjsH+3r8E+lsJWiW36PhwqZfi0wgZhWT96f0hJMZHeEJgeScIVUmGyMLDVLtk7SI5e+D02dbs1aJ0bwCdXHdnU2PfvzH3bVUFF5ZYA612mqW1pThTrFgHu0TYD2J6wVqKcfrrrDqQp48aYsmgUlVGIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1s2grU9IgV1V9Iz8liZAOvJeBb1rty6Kpt26tyv4Ik=;
 b=D7oMVl634oDQafjqrO6XHEME99gIrLeRZGC9vTIXUp67MxfKFenzWJQuQGkv8f2908EGL8tOWkdOdi8hsfEO+vig/z5BrVcP4kvuV4VuNMqgA4BES3JwzhwuFeP2WBiBqfa5sykT4IpIfQMBXUvjwhcXUfQY/feFdScFUTwKMvA=
Received: from CH2PR17CA0023.namprd17.prod.outlook.com (2603:10b6:610:53::33)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:41:00 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::f0) by CH2PR17CA0023.outlook.office365.com
 (2603:10b6:610:53::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:00 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:58 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:35 +0000
Subject: [PATCH v6 06/15] x86/mce: Move machine_check_poll() status checks
 to helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-6-eef5d6c74b9c@amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
In-Reply-To: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 75def10f-76da-4996-c117-08ddeeee1c8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVpuN0R3OHRnSHY4MjFXeWhQL3N6ZnJYQkNDbTNzRlJSUFIyVVk1Qnk5TzVW?=
 =?utf-8?B?b0ZWeEdNNXBQbDMvai9CR2x1L0k3a25OcDljMGxQZTNSb0x5MjRhNEJaeHZZ?=
 =?utf-8?B?dE5COEFrNGE5djBJSDBpanBBaHd0Y3RKYXhLS1diM2lYQ0UyQ0tMcEJERzdp?=
 =?utf-8?B?cVlnYkt1b1JTdXc2WG12clFBOU1QdDBIbllRTFVCOFZmbHRJK2k0VytjQjh5?=
 =?utf-8?B?ZFYzeXY5SVlpcytrWU9Wc3dhRm9IQXJ3aU1lQmtNemlFa2dQN1BsQU15SGgw?=
 =?utf-8?B?ck9HYVNMaWhaZlZQbGx2cU16aDI4cjd0V3RJOGNqQzI3c0dqU2ZTc3VpSkY2?=
 =?utf-8?B?VURLOC92Tm53Q1Rqa2luWmNXTDAyRzBLeHNWR1VNb3NYRk5QSFdmR1hmWTFx?=
 =?utf-8?B?RG02clMyeHROOSt4ajJmbWdzamZYakpRNjJ4dlpPallQVkRDaGpWeVBsZmpT?=
 =?utf-8?B?SnArMnFoZmVBT3BkQTMzZzRDNEg0UUVpMGlVd29sOUlDMnZKNURWMGluUVdU?=
 =?utf-8?B?bXFaa2p6b0VFMi91L1hUc29PYTZHbWRZQ3k4TzV1ZXB2amN1QTNBMjZjTFBD?=
 =?utf-8?B?VzdLZGR4OWEwYm1BMXN1MWtKcFVWWTZjSEw0SEdZL2RVL05RdEUvVWRtbDJy?=
 =?utf-8?B?eVJuemwyOFd2TVlKT3VhZTFPa0Zyc3V5NGpCV25hUVJVeFNocTVUWENmVzVl?=
 =?utf-8?B?S3Q1b0RUdmtVdlVOeG5PSWFFd1RCZW4zUjUvRWR6MzdtbzZJcHAxaHM5aDVP?=
 =?utf-8?B?dWs1VzNuZkJSZDhLSnRzZU5RZ09mNXp1YUwydTJZTnZJb253VUYrZGw4YVd2?=
 =?utf-8?B?K0F4OUQ4TDBsVGdLajhEbjZBd3VBSTJCcURSMFYvcE45RTlHcEJZYUZFVENX?=
 =?utf-8?B?U2l4V29vUHI4am93U0Z1ZzVZVGJnTWV3T29IRmhJSmZkeWU0V0RmMFZJZWRQ?=
 =?utf-8?B?UDZKbThXc1g1cTNueVVZRit5K3A3Qmc1Y3hPK1BIUE5wMFRWRE9lTmkxNHh2?=
 =?utf-8?B?VVFDZXNMOTVqdmp5Z3hpQnVKZjhjMXZzTzltSGhrRmRFY3hRRFNqMlZUQzQy?=
 =?utf-8?B?K0hwZStCelZqRE9mTUtUWHFTd1BBdGhqajFnbm16YnJjd3g4QXhkVnFSdFB5?=
 =?utf-8?B?U1VzVFpnTkM1bE9ZVGs0MitGL0U5d0RrWTBVQk5nMkptKzRaOHdVbmVCUDE3?=
 =?utf-8?B?MHQzeUZPejBEL2VQRVJ3U3RYM1Z2aUVvRHlDM1lCdGYrUFVSYzBYLyt2V0VS?=
 =?utf-8?B?YVR5MFd2UkJUd2hGOEp2a0lrNllOY3p5MmdZcEFPaGhIdDFWQlcxK3dnQ05T?=
 =?utf-8?B?MHROSzdpR3pTeHNsR2gvZndnVVVYVGZ4SFd1UTdXM0lBMWZ2RGc1OEZkZUpa?=
 =?utf-8?B?d3doZWdOWFZXbDVQRWdLUytKbW5CR2RYci9lN0ZxWVYxbjFhbVZJdXRKQUdP?=
 =?utf-8?B?ak8wY1prQm4xaTVvRVRNQzFSUHVyUHo4ZjFDSUNIbHdSV3UxaVlROTBTbWcz?=
 =?utf-8?B?RUxjVEpkeDBXQjlBdEd5RXlLS3hkTll5V1cyYzVSRVV4MFpFbzBoMmF0VUQ5?=
 =?utf-8?B?QVo0RXloeTRqbU9nc3ZHVE81Ky9ycTFvMzd0OGZraCtYRkRCaWF1V1VDMUc1?=
 =?utf-8?B?WENUb1JvWGRZV2FSc3JPUm5TNDhDTC9IVlZrNkd6NmN0dmNXY0ljejVBWGVZ?=
 =?utf-8?B?OEpraUYzajExMHZ4MmpVNVhIZ1lPcDByNmhwM241ZktvQ2ZVWGZoZG9raUE5?=
 =?utf-8?B?TXZESHZlbjZObFRkQkMyVlBWQ0swcjBkSjkxTXlmQXEycjB0Y0hqcXhrQkxV?=
 =?utf-8?B?MlAyZnFReDJsVkZRbFh4UlpOc09tcDJ6ZVBQbjBzOEJSNTJYSUNwWjQ3ZzRI?=
 =?utf-8?B?cXI4eUxDZUNHUXVRbVE5VzlsTGhONmRQUzBTTTljbm42N1llVnZyMndicnB5?=
 =?utf-8?B?QlB3WENydDBuRjJZVGgyaTk2ZW5POWJ2NWtha0cwY2hLU1ZObUVJOUtsMzg3?=
 =?utf-8?B?djV0RzBrMCtrMHNXMkFBUU5sUWsxYndPVHpiaW5abG9NamY3bFhZY1g4VExu?=
 =?utf-8?Q?paEzGs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:00.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75def10f-76da-4996-c117-08ddeeee1c8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

There are a number of generic and vendor-specific status checks in
machine_check_poll(). These are used to determine if an error should be
skipped.

Move these into helper functions. Future vendor-specific checks will be
added to the helpers.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-12-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Change log_poll_error() to should_log_poll_error().
    * Keep code comment.

 arch/x86/kernel/cpu/mce/core.c | 88 +++++++++++++++++++++++-------------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7fd86c8006ba..5dec0da6169e 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -714,6 +714,52 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
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
@@ -765,48 +811,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
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
2.51.0


