Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB27339CF
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2019 22:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfFCUgM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Jun 2019 16:36:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:21498 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfFCUgM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 3 Jun 2019 16:36:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jun 2019 13:36:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,548,1549958400"; 
   d="scan'208";a="181288485"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jun 2019 13:36:10 -0700
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, mchehab@kernel.org, james.morse@arm.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>
Subject: [PATCH] EDAC/altera: Warm Reset option for Stratix10 peripheral DBE
Date:   Mon,  3 Jun 2019 15:37:49 -0500
Message-Id: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The Stratix10 peripheral FIFO memories can recover from double
bit errors with a warm reset instead of a cold reset.
Add the option of a warm reset for peripheral (USB, Ethernet)
memories.

CPU memories such as SDRAM and OCRAM require a cold reset for
DBEs.
Filter on whether the error is a SDRAM/OCRAM or a peripheral
FIFO memory to determine which reset to use when the warm
reset option is configured.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 drivers/edac/Kconfig       |  9 +++++++++
 drivers/edac/altera_edac.c | 31 +++++++++++++++++++++++++++++--
 drivers/edac/altera_edac.h |  4 ++++
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..e47c428d485d 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -394,6 +394,15 @@ config EDAC_ALTERA
 	  Altera SOCs. This is the global enable for the
 	  various Altera peripherals.
 
+config EDAC_ALTERA_ARM64_WARM_RESET
+	bool "Altera ARM64 Peripheral Warm Reset"
+	depends on EDAC_ALTERA=y && ARM64
+	help
+	  Support for Warm Reset on peripheral FIFO double bit errors
+	  on SoCFPGA ARM64 platforms. Otherwise a peripheral FIFO DBE
+	  will cause a cold reset. SDRAM and OCRAM DBEs always cause
+	  a cold reset.
+
 config EDAC_ALTERA_SDRAM
 	bool "Altera SDRAM ECC"
 	depends on EDAC_ALTERA=y
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8816f74a22b4..179601f14b48 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2036,6 +2036,19 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
 /* panic routine issues reboot on non-zero panic_timeout */
 extern int panic_timeout;
 
+#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
+/* EL3 SMC call to setup CPUs for warm reset */
+void panic_smp_self_stop(void)
+{
+	struct arm_smccc_res result;
+
+	__cpu_disable();
+	cpu_relax();
+	arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, S10_WARM_RESET_WFI_FLAG,
+		      S10_WARM_RESET_WFI_FLAG, 0, 0, 0, 0, 0, &result);
+}
+#endif
+
 /*
  * The double bit error is handled through SError which is fatal. This is
  * called as a panic notifier to printout ECC error info as part of the panic.
@@ -2067,14 +2080,28 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
 			regmap_write(edac->ecc_mgr_map,
 				     S10_SYSMGR_UE_ADDR_OFST, err_addr);
 			edac_printk(KERN_ERR, EDAC_DEVICE,
-				    "EDAC: [Fatal DBE on %s @ 0x%08X]\n",
-				    ed->edac_dev_name, err_addr);
+				    "EDAC: [Fatal DBE on %s [CPU=%d] @ 0x%08X]\n",
+				    ed->edac_dev_name, raw_smp_processor_id(),
+				    err_addr);
 			break;
 		}
 		/* Notify the System through SMC. Reboot delay = 1 second */
+#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
+		/* Handle peripheral FIFO DBE as Warm Resets */
+		if (dberror & S10_COLD_RESET_MASK) {
+			panic_timeout = 1;
+			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0,
+				      0, 0, 0, &result);
+		} else {
+			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE,
+				      S10_WARM_RESET_WFI_FLAG | dberror, 0, 0,
+				      0, 0, 0, 0, &result);
+		}
+#else
 		panic_timeout = 1;
 		arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0, 0,
 			      0, 0, &result);
+#endif
 	}
 
 	return NOTIFY_DONE;
diff --git a/drivers/edac/altera_edac.h b/drivers/edac/altera_edac.h
index 55654cc4bcdf..e5936fbe3964 100644
--- a/drivers/edac/altera_edac.h
+++ b/drivers/edac/altera_edac.h
@@ -327,6 +327,10 @@ struct altr_sdram_mc_data {
 #define ECC_READ_EOVR                     0x2
 #define ECC_READ_EDOVR                    0x3
 
+/* DRAM and OCRAM require cold reset */
+#define S10_COLD_RESET_MASK               0x30002
+#define S10_WARM_RESET_WFI_FLAG           BIT(31)
+
 struct altr_edac_device_dev;
 
 struct edac_device_prv_data {
-- 
2.7.4

