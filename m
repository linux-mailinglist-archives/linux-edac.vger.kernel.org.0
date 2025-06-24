Return-Path: <linux-edac+bounces-4229-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E94AE683D
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F9487AB17F
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919512E11D9;
	Tue, 24 Jun 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f5J9XwCg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8742DF3CF;
	Tue, 24 Jun 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774605; cv=fail; b=ceVOeAw96lTpkMnPMPPmJ2v7SBReH5oDaRFoKiBRfd60+BPXHXFuPqTTwp9uCfqcDDZEtDd5p4nj70Uba2upsALW7n1zm+J7pXORhh6c1sKtV439SMEFj1sAd/2dmFs0U5hfCn5T8D18ki6FKb69v4aUyfDkixYqE8sLALk/qBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774605; c=relaxed/simple;
	bh=+JSZfAqUtjBAbCGYXXcdQkt7xR9QJYOKBOdIiLugiO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=At8pat6dA8YJGqe8ulG+gEIRmg3840HuD2L3a5ERGlIotANCX9LeoVFYu/UVNrHM48QGXRRJpytLgRiwOe2Tn2l5UpUQDhAKIONHdk6ZtrjHiUS74Lv5SAMW7PAfBjLxDGwKn9jWsI4ePUHzC8bOttKhoKue8TCa01sTqpRHAWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f5J9XwCg; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bo6VbogPU2mdtWtQS/ryCeW6e0Gg5DyYi65weJl0WwEFtCkTnms3yECwMVfen/YWmgK1Rq7k/Ca6FY2l4ITZ74MEjV9gtC4xNgy2VVVAsBfY/MC9tEUCOZHgac6pbPqlL1UT3aqPpiTkitLa51BfRB/0nIg3n9ASPrPRUnXNhCYSafEQ/yizPxIS8C935nFnUWNxSKerBLUJMbkocYxL7TCm4pjLIxSVjJ8lJ7i4u8Wuf4Q6TNVKfgNwnBhYMVe+vpMs1d4nApT6kesOB3aT9VC49GpvMCVMgzOA698IAnJKXkOkTXCRbVKKLDwdfMhOR4Y4WmbtHXPvte7rhgaA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLnWDrZ3Uz/9NQm9vYqEbfkR0n+TxZl/17+7p9Q3Lvc=;
 b=aO0EUa6tGdMrvWttiTyFG+5oOdmWGr96dFQe1iRWq7dkpU/evK47Uhd9oAknQVd+qyP0WPfzCnwdHrW1bOcMyzrLFwZ1QIhnDb7I4OtpKOzZ1X/o2/WfFsUL2rTpedEJhlJTGIHKjk3hK0XrHJqKleZ4EHqpWB9oQ02tTuf5GZjN/piVpN6SL5daib+nlG8NBGxIZ40j+fKzsIem6Wh9K1iqXY3bUstY4CCpDdtnhTfD9EXZ3qLREPo3NyWHPEXUqCW+RnyE18sWB4prqsfFZLRMKjcLv2CEdE/u1qjwxOusRp8jOn3IeEYUtY8iOoLPllDpnpXB+Jp5V0OcdM1klA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLnWDrZ3Uz/9NQm9vYqEbfkR0n+TxZl/17+7p9Q3Lvc=;
 b=f5J9XwCgZH8jp13FAFY0AQwR72VW9p9vviFPqgk+gu6eRuNcNd1UJoPd/mv0cBPgTeEtKO1b3NRdI/TURkA08vPNWaEsugCJ8gXxDtOpZzV9ToHJr1dMxjA96j9Lh7dUKJM/mUicyOcB2A2zGslwqXDPbX6g7Tbv1wfh6jLPtCE=
Received: from BYAPR02CA0051.namprd02.prod.outlook.com (2603:10b6:a03:54::28)
 by BL3PR12MB6427.namprd12.prod.outlook.com (2603:10b6:208:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:38 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:54:cafe::ff) by BYAPR02CA0051.outlook.office365.com
 (2603:10b6:a03:54::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:16:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:38 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:32 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:07 +0000
Subject: [PATCH v4 12/22] x86/mce: Define BSP-only SMCA init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-12-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|BL3PR12MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6a837c-810e-49a4-e6bb-08ddb329bbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTVVd0ExSnRBVHNHRkE5ZTlLQWZjc3UxVWJoc005Z0JHbTh3UGMyU3dOeFFa?=
 =?utf-8?B?YWx4U0hURlgwTk1jeks4ME54NUt5WXJUT3FiMVVNMFhiQnVqcVhkYVpUWEkv?=
 =?utf-8?B?V0ZqMmFlanhCclN4cnpJamZPZkx3ei80bkZ0M205bGswRnZIZFBmN0s1RlE4?=
 =?utf-8?B?Mjl4Z05kRHR5cGx5c0FxVzFvdVE2L3Y2YzNxbUxwbXBtc3RUUDRCa0FRTjdn?=
 =?utf-8?B?MTdjbVViYVdqL0FHcUZ0TFlBdzZuZDFXMlNHU0d2NlpiQ3VYMDFWYTErZE4y?=
 =?utf-8?B?Vk1uTzNCMWNGWjdIRENBNkxJUzV2VlFKUWVZaFlURDhPamVDZEhNeGF0bVNL?=
 =?utf-8?B?aHgrRjlMRkNCWDl6amxUNE1XU2NRaUFmZzF2TU9DQjVqTE1jdEhtVy9PZHpE?=
 =?utf-8?B?aHVsNjdWL0NMRGxCVkJ5NmllU1FuSHFVZWc0TW8zNkZDUzFNdVZtdXBXTGNX?=
 =?utf-8?B?V3hzZExUYUtPMk9UL2duait3Z0hQZ01ML3hmbjRPOGxzdkd4M2RFM3BjVi93?=
 =?utf-8?B?a2tJNnhDZmlZc01TalZmMEhKeGhtcTc1NXZQTFpnVGNrOUp2L2oyQW9aeGw5?=
 =?utf-8?B?eFp3WCtwNExtZ1FzQjBVZkRaS3hGVjFWRnZTUldmYzVqUVlPSlVmSFJCQzNJ?=
 =?utf-8?B?SU9jSEZQNGcwcDVSSEV0VmxHVDRmNVp1VHN0N0VaS2lpM1FYVU1SN00vSlBR?=
 =?utf-8?B?MmlBOVpzT2RzL2R6WnJRWW80RGlEMmZUUW9nc3RhOXp3b2RzVm5pbTBYaTh1?=
 =?utf-8?B?bWMrZ1RNQitGL2JYMjRqRWxwdEszNitRVldWNktTcXZGUFBUd0loZnFEUDJx?=
 =?utf-8?B?cW1oZmp0MFRjWlVsRGdjK0hQcVdicEUwMS93TFB3RU9BWUVMcGk2Rk12NFJC?=
 =?utf-8?B?b1Z3QjBWOUJLR0hUanBZdmRJbVRlN1pTZ0tteS9JSXFORnFaQXZmcEllSE04?=
 =?utf-8?B?eXY3YzQ1Ykc4YnZIUlVXUTZleWlVZTE2VHNSL3pCcHhMM1U2eUduODQ1cjdl?=
 =?utf-8?B?NXJvai9JSTJVaUFnR2FCUVNqUGF1VndtMzZlaExjekl1b2JNR2NBcmxQekNv?=
 =?utf-8?B?aEYySjl2ZnBNUUYrT2dWZXdmMTljUmY1UzBqc3duaGRxK2lTNGJOY3p0YU1D?=
 =?utf-8?B?WHlLSy9yT29OYUlLb0RFSHFweW5Zam5IemgxMkYxQVFlOHZ6eTNJR0JTTmk0?=
 =?utf-8?B?Rjk1Z0tFU0xSS1NWR0RFZ240bGJOelFRa3pibWYxSlN6emUrNytobHFXRWtS?=
 =?utf-8?B?b1JyaHliWEJLV3VUbElzTy8raEJwdjNRRjhibDB1cDFQcENkK0FhOFBoelhi?=
 =?utf-8?B?emFmQTFEWGtSQk9NMzlHcVFLUGVnWmlWQ2JIWlRyWEwycDVUYWVUbHhtN1JV?=
 =?utf-8?B?V1V0NDA3bUQzZnhPb2xUVnNoc0I3YlFRNU1IZk9Ja0FwY2NmU0Q1SGFZYXFm?=
 =?utf-8?B?NEVDZVAxM2doSis4alRHRE5nVVBmL3pHRDZYWmZuRFlWdTl6SVpuWmVrOWc1?=
 =?utf-8?B?QTZpR21EVUlQVHY1eUVKWU8xcTVubk9VL0pmZ3NuOUpleSt6Yy9jYmdsblhP?=
 =?utf-8?B?T0NLV3hnMmJ3VHV1aU1PaXRrVHJqSFZKWTlDbFV3bDY4R1JpR3Jody96bnZK?=
 =?utf-8?B?cFhpdWpKbTBVeFRkUWhPdkRGTnYzYlRrREpWajkzWVFEcGY2TkVwWGgvVGV4?=
 =?utf-8?B?NE5iMGJuUFl2YXRiM0RpWkQ3NGpvMzdQM2dQVUFGa2tKaXlMdG9HNWdqMUVV?=
 =?utf-8?B?cHFuYVpBTWVTUWFUWTZCSE05YzIwdlBoM0tIRjlEcFJqTk5wWjFBUXFndlpy?=
 =?utf-8?B?N1l3NSt4Y3Jxb0pPbUh6KzlhVDlKNVJRR2sycmNaTE45V3BVdUJ2K0Y1bUxX?=
 =?utf-8?B?VkN5UitsNVBjYmNmNGJEM3RxVVdMd1U5ZlFya1h6U1Nkb1hOTzFNRUdQZ0Vn?=
 =?utf-8?B?aWpPNkprR01lclB6VFkzR2FueFJTWVNMZmVPVXBTRkNIU0llUWQxUTJYMkQ1?=
 =?utf-8?B?eTNkVWJNL2dZNXFsMVpsWWhqbXBMOXFGaC81b1dKWWNRaDB4TXk1TXdqdXFl?=
 =?utf-8?Q?Ah/d0R?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:38.1443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6a837c-810e-49a4-e6bb-08ddb329bbd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6427

Currently on AMD systems, MCA interrupt handler functions are set during
CPU init. However, the functions only need to be set once for the whole
system.

Assign the handlers only during BSP init. Do so only for SMCA systems to
maintain the old behavior for legacy systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-8-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * Change mce_smca_cpu_init() to smca_bsp_init().
    
    v2->v3:
    * No change.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c      | 6 ++++++
 arch/x86/kernel/cpu/mce/core.c     | 3 +++
 arch/x86/kernel/cpu/mce/internal.h | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 25a24d0b9cf9..d55c4b5f5354 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -686,6 +686,12 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
+void smca_bsp_init(void)
+{
+	mce_threshold_vector	  = amd_threshold_interrupt;
+	deferred_error_int_vector = amd_deferred_error_interrupt;
+}
+
 /*
  * DRAM ECC errors are reported in the Northbridge (bank 4) with
  * Extended Error Code 8.
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index c55462e6af1c..c852d06713ed 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2247,6 +2247,9 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
 
+	if (mce_flags.smca)
+		smca_bsp_init();
+
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
 
 	/* Use accurate RIP reporting if available. */
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 64ac25b95360..6cb2995f0ec1 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -294,12 +294,14 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	m->addr &= GENMASK_ULL(55, lsb);
 }
 
+void smca_bsp_init(void);
 #else
 static inline void mce_threshold_create_device(unsigned int cpu)	{ }
 static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_bsp_init(void) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE

-- 
2.49.0


