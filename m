Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7585A25C9E0
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgICUCd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:33 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:19073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbgICUCD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObtZan7ba4g5Yb1ASK4tbLv1eVrWYKJ19tO05R+/xyQukaaTarBEIoqQ8Af8a+WwsphtC/7vc31zuI1fDRxJbLwHhmn4JYFVbT6Ml5mRTzsTvyXS71Be+xh5iMZ7c0xYNrcV82+OyjjJXVpKQoYXXF/y1gqUWlu04cB/oGMs95Pr9B8GcmG5RWiGHAUK4yNoq9aAy8an3IoSL7wq8YVoXYoZZZvbsb8BNcV52fLSI0y5wzqwb1lJGVgq7+LGwsxz59egaWmVzO860QJy+5usGU0+og7Xjqhz3Idoc7pQcyovPzoX3RyFfFL552SXmiSE6pN6nYYvSCCEIIq0LWVTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlNB6+cRTOzXSBhVjU/odH9YcsyfA1V61hCli+LR7IY=;
 b=WXntHP6MyU1W9o/X3Sfbhm5RoR3DYcCwgR0g77u1hKHkl+xa3Fqef4jZFH0ZeWqtswRhz5KmCZxD561IDuDV20cMtcrb7OfE+Qh0xIPxCBMObSd6RkX2dfUOrMHQDRjanUAxFIeFGEwPrnn+ua0M31q1T65+lCfHwQcUeBrN0iBjKCgZgETLcJKajJTdvbwz4FB/5n162hxFCRVMas5ad8Q2XQB1APQrrh1AzoNXFWTfqp9OnwiJMNJMtlAVnJCLKtzeYEh4k3RhCm7fyA33UqPkpMDDK5d1ubsU+brEwn1GQu5Jb52QQ8I4h54MpXaiQW3UjNeW36ZwJch9wvYiFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlNB6+cRTOzXSBhVjU/odH9YcsyfA1V61hCli+LR7IY=;
 b=NPkU5MzltQoPC1YT6azdyYCEnhiMoNI9s6ncDXIXcYWlsBLEuN45R8xi+xu6xNDRIhhRui2DCvAiEEo46RfpsSrMAC7CISzxmnXILTNeZQCwFB/Mu9CA8jZKys30Zvxj+UMRAI/YNDR3x+5ety7d+ajLP29VF5ezhPkX80moALg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 20:01:49 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:49 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 1/8] x86/CPU/AMD: Save NodeId on AMD-based systems
Date:   Thu,  3 Sep 2020 20:01:37 +0000
Message-Id: <20200903200144.310991-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
References: <20200903200144.310991-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0075.namprd05.prod.outlook.com
 (2603:10b6:803:22::13) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:48 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7d80000-9f3f-4ac5-f58a-08d850443175
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2980C342D25B525A21E20A1DF82C0@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82kcrTDGvd5aXrccyuxEAusbz1zcsxMIn3qjdh8QLOnoWXphvD1/PxUkwZ1gewoya8/+nY76J8wfb6CJeqZjgGJP3tgj6ULXHqP51V5/Q14aBLlo/Ib5dyhDDcTIDCkPsSOYsXGNfjmPE9GkUN4w2QvCFhzJg2Tz+L6u8om+t6cf5nzeQBQ3RpgME800UN3mPJ2tyk1MGvuCKSOO1bOB+MIiSa24Qb9l8evJ6sc99m7K9vjWRGGcsHe600AOEt+GSxGaCsaO8YogOuPwHBBoz/VUUCgGhtZ33IQRVdvhMJLKm69MROQrnctceb5CPW02NZb5c3kxNmoktMY9IccCXrwN9f5khb/GKYbLY1ikCVEXxAa1jmsMoptc+MMb6NRIDm7R9hQepKJluRqH5B7nBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(966005)(83380400001)(8936002)(316002)(1076003)(186003)(16576012)(52116002)(5660300002)(6666004)(66946007)(8676002)(6916009)(86362001)(6486002)(2906002)(2616005)(36756003)(66556008)(66476007)(4326008)(478600001)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h7nTNLIrZUmB4M/r94ZNjca/Gi1iLWSFRULAYno7+KDRbCa8XHEOGQKBALN/UJlJ1gzi1waQz9ktlGcDsf9rD0wMX+/y8dhNVdXM6iAnuoPum60520sUzwMkcKk5o4Fpc5Kj13uO+i5Y+dTH5e0asumg9OpvJ1eVULMabWiHnSFd8LSlr5RhlqGUiIBn4BlDJJohlmV+nV9arY1lovOC95/qd85TA2nMQKPhpjUmV83RDADj7UalXGNlpoR0WcCT1CDmB2EFWhHe5BND06uZ47oL4oIUhwrm3kaIhtCaCKgUE0yqUkOTZJmNd8u1CLsplEDXgCBQ+Gc5uj+pBnQA56EZr35y0+l6SMkABjgkZgVLVCXWlqeOVsqBjrP84NQhgqbYoKXIOC1Wz2oQPV2/+bXJQB8EhZPsLEVWAjU34tnQPZ6BttrJrPfmy9FBkliurLx9NL7tMZ7FOqgk6x7JGyLPt8Pds7AwKS7AW7K110rjfVrBI5Ayw3oa7BVA/+G99v4icEfwJDF3IdYGUO0EXe+ntD05Vco5yU2fvt0AJW1UmO0Bx0v6E64QeWVcaMbwZuxvj76aVFsYAghONGW5zJgLjsxviPlY3v7XhKo8W/v1NE5zbP0ESbrfBGpF1c/WlciAIT8WBegRgnuJK3/q4w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d80000-9f3f-4ac5-f58a-08d850443175
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:49.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOEdTlK/BEK51yuRnF4u6nZIM/52wO5MveflWf+S4Dcy71VKATWc8fY1eBrkWdtJmG0plGFR1pIsGvKhqnXABg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems provide a "NodeId" value that represents a global ID
indicating to which "Node" a logical CPU belongs. The "Node" is a
physical structure equivalent to a Die, and it should not be confused
with logical structures like NUMA node. Logical nodes can be adjusted
based on firmware or other settings whereas the physical nodes/dies are
fixed based on hardware topology.

The NodeId value can be used when a physical ID is needed by software.

Save the AMD NodeId to struct cpuinfo_x86. Use the value from CPUID or
MSR as appropriate. Default to phys_proc_id otherwise. Do so for both
AMD and Hygon systems.

Drop the node_id parameter from cacheinfo_*_init_llc_id() as it is no
longer needed.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-2-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch based on review comment to save value to struct cpuinfo_x86.

 arch/x86/include/asm/cacheinfo.h |  4 ++--
 arch/x86/include/asm/processor.h |  1 +
 arch/x86/kernel/cpu/amd.c        | 11 +++++------
 arch/x86/kernel/cpu/cacheinfo.c  |  6 +++---
 arch/x86/kernel/cpu/hygon.c      | 11 +++++------
 5 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 86b63c7feab7..86b2e0dcc4bf 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_CACHEINFO_H
 #define _ASM_X86_CACHEINFO_H
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id);
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 97143d87994c..a776b7886ec0 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -95,6 +95,7 @@ struct cpuinfo_x86 {
 	/* CPUID returned core id bits: */
 	__u8			x86_coreid_bits;
 	__u8			cu_id;
+	__u8			node_id;
 	/* Max extended CPUID function supported: */
 	__u32			extended_cpuid_level;
 	/* Maximum supported CPUID level, -1=no CPUID: */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index dcc3d943c68f..5eef4cc1e5b7 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -330,7 +330,6 @@ static void legacy_fixup_core_id(struct cpuinfo_x86 *c)
  */
 static void amd_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -340,7 +339,7 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->node_id  = ecx & 0xff;
 
 		if (c->x86 == 0x15)
 			c->cu_id = ebx & 0xff;
@@ -360,15 +359,15 @@ static void amd_get_topology(struct cpuinfo_x86 *c)
 		if (!err)
 			c->x86_coreid_bits = get_count_order(c->x86_max_cores);
 
-		cacheinfo_amd_init_llc_id(c, cpu, node_id);
+		cacheinfo_amd_init_llc_id(c, cpu);
 
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->node_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->node_id;
 	} else
 		return;
 
@@ -393,7 +392,7 @@ static void amd_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->node_id = c->phys_proc_id;
 }
 
 static void amd_detect_ppin(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 57074cf3ad7c..81dfddae4470 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -646,7 +646,7 @@ static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 	return i;
 }
 
-void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
@@ -657,7 +657,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 
 	if (c->x86 < 0x17) {
 		/* LLC is at the node level. */
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->node_id;
 	} else if (c->x86 == 0x17 && c->x86_model <= 0x1F) {
 		/*
 		 * LLC is at the core complex level.
@@ -684,7 +684,7 @@ void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
 	}
 }
 
-void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu, u8 node_id)
+void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu)
 {
 	/*
 	 * We may have multiple LLCs if L3 caches exist, so check if we
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index ac6c30e5801d..604b0315211a 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -65,7 +65,6 @@ static void hygon_get_topology_early(struct cpuinfo_x86 *c)
  */
 static void hygon_get_topology(struct cpuinfo_x86 *c)
 {
-	u8 node_id;
 	int cpu = smp_processor_id();
 
 	/* get information required for multi-node processors */
@@ -75,7 +74,7 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 
 		cpuid(0x8000001e, &eax, &ebx, &ecx, &edx);
 
-		node_id  = ecx & 0xff;
+		c->node_id  = ecx & 0xff;
 
 		c->cpu_core_id = ebx & 0xff;
 
@@ -93,14 +92,14 @@ static void hygon_get_topology(struct cpuinfo_x86 *c)
 		/* Socket ID is ApicId[6] for these processors. */
 		c->phys_proc_id = c->apicid >> APICID_SOCKET_ID_BIT;
 
-		cacheinfo_hygon_init_llc_id(c, cpu, node_id);
+		cacheinfo_hygon_init_llc_id(c, cpu);
 	} else if (cpu_has(c, X86_FEATURE_NODEID_MSR)) {
 		u64 value;
 
 		rdmsrl(MSR_FAM10H_NODE_ID, value);
-		node_id = value & 7;
+		c->node_id = value & 7;
 
-		per_cpu(cpu_llc_id, cpu) = node_id;
+		per_cpu(cpu_llc_id, cpu) = c->node_id;
 	} else
 		return;
 
@@ -123,7 +122,7 @@ static void hygon_detect_cmp(struct cpuinfo_x86 *c)
 	/* Convert the initial APIC ID into the socket ID */
 	c->phys_proc_id = c->initial_apicid >> bits;
 	/* use socket ID also for last level cache */
-	per_cpu(cpu_llc_id, cpu) = c->phys_proc_id;
+	per_cpu(cpu_llc_id, cpu) = c->node_id = c->phys_proc_id;
 }
 
 static void srat_detect_node(struct cpuinfo_x86 *c)
-- 
2.25.1

