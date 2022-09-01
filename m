Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72565AA052
	for <lists+linux-edac@lfdr.de>; Thu,  1 Sep 2022 21:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiIATnr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Sep 2022 15:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbiIATnd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Sep 2022 15:43:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F14E9BB5A;
        Thu,  1 Sep 2022 12:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662061412; x=1693597412;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w4h4BOehZh3KOQ0TFBnp+WQud/kuPjA/m/SdaY7wrZ4=;
  b=KTWSXLKFbPFJ5vPoCogLxiNv9gztTAiOgnZ3HNBzly9xtwzHn95eF5Bh
   K5c7U/ftuVLXzT9KrOucIoB3bR+3JTEjYsgkU6Yw0CkTOsoQMtloic2q6
   Td6tV4CB3Pd7H92HayBS5GaWlh0O3gj7A1ULF1G9+KGHqUMqU7NMaMyjW
   PYErBFxX0Pu6eHI4P9Ip9dyt0unYEX/EGOYPAQjNlG9JQ5NOX4sni/I9s
   zKTHL2wgJCrTaeD8vtzcGJrVvOWF1z2kJIPiqnImT5V9C2OghucqPRnjD
   UeAmuecqRAxJ0y96DjwyS2+MRaY+mQKbboVL1PHawspQ0Z4SXU+cRbHOP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295821697"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="295821697"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="674020256"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 12:43:20 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     linux-edac@vger.kernel.org
Cc:     Youquan Song <youquan.song@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH 3/3] EDAC/i10nm: Add driver decoder for Ice Lake and Tremont CPUs
Date:   Thu,  1 Sep 2022 12:43:10 -0700
Message-Id: <20220901194310.115427-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901194310.115427-1-tony.luck@intel.com>
References: <20220901194310.115427-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Current i10nm_edac only supports firmware decoder (ACPI DSM methods).
MCA bank registers of Ice Lake or Tremont CPUs contain the information
to decode DDR memory errors. To get better decoding performance, add
the driver decoder (decoding DDR memory errors via extracting error
information from MCA bank registers) for Ice Lake and Tremont CPUs.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/mce.h |   1 +
 drivers/edac/skx_common.h  |   5 ++
 drivers/edac/i10nm_base.c  | 134 ++++++++++++++++++++++++++++++++++++-
 drivers/edac/skx_common.c  |   1 +
 4 files changed, 139 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..6e986088817d 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -42,6 +42,7 @@
 #define MCI_STATUS_CEC_SHIFT	38           /* Corrected Error Count */
 #define MCI_STATUS_CEC_MASK	GENMASK_ULL(52,38)
 #define MCI_STATUS_CEC(c)	(((c) & MCI_STATUS_CEC_MASK) >> MCI_STATUS_CEC_SHIFT)
+#define MCI_STATUS_MSCOD(m)	(((m) >> 16) & 0xffff)
 
 /* AMD-specific bits */
 #define MCI_STATUS_TCC		BIT_ULL(55)  /* Task context corrupt */
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 880ecd15ca42..c542f1562825 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -10,6 +10,7 @@
 #define _SKX_COMM_EDAC_H
 
 #include <linux/bits.h>
+#include <asm/mce.h>
 
 #define MSG_SIZE		1024
 
@@ -52,6 +53,9 @@
 #define IS_DIMM_PRESENT(r)		GET_BITFIELD(r, 15, 15)
 #define IS_NVDIMM_PRESENT(r, i)		GET_BITFIELD(r, i, i)
 
+#define MCI_MISC_ECC_MODE(m)	(((m) >> 59) & 15)
+#define MCI_MISC_ECC_DDRT	8	/* read from DDRT */
+
 /*
  * Each cpu socket contains some pci devices that provide global
  * information, and also some that are local to each of the two
@@ -120,6 +124,7 @@ enum {
 #define BIT_NM_DIMM	BIT_ULL(INDEX_NM_DIMM)
 
 struct decoded_addr {
+	struct mce *mce;
 	struct skx_dev *dev;
 	u64	addr;
 	int	socket;
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 6cf50ee0b77c..817f618fcff0 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -74,6 +74,8 @@ static struct list_head *i10nm_edac_list;
 
 static struct res_config *res_cfg;
 static int retry_rd_err_log;
+static int decoding_via_mca;
+static bool mem_cfg_2lm;
 
 static u32 offsets_scrub_icx[]  = {0x22c60, 0x22c54, 0x22c5c, 0x22c58, 0x22c28, 0x20ed8};
 static u32 offsets_scrub_spr[]  = {0x22c60, 0x22c54, 0x22f08, 0x22c58, 0x22c28, 0x20ed8};
@@ -231,6 +233,103 @@ static bool i10nm_check_2lm(struct res_config *cfg)
 	return false;
 }
 
+/*
+ * Check whether the error comes from DDRT by ICX/Tremont model specific error code.
+ * Refer to SDM vol3B 16.11.3 Intel IMC MC error codes for IA32_MCi_STATUS.
+ */
+static bool i10nm_mscod_is_ddrt(u32 mscod)
+{
+	switch (mscod) {
+	case 0x0106: case 0x0107:
+	case 0x0800: case 0x0804:
+	case 0x0806 ... 0x0808:
+	case 0x080a ... 0x080e:
+	case 0x0810: case 0x0811:
+	case 0x0816: case 0x081e:
+	case 0x081f:
+		return true;
+	}
+
+	return false;
+}
+
+static bool i10nm_mc_decode_available(struct mce *mce)
+{
+	u8 bank;
+
+	if (!decoding_via_mca || mem_cfg_2lm)
+		return false;
+
+	if ((mce->status & (MCI_STATUS_MISCV | MCI_STATUS_ADDRV))
+			!= (MCI_STATUS_MISCV | MCI_STATUS_ADDRV))
+		return false;
+
+	bank = mce->bank;
+
+	switch (res_cfg->type) {
+	case I10NM:
+		if (bank < 13 || bank > 26)
+			return false;
+
+		/* DDRT errors can't be decoded from MCA bank registers */
+		if (MCI_MISC_ECC_MODE(mce->misc) == MCI_MISC_ECC_DDRT)
+			return false;
+
+		if (i10nm_mscod_is_ddrt(MCI_STATUS_MSCOD(mce->status)))
+			return false;
+
+		/* Check whether one of {13,14,17,18,21,22,25,26} */
+		return ((bank - 13) & BIT(1)) == 0;
+	default:
+		return false;
+	}
+}
+
+static bool i10nm_mc_decode(struct decoded_addr *res)
+{
+	struct mce *m = res->mce;
+	struct skx_dev *d;
+	u8 bank;
+
+	if (!i10nm_mc_decode_available(m))
+		return false;
+
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		if (d->imc[0].src_id == m->socketid) {
+			res->socket = m->socketid;
+			res->dev = d;
+			break;
+		}
+	}
+
+	switch (res_cfg->type) {
+	case I10NM:
+		bank = m->bank - 13;
+		res->imc = bank / 4;
+		res->channel = bank % 2;
+		break;
+	default:
+		return false;
+	}
+
+	if (!res->dev) {
+		skx_printk(KERN_ERR, "No device for src_id %d imc %d\n",
+			   m->socketid, res->imc);
+		return false;
+	}
+
+	res->column       = GET_BITFIELD(m->misc, 9, 18) << 2;
+	res->row          = GET_BITFIELD(m->misc, 19, 39);
+	res->bank_group   = GET_BITFIELD(m->misc, 40, 41);
+	res->bank_address = GET_BITFIELD(m->misc, 42, 43);
+	res->bank_group  |= GET_BITFIELD(m->misc, 44, 44) << 2;
+	res->rank         = GET_BITFIELD(m->misc, 56, 58);
+	res->dimm         = res->rank >> 2;
+	res->rank         = res->rank % 4;
+
+	return true;
+}
+
 static int i10nm_get_ddr_munits(void)
 {
 	struct pci_dev *mdev;
@@ -574,7 +673,8 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 	}
 
-	skx_set_mem_cfg(i10nm_check_2lm(cfg));
+	mem_cfg_2lm = i10nm_check_2lm(cfg);
+	skx_set_mem_cfg(mem_cfg_2lm);
 
 	rc = i10nm_get_ddr_munits();
 
@@ -626,9 +726,11 @@ static int __init i10nm_init(void)
 	setup_i10nm_debug();
 
 	if (retry_rd_err_log && res_cfg->offsets_scrub && res_cfg->offsets_demand) {
-		skx_set_decode(NULL, show_retry_rd_err_log);
+		skx_set_decode(i10nm_mc_decode, show_retry_rd_err_log);
 		if (retry_rd_err_log == 2)
 			enable_retry_rd_err_log(true);
+	} else {
+		skx_set_decode(i10nm_mc_decode, NULL);
 	}
 
 	i10nm_printk(KERN_INFO, "%s\n", I10NM_REVISION);
@@ -658,6 +760,34 @@ static void __exit i10nm_exit(void)
 module_init(i10nm_init);
 module_exit(i10nm_exit);
 
+static int set_decoding_via_mca(const char *buf, const struct kernel_param *kp)
+{
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &val);
+
+	if (ret || val > 1)
+		return -EINVAL;
+
+	if (val && mem_cfg_2lm) {
+		i10nm_printk(KERN_NOTICE, "Decoding errors via MCA banks for 2LM isn't supported yet\n");
+		return -EIO;
+	}
+
+	ret = param_set_int(buf, kp);
+
+	return ret;
+}
+
+static const struct kernel_param_ops decoding_via_mca_param_ops = {
+	.set = set_decoding_via_mca,
+	.get = param_get_int,
+};
+
+module_param_cb(decoding_via_mca, &decoding_via_mca_param_ops, &decoding_via_mca, 0644);
+MODULE_PARM_DESC(decoding_via_mca, "decoding_via_mca: 0=off(default), 1=enable");
+
 module_param(retry_rd_err_log, int, 0444);
 MODULE_PARM_DESC(retry_rd_err_log, "retry_rd_err_log: 0=off(default), 1=bios(Linux doesn't reset any control bits, but just reports values.), 2=linux(Linux tries to take control and resets mode bits, clear valid/UC bits after reading.)");
 
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 16ca3de57c24..7276ce3a33e1 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -651,6 +651,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 		return NOTIFY_DONE;
 
 	memset(&res, 0, sizeof(res));
+	res.mce  = mce;
 	res.addr = mce->addr;
 
 	/* Try driver decoder first */
-- 
2.37.1

