Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4DDBD4A4
	for <lists+linux-edac@lfdr.de>; Tue, 24 Sep 2019 23:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438997AbfIXVwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Sep 2019 17:52:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:33671 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbfIXVwc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 24 Sep 2019 17:52:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 14:52:31 -0700
X-IronPort-AV: E=Sophos;i="5.64,545,1559545200"; 
   d="scan'208";a="191149923"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 14:52:30 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [PATCHv2 2/2] EDAC, skx: Retrieve and print retry_rd_err_log registers
Date:   Tue, 24 Sep 2019 14:52:30 -0700
Message-Id: <20190924215230.14753-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190918075246.534d9d6c@coco.lan>
References: <20190918075246.534d9d6c@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Skylake logs some additional useful information in per-channel
registers in addition the the architectural status/addr/misc
logged in the machine check bank.

Pick up this information and add it to the EDAC log:

	retry_rd_err_log[five 32-bit register values]

Sorry, no definitions for these registers. OEMs and DIMM vendors
will be able to use them to isolate which cells in the DIMM are
causing problems.

	correrrcnt[per rank corrected error counts]

Note that if additional errors are logged while these registers are
being read, you may see a jumble of values some from earlier errors,
others from later errors (since the registers report the most recent
logged error). The correrrcnt registers provide error counts per possible
rank. If these counts only change by one since the previous error logged
for this channel, then it is safe to assume that the registers logged
provide a coherent view of one error.

With this change EDAC logs look like this:

EDAC MC4: 1 CE memory read error on CPU_SrcID#2_MC#0_Chan#1_DIMM#0 (channel:1 slot:0 page:0x8f26018 offset:0x0 grain:32 syndrome:0x0 -  err_code:0x0101:0x0091 socket:2 imc:0 rank:0 bg:0 ba:0 row:0x1f880 col:0x200 retry_rd_err_log[0001a209 00000000 00000001 04800001 0001f880] correrrcnt[0001 0000 0000 0000 0000 0000 0000 0000])

Signed-off-by: Tony Luck <tony.luck@intel.com>
---

Changes since v1(RFC):
- Fixed case statements in switch to be one per line
- Changed from printing extra information to console to appending to
  EDAC log
- Decode the corrected error registers into the two 16-bit values
  corresponding to the two ranks covered by each.
- Update commit comment with apology about lack of decode for the
  retry_rd_err_log registers

 drivers/edac/skx_base.c   | 51 ++++++++++++++++++++++++++++++++++++---
 drivers/edac/skx_common.c | 12 ++++++---
 drivers/edac/skx_common.h |  4 ++-
 3 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 0fcf3785e8f3..a8853e724d1f 100644
--- a/drivers/edac/skx_base.c
+++ b/drivers/edac/skx_base.c
@@ -46,7 +46,8 @@ static struct skx_dev *get_skx_dev(struct pci_bus *bus, u8 idx)
 }
 
 enum munittype {
-	CHAN0, CHAN1, CHAN2, SAD_ALL, UTIL_ALL, SAD
+	CHAN0, CHAN1, CHAN2, SAD_ALL, UTIL_ALL, SAD,
+	ERRCHAN0, ERRCHAN1, ERRCHAN2,
 };
 
 struct munit {
@@ -68,6 +69,9 @@ static const struct munit skx_all_munits[] = {
 	{ 0x2040, { PCI_DEVFN(10, 0), PCI_DEVFN(12, 0) }, 2, 2, CHAN0 },
 	{ 0x2044, { PCI_DEVFN(10, 4), PCI_DEVFN(12, 4) }, 2, 2, CHAN1 },
 	{ 0x2048, { PCI_DEVFN(11, 0), PCI_DEVFN(13, 0) }, 2, 2, CHAN2 },
+	{ 0x2043, { PCI_DEVFN(10, 3), PCI_DEVFN(12, 3) }, 2, 2, ERRCHAN0 },
+	{ 0x2047, { PCI_DEVFN(10, 7), PCI_DEVFN(12, 7) }, 2, 2, ERRCHAN1 },
+	{ 0x204b, { PCI_DEVFN(11, 3), PCI_DEVFN(13, 3) }, 2, 2, ERRCHAN2 },
 	{ 0x208e, { }, 1, 0, SAD },
 	{ }
 };
@@ -104,10 +108,18 @@ static int get_all_munits(const struct munit *m)
 		}
 
 		switch (m->mtype) {
-		case CHAN0: case CHAN1: case CHAN2:
+		case CHAN0:
+		case CHAN1:
+		case CHAN2:
 			pci_dev_get(pdev);
 			d->imc[i].chan[m->mtype].cdev = pdev;
 			break;
+		case ERRCHAN0:
+		case ERRCHAN1:
+		case ERRCHAN2:
+			pci_dev_get(pdev);
+			d->imc[i].chan[m->mtype - ERRCHAN0].edev = pdev;
+			break;
 		case SAD_ALL:
 			pci_dev_get(pdev);
 			d->sad_all = pdev;
@@ -216,6 +228,39 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
 #define SKX_ILV_REMOTE(tgt)	(((tgt) & 8) == 0)
 #define SKX_ILV_TARGET(tgt)	((tgt) & 7)
 
+static void skx_show_retry_rd_err_log(struct decoded_addr *res,
+				      char *msg, int len)
+{
+	u32 log0, log1, log2, log3, log4;
+	u32 corr0, corr1, corr2, corr3;
+	struct pci_dev *edev;
+	int n;
+
+	edev = res->dev->imc[res->imc].chan[res->channel].edev;
+
+	pci_read_config_dword(edev, 0x154, &log0);
+	pci_read_config_dword(edev, 0x148, &log1);
+	pci_read_config_dword(edev, 0x150, &log2);
+	pci_read_config_dword(edev, 0x15c, &log3);
+	pci_read_config_dword(edev, 0x114, &log4);
+
+	n = snprintf(msg, len, " retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x]",
+		     log0, log1, log2, log3, log4);
+
+	pci_read_config_dword(edev, 0x104, &corr0);
+	pci_read_config_dword(edev, 0x108, &corr1);
+	pci_read_config_dword(edev, 0x10c, &corr2);
+	pci_read_config_dword(edev, 0x110, &corr3);
+
+	if (len - n > 0)
+		snprintf(msg + n, len - n,
+			 " correrrcnt[%.4x %.4x %.4x %.4x %.4x %.4x %.4x %.4x]",
+			 corr0 & 0xffff, corr0 >> 16,
+			 corr1 & 0xffff, corr1 >> 16,
+			 corr2 & 0xffff, corr2 >> 16,
+			 corr3 & 0xffff, corr3 >> 16);
+}
+
 static bool skx_sad_decode(struct decoded_addr *res)
 {
 	struct skx_dev *d = list_first_entry(skx_edac_list, typeof(*d), list);
@@ -659,7 +704,7 @@ static int __init skx_init(void)
 		}
 	}
 
-	skx_set_decode(skx_decode);
+	skx_set_decode(skx_decode, skx_show_retry_rd_err_log);
 
 	if (nvdimm_count && skx_adxl_get() == -ENODEV)
 		skx_printk(KERN_NOTICE, "Only decoding DDR4 address!\n");
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 58b8348d0f71..9174836ba85d 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -37,6 +37,7 @@ static char *adxl_msg;
 
 static char skx_msg[MSG_SIZE];
 static skx_decode_f skx_decode;
+static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
 
@@ -150,9 +151,10 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	return true;
 }
 
-void skx_set_decode(skx_decode_f decode)
+void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	skx_decode = decode;
+	skx_show_retry_rd_err_log = show_retry_log;
 }
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
@@ -481,6 +483,7 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 	bool overflow = GET_BITFIELD(m->status, 62, 62);
 	bool uncorrected_error = GET_BITFIELD(m->status, 61, 61);
 	bool recoverable;
+	int len;
 	u32 core_err_cnt = GET_BITFIELD(m->status, 38, 52);
 	u32 mscod = GET_BITFIELD(m->status, 16, 31);
 	u32 errcode = GET_BITFIELD(m->status, 0, 15);
@@ -540,12 +543,12 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 		}
 	}
 	if (adxl_component_count) {
-		snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
+		len = snprintf(skx_msg, MSG_SIZE, "%s%s err_code:0x%04x:0x%04x %s",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
 			 mscod, errcode, adxl_msg);
 	} else {
-		snprintf(skx_msg, MSG_SIZE,
+		len = snprintf(skx_msg, MSG_SIZE,
 			 "%s%s err_code:0x%04x:0x%04x socket:%d imc:%d rank:%d bg:%d ba:%d row:0x%x col:0x%x",
 			 overflow ? " OVERFLOW" : "",
 			 (uncorrected_error && recoverable) ? " recoverable" : "",
@@ -554,6 +557,9 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			 res->bank_group, res->bank_address, res->row, res->column);
 	}
 
+	if (skx_show_retry_rd_err_log)
+		skx_show_retry_rd_err_log(res, skx_msg + len, MSG_SIZE - len);
+
 	edac_dbg(0, "%s\n", skx_msg);
 
 	/* Call the helper to output message */
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 08cc971a50ea..60d1ea669afd 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -64,6 +64,7 @@ struct skx_dev {
 		u8 src_id, node_id;
 		struct skx_channel {
 			struct pci_dev	*cdev;
+			struct pci_dev	*edev;
 			struct skx_dimm {
 				u8 close_pg;
 				u8 bank_xor_enable;
@@ -113,10 +114,11 @@ struct decoded_addr {
 
 typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci);
 typedef bool (*skx_decode_f)(struct decoded_addr *res);
+typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int len);
 
 int __init skx_adxl_get(void);
 void __exit skx_adxl_put(void);
-void skx_set_decode(skx_decode_f decode);
+void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.20.1

