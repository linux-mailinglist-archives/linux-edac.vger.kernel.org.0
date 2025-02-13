Return-Path: <linux-edac+bounces-3058-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDCA34ABF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBBB18971A2
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A5B28A2A7;
	Thu, 13 Feb 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vw1qGOki"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E15228A2B0;
	Thu, 13 Feb 2025 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465191; cv=fail; b=JiLhrqJSbmEgVxRx0lOowQCvkQjNG7pfZGE2weDo1xPVKA4ArCGUZylW/ILYelDLZ6jYx7Gg7aGkDH/n3s547FHF3vpm4LtmovM38O6SL3cIwcCN0uW4k5SWs63k35A81sJocfBv73xN3x2N9/MqdKUfz3RJLT4AIjGOXIU+O7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465191; c=relaxed/simple;
	bh=yS1hz0+k2wyAVzW6DTMRL82hP6vaaS1ug8doKfOkouk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Rf/NqXmeIqxL/PhaaNkf62uT2203QU51ppYz9mw3oPwqykx9My9eUVnj/N68LsXrfZ23mYz1lwvG7vfUxTr0t1v6EXNCJlbGmOSiyo9PzYmvYbEwsdkIKHk/Amrha/pzGrlhBl3kXJu+0NjOVOoFNNG6mumb3vBhNZ3rNzUI7L8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vw1qGOki; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDmOANE6e79ZN169L0c57+LEoMpL2bG/6GFcA2uibF65nnEJa4JvIuw40FEHdtg/geu1YQUicAdqN0mUiBDwePvIHq8fRzGFDz08ytClIae4E6L9+yyPDxY4+6q930h02zcvvduQ1F1NfetxcpGUQogbSd8kF5Jcytd80XLNEwqwy4mr//nBI069+W7AditGoA3F51lI9fqhoidUJdXQLGWVg0yKVZx91O31+CONswl82udPlhDTi6dAawrCKvUVCJtN1ipqZCgvN9rBxjrNpyoZsYZrXwKGnlv1fJ2tnvqxYLqNT0ySHiNYDEG+Rww3o8hQNlehy/N3AsVtVNrKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1m5ghx+1OVbM54phDYM7xlX5Ot/IspF10VIn1XFMwNs=;
 b=m8QvDI/FLTpUV+0n1HXeJNQN1CXdrzRUI77L2IUnAIy2fyGFxh7mv/kPOCIRIJX+EWbzY1IwG8cCTpFFHOlxmb/zKSFlAGkQ966wlAIA26QXVUTcYmFiOrXwjphPw0Y2blwxl4EVt3FehAuRu7z6NQmK8lGh/FgSzrtRn8GjmDm/zzNpm3Xycg9y9yiVQoHOf5Y+TV3FpEaVM0I1FlrvAdTcyn6AandAjolp6eYdSgcjiLmmT1GURidj71bhDkqFyvp0trDbhLBmPMmI/LWknzJmOS47u+NbbLP2hj3igD/b/Hw8Unp0wOjX96IEbwDne7cioFkLAvFlobEnqlPWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m5ghx+1OVbM54phDYM7xlX5Ot/IspF10VIn1XFMwNs=;
 b=Vw1qGOkix5FSq0OgWgCkil4tRMEyLnK01dXXzvalCy9gDt4PzTHi2OWRPxC55rDLzClYPRNsNv58Y6R+/zUxU/qN4Pqfb+OPanB9iNMsibEQTx0eBEdaXIj6/t6e/yT/0YG31cZrUE3QaLRSf3752b8n2rrNQWN37aCFVExn9A8=
Received: from DM6PR11CA0017.namprd11.prod.outlook.com (2603:10b6:5:190::30)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 16:46:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::4d) by DM6PR11CA0017.outlook.office365.com
 (2603:10b6:5:190::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 16:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:25 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:23 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:51 +0000
Subject: [PATCH v2 02/16] x86/mce/amd: Remove return value for
 mce_threshold_create_device()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-2-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6627f000-8fb9-4f1e-9e7a-08dd4c4df4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NE1SbWpMMjFhdGdFcHFYOTN1VytvRTI2bk5BR1FzMUt6a1VjU0hzbkdvTmdX?=
 =?utf-8?B?YkpyUEN1S3JaUkJNNE54bWxvSVlhd202UThYUWpRbGJDdkNNcXZKanJBbVA2?=
 =?utf-8?B?V1QxZDJVV3BoZnduVUdjVW5kNzIrVll2MDFOL3pvQnRhRi9uR0VjKzBvVUw4?=
 =?utf-8?B?bktRWUJibHcxWkRXMnU0TkJBVDNKTm5iK25BeU1xVHcyVTlRMHB1STAwME85?=
 =?utf-8?B?eTRSaFVGT1psd2d5R1dWRVE1NTlMZDBXbnp4UmFkTlJxSklSME1Ba1FKTmpX?=
 =?utf-8?B?N0h6YzFhQmpiMVozSitjSkQ5a3RPakE1MkhRQkJRV21RQWx0cHhWOC9SMXph?=
 =?utf-8?B?RlphRHoxV2ZLSUwvcTlKeWFmK1JseVBYZzhuU1FsQnUyeUdoV0NYUlNRNCti?=
 =?utf-8?B?QmJMOFhoTTBaMlhUaVFzQSs4eE5QcUxsc0NIZ2J4VisyMUZQazlMNnNoQll6?=
 =?utf-8?B?NXhhREgrZU1lMkNPdnVVZGk0RDNuVnhKazJmMmI2OEhSTlFWUk8xaUs1d0tZ?=
 =?utf-8?B?K1RqTGFXUmkxb1BSdVVERGZpS3RWVmpsd25EK3RYNXhJalVOc09aeXZVMnFu?=
 =?utf-8?B?UjNwZ0JHdXNIWW5MNlQrNnNaRjE1Q1VDUFZOVWxCV3lFZit0V0xXS2M5LzZt?=
 =?utf-8?B?bXhyVGdzSmM0aGhoRjBLUjhLU2JRNFVPZ2FqQ1dnZkc3NGt1a0xzOFBscW0r?=
 =?utf-8?B?dDRXK09oemhSN1BYWGl5SWxyM2N3MVVteFpYYmxUZkVJTGdSZ1Jlc2g4dk1j?=
 =?utf-8?B?Q3ZRVHA4WHBDQnBmalZpaEFicHpoY2tCSWRicitacGJReG8zbjFSc3g0TmFV?=
 =?utf-8?B?U2dqN2J3dUhYUStiOWJtcnZkNncvejU5MnNPOExTQ2xmZDhHemVYS2t3WEk1?=
 =?utf-8?B?VGVjaVFLRHFBUG40SEY1VmU0Z0pDdHorTHJqa3N6UE5Odms3OWV0VzJvTUFi?=
 =?utf-8?B?K3Z0ZVg4SDdVbTZLdDVjak02MXpja1BaaUZBRnl0YUgrbUJDQWtIZjI3YVl6?=
 =?utf-8?B?bFFZTTVDVnhlV1M2R3JLSXFNSVVpT1RjWVVTUlJaVDNsRXNQeWx3QjZqZEky?=
 =?utf-8?B?TzZBV2tTWDBDVXQ5eUxnYUJWZkhiK25uOVU1M1g1SUozeW84MVdHdHBzZ3RU?=
 =?utf-8?B?bjdPYkhNaDhNMmo4cmYwLy9vVEFQclNLY0pFcVBGYzFURFdDU21Od2UrN0ds?=
 =?utf-8?B?WWl0L29CWElKYTB1RHNsU0NxVkdHSUZjd0F4SzlISU5PLzhWKzBNWmZKWjhE?=
 =?utf-8?B?RXVMY3k4NEoyVm1ISGxtbXhxeUxjWmFETERSQzl0bFZvaGtyc3hlM0ttWkFz?=
 =?utf-8?B?NG1XOWxHY3NRTTljamk5LzY3QWs4ZXJBWVFjSm54UVEvSllqVWU2SmdFdW54?=
 =?utf-8?B?SDNrVDJvVVJCb3N3bDhGQjRRU3BCR3lMbjM5Tms5S3pUZm9QbFV6Rko3Y2lo?=
 =?utf-8?B?QTU4US9zVjZhbkFhU0xQRUM5Q1JUVDNyNzFOKzhBZ1BUWHJnY3NZdE5WeE1Y?=
 =?utf-8?B?eHZGd2poVnpTQTgzSXZGMHZzQ3JhSlBoR1liS3JsSnF5UWgvUG5kZjBXemMw?=
 =?utf-8?B?eXhkLzZydnZ4YjhoMWJaREhKL3dJMjJRZUxGQ0RZdyt3YWhvbGU4M21kNXI2?=
 =?utf-8?B?VTRIRmljZGR0ZkwrT2QrRlhIZmw1dVFZckxPMXVtR0NyanBlRkdOUEU4ZkV0?=
 =?utf-8?B?MXpwM2l0YTJtVlRFbEhZTzUxRUV5QVEyUDJkZFRNTVVLV2Vtc2o0bVdidzdz?=
 =?utf-8?B?M2cxRzJkbCszZ093Tm8zTFNQOTBzSnN1R3N5ZUdjc2lQYUZldEY3SDlocWtv?=
 =?utf-8?B?QXRmTktUQ2tudWRRNVl3Sk9oVG9OWlhETVpGN3kycklrWTRvb3EvelB2NWlL?=
 =?utf-8?B?WEZ2eGYxcUw1S09nbFJaZmdDM2pSOU9MSkhhRnZwekFJM0N4UmVKY1hTcWpU?=
 =?utf-8?B?eHJ5eUlYOEZLeVFnKzduV1dKQUE3MzUvNUEwQ0pYdG94dmc1RXlONGlXRjFN?=
 =?utf-8?Q?bJfXckGiVhQNBbMda2sPcTwv1wBKy4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:25.9348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6627f000-8fb9-4f1e-9e7a-08dd4c4df4d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738

The return value is no longer checked, so set return type to 'void'.

Also, move function declarations to internal.h, since this function is
only used within the MCE subsystem.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v1->v2:
    * New in v2.

 arch/x86/include/asm/mce.h         |  2 --
 arch/x86/kernel/cpu/mce/amd.c      | 16 +++++++---------
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index eb2db07ef39c..2701aca04aec 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -373,14 +373,12 @@ enum smca_bank_types {
 
 extern bool amd_mce_is_memory_error(struct mce *m);
 
-extern int mce_threshold_create_device(unsigned int cpu);
 extern int mce_threshold_remove_device(unsigned int cpu);
 
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
 
-static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
 static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1075a90141da..4ea691006c3b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1318,36 +1318,34 @@ int mce_threshold_remove_device(unsigned int cpu)
  * thread running on @cpu.  The callback is invoked on all CPUs which are
  * online when the callback is installed or during a real hotplug event.
  */
-int mce_threshold_create_device(unsigned int cpu)
+void mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err;
 
 	if (!mce_flags.amd_threshold)
-		return 0;
+		return;
 
 	bp = this_cpu_read(threshold_banks);
 	if (bp)
-		return 0;
+		return;
 
 	numbanks = this_cpu_read(mce_num_banks);
 	bp = kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return;
 
 	for (bank = 0; bank < numbanks; ++bank) {
 		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
-		err = threshold_create_bank(bp, cpu, bank);
-		if (err) {
+		if (threshold_create_bank(bp, cpu, bank)) {
 			__threshold_remove_device(bp);
-			return err;
+			return;
 		}
 	}
 	this_cpu_write(threshold_banks, bp);
 
 	if (thresholding_irq_en)
 		mce_threshold_vector = amd_threshold_interrupt;
-	return 0;
+	return;
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 95a504ece43e..231ba8ca4a3e 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -265,6 +265,7 @@ void mce_prep_record_common(struct mce *m);
 void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 
 #ifdef CONFIG_X86_MCE_AMD
+void mce_threshold_create_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 
@@ -293,6 +294,7 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 }
 
 #else
+static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }

-- 
2.43.0


