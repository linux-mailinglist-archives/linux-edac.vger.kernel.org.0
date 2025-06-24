Return-Path: <linux-edac+bounces-4216-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088BEAE6851
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8B8161F97
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671962D6609;
	Tue, 24 Jun 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pl7u9KtF"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5032D5C6D;
	Tue, 24 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774592; cv=fail; b=fq+VNK/bwRe4bpMN1xVNdf2DdfypgWiNXg5Ow30F0TF1lmCKrYTVzZRKMehMl+I8lhjqT073EeyiFJI+Z4wiXLgGlk6QznzZHupZ3OfoYKZsmY23A36B2s+SRCH0iY5sLEYyjtfEeGs79rJBk/ECzFcLQsRCTnS5Ft3BvKQ7Xk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774592; c=relaxed/simple;
	bh=lpoQWd7Pp8XM5F+FETb7DdgvFwHNul+KJVE9njrXr8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Cd9sINruYup7VGakwWAnJ1N9UGk/QVjYjLhHvHsc+UftfQIGZzAACCS2SrdWd2IEZSLm6v5XMPCBAUkM7Qc5r7Dhb9A0hKGh+i+spLeq7zEKLShJS4PGGzW/qRn7WdGcumXeBrkvSaQ4vw08mwPUWFLwlAZFOfgW53tDC9q6kUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pl7u9KtF; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=euB73dAKIPQ16DwNq0FhXxSRH3nvTFAGcnZVde5mzs9ssS/YsFlWxCrdotPpOzLkBeI3C7XQpwTx7e4PA0mnYSCUa5uTBt8PWqyko5wWNpk6aKyk0hFGs0Qrl3ggC4g5xKHTySCcsY5VwEWefBrlRendo0CJBKnOH1Zrv/jwWE+yq69Ti3mrADgk0+Dk+qWKdFuhWxUlsKB1b/awf5daWjopypMu5AyLhoGOneaHblXYhPd4thwxm5LGW+jGRRwBcrtiSh4oDfhkpxj0Bh2kOg0I7OSgAr1yRbBEfGSMfGy8IwYQl26+aKfeXX+CSrMq8m3Yz/Ut9Ew03tDSBNiRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AWv1ZX9mKVaN+qUrGWDsUXeo0f8F2QWrvGnhe7vl6I=;
 b=gT0THK2lYKDtpPyRI6RAPToGyUr6+S7K86TO6Au0ttRBBeKuwh8Nd1uwl12+rhhj+jsDy125mnKbC7W80TcRU8HHywmooxshDCnfKnGVjvHp0S/tJCZ2WgeyLFzCidpW43IYfcIT/6aUU/5IM1EHA/hw7nbryQMet2Qywf7/tSwxstayanzb0htMns91kZbonL1H+MZsdk9w/bSAk0HXJ4OtndQkucRFjYxzPsjYVgt7DwrlOrzm/VRsIKKjBwQxxDAkjjZ4OuuL+H9uqiynZICXCc0W4MeyUimdZISTISAFgfjLZh4L9QbGnqUwELN73mO7fQmzsCnHrYI0M01zrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AWv1ZX9mKVaN+qUrGWDsUXeo0f8F2QWrvGnhe7vl6I=;
 b=pl7u9KtF7/kqHlQQYv5oJvU9PP0t6rJ6juJIMdmGs1nw7c+mBHvlbmM/ijCa08tRJEHBYFTp9pK6Np/nB/Y7hbNpknVANftgBUgbJQcAa3RwPzO8aRDE0snxKRlGAcycNUWb25ajncXzaPUvvTmqACZ36FAVhsaQo34X1FZHzjI=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.31; Tue, 24 Jun
 2025 14:16:27 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::f2) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:25 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:15:57 +0000
Subject: [PATCH v4 02/22] x86/mce: Restore poll settings after storm
 subsides
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa35c2f-c7d7-4afd-f66f-08ddb329b51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2tEZGE4REpTR08xSmIrbWlBeXZhNThFNVNrUmpFbnVjNkh5YWdUbCsvTGpC?=
 =?utf-8?B?dmxZRnNkL1NubE9SdEcrQTNOUkF2U3pGREpONlhadVk5UTN1SGpIU0haVGhW?=
 =?utf-8?B?dWJIMW1EZjFvdVNTQWM1eDRDc2xHcmlvb3NpcDF0TG1jeHVLZms1anFDTEly?=
 =?utf-8?B?U3NYanl6QUF3dmR6endVSk00c00rQzZHcG1ZSTFGNTZtalhaZXRuNzM2eGcz?=
 =?utf-8?B?eDYwQmtnblVnTFN6b28wK0d6U1U2THZqb2x2RSs5aW80eVRtZW93TEpJV3Ry?=
 =?utf-8?B?cHhpMUREeFpwQlR3TGdUNHpxdVJ5T0o5N1g3clNkcStmYjhtT3dqcFF5RXND?=
 =?utf-8?B?M1E3bXVUSHVvb0VCTm9OblpWYXkyU1lDUzRhODlwZkZMRkhtWnB6TjBrYmJ2?=
 =?utf-8?B?RmRNczNPNk54NFVVSFhuTUhoTE1qb1EyRm9wMmZBazVjYzBiK2UxNXhES3FT?=
 =?utf-8?B?MDl5U1pBL24xcFRSd0pPQkFXMmpjQTNUZXIrc3dVTWQ5TFkzVTNGQlF5K1cw?=
 =?utf-8?B?ajNzN2FWdXcrMHluaDF3KzBIRlNxdU1CVGxvYVVPU0FEUkg2SFBMWFJXZFZq?=
 =?utf-8?B?WXZOV2k3WEE1djY4c2dpMHJyM3JKaDFLSnU0OTdseEorNEFtK2Npdm5POUFP?=
 =?utf-8?B?WmlHaXlRRk5sY0NOLzRqR2JkYkdwWmlDbVY4QTN4RlpSMk5RNnR5bG5oamlz?=
 =?utf-8?B?MUEzMmlHSk0xZ3pOTWdpR1pvQm52MVl4V2p1emxDVjU3SHArbE0wcFI4UHRy?=
 =?utf-8?B?UjhtSGZkNlh6VThBeHNNOVhlRHM3SnEyVUhDeGtGUms3WktpVXJZN3FLSWZn?=
 =?utf-8?B?clBDNVBDQ3BYaVBDdjFTRWl3QThPTUk3Q2pqZmRMVHdSZ2pnbUxmcEptUTVa?=
 =?utf-8?B?UUFXSVg0Q0U1QUMxSEVqMGM5SGgvK3hVT2p0MXhwdXhYN3BGemY3cUpiTUl1?=
 =?utf-8?B?eTU5anBLVlVvVkp1ckNaUm0ramg5bm5YanZnNHhNeDRPSEdmZ2hDaUdXYXZO?=
 =?utf-8?B?NW1Bb2ZRVlpDS05PWEI1NHdhMVJDd1pUTWFNaU9rT3RobnN6U2d3Vnk1Yk1V?=
 =?utf-8?B?cTVNb1Z5K2RwYWZQMXNwYkhacTltVlZzcEdCV2podEdFUEpUK2xiV3orVTgv?=
 =?utf-8?B?WUFCVmNIRStCbVdBQThHNVRZSDFSczgrSnJyeERXSXVvOXZFZ1Vrc2VPYXJa?=
 =?utf-8?B?ME1KSTFyb3Q3R3BJRitnMDZBSDFEZUVjaTFRdk12UnZ6amk0d1VPb25uNFJq?=
 =?utf-8?B?dnQxWWFrUkZiQkkyeHZZRXlqeTF2bWoyM25zWlVmZXI0N01yUWQ1UTkwcERP?=
 =?utf-8?B?WGw1WUFVRkNrZHl1RE5mdGxSdk9jU2pOeVh0SFNKY2xobndMamlxamYxVTQy?=
 =?utf-8?B?RTIwaW5VRFVaVlZmY1QwMkdaTlBEVmRSRlBtdjZZUTVoMHFIUmZMZmhlSDR2?=
 =?utf-8?B?V0Q4VXkxRFJSeFV4SXZHblVnUFY4N2NDd285bkJ0aTRDMmJnNG5nc1NKRTRn?=
 =?utf-8?B?QTVhVFdCMlNmWjZoaFB3RFRCYmdXczdNQjZOeitkYTMzUFJXUEFZOWxzYmY1?=
 =?utf-8?B?ak5pTjlsN242aUtjTWFWamxhQ3U5cldQVjR5cmVYakRjTWZKdHNMRjBibkpY?=
 =?utf-8?B?UkdHYzAyVk1TbDZGWWFjYUEvRVR4anhJTytRbUNNYmtLREtiZkxwbm5DMUNu?=
 =?utf-8?B?SDJCNVZ3YTN1ZlFBSE5DZnk2RUZVTUtYWnl3bWdGUW5YWUxvUTltWEJFY2ZX?=
 =?utf-8?B?OTE2MDhKekRHdHFOVjh3Q0ExV3FBaGliT1M0YXlINjBZbTU3KzlUeXJxVHB2?=
 =?utf-8?B?T2d3SnBDeW1kdjZUeTNvcTVTZHpVczVhKzlqUldId0NIeG10T09yY203MTQ2?=
 =?utf-8?B?bk51SkRGdTZWQnZSTnVSYXBoSWZIRHpWenBRNHZPKzBsSWRiR2dxcGRNMW91?=
 =?utf-8?B?K2g4U25LUDhxMHdnbllOaGRLV3hnSnJvbXdoekwvYUU2WVV1T0k3eFZlQk5W?=
 =?utf-8?B?NDFleDJad09nelRRN1I0OEprb1d5WHNZazRjdFNIbnVxc3ZIQXMwZjcxajZ3?=
 =?utf-8?B?a3NpVjliSFhvWmNyVWdibTY5WW4ycWRRamR4Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:26.8863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa35c2f-c7d7-4afd-f66f-08ddb329b51e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

Users can disable MCA polling by setting the "ignore_ce" parameter or by
setting "check_interval=0". This tells the kernel to *not* start the MCE
timer on a CPU.

If the user did not disable CMCI, then storms can occur. When these
happen, the MCE timer will be started with a fixed interval. After the
storm subsides, the timer's next interval is set to check_interval.

This disregards the user's input through "ignore_ce" and
"check_interval". Furthermore, if "check_interval=0", then the new timer
will run faster than expected.

Create a new helper to check these conditions and use it when a CMCI
storm ends.

Fixes: 7eae17c4add5 ("x86/mce: Add per-bank CMCI storm mitigation")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * Update commit message.
    * Move to beginning of set.
    * Note: Polling vs thresholding use case updates not yet addressed.
    
    v2->v3:
    * New in v3.

 arch/x86/kernel/cpu/mce/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 07d61937427f..ae2e2d8ec99b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1740,6 +1740,11 @@ static void mc_poll_banks_default(void)
 
 void (*mc_poll_banks)(void) = mc_poll_banks_default;
 
+static bool should_enable_timer(unsigned long iv)
+{
+	return !mca_cfg.ignore_ce && iv;
+}
+
 static void mce_timer_fn(struct timer_list *t)
 {
 	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
@@ -1763,7 +1768,7 @@ static void mce_timer_fn(struct timer_list *t)
 
 	if (mce_get_storm_mode()) {
 		__start_timer(t, HZ);
-	} else {
+	} else if (should_enable_timer(iv)) {
 		__this_cpu_write(mce_next_interval, iv);
 		__start_timer(t, iv);
 	}
@@ -2156,7 +2161,7 @@ static void mce_start_timer(struct timer_list *t)
 {
 	unsigned long iv = check_interval * HZ;
 
-	if (mca_cfg.ignore_ce || !iv)
+	if (!should_enable_timer(iv))
 		return;
 
 	this_cpu_write(mce_next_interval, iv);

-- 
2.49.0


