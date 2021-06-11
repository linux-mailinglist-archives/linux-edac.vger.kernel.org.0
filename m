Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E315B3A4754
	for <lists+linux-edac@lfdr.de>; Fri, 11 Jun 2021 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFKRDu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Jun 2021 13:03:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:56300 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhFKRDs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Jun 2021 13:03:48 -0400
IronPort-SDR: A2vnqnge8X5+Swt8bz/zGm9fgRVIQHOLsH/2qQsRttXmMXRx636z7kcDK55tDiEkY7cKEzmZu0
 znoY4xjkFSVw==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="266715350"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="266715350"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:37 -0700
IronPort-SDR: EBKoTBwQWQw/+LkVBqj3DJNRPVOWO1o6uPBZaWKh/0iBHji0UlRfIXmzlsya330okKDUiTgOM7
 mA/Z+lMvCr8w==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="483329865"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 10:01:36 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     tony.luck@intel.com
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] EDAC/i10nm: Add detection of memory levels for ICX/SPR servers
Date:   Fri, 11 Jun 2021 10:01:19 -0700
Message-Id: <20210611170123.1057025-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210611170123.1057025-1-tony.luck@intel.com>
References: <20210611170123.1057025-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Current i10nm_edac driver is only for system configured in 1-level
memory. If the system is configured in 2-level memory, the driver
doesn't report the 1st level memory DIMM for the error address, even
if the error occurs in the 1st level memory.

Both Ice Lake servers and Sapphire Rapids servers can be configured
in 2-level memory. Add detection of memory levels to i10nm_edac for
the two kinds of servers so that the driver can report the 2nd level
memory DIMM or the 1st level memory DIMM according to error source.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/i10nm_base.c | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/edac/skx_common.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index 238a4ad1e526..91431d8922a0 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -24,6 +24,8 @@
 	pci_read_config_dword((d)->uracu, 0xd0, &(reg))
 #define I10NM_GET_IMC_BAR(d, i, reg)	\
 	pci_read_config_dword((d)->uracu, 0xd8 + (i) * 4, &(reg))
+#define I10NM_GET_SAD(d, offset, i, reg)\
+	pci_read_config_dword((d)->sad_all, (offset) + (i) * 8, &(reg))
 #define I10NM_GET_DIMMMTR(m, i, j)	\
 	readl((m)->mbase + 0x2080c + (i) * (m)->chan_mmio_sz + (j) * 4)
 #define I10NM_GET_MCDDRTCFG(m, i, j)	\
@@ -38,6 +40,10 @@
 #define I10NM_GET_IMC_MMIO_SIZE(reg)	((GET_BITFIELD(reg, 13, 23) - \
 					 GET_BITFIELD(reg, 0, 10) + 1) << 12)
 
+#define I10NM_MAX_SAD			16
+#define I10NM_SAD_ENABLE(reg)		GET_BITFIELD(reg, 0, 0)
+#define I10NM_SAD_NM_CACHEABLE(reg)	GET_BITFIELD(reg, 5, 5)
+
 static struct list_head *i10nm_edac_list;
 
 static struct pci_dev *pci_get_dev_wrapper(int dom, unsigned int bus,
@@ -63,6 +69,31 @@ static struct pci_dev *pci_get_dev_wrapper(int dom, unsigned int bus,
 	return pdev;
 }
 
+static bool i10nm_check_2lm(struct res_config *cfg)
+{
+	struct skx_dev *d;
+	u32 reg;
+	int i;
+
+	list_for_each_entry(d, i10nm_edac_list, list) {
+		d->sad_all = pci_get_dev_wrapper(d->seg, d->bus[1],
+						 PCI_SLOT(cfg->sad_all_devfn),
+						 PCI_FUNC(cfg->sad_all_devfn));
+		if (!d->sad_all)
+			continue;
+
+		for (i = 0; i < I10NM_MAX_SAD; i++) {
+			I10NM_GET_SAD(d, cfg->sad_all_offset, i, reg);
+			if (I10NM_SAD_ENABLE(reg) && I10NM_SAD_NM_CACHEABLE(reg)) {
+				edac_dbg(2, "2-level memory configuration.\n");
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int i10nm_get_all_munits(void)
 {
 	struct pci_dev *mdev;
@@ -132,6 +163,8 @@ static struct res_config i10nm_cfg0 = {
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xcc,
 	.ddr_chan_mmio_sz	= 0x4000,
+	.sad_all_devfn		= PCI_DEVFN(29, 0),
+	.sad_all_offset		= 0x108,
 };
 
 static struct res_config i10nm_cfg1 = {
@@ -139,6 +172,8 @@ static struct res_config i10nm_cfg1 = {
 	.decs_did		= 0x3452,
 	.busno_cfg_offset	= 0xd0,
 	.ddr_chan_mmio_sz	= 0x4000,
+	.sad_all_devfn		= PCI_DEVFN(29, 0),
+	.sad_all_offset		= 0x108,
 };
 
 static struct res_config spr_cfg = {
@@ -147,6 +182,8 @@ static struct res_config spr_cfg = {
 	.busno_cfg_offset	= 0xd0,
 	.ddr_chan_mmio_sz	= 0x8000,
 	.support_ddr5		= true,
+	.sad_all_devfn		= PCI_DEVFN(10, 0),
+	.sad_all_offset		= 0x300,
 };
 
 static const struct x86_cpu_id i10nm_cpuids[] = {
@@ -296,6 +333,8 @@ static int __init i10nm_init(void)
 		return -ENODEV;
 	}
 
+	skx_set_mem_cfg(i10nm_check_2lm(cfg));
+
 	rc = i10nm_get_all_munits();
 	if (rc < 0)
 		goto fail;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 8b5a49058ce4..34e89f7ddf93 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -133,6 +133,9 @@ struct res_config {
 	/* Per DDR channel memory-mapped I/O size */
 	int ddr_chan_mmio_sz;
 	bool support_ddr5;
+	/* SAD device number and function number */
+	unsigned int sad_all_devfn;
+	int sad_all_offset;
 };
 
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
-- 
2.29.2

