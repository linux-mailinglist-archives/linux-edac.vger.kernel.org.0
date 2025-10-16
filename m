Return-Path: <linux-edac+bounces-5073-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF63BE4A3B
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F396E4826E6
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A843570BC;
	Thu, 16 Oct 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YQYAqq5v"
X-Original-To: linux-edac@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA63570A8;
	Thu, 16 Oct 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632696; cv=fail; b=ukXWSmSeLHlDZhiNOuC69N629aqSaDxhv8mDobK0hDTCSKYwMGJAz5YiWUDmcxmJFW6OEim0DhnAITOHLJSnKPMyOR001SIF/7aO41Qd5GAafDf49GFM7OJFV31vllp/lHln0rJySh9MGkz1SA52TEzzgaj3HrN5/vtzdycg9iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632696; c=relaxed/simple;
	bh=Cuw2W5NwkF2apjF9NSlMRtmhKI/Wt/FfKutq7NkQS8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hlRAqBgeUatJ0t7+1mhNeFFoe09WUxUb+EELh4pylXMNvM/+8ifDXgXvg+Jg3a9D7Xz4L/UyqymtBRB/qv1A7WEwsB84L4EMVbPx/HB+iyK4nPq1R0s+xfm1ILjbXIZYxtS7LTXTmcKNngEJMD0Ymf/CXLwPKzIGaSNGq6xduaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YQYAqq5v; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NsssZsCF2vrRMz43OkkD2yt0HAXkHReEkP4f0FQZBDrJw5VlboJxAGswnkROMLbBm7WkjbNo+X+MC8nr2ED5yplTKVl88qqyBhoQVyqwpkmkdf8C2hAyDaIy0k7rqrBVSyY6oysGNFG+Gw/jk7v71L84Y469x2f8jEm1Xu2wPuxlo0sZYm+uiMKZduxX7XQu+/4K2ZhOKn3G+ehPQCG8apTA22hpOzd7x4fk2yJeK/lZG8PNs+M9JMJuhh71zTOmMwfvhNQs/QFuT9qPMTzflFEq5fEVLybQ37cwu53bQRNy6vUytCVqVck5L+N6HoZ9EAFkU0pNtdvFGx7jg6G+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+WYcjqNBgZOeQiXCL0KmcD9fwUq2cdb5M8IAO+O0VE=;
 b=IGXJvjF773ML+OBLScA6IMCZkeM3vKjpy/kHxEiir/Q5uFg5Cuz6vJDUpQUYOK4sRViO3UhuiyBWM0QwDgoRuqneq4xvuS2uhcCnIrL5ua1OhrEpndzvH24YemTAUVtojB3LdyJp5fRNQxZaF4qiTGAMIj7Q/iQ+eRnwYHagT+WSKKwgxJrn3S/dKjtODbmrZk4Yi3QBCI1IrOvgswQFHhJMXtEjfnCqzuYwuoY/BmwlvtZQdpLMwdUw2HMmu+ekjkrF7sRtOwLyTWrjhc/sjOhwzeZbm4GlXk+r0Suyv7G7+2hP3/l4IzvoxZUfMCQtd9rdICwJgcEKlYFM+K7Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+WYcjqNBgZOeQiXCL0KmcD9fwUq2cdb5M8IAO+O0VE=;
 b=YQYAqq5vdPYG/M2hnjzGn/2kWnhs4hi4xhpEN7Smqt5QaVU/zVh/1elndTMgeP7OxR31KCwMiY9ljkX/7dUOMkerrKc1AudjwsItobKytAbawZiH//jtOC9W/sDynHmZmeG9kzi3MNO2Hz1janmz1+ihX5ofqVSSAqkW9qcY1k0=
Received: from BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:38:08 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::ef) by BL1PR13CA0146.outlook.office365.com
 (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 16:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:03 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:52 +0000
Subject: [PATCH v7 7/8] x86/mce: Handle AMD threshold interrupt storms
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-7-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 93013b30-22c0-4251-5ab7-08de0cd26333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTV2ZXpiZXNyNWhyL0xGRVV0K0tWZm9OOUdXOXkvRHpoOVRaRitQaGYvYTFN?=
 =?utf-8?B?TmVEaG1jNVNnaHRuUlhoMmxtRG5EUWVScElHVWMzbXFiSGZnOVF1NENnckZQ?=
 =?utf-8?B?L3FHL2hFdkp4UTk4WlZBVkl1c2xzcUdZN25uUXI1Q2NINjQ1UFhhRm9GV0M3?=
 =?utf-8?B?RGRoa2dPTWY2N2ZDRDZhVkNETGFYV3prVWRyY0lheEhIck5OMG1MS21VTHNi?=
 =?utf-8?B?ZlpCaEc1SEFNcm5xclJ3Z0hmM1Q2bU9Nc0xDZHhHQ0s0WU5FbldlQkMwUzky?=
 =?utf-8?B?SDBSWlRHWUNKbXl2Y2hlRmEzQXV4VEh4SUZXT21pc0krYVNSTVl5eG1GUTBU?=
 =?utf-8?B?NVAvVkpvY3JwR2tkK3FBRS85VFpidloxcUtGLzhsd1U1a29pemc2L2NDL1dm?=
 =?utf-8?B?b3llWVhSVlVOM09BL0dvc2dZYXJReEJ6Z1FXUlJzZ1BUTnFhTGdGSDVXd2hz?=
 =?utf-8?B?MU50aWNuTmVBTzBTYTNLNUwwUjZhVzFPZzc1WmZmaU4yT1lVdnNoOXpqM1Np?=
 =?utf-8?B?dHR2S0VacElINE0xdHR2L0RlUUlkZ0NvUXIvNXE4TEZaTmd2NWRqN0lGVE16?=
 =?utf-8?B?eUoyY2NSS29CazFFdjAzYk42VHRyN01FbXR4SHJhcFVmekxyMk0yL1c3Sm5T?=
 =?utf-8?B?d1k2enRYWE5nU1pHUDUyT1o5Q2VucHpQeEtNWlpqZjRqTjBwVEV0VjA5RTZJ?=
 =?utf-8?B?L2grZXNXNVhBUUEvcDZDMVdEUVZEZWNVVlI4Snh1ZngzQnp3blROUXNsQmQ5?=
 =?utf-8?B?Z2srOHprL2hpR05QMjNWSjhMNzg4NXNBT0MyL214MDN1WWNIWkhKbVRSREgw?=
 =?utf-8?B?czJ1bFJjcVQxNVhJVjVvUmUxcnJnS3cvUy9QOGJiako3NWFiaGRCMkdscmU5?=
 =?utf-8?B?WEtIWTV6VTFYaDNCYmx2MjVsbzZCZmd2MlNMVzg3OXRFcXJQMHVXMXFQbFZK?=
 =?utf-8?B?RmVVUkNyZ0NSa0Jhc1dKZkxicWc2NzNveVVmanJQMFV3dlpaWDlDY3phYVlI?=
 =?utf-8?B?emNIS3B4RmpuNit6VUlQK2dnVDFjR3pXNUl3dWxkTkVJUFcyWXRTalpOOFQ1?=
 =?utf-8?B?YkE3b1p4YVVQZzZlSWdQVnlubDkvOFUvbGN2Y3kxanB2Vm5BVmFHLzRWUy94?=
 =?utf-8?B?WGdJeEtXNmkvblR4WFpXejJJUUJBVVFMNVIvQnd4WEJjdG1SZ2xxUHRaNmN5?=
 =?utf-8?B?MkRyZVRORUwweE1pWU1EOFZEQ3k3NDl1Q2o5N3ZPbkFGQzNSKzRTZnFhZDEy?=
 =?utf-8?B?cEZCK3ppb3hHQjB4ODZtVkplc2dIajVGRC9lRmJjTGVwbktUV0dORWxXU2tD?=
 =?utf-8?B?MXhyYyt0NXZYUGpzL21CamU0YkJBVFFYMzYyc1FKUHo5M0NZRFd6RWcrK1Mr?=
 =?utf-8?B?MFlRT0pXVzRFZEFPQkpJbXBuYjNndFFVQkFaUDgxWURna1EzRlpYMnhVWW1Y?=
 =?utf-8?B?NHBnZDBSVWV1c2xXYVNHeC9tUHVKcFZhYTZ1OUdYVVFzT2pUM05DVElWUDN0?=
 =?utf-8?B?WFVjcFhhcGthN01YOUQ5amJRdU4wblAxaDNRREZ3ajlQZ3orWDRVb3E1OFNj?=
 =?utf-8?B?MFJld3ZyK2pCRDg4Uzl0MGw2aktFWExObEhkaXV0dXdyN1hHV1FLYVlmQ2Ns?=
 =?utf-8?B?M0RZYlBIaEt3b2VBc3dtRFFGdzliNTNhR0x2TDBBYUhpOVR0M255VUI3T05W?=
 =?utf-8?B?alE5SEVUN3ZXZWEreFdCRU83NEE2dkcwVGVHajh3VkxxbXJEMEV3UjFwTThC?=
 =?utf-8?B?VzNVZHVOeE8ydENiSTQ4ZHU4QjBQaEJSSVo0RTNDNXdIYmYvdFNWWG94NUJR?=
 =?utf-8?B?eUQ0c0JrdHE5dlQ3bkJKbThsdTdWK2pITHkzVFl1YlhUQWVxeHd2Y3cxK2FQ?=
 =?utf-8?B?VGJ5cjJRYS9BNFRoMW8wd29sUTEvaU04Vy8rSS9jakFzLzlsaDN6QW1aR084?=
 =?utf-8?B?RG1oWU5iNHIzL09NSmU5enhDL2RPVlRoOU1rSVgzZTVjVEcrOHIrODY2SUVk?=
 =?utf-8?B?MzF1c2UyN1VFcVVFTFEvQkc0WGVqWUhWMS9MMmhMK0xwZ1RqS2VHVXlNS2xR?=
 =?utf-8?B?RjFqRHZ3U1ZCZTlvMUF2QTU1SENWam5oL2hVbjdpRjdFc2tSQ1g5UDExN0Rh?=
 =?utf-8?Q?a2XU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:07.9550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93013b30-22c0-4251-5ab7-08de0cd26333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258

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

Also, AMD systems currently allow banks to be managed by both polling
and interrupts. So don't modify the polling banks set after a storm
ends.

[Tony: Small tweak because mce_handle_storm() isn't a pointer now]
[Yazen: Rebase and simplify]

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-14-eef5d6c74b9c@amd.com
    
    v6->v7:
    * Don't modify polling banks.
    
    v5->v6:
    * No change.
    
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
 arch/x86/kernel/cpu/mce/threshold.c | 6 +++++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index dd485ebae267..7020c5ad4c74 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -830,6 +830,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
+void mce_amd_handle_storm(unsigned int bank, bool on)
+{
+	threshold_restart_bank(bank, on);
+}
+
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	threshold_restart_bank(bank, true);
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b0e00ec5cc8c..9920ee5fb34c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -267,6 +267,7 @@ void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 void mce_threshold_create_device(unsigned int cpu);
 void mce_threshold_remove_device(unsigned int cpu);
+void mce_amd_handle_storm(unsigned int bank, bool on);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
 void amd_clear_bank(struct mce *m);
@@ -299,6 +300,7 @@ void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
+static inline void mce_amd_handle_storm(unsigned int bank, bool on)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void amd_clear_bank(struct mce *m) { }
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index f4a007616468..22930a8fcf9e 100644
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
 
@@ -85,7 +88,8 @@ void cmci_storm_end(unsigned int bank)
 {
 	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
 
-	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
+	if (!mce_flags.amd_threshold)
+		__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
 	storm->banks[bank].history = 0;
 	storm->banks[bank].in_storm_mode = false;
 

-- 
2.51.0


