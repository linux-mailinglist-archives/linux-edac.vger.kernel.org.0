Return-Path: <linux-edac+bounces-3186-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CAFA411EA
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DE967A98E3
	for <lists+linux-edac@lfdr.de>; Sun, 23 Feb 2025 21:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71423CEF0;
	Sun, 23 Feb 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U4tdi9P8"
X-Original-To: linux-edac@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B71E868
	for <linux-edac@vger.kernel.org>; Sun, 23 Feb 2025 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740345918; cv=none; b=OEDHLuovIw9Qm+HA8KhjnHQIic36LTCGKcBpv4n/pQz8sO+q6JLN/I30qucAL2CclkQH5Fim9OFw6JC0UADxHTTdAgqE3NOH2ycjWR4kK1EyjJ0j8xwPJCmCJsfCyT+bNGrTqkxuVBrprcCZ29lyQcN0ZGFcLAu84aNm1NzSZyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740345918; c=relaxed/simple;
	bh=BM8VYP7hhwVS/0K+DADZ4Du3fkI3YYkmwACnl7ZBVio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpOie/Bk1s1qfp3ZCUWGEqS2g/0+YewWjiD/LgfnuoCJjx73D1/2MEWFdKAZ0X7b/9BuIU3tskr7IrIyt7X15+6TBC3KhUFJe4dmDx1A9m72r40mUIp+gdn6/MJe4BKVVxMtRSV4jaYJzS0HO3D/xfMktwUsp+iY4fQmvezoiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U4tdi9P8; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740345912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N1nciALmWNx8Ps1kKUfqP3lTvlM+h32MdejY2ApaFF0=;
	b=U4tdi9P8A9mVnHGQ6o/SyoO0IgXAIO6svxZ4LVYW57CLJbV+gukOqpKe3MCFsiAzX+Nih1
	KKrAkFKxfE/VwyEH66rwTsQlWgwAEcm72tcv9lp1hljNQOQd2+ndpdJUcdBa7j0rHvjE9r
	QiN+BOVQh4VDT/w8OR2xkgkFRy1ajcY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Yazen Ghannam <yazen.ghannam@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] EDAC: Use string choice helper functions
Date: Sun, 23 Feb 2025 22:24:29 +0100
Message-ID: <20250223212429.3466-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled(),
str_yes_no(), str_write_read(), and str_plural() helper functions.

Add a space in "All DIMMs support ECC: yes/no" to improve readability.

Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/edac/amd64_edac.c | 47 +++++++++++++++++++--------------------
 drivers/edac/debugfs.c    |  5 ++++-
 drivers/edac/i5400_edac.c |  3 ++-
 drivers/edac/i7300_edac.c |  7 +++---
 drivers/edac/xgene_edac.c | 17 +++++++-------
 5 files changed, 42 insertions(+), 37 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 8414ceb43e4a..d133a5be5890 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/ras.h>
+#include <linux/string_choices.h>
 #include "amd64_edac.h"
 #include <asm/amd_nb.h>
 #include <asm/amd_node.h>
@@ -1171,22 +1172,21 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 		edac_dbg(1, " LRDIMM %dx rank multiply\n", (dcsm & 0x3));
 	}
 
-	edac_dbg(1, "All DIMMs support ECC:%s\n",
-		    (dclr & BIT(19)) ? "yes" : "no");
+	edac_dbg(1, "All DIMMs support ECC: %s\n", str_yes_no(dclr & BIT(19)));
 
 
 	edac_dbg(1, "  PAR/ERR parity: %s\n",
-		 (dclr & BIT(8)) ?  "enabled" : "disabled");
+		 str_enabled_disabled(dclr & BIT(8)));
 
 	if (pvt->fam == 0x10)
 		edac_dbg(1, "  DCT 128bit mode width: %s\n",
 			 (dclr & BIT(11)) ?  "128b" : "64b");
 
 	edac_dbg(1, "  x4 logical DIMMs present: L0: %s L1: %s L2: %s L3: %s\n",
-		 (dclr & BIT(12)) ?  "yes" : "no",
-		 (dclr & BIT(13)) ?  "yes" : "no",
-		 (dclr & BIT(14)) ?  "yes" : "no",
-		 (dclr & BIT(15)) ?  "yes" : "no");
+		 str_yes_no(dclr & BIT(12)),
+		 str_yes_no(dclr & BIT(13)),
+		 str_yes_no(dclr & BIT(14)),
+		 str_yes_no(dclr & BIT(15)));
 }
 
 #define CS_EVEN_PRIMARY		BIT(0)
@@ -1353,14 +1353,14 @@ static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 		edac_dbg(1, "UMC%d UMC cap high: 0x%x\n", i, umc->umc_cap_hi);
 
 		edac_dbg(1, "UMC%d ECC capable: %s, ChipKill ECC capable: %s\n",
-				i, (umc->umc_cap_hi & BIT(30)) ? "yes" : "no",
-				    (umc->umc_cap_hi & BIT(31)) ? "yes" : "no");
+				i, str_yes_no(umc->umc_cap_hi & BIT(30)),
+				    str_yes_no(umc->umc_cap_hi & BIT(31)));
 		edac_dbg(1, "UMC%d All DIMMs support ECC: %s\n",
-				i, (umc->umc_cfg & BIT(12)) ? "yes" : "no");
+				i, str_yes_no(umc->umc_cfg & BIT(12)));
 		edac_dbg(1, "UMC%d x4 DIMMs present: %s\n",
-				i, (umc->dimm_cfg & BIT(6)) ? "yes" : "no");
+				i, str_yes_no(umc->dimm_cfg & BIT(6)));
 		edac_dbg(1, "UMC%d x16 DIMMs present: %s\n",
-				i, (umc->dimm_cfg & BIT(7)) ? "yes" : "no");
+				i, str_yes_no(umc->dimm_cfg & BIT(7)));
 
 		umc_debug_display_dimm_sizes(pvt, i);
 	}
@@ -1371,11 +1371,11 @@ static void dct_dump_misc_regs(struct amd64_pvt *pvt)
 	edac_dbg(1, "F3xE8 (NB Cap): 0x%08x\n", pvt->nbcap);
 
 	edac_dbg(1, "  NB two channel DRAM capable: %s\n",
-		 (pvt->nbcap & NBCAP_DCT_DUAL) ? "yes" : "no");
+		 str_yes_no(pvt->nbcap & NBCAP_DCT_DUAL));
 
 	edac_dbg(1, "  ECC capable: %s, ChipKill ECC capable: %s\n",
-		 (pvt->nbcap & NBCAP_SECDED) ? "yes" : "no",
-		 (pvt->nbcap & NBCAP_CHIPKILL) ? "yes" : "no");
+		 str_yes_no(pvt->nbcap & NBCAP_SECDED),
+		 str_yes_no(pvt->nbcap & NBCAP_CHIPKILL));
 
 	debug_dump_dramcfg_low(pvt, pvt->dclr0, 0);
 
@@ -1398,7 +1398,7 @@ static void dct_dump_misc_regs(struct amd64_pvt *pvt)
 	if (!dct_ganging_enabled(pvt))
 		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
 
-	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
+	edac_dbg(1, "  DramHoleValid: %s\n", str_yes_no(dhar_valid(pvt)));
 
 	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
@@ -2027,15 +2027,15 @@ static void read_dram_ctl_register(struct amd64_pvt *pvt)
 
 		if (!dct_ganging_enabled(pvt))
 			edac_dbg(0, "  Address range split per DCT: %s\n",
-				 (dct_high_range_enabled(pvt) ? "yes" : "no"));
+				 str_yes_no(dct_high_range_enabled(pvt)));
 
 		edac_dbg(0, "  data interleave for ECC: %s, DRAM cleared since last warm reset: %s\n",
-			 (dct_data_intlv_enabled(pvt) ? "enabled" : "disabled"),
-			 (dct_memory_cleared(pvt) ? "yes" : "no"));
+			 str_enabled_disabled(dct_data_intlv_enabled(pvt)),
+			 str_yes_no(dct_memory_cleared(pvt)));
 
 		edac_dbg(0, "  channel interleave: %s, "
 			 "interleave bits selector: 0x%x\n",
-			 (dct_interleave_enabled(pvt) ? "enabled" : "disabled"),
+			 str_enabled_disabled(dct_interleave_enabled(pvt)),
 			 dct_sel_interleave_addr(pvt));
 	}
 
@@ -3208,8 +3208,7 @@ static bool nb_mce_bank_enabled_on_node(u16 nid)
 		nbe = reg->l & MSR_MCGCTL_NBE;
 
 		edac_dbg(0, "core: %u, MCG_CTL: 0x%llx, NB MSR is %s\n",
-			 cpu, reg->q,
-			 (nbe ? "enabled" : "disabled"));
+			 cpu, reg->q, str_enabled_disabled(nbe));
 
 		if (!nbe)
 			goto out;
@@ -3353,7 +3352,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
 		edac_dbg(0, "NB MCE bank disabled, set MSR 0x%08x[4] on node %d to enable.\n",
 			 MSR_IA32_MCG_CTL, nid);
 
-	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, str_enabled_disabled(ecc_en));
 
 	if (!ecc_en || !nb_mce_en)
 		return false;
@@ -3378,7 +3377,7 @@ static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 		}
 	}
 
-	edac_dbg(3, "Node %d: DRAM ECC %s.\n", pvt->mc_node_id, (ecc_en ? "enabled" : "disabled"));
+	edac_dbg(3, "Node %d: DRAM ECC %s.\n", pvt->mc_node_id, str_enabled_disabled(ecc_en));
 
 	return ecc_en;
 }
diff --git a/drivers/edac/debugfs.c b/drivers/edac/debugfs.c
index 4804332d9946..8195fc9c9354 100644
--- a/drivers/edac/debugfs.c
+++ b/drivers/edac/debugfs.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/string_choices.h>
+
 #include "edac_module.h"
 
 static struct dentry *edac_debugfs;
@@ -22,7 +25,7 @@ static ssize_t edac_fake_inject_write(struct file *file,
 	       "Generating %d %s fake error%s to %d.%d.%d to test core handling. NOTE: this won't test the driver-specific decoding logic.\n",
 		errcount,
 		(type == HW_EVENT_ERR_UNCORRECTED) ? "UE" : "CE",
-		errcount > 1 ? "s" : "",
+		str_plural(errcount),
 		mci->fake_inject_layer[0],
 		mci->fake_inject_layer[1],
 		mci->fake_inject_layer[2]
diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
index 49b4499269fb..b5cf25905b05 100644
--- a/drivers/edac/i5400_edac.c
+++ b/drivers/edac/i5400_edac.c
@@ -31,6 +31,7 @@
 #include <linux/slab.h>
 #include <linux/edac.h>
 #include <linux/mmzone.h>
+#include <linux/string_choices.h>
 
 #include "edac_module.h"
 
@@ -899,7 +900,7 @@ static void decode_mtr(int slot_row, u16 mtr)
 	edac_dbg(2, "\t\tWIDTH: x%d\n", MTR_DRAM_WIDTH(mtr));
 
 	edac_dbg(2, "\t\tELECTRICAL THROTTLING is %s\n",
-		 MTR_DIMMS_ETHROTTLE(mtr) ? "enabled" : "disabled");
+		 str_enabled_disabled(MTR_DIMMS_ETHROTTLE(mtr)));
 
 	edac_dbg(2, "\t\tNUMBANK: %d bank(s)\n", MTR_DRAM_BANKS(mtr));
 	edac_dbg(2, "\t\tNUMRANK: %s\n",
diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
index 61adaa872ba7..69068f8d0cad 100644
--- a/drivers/edac/i7300_edac.c
+++ b/drivers/edac/i7300_edac.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/edac.h>
 #include <linux/mmzone.h>
+#include <linux/string_choices.h>
 
 #include "edac_module.h"
 
@@ -620,7 +621,7 @@ static int decode_mtr(struct i7300_pvt *pvt,
 	edac_dbg(2, "\t\tWIDTH: x%d\n", MTR_DRAM_WIDTH(mtr));
 
 	edac_dbg(2, "\t\tELECTRICAL THROTTLING is %s\n",
-		 MTR_DIMMS_ETHROTTLE(mtr) ? "enabled" : "disabled");
+		 str_enabled_disabled(MTR_DIMMS_ETHROTTLE(mtr)));
 
 	edac_dbg(2, "\t\tNUMBANK: %d bank(s)\n", MTR_DRAM_BANKS(mtr));
 	edac_dbg(2, "\t\tNUMRANK: %s\n",
@@ -871,9 +872,9 @@ static int i7300_get_mc_regs(struct mem_ctl_info *mci)
 			 IS_MIRRORED(pvt->mc_settings) ? "" : "non-");
 
 	edac_dbg(0, "Error detection is %s\n",
-		 IS_ECC_ENABLED(pvt->mc_settings) ? "enabled" : "disabled");
+		 str_enabled_disabled(IS_ECC_ENABLED(pvt->mc_settings)));
 	edac_dbg(0, "Retry is %s\n",
-		 IS_RETRY_ENABLED(pvt->mc_settings) ? "enabled" : "disabled");
+		 str_enabled_disabled(IS_RETRY_ENABLED(pvt->mc_settings)));
 
 	/* Get Memory Interleave Range registers */
 	pci_read_config_word(pvt->pci_dev_16_1_fsb_addr_map, MIR0,
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 699c7d29d80c..9955396c9a52 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
+#include <linux/string_choices.h>
 
 #include "edac_module.h"
 
@@ -1407,7 +1408,7 @@ static void xgene_edac_iob_gic_report(struct edac_device_ctl_info *edac_dev)
 		dev_err(edac_dev->dev, "Multiple XGIC write size error\n");
 	info = readl(ctx->dev_csr + XGICTRANSERRREQINFO);
 	dev_err(edac_dev->dev, "XGIC %s access @ 0x%08X (0x%08X)\n",
-		info & REQTYPE_MASK ? "read" : "write", ERRADDR_RD(info),
+		str_read_write(info & REQTYPE_MASK), ERRADDR_RD(info),
 		info);
 	writel(reg, ctx->dev_csr + XGICTRANSERRINTSTS);
 
@@ -1489,19 +1490,19 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
 		if (reg & AGENT_OFFLINE_ERR_MASK)
 			dev_err(edac_dev->dev,
 				"IOB bus %s access to offline agent error\n",
-				write ? "write" : "read");
+				str_write_read(write));
 		if (reg & UNIMPL_RBPAGE_ERR_MASK)
 			dev_err(edac_dev->dev,
 				"IOB bus %s access to unimplemented page error\n",
-				write ? "write" : "read");
+				str_write_read(write));
 		if (reg & WORD_ALIGNED_ERR_MASK)
 			dev_err(edac_dev->dev,
 				"IOB bus %s word aligned access error\n",
-				write ? "write" : "read");
+				str_write_read(write));
 		if (reg & PAGE_ACCESS_ERR_MASK)
 			dev_err(edac_dev->dev,
 				"IOB bus %s to page out of range access error\n",
-				write ? "write" : "read");
+				str_write_read(write));
 		if (regmap_write(ctx->edac->rb_map, RBEIR, 0))
 			return;
 		if (regmap_write(ctx->edac->rb_map, RBCSR, 0))
@@ -1560,7 +1561,7 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
 	err_addr_lo = readl(ctx->dev_csr + IOBBATRANSERRREQINFOL);
 	err_addr_hi = readl(ctx->dev_csr + IOBBATRANSERRREQINFOH);
 	dev_err(edac_dev->dev, "IOB BA %s access at 0x%02X.%08X (0x%08X)\n",
-		REQTYPE_F2_RD(err_addr_hi) ? "read" : "write",
+		str_read_write(REQTYPE_F2_RD(err_addr_hi)),
 		ERRADDRH_F2_RD(err_addr_hi), err_addr_lo, err_addr_hi);
 	if (reg & WRERR_RESP_MASK)
 		dev_err(edac_dev->dev, "IOB BA requestor ID 0x%08X\n",
@@ -1611,7 +1612,7 @@ static void xgene_edac_pa_report(struct edac_device_ctl_info *edac_dev)
 	dev_err(edac_dev->dev,
 		"%sAXI slave 0 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
 		reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
-		REQTYPE_RD(err_addr_hi) ? "read" : "write",
+		str_read_write(REQTYPE_RD(err_addr_hi)),
 		ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
 	writel(reg, ctx->dev_csr + IOBAXIS0TRANSERRINTSTS);
 
@@ -1625,7 +1626,7 @@ static void xgene_edac_pa_report(struct edac_device_ctl_info *edac_dev)
 	dev_err(edac_dev->dev,
 		"%sAXI slave 1 illegal %s access @ 0x%02X.%08X (0x%08X)\n",
 		reg & IOBAXIS0_M_ILLEGAL_ACCESS_MASK ? "Multiple " : "",
-		REQTYPE_RD(err_addr_hi) ? "read" : "write",
+		str_read_write(REQTYPE_RD(err_addr_hi)),
 		ERRADDRH_RD(err_addr_hi), err_addr_lo, err_addr_hi);
 	writel(reg, ctx->dev_csr + IOBAXIS1TRANSERRINTSTS);
 }

base-commit: b3205f5a415b88d73b18130af1bacefd876de8bf
-- 
2.48.1


