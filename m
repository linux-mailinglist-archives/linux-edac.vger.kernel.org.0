Return-Path: <linux-edac+bounces-4673-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4073B348EA
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7956B2074D7
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B731076C;
	Mon, 25 Aug 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rjClSTnj"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9830AAD0;
	Mon, 25 Aug 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143236; cv=fail; b=AWnavUZ9JqzoIubSrJ8hW9EuGU6WQttWjvdY8bjRZxKkUpsCLBOfZpskt8c5hfjZ8L/YHOxjLWI3inlZViaUBL+bibfYKibNShqCr6+UOFwnhP5YW7w5sgU8Vf2h0fTloIJau6Vqip7/OzejS9HBHS9VE9FnTpJP7LmhAwCXn1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143236; c=relaxed/simple;
	bh=/tm9fmLWlNZosIX0p0kUv8XJIRt6+wZPyBK/FkAp6to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lx8dYcGopPT8LBHAAy6oFnNvGa3fbMKufK/3Q0FlIkRGDyR9gzw0QSejxWnnhru9m8xzCJCUgq56H/Xtyxqjd5opLcx3MH/wB2Q/hRkBwl5CJOyhWyPfSZhQeF1fCoUz9IYt6I80bLodaTY6TYCVwdUJqVXz9U/9dbFZoDf9aOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rjClSTnj; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bVIsuvXYHssL2CvQc+qkzuzbIsQMzRhIRlTiTExbHZiO6WGJfsCV7LeTE8Ra5fbFTsPHs6nkU4baDtAA6womZ7JJGqeTjnaKyy2DROkz03IqSH4HAZ9Aresr+cdJgiuVM6tCVHPot0ePHJ6POQW9+aqN5kAniiPbAhKPEiu746GyWrPkW/XGeMZowiGKnF6oyqL4dQslIeoVyBfs1pFuXB7IBZmtU8G2qmXp/eYNXzBMdtl5/k0JYIP6C54EoVMVqD0Rs66q0vfebgyqKtxeAUUeT9jEAp7oNe+rPQR2uqmjVpx8tmlzuco5DjKIC3+KH/IHl54TOKwZWTi7OqzB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyQ25cKn5JeQPpWBZbHflPZ1cEtWF9lEUW2RWd63CXU=;
 b=guZA0C4luLqAVFj880luea6jfRqt7jFDdCo82pf1kAxuj0NFR7LDWf99NeHaMEe5BoLjV1OLnHZvyGLlYUBGLGSGQmdfPdRruc8UQz1krq0G/ad5r4TOBHEHXipKNUqvT4VzivR0BWX33G0j9xGL1aMCZdo6L7gbsdaBjpL8IXdN27tXsCu5h7qp8vjMmIvCffFEb/4I4IUqrgME4H0lohC5kZI9xGi/XmVd5dUjNGzlcvWALvf8EpZoACECzaDKFgTsqiMNtjHpOEYt/G71qVCuHrvt4XOBt/gMZ7NL0wFQRZ6TGnXQymQD/gdCsms5JoRitYcBD1GoSAv4RmrYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyQ25cKn5JeQPpWBZbHflPZ1cEtWF9lEUW2RWd63CXU=;
 b=rjClSTnj2+jnNSa1VJ1jEKJu55owQTmWWBb9ueR3mNm3tvDuBNSU3HS2j9DPM9F3JQlp0fcf6Dnm/ndPfOWxT1rpxlfFFVaeLHm5gN+yrprbvEOhyJKqr0zYiKjQCZNa+/8//YRsMoKeGM5qvTJQy5Q0/LGuN1twomPL/tGQ/Bs=
Received: from SN7PR04CA0033.namprd04.prod.outlook.com (2603:10b6:806:120::8)
 by DS7PR12MB6167.namprd12.prod.outlook.com (2603:10b6:8:98::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Mon, 25 Aug
 2025 17:33:47 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::ef) by SN7PR04CA0033.outlook.office365.com
 (2603:10b6:806:120::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 17:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:46 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:42 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:09 +0000
Subject: [PATCH v5 12/20] x86/mce: Move machine_check_poll() status checks
 to helper functions
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-12-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
In-Reply-To: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS7PR12MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 081222c1-4bda-444c-2229-08dde3fd8bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2FZdk1YSXkrV0dPK2lRNitKVTRFSjNSTnRSSEd4ZlNxZHpLRTE4VGh4WSty?=
 =?utf-8?B?V1VxLy84RWE4cGh5czZVRFcrWmRrSTROeEhqTE4vMS9jK1BNeGR0eHhmcTNr?=
 =?utf-8?B?YzI0S2diREZyYW8xQTB6dmdKRk1wK3NxaG5CblRQdDFDd2NZMHlTTklLS0Nu?=
 =?utf-8?B?OFVMaGdQeG1lMndyZDNqbHlBTXNIOWRNVTlueUY2UW5abFNaMTV2OEVWWFF6?=
 =?utf-8?B?R0Z1VzZTc0VzY0VYTXpuM2ZxN0k1cFdIZEVNUUo1Y3pOUjlyazlzZjBFbUpu?=
 =?utf-8?B?UkhIenBLeEJlbGdReTY1NXNaTmltSWFBalUrUGtXVWhTcFVqcDA5azg5Wk5n?=
 =?utf-8?B?ai9WeVBpMExLNGtEVXM0clBqMnJkeUZHeUxqT2tRVUxVNGRqclFSU09Gdkd6?=
 =?utf-8?B?SlRrdXJVU0hMK1NUVThzUW9UekRoRHk2RVRRLzlnV29NeHdWTW5OYzFkek9S?=
 =?utf-8?B?RkhadU5VYUhLeEtaQTRnQzVMUUdZY2J4Rmx2MFRjT0VIalRMUnF3cVhSUUxx?=
 =?utf-8?B?dTVKK0NmREszaVhzUVV4L09WSHJJajZqWTQxc3IxMmpDZGgzYU4wTnBSUVJ0?=
 =?utf-8?B?bTB2Si9GVlNtOFBhY1Z0eWF2aU1GODg0UHgxWWNNQjdxVzVTNWFSUUtMcTFn?=
 =?utf-8?B?MzZNVEpNSVc2TG9LbUs1SGpRejJiOThvc3dFTjl3LzNpSWVnRDZnL2Q5VHNY?=
 =?utf-8?B?ZjFlanNzekpPd0ttSEdJR0UxVjVNNzlidHFIaURKbXdFMjU0OXhVVitXQUov?=
 =?utf-8?B?QlBTWlUzNnA3R2lNMVJ6cFAwTElLbjZsaEdsSUVWbzBoem95elh0TEpFVlhL?=
 =?utf-8?B?TXpCQ2ZhSHI2TmYvUHhXck5PODUzRnZtQmE4Sk5xUUlaOTJJcms5WFJEUmhI?=
 =?utf-8?B?L1oyb1FkRjNaOTZkLytHWHBQMStFamdzMmJQWlVaUUtjNm00US9IRklhZC9O?=
 =?utf-8?B?VmhoeGJtM2d2YUc1RzFkamN6b3VxMjdKanJ0Wjh2b3NNd3R6amIyWFNmWXAz?=
 =?utf-8?B?NTJtdERoSE1JaWtQTExic2FiZlFwbFlleFpXc21DOUk0d2dZbXIrV1YzVkV1?=
 =?utf-8?B?NzFIbWQ3RUtHb0I1ZCsveWJaNHhJell0MUY2cWVFYTR0NjUyVVZoY3FLNkJn?=
 =?utf-8?B?R1pVa1lCc0pnK0lrVWw0eVByR29nSmNTVjZXczNoaVpQbURucE9UUDlBSldH?=
 =?utf-8?B?a25BMnZSTjBzOU54Y2dYOWhhQTJTdnIrdmFGeGRLZ2VDVlRZWFQxNk5xQmRJ?=
 =?utf-8?B?djFKdlpvdWxpQjhUUk9Ob3VEeGNrNWw4UnJ0eTZSY09VOVB2RE5UZXpFM29E?=
 =?utf-8?B?bWhFdFRyeG1FNG1zMlI0VmhYWDRCK1AvNHptQ0FHUGVpSDEzMTY5dFpDTVFT?=
 =?utf-8?B?eHhVeFh2VGtIMGNRWTY2dURlb3FCaGQveElLODJWZUVUOGx4SFFZMzNwMkRJ?=
 =?utf-8?B?bHdoNlNTdG1uN2xQSW9mUnFoTS9CZmxEMHNORTZPL05VNm5IdHNNek9kVjBI?=
 =?utf-8?B?WVVnMzNPemxOWmwyTHdZaW84SThBSmxEVzQzdExqYkM3Q2lyMXhIZUk3RmZR?=
 =?utf-8?B?ekI3Vjh0eWJ1Z05VblNsQ2gyaU14V3pLbktmWFJjRVJ6K1VRbnpjYmxSVDVi?=
 =?utf-8?B?ek1UZUpqakJGc3I1Wk1lWWZrTlhyUzREK0hyZTBWblFISnZ6dkVISWl6Zmlh?=
 =?utf-8?B?eWZTa2hrT1paOTRkYUZGZTZySEhIY0hUcUhFWTF1UVlIWnlaWGpCVmxJa3FB?=
 =?utf-8?B?ZlF6ai9xWFFnRGFwUG8xWEtrYm1mU3c5eGxUV2owNHg4ZHZsYWZnS2VPK1pT?=
 =?utf-8?B?TTlRbVJRaDlQaWp5bUEwTFdzWFlNNmQ0aDlZcnFqajFxblNtdkpYRXQ1cXhZ?=
 =?utf-8?B?Rk85RmdtZ0FmaG9kTklKcEY3Lzd4b0taWWQweU91VUhIclluemI1MzhFWXpQ?=
 =?utf-8?B?QUxDeis2WU5sNXVNZU1xZmdGUFhFVnByV25qTTFEaXZuRFRRWWR1U2xXb3Zp?=
 =?utf-8?B?em9xQzA4VUJodWU2S0dWUlExRk9sOWdCcllScm1TejA5b3ltV2JHUXRIc2ZH?=
 =?utf-8?Q?mNutv9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:46.6414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081222c1-4bda-444c-2229-08dde3fd8bbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6167

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
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-15-236dd74f645f@amd.com
    
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
index 21a5ea239e93..b3593a370bc9 100644
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


