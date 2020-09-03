Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632A325C9D6
	for <lists+linux-edac@lfdr.de>; Thu,  3 Sep 2020 22:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgICUCA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Sep 2020 16:02:00 -0400
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:19073
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgICUB4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Sep 2020 16:01:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZ3Lz6K8XhfriA7YYA2Rq5Pz/gvksA3XC2EG26m1TjO0y0HhEk/Y4VfgJ6LwGG7y8f1xgzC7625XWBVJYI1XEWUEeiWvttfaIaeIGz/eFcRj6JnatVlNmeVfGcIIh2XuQBMJEhSca1FIcJRyM8EU6JQyVYBByIkO26jhlqR9kymLdHNu8p+WgmCwFQLElZ1OgaavEn2kIz6jSTl5/VwFTu/bYo0IiraO+TDbAgFksv/puXrBbp/xc4CrrQGPX6AIlyGvSAlOZmB7LWTpHEylZmLrseAU3yQQpcXc/BIwXMu234lhZjE475ez/HqpHEt2NfvUMWPBUMxwz18KAVaMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCl68feaXsAhu6E5Ks6OlNOvp6IWa0leYKgs7KR+jsE=;
 b=n0otDBGS7eKP8vC0IZedlCduvD2v7VK+Pk96DNRBuleXifLz94T5X2qeVtR40vGtkQKEg00E0tHLvWAhYj0mE1QrFdMXS9Yvaneem9xmZ1TdU/xwNLJZhHBCpSmWAZid+fWV+93VG86rKF2VirAwDyXlydfQqjwg+/CeEZ3san7B172YUexF2Fh4V/dLRbTfxJIWEI76DpMRLw5FAqfpQuA+C9ctMl+iqqZPgrWAfZzIwZsR8neQ36ANNL4Xv9Rq/EJuvxBol5fXOu1oaXMuj9DcMFVpCMujlClSuZgJOuPHlGZwbgCLHhLgK0GcyTbf+wS64lQd/ktskjHvcPGHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCl68feaXsAhu6E5Ks6OlNOvp6IWa0leYKgs7KR+jsE=;
 b=0pttzdTQQvzK1LpDNgCZcwARUGmMUu0it+Of4YWplqMkK8Okju1AUaxOIagkhPFKGSC1I9Cyh9SxcbZCcQmiirAcSkc0AKyXjT1cT28BGGkNPB6YGbGwhEun7P5zRs/8ivZkXgx4obV1j9s/WB4pvZQZSvfeP0/bJABTTePI37Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BN8PR12MB2980.namprd12.prod.outlook.com (2603:10b6:408:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Thu, 3 Sep
 2020 20:01:50 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::b038:2a58:64e0:2a3e%4]) with mapi id 15.20.3348.015; Thu, 3 Sep 2020
 20:01:50 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: [PATCH v2 2/8] x86/CPU/AMD: Remove amd_get_nb_id()
Date:   Thu,  3 Sep 2020 20:01:38 +0000
Message-Id: <20200903200144.310991-3-Yazen.Ghannam@amd.com>
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
Received: from 255.255.255.255 (255.255.255.255) by SN4PR0501CA0075.namprd05.prod.outlook.com (2603:10b6:803:22::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.7 via Frontend Transport; Thu, 3 Sep 2020 20:01:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fd97985-1e4a-40b6-f10b-08d8504431f1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2980:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB29807D4DBE980991427C8FD6F82C0@BN8PR12MB2980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x579Sq6VM5tgDVqHocFwzfVslXEGtU8Iyx4YzjtwVTZodhGjbTD543pFeULHqA7p3VsrffLvJk7HDN7DlfCxl5xGeLRcvj6fnWKc3ocGenlB8KwJZ4Ko26IbOlqMEt8zHzIacoCXRe4PwJ5jODsI3Pm4cAYop5YjHzOfE6PI8wtDuLJJ7mpzbuTpYu6uSG8HZZF+A4jY739JcHQ4ZimSmtu9YqC7hbYnutKyxKQ4wtUxrkrbG+DVfu5EuCM/HzfHKve2akRMmOLCahqTDCDGYaCTwMwZWx4MEx5FROaCkS1FKGNnOQUWOm5qTYUIGTgyNY21g4IbI6cryzC6/8IArsSdCeGhoqTYL12qoHbCjPAXns2b7e2p67fBL3MRBhwwOhkFgoWGkkUp5daw2Es9JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(966005)(83380400001)(8936002)(316002)(1076003)(186003)(16576012)(52116002)(5660300002)(6666004)(66946007)(8676002)(6916009)(86362001)(6486002)(2906002)(2616005)(36756003)(66556008)(66476007)(4326008)(478600001)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WQf8QZ3FcYxeRR1vZDNRJMRLgQz0K3GNMH+UrMcGaSVPxZqF0k90HeZY5gYF9mTBuOcOKyNuD4VPwdWkqMcEr9KY8+9cP7bOaXV40RQlm9cx22ssqRpu3RJQI2cQE4/PDosrga5uowJP7v+1X7paRpiNMEKWzMO4nge9SdGjOzCPXnL6zuV3CrwaqSmc2ojv8h4hTCwssjMA8/TW26aFYnRORPDLcxbrdHHl9dfsJDMEXckDcF+39U7gXQ65+0Y/OkpWd4xol+u3j7qGwPl2cUopxyaq7y/05EAbKBK2Ek+8es0SIS1MiomI4TBgeg7yseDBjVWBNcI9H5izfvpZuNKC0X7SLWBF+2jSUZKHp64cFyjAO/AeqJ/newIv1VKhJLbeCtbWfkeUYoIMD8AxgpfTBDYqsHVXeyPC4PigN2H41KOi7qiRROoP/31DSKDlfLpD58YtPHozFiE3H6KqVN+xo43Qz79w51ueXwuoDB8qpSRXW+5liTzWZD5munvwHPoKn7Wj+is0maBUeSJW+8N4VLAXWr69gSsi/6CADNxynS8rp32CDf4Y+KgITfN9khkoyLxHf0b/KYhHWNvsMzGLuyCgQZz0uUHNu+HS6+WofWM9LGhNuTKsAeX7XNR2Y9uYcfKGGs4XK0YL90SIWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd97985-1e4a-40b6-f10b-08d8504431f1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2020 20:01:50.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge6Dz5OjkTftm4jTbzPoasQQPqE8caNMaJduPLT2s/CKCzo/J2hxgdj4VHvB/hQ6xvZrBLNXWi+AITF1iL93gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2980
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The Last Level Cache ID is returned by amd_get_nb_id(). In practice,
this value is the same as the AMD NodeId for callers of this function.
The NodeId is saved in struct cpuinfo_x86.node_id.

Replace calls to amd_get_nb_id() with the logical CPU's node_id and
remove the function.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20200814191449.183998-2-Yazen.Ghannam@amd.com

v1 -> v2:
* New patch.

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
index 39eb276d0277..01b9b943dcf4 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -538,7 +538,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	if (!x86_pmu.amd_nb_constraints)
 		return;
 
-	nb_id = amd_get_nb_id(cpu);
+	nb_id = cpu_data(cpu).node_id;
 	WARN_ON_ONCE(nb_id == BAD_APICID);
 
 	for_each_online_cpu(i) {
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index a776b7886ec0..408977a323d3 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -871,10 +871,8 @@ extern int set_tsc_mode(unsigned int val);
 DECLARE_PER_CPU(u64, msr_misc_features_shadow);
 
 #ifdef CONFIG_CPU_SUP_AMD
-extern u16 amd_get_nb_id(int cpu);
 extern u32 amd_get_nodes_per_socket(void);
 #else
-static inline u16 amd_get_nb_id(int cpu)		{ return 0; }
 static inline u32 amd_get_nodes_per_socket(void)	{ return 0; }
 #endif
 
diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 18f6b7c4bd79..2bd8abdbed8e 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -384,7 +384,7 @@ struct resource *amd_get_mmconfig_range(struct resource *res)
 
 int amd_get_subcaches(int cpu)
 {
-	struct pci_dev *link = node_to_amd_nb(amd_get_nb_id(cpu))->link;
+	struct pci_dev *link = node_to_amd_nb(cpu_data(cpu).node_id)->link;
 	unsigned int mask;
 
 	if (!amd_nb_has_feature(AMD_NB_L3_PARTITIONING))
@@ -398,7 +398,7 @@ int amd_get_subcaches(int cpu)
 int amd_set_subcaches(int cpu, unsigned long mask)
 {
 	static unsigned int reset, ban;
-	struct amd_northbridge *nb = node_to_amd_nb(amd_get_nb_id(cpu));
+	struct amd_northbridge *nb = node_to_amd_nb(cpu_data(cpu).node_id);
 	unsigned int reg;
 	int cuid;
 
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 5eef4cc1e5b7..846367a69c4a 100644
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
index 81dfddae4470..8e34e90bb872 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -580,7 +580,7 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *this_leaf, int index)
 	if (index < 3)
 		return;
 
-	node = amd_get_nb_id(smp_processor_id());
+	node = cpu_data(smp_processor_id()).node_id;
 	this_leaf->nb = node_to_amd_nb(node);
 	if (this_leaf->nb && !this_leaf->nb->l3_cache.indices)
 		amd_calc_l3_indices(this_leaf->nb);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 0c6b02dd744c..be96f77004ad 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1341,7 +1341,7 @@ static int threshold_create_bank(struct threshold_bank **bp, unsigned int cpu,
 		return -ENODEV;
 
 	if (is_shared_bank(bank)) {
-		nb = node_to_amd_nb(amd_get_nb_id(cpu));
+		nb = node_to_amd_nb(cpu_data(cpu).node_id);
 
 		/* threshold descriptor already initialized on this node? */
 		if (nb && nb->bank4) {
@@ -1445,7 +1445,7 @@ static void threshold_remove_bank(struct threshold_bank *bank)
 		 * The last CPU on this node using the shared bank is going
 		 * away, remove that bank now.
 		 */
-		nb = node_to_amd_nb(amd_get_nb_id(smp_processor_id()));
+		nb = node_to_amd_nb(cpu_data(smp_processor_id()).node_id);
 		nb->bank4 = NULL;
 	}
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 3a44346f2276..ba491134c326 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -522,8 +522,8 @@ static void do_inject(void)
 	if (boot_cpu_has(X86_FEATURE_AMD_DCM) &&
 	    b == 4 &&
 	    boot_cpu_data.x86 < 0x17) {
-		toggle_nb_mca_mst_cpu(amd_get_nb_id(cpu));
-		cpu = get_nbc_for_node(amd_get_nb_id(cpu));
+		toggle_nb_mca_mst_cpu(cpu_data(cpu).node_id);
+		cpu = get_nbc_for_node(cpu_data(cpu).node_id);
 	}
 
 	get_online_cpus();
diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fcc08bbf6945..3f91cac00fb2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1133,7 +1133,7 @@ static int k8_early_channel_count(struct amd64_pvt *pvt)
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
-	u16 mce_nid = amd_get_nb_id(m->extcpu);
+	u16 mce_nid = cpu_data(m->extcpu).node_id;
 	struct mem_ctl_info *mci;
 	u8 start_bit = 1;
 	u8 end_bit   = 47;
@@ -3046,7 +3046,7 @@ static void get_cpus_on_this_dct_cpumask(struct cpumask *mask, u16 nid)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		if (amd_get_nb_id(cpu) == nid)
+		if (cpu_data(cpu).node_id == nid)
 			cpumask_set_cpu(cpu, mask);
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 7f28edb070bd..ac9bd74c92cd 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -869,7 +869,7 @@ static void decode_mc3_mce(struct mce *m)
 static void decode_mc4_mce(struct mce *m)
 {
 	unsigned int fam = x86_family(m->cpuid);
-	int node_id = amd_get_nb_id(m->extcpu);
+	int node_id = cpu_data(m->extcpu).node_id;
 	u16 ec = EC(m->status);
 	u8 xec = XEC(m->status, 0x1f);
 	u8 offset = 0;
-- 
2.25.1

