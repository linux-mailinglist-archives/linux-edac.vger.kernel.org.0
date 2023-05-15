Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004F9702BB0
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbjEOLlh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbjEOLjg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:39:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC4212B;
        Mon, 15 May 2023 04:36:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHr9kQ+wTa65Ey29e7IEzuqmgEqPm+6+A3xpybvjgRsFbcU9cPXPMS3+HmwpwwiwJ5cAA9esJO8W5DFkzXqx0LNa2ITwWH2fOD1NVqvpnuYF3WoiaZ1E7jtK5CDJGFWTpFR+fX9e7bT+9GfmAf+mBvYQHDSQfMoZ8MGQq7zVpFP/tAV+fuffXNAjDfK65wd6CL7Emgyb0JpeBtQSecRctEPLeUHXUIU8am5jSK8epTBrP/QE1dSDoL0oMm/t/2o/4CoV9TtxwaeBsqu/TGrJtK/CYfwoFA+3SCggtKM2c1vz5vYdQOsx310q+n6v3dxY9VfUPWosbzKE6p358tenGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yf2JQlzTZ8sOCjeIBYPKPOjn5xXHOSE5L6m9BbixCTM=;
 b=JxkLKh+rud6DCONx8WtKEnGQuknbWAy3VayZjv6eAFmZpAq3YHk9/1hFic237gKD+ZT5bsv57+fnGhD9Z81qNJ7bmTkQ1ypywc1jqosxa3JR5liXJsIC3pd5k4R9d3D8pL3OtCa65gDoFddME/mhAgIcAm11ijSt++et73+rQJuLE+0XsNzHipsnB3S1uag6+7ekFlaF1JZQfGAOx96p4wLz6wB+ZrQlqbtyajTMnu25z6rJQHKHee9Okw4zIJDQMlVR7LzAjX4mxcPiWMaXaUK//vvlet4dp4FnJ7cO3t9fFf6LbhgUX118YjI3zOqrCIyW9i07cBygU9hAcjLXNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yf2JQlzTZ8sOCjeIBYPKPOjn5xXHOSE5L6m9BbixCTM=;
 b=zdqhtZt4WUbdLN0VSEd1xPOuwHlUAmuUCzxmFgBfPEqeQrAXVLkVFFFuzhMsRoLmpxc+eoV8u/ub46UHENkvd4in7h8EO2rdIcnzP8QLHsQcLsBrYFOi1ne11HFrgC5pJZLSSI7Ntz0bvxR/9H6aQF/kTYSv0zTC/vAmQgE46JA=
Received: from DS7PR03CA0183.namprd03.prod.outlook.com (2603:10b6:5:3b6::8) by
 CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 11:36:08 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::be) by DS7PR03CA0183.outlook.office365.com
 (2603:10b6:5:3b6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30 via Frontend
 Transport; Mon, 15 May 2023 11:36:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:36:08 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:36:04 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH 4/5] EDAC/amd64: Add support for AMD heterogeneous Family 19h Model 30h-3Fh
Date:   Mon, 15 May 2023 11:35:36 +0000
Message-ID: <20230515113537.1052146-5-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515113537.1052146-1-muralimk@amd.com>
References: <20230515113537.1052146-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: a07c7219-60b0-423f-e07c-08db5538935f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKtRAM++aK6cJs8EJMWxvscStomeH+4qxoiegFMSWx5SpffsdHtIQYUWQ1AA3uL6auwHWla4oit0FDqhUEyPSyFGdsThPXuhHrK1hPs7PJkdxVnNwIoS9WU4W9TnAt8c/Xzru3anEJFxgIWaLOgruiKbHVDuGt9BeOe4YzNKsJgPADFT7W9iund+njvoQE1ETURyfJwn362LUHfWJxCnt877lf9kq6GmICCxnNu0P4bx2c0NI7AT8eG1Am69s3RZRButF9JTj2MOtQaF4L+NdeeKjNI6gsTirAcdUYu4Fyb4qdW2/BWo95ZqxaLUSYoxFRPnLfkH1ojIhX/3YMO/YrFVAMx/adwhuzrJQe1dUvexBi376+DmEn5AsFyL0pwtFQXiQwPo2XAzfiewlr95Aod48b9tDfW3KayM55tRSiD0bJwisd4txpZQzKrp7skRgXmMqk1DxETxKmdzP1Al0MW9XF3G+IbwC9uj1ebZW0UW+Yxyrnf/3/o8oc7nIiSr6ghHjZiLwM50irLV7MtExzzpwGz/Vc+5f+v8EDOdEqFsgT5FfPb1zAs0FcU4qm804HungfbDYP+qCLcNIoB4dLkA54/kz69Q3gxR6ToQtUZV8NuAIBfqZLjfsyXmu6os8Czi6nKROLEtVfmZ1oPQ6DLpSqVKiJnB6kbNUS7UI8lS1jjsGXKdY7TJ/2CzypwAnLDo7O2io23oUCKyIElEQ88m9Rja99oPbMGbP9mMP8toCw9dw11u7hEzMOxAiMOfyI9BnTvVUfdVIpXgs2eGgg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(40460700003)(70586007)(4326008)(70206006)(7696005)(478600001)(316002)(54906003)(110136005)(36756003)(83380400001)(426003)(47076005)(1076003)(26005)(186003)(2616005)(336012)(36860700001)(41300700001)(5660300002)(8936002)(6666004)(30864003)(8676002)(2906002)(82310400005)(40480700001)(356005)(82740400003)(81166007)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:36:08.1339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a07c7219-60b0-423f-e07c-08db5538935f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

AMD Family 19h Model 30h-3Fh systems can be connected to AMD MI200
accelerator/GPU devices such that the CPU and GPU data fabrics are
connected together. In this configuration, the CPU manages error logging
and reporting for MCA banks located on the GPUs. This includes HBM memory
errors reported from Unified Memory Controllers (UMCs) on the GPUs.
The GPU memory errors are handled like CPU memory errors.

AMD CPU UMC support in EDAC can be re-used for GPU UMC support. However,
keeping them separate means drastic changes in one path (e.g. to support
newer products) should have less impact on the other path.

Also, simplify the "gpu_" helper functions where possible. GPU product
configuration, like memory type and channel count, is fixed compared to
CPU products.

GPU UMCs each have four physical connections (phys) connected to eight
channels. There is a single "chip select". This differs from CPUs where
each UMC has one physical connection connected to one channel, and each
channel has up to four "chip selects".

Enumerate each UMC "phy" as an EDAC CSROW, since there is only a single
chip select for each physical connection. This is similar to how a CPU
UMC "phy" is enumerated as an EDAC CHANNEL, since there is only a single
channel for each physical connection.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 310 ++++++++++++++++++++++++++++++++++----
 1 file changed, 279 insertions(+), 31 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5c4292e65b96..28155b01f144 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1426,12 +1426,47 @@ static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
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
 static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
 				    unsigned int cs_mode, int csrow_nr)
 {
-	u32 addr_mask_orig, addr_mask_deinterleaved;
-	u32 msb, weight, num_zero_bits;
 	int cs_mask_nr = csrow_nr;
+	u32 addr_mask_orig;
 	int dimm, size = 0;
 
 	/* No Chip Selects are enabled. */
@@ -1475,33 +1510,7 @@ static int umc_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
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
-
-	/* Register [31:1] = Address [39:9]. Size is in kBs here. */
-	size = (addr_mask_deinterleaved >> 2) + 1;
-
-	/* Return size in MBs. */
-	return size >> 10;
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, dimm);
 }
 
 static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
@@ -3675,6 +3684,221 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 	return 0;
 }
 
+/*
+ * The CPUs have one channel per UMC, so UMC number is equivalent to a
+ * channel number. The GPUs have 8 channels per UMC, so the UMC number no
+ * longer works as a channel number.
+ *
+ * The channel number within a GPU UMC is given in MCA_IPID[15:12].
+ * However, the IDs are split such that two UMC values go to one UMC, and
+ * the channel numbers are split in two groups of four.
+ *
+ * Refer to comment on gpu_get_umc_base().
+ *
+ * For example,
+ * UMC0 CH[3:0] = 0x0005[3:0]000
+ * UMC0 CH[7:4] = 0x0015[3:0]000
+ * UMC1 CH[3:0] = 0x0025[3:0]000
+ * UMC1 CH[7:4] = 0x0035[3:0]000
+ */
+static void gpu_get_err_info(struct mce *m, struct err_info *err)
+{
+	u8 ch = (m->ipid & GENMASK(31, 0)) >> 20;
+	u8 phy = ((m->ipid >> 12) & 0xf);
+
+	err->channel = ch % 2 ? phy + 4 : phy;
+	err->csrow = phy;
+}
+
+static int gpu_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
+				    unsigned int cs_mode, int csrow_nr)
+{
+	u32 addr_mask_orig = pvt->csels[umc].csmasks[csrow_nr];
+
+	return __addr_mask_to_cs_size(addr_mask_orig, cs_mode, csrow_nr, csrow_nr >> 1);
+}
+
+static void gpu_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
+{
+	int size, cs_mode, cs = 0;
+
+	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
+
+	cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	for_each_chip_select(cs, ctrl, pvt) {
+		size = gpu_addr_mask_to_cs_size(pvt, ctrl, cs_mode, cs);
+		amd64_info(EDAC_MC ": %d: %5dMB\n", cs, size);
+	}
+}
+
+static void gpu_dump_misc_regs(struct amd64_pvt *pvt)
+{
+	struct amd64_umc *umc;
+	u32 i;
+
+	for_each_umc(i) {
+		umc = &pvt->umc[i];
+
+		edac_dbg(1, "UMC%d UMC cfg: 0x%x\n", i, umc->umc_cfg);
+		edac_dbg(1, "UMC%d SDP ctrl: 0x%x\n", i, umc->sdp_ctrl);
+		edac_dbg(1, "UMC%d ECC ctrl: 0x%x\n", i, umc->ecc_ctrl);
+		edac_dbg(1, "UMC%d All HBMs support ECC: yes\n", i);
+
+		gpu_debug_display_dimm_sizes(pvt, i);
+	}
+}
+
+static u32 gpu_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr)
+{
+	u32 nr_pages;
+	int cs_mode = CS_EVEN_PRIMARY | CS_ODD_PRIMARY;
+
+	nr_pages   = gpu_addr_mask_to_cs_size(pvt, dct, cs_mode, csrow_nr);
+	nr_pages <<= 20 - PAGE_SHIFT;
+
+	edac_dbg(0, "csrow: %d, channel: %d\n", csrow_nr, dct);
+	edac_dbg(0, "nr_pages/channel: %u\n", nr_pages);
+
+	return nr_pages;
+}
+
+static void gpu_init_csrows(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+	struct dimm_info *dimm;
+	u8 umc, cs;
+
+	for_each_umc(umc) {
+		for_each_chip_select(cs, umc, pvt) {
+			if (!csrow_enabled(cs, umc, pvt))
+				continue;
+
+			dimm = mci->csrows[umc]->channels[cs]->dimm;
+
+			edac_dbg(1, "MC node: %d, csrow: %d\n",
+				 pvt->mc_node_id, cs);
+
+			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
+			dimm->edac_mode = EDAC_SECDED;
+			dimm->mtype = MEM_HBM2;
+			dimm->dtype = DEV_X16;
+			dimm->grain = 64;
+		}
+	}
+}
+
+static void gpu_setup_mci_misc_attrs(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+
+	mci->mtype_cap		= MEM_FLAG_HBM2;
+	mci->edac_ctl_cap	= EDAC_FLAG_SECDED;
+
+	mci->edac_cap		= EDAC_FLAG_EC;
+	mci->mod_name		= EDAC_MOD_STR;
+	mci->ctl_name		= pvt->ctl_name;
+	mci->dev_name		= pci_name(pvt->F3);
+	mci->ctl_page_to_phys	= NULL;
+
+	gpu_init_csrows(mci);
+}
+
+/* ECC is enabled by default on GPU nodes */
+static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
+{
+	return true;
+}
+
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
+
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
+}
+
+static void gpu_read_base_mask(struct amd64_pvt *pvt)
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
+static int gpu_hw_info_get(struct amd64_pvt *pvt)
+{
+	pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+	if (!pvt->umc)
+		return -ENOMEM;
+
+	gpu_prep_chip_selects(pvt);
+	gpu_read_base_mask(pvt);
+	gpu_read_mc_regs(pvt);
+
+	return 0;
+}
+
 static void hw_info_put(struct amd64_pvt *pvt)
 {
 	pci_dev_put(pvt->F1);
@@ -3690,6 +3914,14 @@ static struct low_ops umc_ops = {
 	.get_err_info			= umc_get_err_info,
 };
 
+static struct low_ops gpu_ops = {
+	.hw_info_get			= gpu_hw_info_get,
+	.ecc_enabled			= gpu_ecc_enabled,
+	.setup_mci_misc_attrs		= gpu_setup_mci_misc_attrs,
+	.dump_misc_regs			= gpu_dump_misc_regs,
+	.get_err_info			= gpu_get_err_info,
+};
+
 /* Use Family 16h versions for defaults and adjust as needed below. */
 static struct low_ops dct_ops = {
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
@@ -3813,6 +4045,16 @@ static int per_family_init(struct amd64_pvt *pvt)
 		case 0x20 ... 0x2f:
 			pvt->ctl_name			= "F19h_M20h";
 			break;
+		case 0x30 ... 0x3f:
+			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
+				pvt->ctl_name		= "MI200";
+				pvt->max_mcs		= 4;
+				pvt->ops		= &gpu_ops;
+			} else {
+				pvt->ctl_name		= "F19h_M30h";
+				pvt->max_mcs		= 8;
+			}
+			break;
 		case 0x50 ... 0x5f:
 			pvt->ctl_name			= "F19h_M50h";
 			break;
@@ -3846,11 +4088,17 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	struct edac_mc_layer layers[2];
 	int ret = -ENOMEM;
 
+	/*
+	 * For Heterogeneous family EDAC CHIP_SELECT and CHANNEL layers should
+	 * be swapped to fit into the layers.
+	 */
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = pvt->csels[0].b_cnt;
+	layers[0].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
+			 pvt->max_mcs : pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = pvt->max_mcs;
+	layers[1].size = (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) ?
+			 pvt->csels[0].b_cnt : pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
-- 
2.25.1

