Return-Path: <linux-edac+bounces-4674-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E517B348EF
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E175E55C7
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D023112D3;
	Mon, 25 Aug 2025 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BnwImZ9q"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6430E82A;
	Mon, 25 Aug 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143237; cv=fail; b=KMebbAyEZg3Kk9XdeHYtmNr1kz5CStb6H7MajZJGeJ83ccUEZCZowAWvJOwUP8FKGB+qmrnfOpJnWsskpNpvR/nfo+yKk/8bpYnMO74AuWzetDw6BLld5vy7lldIRXTB9ZMnZkpgJ5EARxofKAFjia8qxKK9TZEzn+odik8P+Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143237; c=relaxed/simple;
	bh=Kryv3hK0Yq4w3x21XxTqhkeVIlqZquNSxfh7ipBPXTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lK9PcA3tE3bxdvJai2TLFvAhJn/JUjbLEXzgaPjAAqLKAfy1GyHTN5vp5D4xU2+jLOfGHgF/3tca9XoYh8pG/1jLmGxMChHXxoM+a1GW5XrFyeNe20A/VUtY7h7jNfmJjrXJMsZhmrgvHcNsB40HzLsglCyuOiUU87M9na18SNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BnwImZ9q; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgQQnFUkH64MzN002265Fwz8QM2pgBHVLKqc+uhHBnslK5ZKzW9FTahCnXHlDNhRm93Dri1KFxY6wJbHVov0BtbLt2x7pn81OgWekt+Abl2PfAPT4TIEIJeu3aysdoxY6CT/VSZyGmnM0PCVoukdEzfNEKL2woPcUUo00X3doQA2Z8KY74bggTZwwi4SLGTIwrBR7zbHn9jBmw0xxzOSWJbKlgLqF7kUmqUN+dKwc9ESL9YTx+UCg/AANXPPdZfy9m7cZhnxCB7PSUHFzenGOmmqSHNbMfWmTrMbFK5Gsy0GaCP+kOLCQ9upJev/Iize8qvTTz5hba02u+K34VnMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cbXniQZ0gJ3pjWEODCpdUOXjzqjwp0Xu3tJyS+q5qA=;
 b=JUtw9GXhy9wA9mDOJSW38ZMSYyDap4IQmP1crDM2AeDxjXQaJmzkDAoI7fMZsSi/PeJhpgyVhJysOAmyCrLvt7l4OXiifD8aGHWiLphYTrwV79CA+d7GGLljfo2TIbgPKC356eBA++A2DJQDgMdI/lYT2pHRJnQFGCkMrfJd+GGCv1N8JWbpRs4rfZel4WMh1ZV57gfZrqBw7cErrDP3++P5MOwLpf8qbShR6DfDgY0I9vrsjaqNe7hts3ZYFoqVUyU33Nr0jr8XbkYCCgUubBc+5ghyCO+T5Z//QrAbGUdFX5DHZICvplCQwg/sGF/fS3MSsuRdfn/kPcmr3y4pgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cbXniQZ0gJ3pjWEODCpdUOXjzqjwp0Xu3tJyS+q5qA=;
 b=BnwImZ9qapEab64eJ3zt0bDeR5gBwoArqsA7AlI4F90Z+j7RsxwBUEZJjOG8m3yK8YU2z1QkidN6MiTjmy/hwGuWBOqZql14QkqxKdout8FD1NBu0Tg0JgTeFOQPQS5o5jaTScjtnkw5V0jb8sZ5oecByBURCKRK/YrXLsNwIE0=
Received: from SN7PR04CA0059.namprd04.prod.outlook.com (2603:10b6:806:120::34)
 by LV8PR12MB9406.namprd12.prod.outlook.com (2603:10b6:408:20b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 17:33:52 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::e6) by SN7PR04CA0059.outlook.office365.com
 (2603:10b6:806:120::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:51 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:47 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:16 +0000
Subject: [PATCH v5 19/20] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-19-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV8PR12MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: e38b7a07-a4b0-4dbe-f46e-08dde3fd8ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cThONktUZ0UrcWxSNCtNdGRvbWxDOVljVmhwN2Myb3VXNVZwajY2c3VkR1E5?=
 =?utf-8?B?TXFsVytNOTdLYXhEUkRsSWVLZTJrOFJSNWFrYzdNczBodnlHcTZXMGtGK2tT?=
 =?utf-8?B?MU1pMDNKQXZ0bWpvWHVrUDcxYThWRDVZYWdEa3ZjemgzYWFkZWJ1djczcFNR?=
 =?utf-8?B?Y2s1YmdnMmZRSEtvTEZyOUJ4WkJEbW01aU5oeGtKbDlLVVdnWWNhOU9FZEZG?=
 =?utf-8?B?SUd4WFRTdWdFdU9ZalNYNlc5OTVUQTVuMWhuU0NWOW1UMnBPalBkRzZCdDNk?=
 =?utf-8?B?czdZMmhUMTRMT2VDRnA2amxUZkkrYmdVM0syWjRxelJWWEYxRWduVWNJRGds?=
 =?utf-8?B?TSs1Rk0wbEdRb3NjcTdjVEVUSVMyRXg0K3NuSkRvbzZCMlZZT2lONjI2dStF?=
 =?utf-8?B?ajVicWtnd3hLdDkvbFJaZTNkM1N0YUd5ZmY2d0JTdWVVSFdzOThvYitleGF6?=
 =?utf-8?B?d09xSFFvbDlyVllMYXlKS0hOUE1Na3ZqSFZnekxYcWpCc0owL0lER3lxNjZE?=
 =?utf-8?B?TG5oR1VKay9pa2VpZENNMWljaXRRNHVRdC9XTDRkQ3NMRFpVRmlYVjRWNllV?=
 =?utf-8?B?NmltNFFnK200R0loL0M1cXptb0twOVFwVm16WXZSWlBJcjNQZk15SlNZSEl2?=
 =?utf-8?B?eUZ2cDVJeVN3WjBEb2xUR0pveW5hQk9peWY0TjZNd2tRdStPUVE3VWxYTXFz?=
 =?utf-8?B?RlpuREdJOHlxaWZLaVdJVlBUVlVzUmpQOWVLRkZUdlpqNmtTWnBZOUtDU2Yw?=
 =?utf-8?B?RTJROU1mM2RlT2U2ME81UTh4bDBmdVQxcFMvelJYRnVBN0pBUHJrUWRrN1pO?=
 =?utf-8?B?eitKQjB1eGFqUmZ5Z1JEUkx2YUZUSDhFTXNMYllXMHVSU3liaTFUYXhFK05B?=
 =?utf-8?B?SlpYbC9OcXExdzV1MkxUSVJSbDdWK3YzMlE2bE91NXhUTDFVQVhTSFJsQW0v?=
 =?utf-8?B?RGxGOTk0Z3FCMHdienR3dlpWd0hYdUhPTlFvUHh5azZTUXhQa2h4dE1RWHla?=
 =?utf-8?B?dks1V0JFSlpwbjBDL0FxWS95NGt1aE9MMG9lMlY4aFdPcjFJeHZaTjROSnU2?=
 =?utf-8?B?d0lNUlNKbnpsdHNzTTdOV01scGI1T2w0MjdSYTlkZk81ZUpndHpSc3FxczVH?=
 =?utf-8?B?aklpYW1kMXdHS2dkSHNIMHRudVhrb2t2OC81VE5nWmpDUXpweS9uTmo5OTFD?=
 =?utf-8?B?Ykw2SGhTZk1SNWRaN3R5MFR4L242bTlvVUh3Y1drRDRIbytjWm9QbHE2OTRP?=
 =?utf-8?B?Mzg3Y2l1a1VaaXorL3NHQXpmNjk0NWdCbEgybDhwN2tPTWpXTldMNlZqVGNa?=
 =?utf-8?B?V2FOOGJrQzdMS2Fac2VadENXUnF2d3lyRWdjWkkxYnIxUk5Dd09ZUVVFNGFt?=
 =?utf-8?B?UytBU0xxcTBGWC9LL2xESjIweXN0aTFiZGZUeVNCdHJjS3VYWWg4MjV5MVRa?=
 =?utf-8?B?YlE5dW56QUdScEo1WHBKVUczTUdBd2JNb1NHWVFtWU1JK2JHZ3VFb2NlMCtj?=
 =?utf-8?B?bEhDNkMxVlBIN0FDUHNKZ1VFTDFLUVNEd0xBM09uOElIOURTVU1UQzAycCs4?=
 =?utf-8?B?SEFTelZvbUNERm14RXBIek5zRVNGL1B5dzRwejVuRVdFSkVvYXVGYXdxWFRs?=
 =?utf-8?B?UDFHVThyRFZYZ3hxTVRKOXBsWDVzWVNidXhXVTlDT2c3UDZ6YkxCbW5ocVN5?=
 =?utf-8?B?aTJYMk02RzVoaXJudUpTSWV0eHpNUk1MTW4rcmZOeEYwem9Ec2s1ODFjRWY2?=
 =?utf-8?B?T0JQUEpudzJWQzJ0d0pKMzEzSDFlVDJ2RFVzT05rb0U3T3hyMWJXcHN5R2I1?=
 =?utf-8?B?MWEzdHZUZ2N1NDk4SDJWNnFvZEFtMjFSOUhWaHRuc25Ea28vWGRURGo2RGpz?=
 =?utf-8?B?MFA5bVRXS3VXRE53VFBCa2p3QVp4NUtZUHpDckw2bVNwQzcyRFFDaHcyd3RP?=
 =?utf-8?B?MnJoZUxFQjRlYXpKcTlHOTNid3QyM0NwRjg1c0ZwY0V2MmMwRWNoT2tHKzhw?=
 =?utf-8?B?RUZyZ2I2QnBIWlhFNjlNbVd4MDJ2MFBHSndKbGhQN0hDMkRRbkM0L3RONE5Q?=
 =?utf-8?B?VWEwaUkxcUY3R1UzTkhGWUE0QzM0VngvYVNrdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:51.9552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e38b7a07-a4b0-4dbe-f46e-08dde3fd8ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9406

From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>

Extend the logic of handling CMCI storms to AMD threshold interrupts.

Rely on the similar approach as of Intel's CMCI to mitigate storms per
CPU and per bank. But, unlike CMCI, do not set thresholds and reduce
interrupt rate on a storm. Rather, disable the interrupt on the
corresponding CPU and bank. Re-enable back the interrupts if enough
consecutive polls of the bank show no corrected errors (30, as
programmed by Intel).

Turning off the threshold interrupts would be a better solution on AMD
systems as other error severities will still be handled even if the
threshold interrupts are disabled.

[Tony: Small tweak because mce_handle_storm() isn't a pointer now]
[Yazen: Rebase and simplify]

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-21-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Simplify based on new patches in this set.
    
    v2->v3:
    * Add tag from Qiuxu.
    
    v1->v2:
    * New in v2, but based on older patch.
    * Rebased on current set and simplified.
    * Kept old tags.

 arch/x86/kernel/cpu/mce/amd.c       | 5 +++++
 arch/x86/kernel/cpu/mce/internal.h  | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 3 +++
 3 files changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0c8ec431ebd2..d7b226a68ed3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -832,6 +832,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	threshold_restart_bank(bank, on);
+}
+
 void amd_reset_thr_limit(unsigned int bank)
 {
 	threshold_restart_bank(bank, true);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index e25ad0c005d5..09ebcf82df93 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_reset_thr_limit(unsigned int bank);
@@ -299,6 +300,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_reset_thr_limit(unsigned int bank) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index f4a007616468..45144598ec74 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -63,6 +63,9 @@ static void mce_handle_storm(unsigned int bank, bool on)
 	case X86_VENDOR_INTEL:
 		mce_intel_handle_storm(bank, on);
 		break;
+	case X86_VENDOR_AMD:
+		mce_amd_handle_storm(bank, on);
+		break;
 	}
 }
 

-- 
2.51.0


