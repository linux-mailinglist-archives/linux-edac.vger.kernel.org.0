Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692B1B282B
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2019 00:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390255AbfIMWNq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 18:13:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:24050 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390143AbfIMWNq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 18:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:46 -0700
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="337033398"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Sep 2019 15:13:45 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org
Subject: [RFC PATCH 2/2] EDAC, skx: Retrieve and print retry_rd_err_log registers
Date:   Fri, 13 Sep 2019 15:13:44 -0700
Message-Id: <20190913221344.13055-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913221344.13055-1-tony.luck@intel.com>
References: <20190913221344.13055-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Skylake logs some additional useful information in per-channel
registers in addition the the architectural status/addr/misc
logged in the machine check bank.

Pick up this information and print it.
	retry_rd_err_[five 32-bit register values]
	correrrcnt[four hex values]

Note that if additional errors are logged while these registers
are being read, you may see a jumble of values some from earlier
errors, others from later errors (since the registers report the
most recent logged error). The correrrcnt registers provide error
counts per possible rank (two 16-bit values in each register). If
these counts only change by one since the previous error logged
for this channel, then it is safe to assume that the registers
logged provide a coherent view of one error.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/edac/skx_base.c   | 38 ++++++++++++++++++++++++++++++++++++--
 drivers/edac/skx_common.c |  7 ++++++-
 drivers/edac/skx_common.h |  4 +++-
 3 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
index 0fcf3785e8f3..e0c0366fdc84 100644
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
@@ -108,6 +112,10 @@ static int get_all_munits(const struct munit *m)
 			pci_dev_get(pdev);
 			d->imc[i].chan[m->mtype].cdev = pdev;
 			break;
+		case ERRCHAN0: case ERRCHAN1: case ERRCHAN2:
+			pci_dev_get(pdev);
+			d->imc[i].chan[m->mtype - ERRCHAN0].edev = pdev;
+			break;
 		case SAD_ALL:
 			pci_dev_get(pdev);
 			d->sad_all = pdev;
@@ -216,6 +224,32 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
 #define SKX_ILV_REMOTE(tgt)	(((tgt) & 8) == 0)
 #define SKX_ILV_TARGET(tgt)	((tgt) & 7)
 
+static void skx_show_retry_rd_err_log(struct decoded_addr *res)
+{
+	u32 log0, log1, log2, log3, log4;
+	u32 corr0, corr1, corr2, corr3;
+	struct pci_dev *edev;
+
+	edev = res->dev->imc[res->imc].chan[res->channel].edev;
+
+	pci_read_config_dword(edev, 0x154, &log0);
+	pci_read_config_dword(edev, 0x148, &log1);
+	pci_read_config_dword(edev, 0x150, &log2);
+	pci_read_config_dword(edev, 0x15c, &log3);
+	pci_read_config_dword(edev, 0x114, &log4);
+
+	dev_err(&edev->dev, "retry_rd_err_log[%.8x %.8x %.8x %.8x %.8x]\n",
+		log0, log1, log2, log3, log4);
+
+	pci_read_config_dword(edev, 0x104, &corr0);
+	pci_read_config_dword(edev, 0x108, &corr1);
+	pci_read_config_dword(edev, 0x10c, &corr2);
+	pci_read_config_dword(edev, 0x110, &corr3);
+
+	dev_err(&edev->dev, "correrrcnt[%.8x %.8x %.8x %.8x]\n",
+		corr0, corr1, corr2, corr3);
+}
+
 static bool skx_sad_decode(struct decoded_addr *res)
 {
 	struct skx_dev *d = list_first_entry(skx_edac_list, typeof(*d), list);
@@ -659,7 +693,7 @@ static int __init skx_init(void)
 		}
 	}
 
-	skx_set_decode(skx_decode);
+	skx_set_decode(skx_decode, skx_show_retry_rd_err_log);
 
 	if (nvdimm_count && skx_adxl_get() == -ENODEV)
 		skx_printk(KERN_NOTICE, "Only decoding DDR4 address!\n");
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 58b8348d0f71..982154a899ce 100644
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
@@ -611,6 +613,9 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			   "%u APIC 0x%x\n", mce->cpuvendor, mce->cpuid,
 			   mce->time, mce->socketid, mce->apicid);
 
+	if (skx_show_retry_rd_err_log)
+		skx_show_retry_rd_err_log(&res);
+
 	skx_mce_output_error(mci, mce, &res);
 
 	return NOTIFY_DONE;
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 08cc971a50ea..25209321ea0d 100644
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
+typedef void (*skx_show_retry_log_f)(struct decoded_addr *res);
 
 int __init skx_adxl_get(void);
 void __exit skx_adxl_put(void);
-void skx_set_decode(skx_decode_f decode);
+void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
-- 
2.20.1

