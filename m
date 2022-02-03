Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4904A8ABB
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353142AbiBCRuh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:37 -0500
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:46400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353109AbiBCRuc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3VEj3ojgzaJttz5/Hcmd5+1LOUcWkS10VxKsCq8DTjCYSaIldJzd1FZS56r6a4t59iGAmWQguOKRCfOWQOJ5ztTCpHCd9hfIi8Jvfb8DHoRUfSlo/NizTnbJWF1Yv2mCRba6ZtgVgrUu9NnJUxk66o6mzM+GKLwuubpzL+/AqsngZSZnb/vxJtAu/OYJQFTcn6QQSbfqBuPoInCQ0chpJIWl3/4meWGdh5DCeMVCHe4acFKmxOySe5hWi6+i8VKWRRqllnKKP54PHYBk8ISzdxHJ5b6LqJ/zy2U6Nbe4oi8QE1HnWJNYz8hQsohw7rLrlfoWtGI0RAFkFGEuvpmwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ct3QQGUsasie34WZF5anFTsDWa9ajs5XFZ3BhYLKrsk=;
 b=Nl0nTGXHNRLO1etGLWOlhpPQ+SPrrvPYZHfvT1ZkRU9TwkGjMtf12gsnX5Mx+p8KFGF4C3ss+qkwn9J8chZwCiP0ePPyYVCyTMBVCw5F7EHpl1T4AHF6jkma3qSMbolhnbI9/9ecnCeAmteVuw+XH9+S1fFKIv+JBRZNLlmiAsG5e7CQ3AjbeUyXhrpgyUu9kTF3EO0lKtO3Rbk0Rx/TrWfQyD6OH+Q/9T6h333Hl0Nr5Zi9y6kxLzcscMoRVZny9hY0wXGfjGwK/SgtiazptIXcvV0GojMpN6igZCyXlasSl36NTWg7UMm5kcY4cZiFPe3a2Uzv9a2H9TzWrXkmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ct3QQGUsasie34WZF5anFTsDWa9ajs5XFZ3BhYLKrsk=;
 b=IS2GMIuV9ZqNJ6lyqYnB30BzZqtOcDWOcgo381kWwnzhLZbIZY8QkbSI6SHkcPSHeChx2aY8ikzGTRPwoUSb7TVdvb2ILqMFUiv4hlw9l5F+G+i5H8hvWp3Ys3sXvdjBFOvWZVCsTKc+YPOR+3bP5aKDiFY8uWsgHMiyG9o0+mo=
Received: from MW4PR04CA0322.namprd04.prod.outlook.com (2603:10b6:303:82::27)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:30 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::29) by MW4PR04CA0322.outlook.office365.com
 (2603:10b6:303:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:29 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:26 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v7 07/12] EDAC/amd64: Enumerate Aldebaran GPU nodes by adding family ops
Date:   Thu, 3 Feb 2022 11:49:37 -0600
Message-ID: <20220203174942.31630-8-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f00c3aa-a118-4b2a-cb0f-08d9e73dab37
X-MS-TrafficTypeDiagnostic: CH2PR12MB4168:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4168DEF226F7D6107F384527E8289@CH2PR12MB4168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fu7z+sCzdoY3pgyj0aEH1yKm7ArVvzTNxHqE8CxLxpCyJXIVXBKmlxJB57JVHsrVjgJ/SRsicXYWtcElSbHGZwBZkqJJ0bQU734RCLdM+xeyzcSZ+Vt1LUVZ9BkGVt/XP7S53r8xwWKATYMTyGMkDXAJLj5omP49Kr4FDQiyJRi+Yc6V0h8iEX2pQv7sguYsy7Qz0VTdjNj2vWTiizr2P+tS5tZIZP3hOR7BrrTF5gfBp9Ufjm97rnAffRnK+L6GHf45HQ5J1eO1P1wMjyHLTwULQIb7BmhWdmzpgxQXrvFfaQkM//p5kqwat168j3fG2DkrdbplzlNkNF1JCvDKZpmj2rGRbAp1BLngm/KjMxCMIkoe/tMgySlrb3o7ZRTGv+cCxIFvd6RzrpzMdM3ilyfIl/8iU+G6wImnJpLTUgfC/Wsc7e7tK8BlfkZ3sFzwHcKUsIm+8WjEZz7peS16GqFvcpj/bjxnetIxkqv6LSo1VwX9RAThAa41IG2EWfGL/6MTOrK9sL82ys/aKBBoYuZXanckQraWDSCkIoODqjHWnVYjWAjj1jFmuYHHttfzrKuzXJn01r7WTtccgSddd23yixUuG7wSrLUEOR8TW0VezgL4VB3hpwJL9/6VwxGg8bxxnHVyoPO4nlzIuOPcWdzGLMLTuPzaO73dnUctQ8Si5hhbjyrqkRemfs6cbKO6VxbtQSU559se6P+hjkH+TPHK0WMV8TKCE1KrKy2pvVuHwXLj1zq6NLEN0l9fR7y8D7l2x0giWkSBjxWJsrZu5asMkKRvSemziC+IgtH1gL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(36756003)(508600001)(7696005)(81166007)(8936002)(5660300002)(4326008)(6666004)(8676002)(36860700001)(356005)(2616005)(2906002)(1076003)(26005)(336012)(426003)(186003)(82310400004)(40460700003)(30864003)(83380400001)(316002)(110136005)(70586007)(70206006)(54906003)(966005)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:29.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f00c3aa-a118-4b2a-cb0f-08d9e73dab37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On newer heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
are connected directly via custom links.

One such system, where Aldebaran GPU nodes are connected to the
Family 19h, model 30h family of CPU nodes, the Aldebaran GPUs can report
memory errors via SMCA banks.

Aldebaran GPU support was added to DRM framework
https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html

The GPU nodes comes with HBM2 memory in-built, ECC support is enabled by
default and the UMCs on GPU node are different from the UMCs on CPU nodes.

GPU specific ops routines are defined to extend the amd64_edac
module to enumerate HBM memory leveraging the existing edac and the
amd64 specific data structures.

The UMC Phys on GPU nodes are enumerated as csrows and the UMC
channels connected to HBM banks are enumerated as ranks.

Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20210823185437.94417-4-nchatrad@amd.com

v6->v7:
* Added GPU specific ops function definitions, based on the refactor.

v5->v6:
* Added to support number of GPU northbridges with amd_gpu_nb_num()

v4->v5:
* Removed else condition in per_family_init for 19h family

v3->v4:
* Split "f17_addr_mask_to_cs_size" instead as did in 3rd patch earlier

v2->v3:
* Bifurcated the GPU code from v2

v1->v2:
* Restored line deletions and handled minor comments
* Modified commit message and some of the function comments
* variable df_inst_id is introduced instead of umc_num

v0->v1:
* Modifed the commit message
* Change the edac_cap
* kept sizes of both cpu and noncpu together
* return success if the !F3 condition true and remove unnecessary validation


 drivers/edac/amd64_edac.c | 285 +++++++++++++++++++++++++++++++++-----
 drivers/edac/amd64_edac.h |  21 +++
 2 files changed, 273 insertions(+), 33 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 54af7e38d26c..10efe726a959 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1012,6 +1012,12 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
+/* Total number of northbridges if in case of heterogeneous systems */
+static int amd_total_nb_num(void)
+{
+	return amd_nb_num() + amd_gpu_nb_num();
+}
+
 /*
  * Data Fabric Indirect Access uses FICAA/FICAD.
  *
@@ -1031,7 +1037,7 @@ static int __df_indirect_read(u16 node, u8 func, u16 reg, u8 instance_id, u32 *l
 	u32 ficaa;
 	int err = -ENODEV;
 
-	if (node >= amd_nb_num())
+	if (node >= amd_total_nb_num())
 		goto out;
 
 	F4 = node_to_amd_nb(node)->link;
@@ -1732,6 +1738,11 @@ static unsigned long f17_determine_edac_cap(struct amd64_pvt *pvt)
 	return edac_cap;
 }
 
+static unsigned long gpu_determine_edac_cap(struct amd64_pvt *pvt)
+{
+	return EDAC_FLAG_EC;
+}
+
 static void debug_display_dimm_sizes(struct amd64_pvt *, u8);
 
 static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
@@ -1814,6 +1825,25 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
+static int gpu_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+{
+	return CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+}
+
+static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
+{
+	int size, cs = 0, cs_mode;
+
+	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
+
+	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	for_each_chip_select(cs, ctrl, pvt) {
+		size = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs);
+		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
+	}
+}
+
 static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 {
 	int dimm, size0, size1, cs0, cs1, cs_mode;
@@ -1835,6 +1865,27 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
+static void gpu_dump_misc_regs(struct amd64_pvt *pvt)
+{
+	struct amd64_umc *umc;
+	u32 i, umc_base;
+
+	for_each_umc(i) {
+		umc_base = gpu_get_umc_base(i, 0);
+		umc = &pvt->umc[i];
+
+		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
+		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
+		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+
+		gpu_debug_display_dimm_sizes(pvt, i);
+	}
+
+	edac_dbg(1, "F0x104 (DRAM Hole Address): 0x%08x, base: 0x%08x\n",
+		 pvt->dhar, dhar_base(pvt));
+}
+
 static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
@@ -1973,6 +2024,43 @@ static void default_prep_chip_selects(struct amd64_pvt *pvt)
 	pvt->csels[1].m_cnt = 4;
 }
 
+static void gpu_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 8;
+		pvt->csels[umc].m_cnt = 8;
+	}
+}
+
+static void gpu_read_umc_base_mask(struct amd64_pvt *pvt)
+{
+	u32 base_reg, mask_reg;
+	u32 *base, *mask;
+	int umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			base_reg = gpu_get_umc_base(umc, cs) + UMCCH_BASE_ADDR;
+			base = &pvt->csels[umc].csbases[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, base_reg, base)) {
+				edac_dbg(0, "  DCSB%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *base, base_reg);
+			}
+
+			mask_reg = gpu_get_umc_base(umc, cs) + UMCCH_ADDR_MASK;
+			mask = &pvt->csels[umc].csmasks[cs];
+
+			if (!amd_smn_read(pvt->mc_node_id, mask_reg, mask)) {
+				edac_dbg(0, "  DCSM%d[%d]=0x%08x reg: 0x%x\n",
+					 umc, cs, *mask, mask_reg);
+			}
+		}
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -2172,6 +2260,11 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	pvt->dram_type = (pvt->dclr0 & BIT(16)) ? MEM_DDR3 : MEM_RDDR3;
 }
 
+static void gpu_determine_memory_type(struct amd64_pvt *pvt)
+{
+	pvt->dram_type = MEM_HBM2;
+}
+
 /* Get the number of DCT channels the memory controller is using. */
 static int k8_early_channel_count(struct amd64_pvt *pvt)
 {
@@ -2504,6 +2597,19 @@ static int f17_early_channel_count(struct amd64_pvt *pvt)
 	return channels;
 }
 
+static int gpu_early_channel_count(struct amd64_pvt *pvt)
+{
+	int i, channels = 0;
+
+	/* The memory channels in case of GPUs are fully populated */
+	for_each_umc(i)
+		channels += pvt->csels[i].b_cnt;
+
+	amd64_info("MCT channel count: %d\n", channels);
+
+	return channels;
+}
+
 static int ddr3_cs_size(unsigned i, bool dct_width)
 {
 	unsigned shift = 0;
@@ -2631,11 +2737,46 @@ static int f16_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 		return ddr3_cs_size(cs_mode, false);
 }
 
+static int __addr_mask_to_cs_size(u32 addr_mask_orig, unsigned int cs_mode,
+				  int csrow_nr, int dimm)
+{
+	u32 msb, weight, num_zero_bits;
+	u32 addr_mask_deinterleaved;
+	int size = 0;
+
+	/*
+	 * The number of zero bits in the mask is equal to the number of bits
+	 * in a full mask minus the number of bits in the current mask.
+	 *
+	 * The MSB is the number of bits in the full mask because BIT[0] is
+	 * always 0.
+	 *
+	 * In the special 3 Rank interleaving case, a single bit is flipped
+	 * without swapping with the most significant bit. This can be handled
+	 * by keeping the MSB where it is and ignoring the single zero bit.
+	 */
+	msb = fls(addr_mask_orig) - 1;
+	weight = hweight_long(addr_mask_orig);
+	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
+
+	/* Take the number of zero bits off from the top of the mask. */
+	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
+
+	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
+	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
+	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+
+	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
+	size = (addr_mask_deinterleaved >> 2) + 1;
+
+	/* Return size in MBs. */
+	return size >> 10;
+}
+
 static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
+	u32 addr_mask_orig;
 	int cs_mask_nr = csrow_nr;
 	int dimm, size = 0;
 
@@ -2680,33 +2821,15 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 	else
 		addr_mask_orig = pvt->csels[umc].csmasks[cs_mask_nr];
 
-	/*
-	 * The number of zero bits in the mask is equal to the number of bits
-	 * in a full mask minus the number of bits in the current mask.
-	 *
-	 * The MSB is the number of bits in the full mask because BIT[0] is
-	 * always 0.
-	 *
-	 * In the special 3 Rank interleaving case, a single bit is flipped
-	 * without swapping with the most significant bit. This can be handled
-	 * by keeping the MSB where it is and ignoring the single zero bit.
-	 */
-	msb = fls(addr_mask_orig) - 1;
-	weight = hweight_long(addr_mask_orig);
-	num_zero_bits = msb - weight - !!(cs_mode & CS_3R_INTERLEAVE);
-
-	/* Take the number of zero bits off from the top of the mask. */
-	addr_mask_deinterleaved = GENMASK_ULL(msb - num_zero_bits, 1);
-
-	edac_dbg(1, "CS%d DIMM%d AddrMasks:\n", csrow_nr, dimm);
-	edac_dbg(1, "  Original AddrMask: 0x%x\n", addr_mask_orig);
-	edac_dbg(1, "  Deinterleaved AddrMask: 0x%x\n", addr_mask_deinterleaved);
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, cs_mask_nr, dimm);
+}
 
-	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
+static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
 
-	/* Return size in MBs. */
-	return size >> 10;
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
 }
 
 static void read_dram_ctl_register(struct amd64_pvt *pvt)
@@ -3703,6 +3826,11 @@ static void f17_determine_ecc_sym_sz(struct amd64_pvt *pvt)
 	}
 }
 
+/* ECC symbol size is not available on Aldebaran nodes */
+static void gpu_determine_ecc_sym_sz(struct amd64_pvt *pvt)
+{
+}
+
 static void read_top_mem_registers(struct amd64_pvt *pvt)
 {
 	u64 msr_val;
@@ -3724,6 +3852,25 @@ static void read_top_mem_registers(struct amd64_pvt *pvt)
 	}
 }
 
+static void gpu_read_mc_regs(struct amd64_pvt *pvt)
+{
+	u8 nid = pvt->mc_node_id;
+	struct amd64_umc *umc;
+	u32 i, umc_base;
+
+	/* Read registers from each UMC */
+	for_each_umc(i) {
+		umc_base = gpu_get_umc_base(i, 0);
+		umc = &pvt->umc[i];
+
+		amd_smn_read(nid, umc_base + UMCCH_UMC_CFG, &umc->umc_cfg);
+		amd_smn_read(nid, umc_base + UMCCH_SDP_CTRL, &umc->sdp_ctrl);
+		amd_smn_read(nid, umc_base + UMCCH_ECC_CTRL, &umc->ecc_ctrl);
+	}
+
+	amd64_read_pci_cfg(pvt->F0, DF_DHAR, &pvt->dhar);
+}
+
 /*
  * Retrieve the hardware registers of the memory controller.
  */
@@ -3850,6 +3997,35 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
 	return nr_pages;
 }
 
+static int gpu_init_csrows(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+	struct dimm_info *dimm;
+	int empty = 1;
+	u8 umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			empty = 0;
+			dimm = mci->csrows[umc]->channels[cs]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+				 pvt->mc_node_id, cs);
+
+			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
+			dimm->mtype = pvt->dram_type;
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->dtype = DEV_X16;
+			dimm->grain = 64;
+		}
+	}
+
+	return empty;
+}
+
 static int init_csrows_df(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
@@ -4190,6 +4366,12 @@ static bool f17_check_ecc_enabled(struct amd64_pvt *pvt)
 		return true;
 }
 
+/* ECC is enabled by default on GPU nodes */
+static bool gpu_check_ecc_enabled(struct amd64_pvt *pvt)
+{
+	return true;
+}
+
 static inline void
 f1x_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
@@ -4231,6 +4413,12 @@ f17_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	}
 }
 
+static inline void
+gpu_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+{
+	mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+}
+
 static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
@@ -4251,6 +4439,22 @@ static void f1x_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->get_sdram_scrub_rate = get_scrub_rate;
 }
 
+static void gpu_setup_mci_misc_attrs(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+
+	mci->mtype_cap		= MEM_FLAG_HBM2;
+	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
+
+	pvt->ops->determine_edac_ctl_cap(mci, pvt);
+
+	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
+	mci->mod_name		= EDAC_MOD_STR;
+	mci->ctl_name		= pvt->ctl_name;
+	mci->dev_name		= pci_name(pvt->F3);
+	mci->ctl_page_to_phys	= NULL;
+}
+
 /*
  * returns a pointer to the family descriptor on success, NULL otherwise.
  */
@@ -4460,6 +4664,20 @@ static void per_family_init(struct amd64_pvt *pvt)
 				pvt->f0_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0;
 				pvt->f6_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6;
 				pvt->max_mcs		= 4;
+				pvt->ops->early_channel_count	= gpu_early_channel_count;
+				pvt->ops->dbam_to_cs		= gpu_addr_mask_to_cs_size;
+				pvt->ops->prep_chip_selects	= gpu_prep_chip_selects;
+				pvt->ops->determine_memory_type	= gpu_determine_memory_type;
+				pvt->ops->determine_ecc_sym_sz	= gpu_determine_ecc_sym_sz;
+				pvt->ops->determine_edac_ctl_cap = gpu_determine_edac_ctl_cap;
+				pvt->ops->determine_edac_cap	= gpu_determine_edac_cap;
+				pvt->ops->setup_mci_misc_attrs	= gpu_setup_mci_misc_attrs;
+				pvt->ops->get_cs_mode		= gpu_get_cs_mode;
+				pvt->ops->ecc_enabled		= gpu_check_ecc_enabled;
+				pvt->ops->get_base_mask		= gpu_read_umc_base_mask;
+				pvt->ops->dump_misc_regs	= gpu_dump_misc_regs;
+				pvt->ops->get_mc_regs		= gpu_read_mc_regs;
+				pvt->ops->populate_csrows	= gpu_init_csrows;
 				goto end_fam;
 			} else {
 				pvt->ctl_name		= "F19h_M30h";
@@ -4581,9 +4799,10 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	if (pvt->channel_count < 0)
 		return ret;
 
+	/* Define layers for CPU and GPU nodes */
 	ret = -ENOMEM;
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = amd_gpu_nb_num() ? pvt->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
 
@@ -4592,7 +4811,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = pvt->max_mcs;
+	layers[1].size = amd_gpu_nb_num() ? pvt->csels[0].b_cnt : pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -4786,7 +5005,7 @@ static int __init amd64_edac_init(void)
 	opstate_init();
 
 	err = -ENOMEM;
-	ecc_stngs = kcalloc(amd_nb_num(), sizeof(ecc_stngs[0]), GFP_KERNEL);
+	ecc_stngs = kcalloc(amd_total_nb_num(), sizeof(ecc_stngs[0]), GFP_KERNEL);
 	if (!ecc_stngs)
 		goto err_free;
 
@@ -4794,7 +5013,7 @@ static int __init amd64_edac_init(void)
 	if (!msrs)
 		goto err_free;
 
-	for (i = 0; i < amd_nb_num(); i++) {
+	for (i = 0; i < amd_total_nb_num(); i++) {
 		err = probe_one_instance(i);
 		if (err) {
 			/* unwind properly */
@@ -4852,7 +5071,7 @@ static void __exit amd64_edac_exit(void)
 	else
 		amd_unregister_ecc_decoder(decode_bus_error);
 
-	for (i = 0; i < amd_nb_num(); i++)
+	for (i = 0; i < amd_total_nb_num(); i++)
 		remove_one_instance(i);
 
 	kfree(ecc_stngs);
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 66f7b5d45a37..71df08a496d2 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -653,3 +653,24 @@ static inline u32 dct_sel_baseaddr(struct amd64_pvt *pvt)
  * - GPU UMCs use 1 chip select. So we say UMC = EDAC CSROW.
  * - GPU UMCs use 8 channels. So we say UMC Channel = EDAC Channel.
  */
+static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
+{
+	/*
+	 * On CPUs, there is one channel per UMC, so UMC numbering equals
+	 * channel numbering. On GPUs, there are eight channels per UMC,
+	 * so the channel numbering is different from UMC numbering.
+	 *
+	 * On CPU nodes channels are selected in 6th nibble
+	 * UMC chY[3:0]= [(chY*2 + 1) : (chY*2)]50000;
+	 *
+	 * On GPU nodes channels are selected in 3rd nibble
+	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
+	 * HBM chX[7:4]= [Y+1]5X[3:0]000
+	 */
+	umc *= 2;
+
+	if (channel >= 4)
+		umc++;
+
+	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
+}
-- 
2.25.1

