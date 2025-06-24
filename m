Return-Path: <linux-edac+bounces-4227-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA6AE6874
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E461E4E04CA
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC52E11AF;
	Tue, 24 Jun 2025 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eHOdy4fZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893122DFA57;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774604; cv=fail; b=phEDPfA0qefmdOxwGwWvMW0tZ93+/ABm1v1j20HClkjeqvNtksZQgmIh93TYEtArT24nsQoSPveDO5hymeg9jjA2GWerJJKmIvXdcFcCVA+mCvcoshHi3Zf3ZPKDAoqZ/wl8opOiTRk55JPV7ljqebaVqTWHFaFsudcywFwFQ/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774604; c=relaxed/simple;
	bh=gUsS/87xpdCqyg4916ZTRzKT4n9GYVnMs/6TcRgM5Ko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R4mcpKvfRaiJ70a/VjMbjj+YplEPPIkf1jcMNUkScAEcSZ13hHTonUplvGFiL5XUmyxBMGQiP3+vcTLDjmqt2eUiKaHCH2PD3WLjlcBQ73RCFi6BXwvtjO0lPnb0upDdiJcnbyMi2LPxi5PvJhVdIuKYsliC9KYv/j9sYkWe2JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eHOdy4fZ; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=stuCA+zD+xcJuM4jKYh8Jgo/d8jogg+LdM1KOSbtgEY+Iun+8Adeo3QGhcuddkst+UoUX6MM4QIgUbMD49XhQE7wxTBlRmDyWkIFMZBWpOuSWlWNWum7raO9rc1y8xyDvFbISy0F5GpoAwyoWknp5dNYUQ02IwVVlOdwQlIXuF8dtwhGb6D3tycmZPlwow5AYQWnTPEQFv7LHehqKkAaU8HEsZUCwX+UmtwRH5w6xGl1vgSPVElnmK46gkARIYOvm9VJVTxaFuuO3/Za1GnvhUwj6+Qmgbf2tn00JWAPIhOCCeuzVPYRyJ8CgnSra2P6/jcxtmmYfzGl7jbhVHuZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaxW2R1slKCdaaOBhaVyDPlhumxCqfqU2ZGwn1rbz+s=;
 b=Nqp6wfL1Lq464cjbSSrGBsRQx1sEPNonuStggw6tXpxqrVxE9GdxtQXNSL44an6UHIYZnsOO9dNK8aE4JvaNS0EDkAhq6UCzHQndhp7s4L/C2JkxINjsWmoBckhCIxvBCC6256uww/6ORfcXLFQ1x09++djJ9iR2u6ZJmJxhzFwkhhBbzB7q1JtGj4vY8iJv3ekMLFi2O8qzP/hPMh4r2QNEf5+fMeoiIZx/UqVc5w1rdOJ1YayzjD9onZ632/Uduiu5ccyLPEnBWLkrvvvBLmujrxe9BgXZQWw5Pje2cYrmoJJI0cYzWCJm6+V2z6yoQX7FxbyZ77KFC1SiQYptqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaxW2R1slKCdaaOBhaVyDPlhumxCqfqU2ZGwn1rbz+s=;
 b=eHOdy4fZiH5CqJgnNJjvMsCkm3OTma4A2USgOBGdxnLSbeBB2CePPrTvSTiggnp7sSfA48oqr74rduInppcYow+dYzfBhRMrNSSf5z7Glb++/SEb6b/9gd9sknV3X0T8lkZ5Ut4OEEFfPZMDNBfj3ACvOPder7of7/zVuvDQBaI=
Received: from BYAPR02CA0063.namprd02.prod.outlook.com (2603:10b6:a03:54::40)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:39 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::ef) by BYAPR02CA0063.outlook.office365.com
 (2603:10b6:a03:54::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:36 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:13 +0000
Subject: [PATCH v4 18/22] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-18-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: edb915d3-76e3-42aa-f499-08ddb329bc90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d245ZmdoRjU1eS9COVNaR1JyNGQzNk1VMEloazgzeUVtQVJIS1pEdm02YXdq?=
 =?utf-8?B?SG1WMlFZNk5UNFJVRDBjZGc0YjlsS2R6Y0t4Q0JVZmdlZS93SXJPdEFLaVIx?=
 =?utf-8?B?am5sQVNlRmRKV1ZzemJnL3RmMlFISVFkOU01NjdXbWNjcDZVRFloZTE5ZHJa?=
 =?utf-8?B?b2tTMXBOa0hadnNoVWhQVWkzZUw5MUZFWTIrM3Jrd2ZONzVIa0hiS3hpa1BM?=
 =?utf-8?B?T3VudGdsTW5RMHVFbmZGL0xBR0JQanJHNmkvUXJnc1RTMmdDRlI3MldjN3kw?=
 =?utf-8?B?WHpDODZvVmRXdHMrRE5Ga3hjS21CNkY0Qi84WFdUOGpJS0VvYXJqUHR4eExX?=
 =?utf-8?B?MlU1TG1xdmc4dmRETnppRUVWT3RIU2FlR1pkUGVwdDliQkliSEk1V3U5ZnFs?=
 =?utf-8?B?NStibTlMYTJCSUFwcHo2SVVUSTZKZ1Evc1dOZlRWSlI0OVIyRk80R3BOKzZW?=
 =?utf-8?B?dnFUbGM1UitKYURXN2Z3R1FKaHdRTUxhNkEvYUtXaUZ0Z3Q4NnpRbVNMTGVF?=
 =?utf-8?B?eS9QWTZhRk5uQlBwaTBhNWFIa0ZHb0UrZXp1QlJiSlR3aG5uYWF6VHVkU3FI?=
 =?utf-8?B?TS9WVlhtTlFnUGhCVkxVWUExYW9LQ3loSEszdWZYeWdNVHZ0dFMvTjd2K1kw?=
 =?utf-8?B?amExbGdjdnJ1YzNZNnJLeGZUZHBxalVneDhsY2FSNW5iZjYwYjI5YUJCN0Jv?=
 =?utf-8?B?SlluMUMxVEg1aUFyN1dDLzN6Q05ibG1VejhXS1JJY0N0a0h3UzJWV2RFL09P?=
 =?utf-8?B?ei9WTlhmYkx6L1BaMWVrR0VITkVzZUh5R3Y4a3JYck1tTmh5cEM4R1JFZTJl?=
 =?utf-8?B?bUN6Nzg2dkFWUHFmY3IyUjNocFpBNW1YYVp3cDExVFh2eklZcjhKWVhDR1pJ?=
 =?utf-8?B?eE9PL2dEdHJUNlJCRXpVT3h5ZHBSOGdaa3MvUE5oODVoS3NiclFWQ2JKSFFG?=
 =?utf-8?B?eC80YTFxd2ZHUDVHWDhmZUYyR2owazcrMHJMYnV6WFU0bExWRk1aRmg1Y0Iz?=
 =?utf-8?B?SGxaNTVkRnF5SlpTOUREWjdNSGdZOXNoNys3M1ZTcjBVMUszUWJVUktNYnYv?=
 =?utf-8?B?VGF0OVZsY1NsUGQrUFBsR25ML01IUDBOYmpVSXpLby9SUXJyK1lHSFRQaW9Z?=
 =?utf-8?B?Z1dWYUZhbmtIYWF6TnlVK2wxaC9RMFB5ZTYwZ1ZxWEZEQUs1UjNCcTB6dkRa?=
 =?utf-8?B?a0M5SG8zSi96OVBGdnozSTZ0YVNtK3pucWh3TDRzSTBQYXN6TjhianBkc0F6?=
 =?utf-8?B?bHNSMFBYL0tTaXV0c1c3S3NCQkVmdmVWelVRV1hiVGFoQWdNbTN3bVVLbWdX?=
 =?utf-8?B?K3h0cGdCbi8wbU1Mb1VYN3JVSHVnRHE4OThpSiswSEdyUUNIaTJxa1FBcDNQ?=
 =?utf-8?B?NUt6TzhHdldKMWpwRzFTWEpZZE1MQnd5L2t3bjkrL0liR09Ga3l5ZGtUaVlU?=
 =?utf-8?B?Z2gyOUhlN0puMUM3bmx5Q1lhc2Y1bFlmd2phODRsVUFWNmJrUGMwQ3Mza2Fw?=
 =?utf-8?B?UTNQN0Q1bVlLbEdwU3FKZVI0OFVONjZhWC93R0tSd3NSUVdkRDFQT1IyTXky?=
 =?utf-8?B?L2hOaTRwZjRBZTVmblN0NHBUKzJnUWVIOFhQZGIrY0pMNjZyMGxPWU92RHNt?=
 =?utf-8?B?N3ZrM2NBOVdnbVRRdnJnUnYzQU05dXBQNmNkMjRJTjdRanhKY0JYQ0RXbStY?=
 =?utf-8?B?aSt5ZnFBaXBHK2FSZ1hTeWhiRnU0WDNMeUxxNStxK3hDdWIzZTlJM1RpYU5q?=
 =?utf-8?B?VU9wR09TeWJ0c09nbmRoTGJKZmlBQnNoMVZtL2tlanlqOXVRdVNQd0duOXR5?=
 =?utf-8?B?REQrTmNSNUsyQ3hlczdQc2YvT2pFNS9ZTVo5L3h6OTBOdUV4bm5TOEdjdzlv?=
 =?utf-8?B?MTFkbE1scENEOGJqc1Y1bVRQNXpNYUpjc1NiMEx6eVFsVVlSQ3FBc2Z2UFIv?=
 =?utf-8?B?SW9EY1dKN25UZXVxUnlCbHJPRnFKVmFQUG9jWU4zOHVUUUI3bnNIa1owcEdW?=
 =?utf-8?B?L0R3ZGFaTTg4NUR5dUtnVTZpeExwMFpXSHpPaFFlcE5kYmRCbmtNV1FMR2RV?=
 =?utf-8?B?SWFtZ200V0NXcmtSNlZaRjdUaDdxazdIRTcvQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.3782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb915d3-76e3-42aa-f499-08ddb329bc90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748

AMD systems optionally support MCA thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA thresholding. However, the Platform will now be able to send the
MCA thresholding interrupt to the OS.

Check for, and enable, this feature during per-CPU SMCA init.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-15-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * Add code comment describing bits.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d4d0169713b..3ddb28f90d70 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -271,6 +271,7 @@ void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
+	struct mce_amd_cpu_data *data = this_cpu_ptr(&mce_amd_data);
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
 	const struct smca_hwid *s_hwid;
 	unsigned int i, hwid_mcatype;
@@ -302,10 +303,27 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * set.
 		 */
 		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
-			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
+			__set_bit(bank, data->dfr_intr_banks);
 			high |= BIT(5);
 		}
 
+		/*
+		 * SMCA Corrected Error Interrupt
+		 *
+		 * MCA_CONFIG[IntPresent] is bit 10, and tells us if the bank can
+		 * send an MCA Thresholding interrupt without the OS initializing
+		 * this feature. This can be used if the threshold limit is managed
+		 * by the platform.
+		 *
+		 * MCA_CONFIG[IntEn] is bit 40 (8 in the high portion of the MSR).
+		 * The OS should set this to inform the platform that the OS is ready
+		 * to handle the MCA Thresholding interrupt.
+		 */
+		if (low & BIT(10)) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);

-- 
2.49.0


