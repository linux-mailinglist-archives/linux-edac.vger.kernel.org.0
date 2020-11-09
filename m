Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC522AC697
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 22:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgKIVGm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 16:06:42 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:60513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730437AbgKIVGl (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 9 Nov 2020 16:06:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJSUMDxBuG0VKr+cnUZE8GxmJcxOwQdUd9Y2LrqC1KDxkg5XnQb10H2lJtcWCZRmHC2kUd8pa6zjMbHBdeyY3Ray2qjBPn9q+h9E/gJe+UqMnLvZcGHHoD+4wQYQ1qSSrxWV97VNkqj5746lVMBxbdkHrLnT/hd2ZTr9UNbQV15VJaN9xVyNlT7hNjnr05fet+Ozh6lyp9sRB4l7Z/wBdoArFf+8Zfigldcq6FRxykGPMxlGZ6HOsqx5qzzJTQfszrWqblIC/Jh6oPV8pznUkzCmUsa/CW8qauus/fPytX4XVML+g9u70GE77LQ2LxuUyBwsCa/ygcraQNmX/rlOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/EO/qxkJf/mFnETHxF1BxGeU3jz5YqdRdCjBe5jH3U=;
 b=Wp9NA7ZIvqf2AH3DZbOPV3/VyhgDARpfyx/f0W+FZuV3I1LGfVyBYscLdXU01wK3M5VFfNrFSSmaQ/HrddTbjwdk6fqjEuYxsr1HZT8Hj6xLitlgHhuH1MUAj9KMKuTd8NE8CqI2ug4Lk80MeSoEHJUReIBT6mItd4G5K+IVCwnewyCfGr/IbQDOkb9yd/YxMwZHbdqTWl/0xlkwft1dAMXa8IMbIUOjzSqeWYC/kpLltoQOEzQsKzhT8Innsg5k/AuO4eh6Io4XhPCg8idKixpC+BQO8wHeE03aVgVg4wPyUMUXqGKeaiXTNP2AsesXbdRYN4BheVLHm6TLR4d4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/EO/qxkJf/mFnETHxF1BxGeU3jz5YqdRdCjBe5jH3U=;
 b=NhAirBlWRrMaHTDUCoCShNG1g/xiGEza0lLodx5Sn2eRYs7YJqD13HL2YCZA0Iqm1l9jeJrY8bfhIINnoCE/13DKGjB7IZStoLf54qzWOQCqZlKp0n26+pFozLnUP66xSV3xvh8tzt8PT7hV+2mr6+MUZrf4/0LgKk4uAs6YrXk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2979.namprd12.prod.outlook.com (2603:10b6:408:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 21:06:33 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9df4:880c:f3f2:679d%5]) with mapi id 15.20.3541.025; Mon, 9 Nov 2020
 21:06:33 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     x86@kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org,
        Smita.KoralahalliChannabasappa@amd.com, linux-edac@vger.kernel.org,
        puwen@hygon.cn, kim.phillips@amd.com, thomas.lendacky@amd.com,
        wei.huang2@amd.com
Subject: [PATCH 2/4] x86/CPU/AMD: Remove amd_get_nb_id()
Date:   Mon,  9 Nov 2020 21:06:57 +0000
Message-Id: <20201109210659.754018-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
References: <20201109210659.754018-1-Yazen.Ghannam@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR12CA0064.namprd12.prod.outlook.com
 (2603:10b6:3:103::26) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-ethanolx.amd.com (165.204.78.2) by DM5PR12CA0064.namprd12.prod.outlook.com (2603:10b6:3:103::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Mon, 9 Nov 2020 21:06:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c8799821-83d6-44bb-ca4d-08d884f355f1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2979:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29793113197562686A5D7376F8EA0@BN8PR12MB2979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvgkPghbiZDhzdoUa7eCLNzPq6s1LnInkhrvW9o/dD8US9T9UvIQ+aZRxwxlibmGLvdG4E+pZv2GE2/aM6eeVEysNcFQ196o17kbVZ2rEnBBM0Neio1Czng+WeVWXTSBo+Ht616OAPFGeMr5jLCMKFWKbW4aAoTQu37tYhdUT7LwiQzGQS4fpSOlZkIoVi/WTzWLKKMw5k6Z2gB0NuacVtRKSh159oj/kcHfADUD4sLDpRpVq/kV89DBsxxj7Tq5bgskILifGdtRYHpGvDTzaRD2RfeBQ9PDwkOvwVLS4zOo6YPjYgpxGmopFwpjTfVCqrzqNqEyWhWit3gC27rR4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(6486002)(26005)(66946007)(5660300002)(186003)(16526019)(4326008)(1076003)(8936002)(2906002)(83380400001)(66556008)(66476007)(6666004)(36756003)(478600001)(86362001)(316002)(6916009)(2616005)(8676002)(956004)(52116002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5lN6nZkJrMgipvDVoPwy4lZusBDVQtArbA/lDQF0W9hgZVklRUtljbklxXBo8/GNE0/65KaLPK8QYykP43TuPFSUcLLLVsyDs+f8OxzLB7X02gc0oCmwYgXcny3aJ65y+Py9Z6uIS6b3KFDI0CCGIHdXFKkiSKHb2fLPZuhlYE503Q5iWhAmS0mMjMCs6qyfZICDzGrLQTbzBlgfVHX7b3SLG6hx3ahMWaeePLZDZcE5Cq92F6E69CTcNd4pGRrrqv2JEobodro74mPlRKxh7eItYWJJ8r/RVBUt9zjfDtB0q42UsNyodBWrKTdGB7lP89ZO9TEF7q7olTzHNDLqeRFSkGfpbtuHkh86RDA1uG5/F0q8kO/IHJZ8QlyEN//ssJ8SuhaANWqMyylNwlyTjDGfFE+WtlpjwuxJ95COwVKHUw9tfuiLijw7sxmloMgAqJZCmOCYmUsPTUe6EOt4pSfVDGkhlZFDbF10GXQdBIwAhH8u5IKucwXXaduK+FtNmM+hacKZgP01IIoIOK+kkL00I33V2jXw1rtmxSBcz56Q4ZRpJrh50Q1JL4JZ8srw/sGgpFBYrrkh3nsB/Uh0Wkc+LhYG/5EWaDJmx92E7VEb/ygRlaQnUQVcM6i7EoCX7C+k73maQ0/AFZ79C8ghoQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8799821-83d6-44bb-ca4d-08d884f355f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 21:06:32.9982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEjhzMrvkVSPhuMuEsBljoxUwvfswzVfFuB97C5eUCh5/4/Gm5cUp2k3QkC+4iE3XNMz47SoEuAnE/K7AwYR7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2979
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Last Level Cache ID is returned by amd_get_nb_id(). In practice,
this value is the same as the AMD NodeId for callers of this function.
The NodeId is saved in struct cpuinfo_x86.cpu_die_id.

Replace calls to amd_get_nb_id() with the logical CPU's cpu_die_id and
remove the function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/events/amd/core.c       | 2 +-
 arch/x86/include/asm/processor.h | 2 --
 arch/x86/kernel/amd_nb.c         | 4 ++--
 arch/x86/kernel/cpu/amd.c        | 6 ------
 arch/x86/kernel/cpu/cacheinfo.c  | 2 +-
 arch/x86/kernel/cpu/mce/amd.c    | 4 ++--
 arch/x86/kernel/cpu/mce/inject.c | 4 ++--
 drivers/edac/amd64_edac.c        | 4 ++--
 drivers/edac/mce_amd.c           | 2 +-
 9 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 39eb276d0277..2c1791c4a518 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -538,7 +538,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = amd_get_nb_id(cpu);
+	nb_id = topology_die_id(cpu);
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 60dbcdcb833f..a411466a6e74 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -815,10 +815,8 @@ extern int set_tsc_mode(unsigned int val);
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
 #else
-static inline u16 amd_get_nb_id(int cpu)		{ return 0; }
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 #endif
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 18f6b7c4bd79..b4396952c9a6 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -384,7 +384,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link = node_to_amd_nb(amd_get_nb_id(cpu))->link;
+	struct pci_dev *link = node_to_amd_nb(topology_die_id(cpu))->link;
 	unsigned int mask;
 
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -398,7 +398,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb = node_to_amd_nb(amd_get_nb_id(cpu));
+	struct amd_northbridge *nb = node_to_amd_nb(topology_die_id(cpu));
 	unsigned int reg;
 	int cuid;
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 2f1fbd8150af..1f71c7616917 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -424,12 +424,6 @@ static void amd_detect_ppin(struct cpuinfo_x86 *c)
 	clear_cpu_cap(c, X86_FEATURE_AMD_PPIN);
 }
 
-u16 amd_get_nb_id(int cpu)
-{
-	return per_cpu(cpu_llc_id, cpu);
-}
-EXPORT_SYMBOL_GPL(amd_get_nb_id);
-
 u32 amd_get_nodes_per_socket(void)
 {
 	return nodes_per_socket;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f9ac682e75e7..3ca9be482a9e 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -580,7 +580,7 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 	if (index < 3)
 		return;
 
-	node = amd_get_nb_id(smp_processor_id());
+	node = topology_die_id(smp_processor_id());
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0c6b02dd744c..e486f96b3cb3 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1341,7 +1341,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(amd_get_nb_id(cpu));
+		nb = node_to_amd_nb(topology_die_id(cpu));
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1445,7 +1445,7 @@ static void threshold_remove_bank(struct threshold_bank *bank)
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb = node_to_amd_nb(topology_die_id(smp_processor_id()));
 		nb->bank4 = NULL;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3a44346f2276..7b360731fc2d 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -522,8 +522,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(amd_get_nb_id(cpu));
-		cpu = get_nbc_for_node(amd_get_nb_id(cpu));
+		toggle_nb_mca_mst_cpu(topology_die_id(cpu));
+		cpu = get_nbc_for_node(topology_die_id(cpu));
 	}
 
 	get_online_cpus();
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3bac76efd3f6..4e36d8494563 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1133,7 +1133,7 @@ static int k8_early_channel_count(struct amd64_pvt *pvt)
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = amd_get_nb_id(m->extcpu);
+	u16 mce_nid = topology_die_id(m->extcpu);
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3038,7 +3038,7 @@ static void get_cpus_on_this_dct_cpumask(struct cpumask *mask, u16 nid)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (amd_get_nb_id(cpu) == nid)
+		if (topology_die_id(cpu) == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7f28edb070bd..85095e3902ec 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -869,7 +869,7 @@ static void decode_mc3_mce(struct mce *m)
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = amd_get_nb_id(m->extcpu);
+	int node_id = topology_die_id(m->extcpu);
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
-- 
2.25.1

