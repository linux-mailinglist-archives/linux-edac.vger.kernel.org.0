Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD1F113E98
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2019 10:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfLEJxU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Dec 2019 04:53:20 -0500
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:42900
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbfLEJxT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Dec 2019 04:53:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575539597;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=a4R1Cwzd9Cqsa21aNFlkQOSOaD5FzwZPb/kkKGRaRfY=;
        b=HhdttI/aPTbIJ0aRvLjkk+ZFNiJ1TvKksU4CRNfF+QUnB3LuHFKunUMImEZgsSRS
        cwuVDZcTPli/MTkw72Bzkkm8/Bsi7qv52/c105D53l1W+cDA7FrOjONM3w+v5jdhZzG
        G92Q7ZdLJ3S6aZ1/MoM7ghs+g72/HpN1goJnIWf0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575539597;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=a4R1Cwzd9Cqsa21aNFlkQOSOaD5FzwZPb/kkKGRaRfY=;
        b=hLe6Y1eM0UFDgbi0HP4LDfhFAZRQxOp5GrF4NQKhdrSfAGoEi5UrntqZdRnGYMDt
        z1CsaL+kwZzmi57SG845asa0OxRKhlkkGzYfjkKXQSDpVuLzrhHaN2wHJC1+evgYa76
        ziFBkksYGszhxE8ZazZKK9R2Ei9xKIPWnrOPgsys=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A5571C49484
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
Date:   Thu, 5 Dec 2019 09:53:17 +0000
Message-ID: <0101016ed57a615e-5f4a2087-4cc4-498d-ba34-e14807d02b94-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2019.12.05-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Kryo{3,4}XX CPU cores implement RAS extensions to support
Error Correcting Code(ECC). Currently all Kryo{3,4}XX CPU
cores (gold/silver a.k.a big/LITTLE) support ECC via RAS.
This adds an interrupt based driver for those CPUs and
provides an optional polling of error recording system
registers.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 MAINTAINERS                   |   7 +
 drivers/edac/Kconfig          |  20 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/qcom_kryo_edac.c | 679 ++++++++++++++++++++++++++++++++++
 4 files changed, 707 insertions(+)
 create mode 100644 drivers/edac/qcom_kryo_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2d80079dccc..f58c93f963f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6049,6 +6049,13 @@ L:	linux-edac@vger.kernel.org
 S:	Maintained
 F:	drivers/edac/qcom_edac.c
 
+EDAC-KRYO-QCOM
+M:	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+L:	linux-edac@vger.kernel.org
+S:	Maintained
+F:	drivers/edac/qcom_kryo_edac.c
+
 EDIROL UA-101/UA-1000 DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 417dad635526..cd78ac2917c9 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -508,6 +508,26 @@ config EDAC_QCOM
 	  For debugging issues having to do with stability and overall system
 	  health, you should probably say 'Y' here.
 
+config EDAC_QCOM_KRYO
+	tristate "QCOM Kryo EDAC for CPU L1/L2/L3-SCU caches"
+	depends on ARCH_QCOM && ARM64_RAS_EXTN
+	help
+	  Support for Error detection and correction on Kryo Gold and Silver CPU
+	  cores with RAS extensions. Currently it detects and reports all Single
+	  Bit Errors (SBEs) and Double Bit Errors (DBEs).
+
+	  For debugging issues having to do with stability and overall system
+	  health, you should probably say 'Y' here.
+
+config EDAC_QCOM_KRYO_POLL
+	depends on EDAC_QCOM_KRYO
+	bool "Poll on Kryo ECC registers"
+	help
+	  This option chooses whether or not you want to poll on the Kryo ECC
+	  registers. When this is enabled, the polling rate can be set as a
+	  module parameter. By default, it will call the polling function every
+	  second.
+
 config EDAC_ASPEED
 	tristate "Aspeed AST 2500 SoC"
 	depends on MACH_ASPEED_G5
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index d77200c9680b..29edcfa6ec0e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -85,5 +85,6 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
+obj-$(CONFIG_EDAC_QCOM_KRYO)		+= qcom_kryo_edac.o
 obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
 obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
diff --git a/drivers/edac/qcom_kryo_edac.c b/drivers/edac/qcom_kryo_edac.c
new file mode 100644
index 000000000000..05b60ad3cb0e
--- /dev/null
+++ b/drivers/edac/qcom_kryo_edac.c
@@ -0,0 +1,679 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cpu_pm.h>
+#include <linux/of_irq.h>
+#include <linux/smp.h>
+
+#include <asm/cputype.h>
+#include <asm/sysreg.h>
+
+#include "edac_device.h"
+#include "edac_mc.h"
+
+#define DRV_NAME		"qcom_kryo_edac"
+
+/*
+ * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.3
+ * ARM DSU TRM Chapter B2.3
+ * CFI = Corrected Fault Handling interrupt, FI = Fault handling interrupt
+ * UI = Uncorrected error recovery interrupt, ED = Error Detection
+ */
+#define KRYO_ERRXCTLR_ED	BIT(0)
+#define KRYO_ERRXCTLR_UI	BIT(2)
+#define KRYO_ERRXCTLR_FI	BIT(3)
+#define KRYO_ERRXCTLR_CFI	BIT(8)
+#define KRYO_ERRXCTLR_ENABLE	(KRYO_ERRXCTLR_CFI | KRYO_ERRXCTLR_FI | \
+				 KRYO_ERRXCTLR_UI | KRYO_ERRXCTLR_ED)
+
+/*
+ * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.4
+ * ARM DSU TRM Chapter B2.4
+ */
+#define KRYO_ERRXFR_ED		GENMASK(1, 0)
+#define KRYO_ERRXFR_DE		GENMASK(3, 2)
+#define KRYO_ERRXFR_UI		GENMASK(5, 4)
+#define KRYO_ERRXFR_FI		GENMASK(7, 6)
+#define KRYO_ERRXFR_UE		GENMASK(9, 8)
+#define KRYO_ERRXFR_CFI		GENMASK(11, 10)
+#define KRYO_ERRXFR_CEC		GENMASK(14, 12)
+#define KRYO_ERRXFR_RP		BIT(15)
+#define KRYO_ERRXFR_SUPPORTED	(KRYO_ERRXFR_ED | KRYO_ERRXFR_DE | \
+				 KRYO_ERRXFR_UI | KRYO_ERRXFR_FI | \
+				 KRYO_ERRXFR_UE | KRYO_ERRXFR_CFI | \
+				 KRYO_ERRXFR_CEC | KRYO_ERRXFR_RP)
+
+/*
+ * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.5
+ * ARM DSU TRM Chapter B2.5
+ */
+#define KRYO_ERRXMISC0_CECR	GENMASK_ULL(38, 32)
+#define KRYO_ERRXMISC0_CECO	GENMASK_ULL(46, 40)
+
+/* ARM Cortex-A76 TRM Chapter B3.5 */
+#define KRYO_ERRXMISC0_UNIT	GENMASK(3, 0)
+#define KRYO_ERRXMISC0_LVL	GENMASK(3, 1)
+
+/* ARM Cortex-A76 TRM Chapter B3.10 has SERR bitfields 4:0
+ * but Cortex-A55, Cortex-A75 and DSU TRM has SERR bitfields 7:0.
+ * Since max error record is 21, we can use bitfields 4:0 for
+ * Kryo{3,4}XX CPUs.
+ */
+#define KRYO_ERRXSTATUS_SERR	GENMASK(4, 0)
+#define KRYO_ERRXSTATUS_DE	BIT(23)
+#define KRYO_ERRXSTATUS_CE	GENMASK(25, 24)
+#define KRYO_ERRXSTATUS_MV	BIT(26)
+#define KRYO_ERRXSTATUS_UE	BIT(29)
+#define KRYO_ERRXSTATUS_VALID	BIT(30)
+
+/* ARM Cortex-A76 TRM Chapter B3.5
+ * IC = Instruction Cache, DC = Data Cache
+ */
+#define KRYO_L1_UNIT_IC		0x1
+#define KRYO_L2_UNIT_TLB	0x2
+#define KRYO_L1_UNIT_DC		0x4
+#define KRYO_L2_UNIT		0x8
+
+/*
+ * ARM Cortex-A55 TRM Chapter B2.36
+ * ARM Cortex-A75, Cortex-A76 TRM Chapter B2.37
+ */
+#define KRYO_ERR_RECORD_L1_L2	0x0
+#define KRYO_ERR_RECORD_L3	0x1
+
+/* ARM DSU TRM Chapter B2.10 */
+#define BUS_ERROR		0x12
+
+/* QCOM Kryo CPU part numbers */
+#define KRYO3XX_GOLD		0x802
+#define KRYO4XX_GOLD		0x804
+#define KRYO4XX_SILVER_V1	0x803
+#define KRYO4XX_SILVER_V2	0x805
+
+#define KRYO_EDAC_MSG_MAX	256
+
+static int poll_msec = 1000;
+module_param(poll_msec, int, 0444);
+
+enum {
+	KRYO_L1 = 0,
+	KRYO_L2,
+	KRYO_L3,
+};
+
+/* CE = Corrected Error, UE = Uncorrected Error, DE = Deferred Error */
+enum {
+	KRYO_L1_CE = 0,
+	KRYO_L1_UE,
+	KRYO_L1_DE,
+	KRYO_L2_CE,
+	KRYO_L2_UE,
+	KRYO_L2_DE,
+	KRYO_L3_CE,
+	KRYO_L3_UE,
+	KRYO_L3_DE,
+};
+
+struct error_record {
+	u32 error_code;
+	const char *error_msg;
+};
+
+struct error_type {
+	void (*fn)(struct edac_device_ctl_info *edev_ctl,
+		   int inst_nr, int block_nr, const char *msg);
+	const char *msg;
+};
+
+/*
+ * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.10
+ * ARM DSU TRM Chapter B2.10
+ */
+static const struct error_record serror_record[] = {
+	{ 0x1,	"Errors due to fault injection"		},
+	{ 0x2,	"ECC error from internal data buffer"	},
+	{ 0x6,	"ECC error on cache data RAM"		},
+	{ 0x7,	"ECC error on cache tag or dirty RAM"	},
+	{ 0x8,	"Parity error on TLB data RAM"		},
+	{ 0x9,	"Parity error on TLB tag RAM"		},
+	{ 0x12,	"Error response for a cache copyback"	},
+	{ 0x15,	"Deferred error not supported"		},
+};
+
+static const struct error_type err_type[] = {
+	{ edac_device_handle_ce, "Kryo L1 Corrected Error"	},
+	{ edac_device_handle_ue, "Kryo L1 Uncorrected Error"	},
+	{ edac_device_handle_ue, "Kryo L1 Deferred Error"	},
+	{ edac_device_handle_ce, "Kryo L2 Corrected Error"	},
+	{ edac_device_handle_ue, "Kryo L2 Uncorrected Error"	},
+	{ edac_device_handle_ue, "Kryo L2 Deferred Error"	},
+	{ edac_device_handle_ce, "L3 Corrected Error"		},
+	{ edac_device_handle_ue, "L3 Uncorrected Error"		},
+	{ edac_device_handle_ue, "L3 Deferred Error"		},
+};
+
+static struct edac_device_ctl_info __percpu *edac_dev;
+static struct edac_device_ctl_info *drv_edev_ctl;
+
+static const char *get_error_msg(u64 errxstatus)
+{
+	const struct error_record *rec;
+	u32 errxstatus_serr;
+
+	errxstatus_serr = FIELD_GET(KRYO_ERRXSTATUS_SERR, errxstatus);
+
+	for (rec = serror_record; rec->error_code; rec++) {
+		if (errxstatus_serr == rec->error_code)
+			return rec->error_msg;
+	}
+
+	return NULL;
+}
+
+static void dump_syndrome_reg(int error_type, int level,
+			      u64 errxstatus, u64 errxmisc,
+			      struct edac_device_ctl_info *edev_ctl)
+{
+	char msg[KRYO_EDAC_MSG_MAX];
+	const char *error_msg;
+	int cpu;
+
+	cpu = raw_smp_processor_id();
+
+	error_msg = get_error_msg(errxstatus);
+	if (!error_msg)
+		return;
+
+	snprintf(msg, KRYO_EDAC_MSG_MAX,
+		 "CPU%d: %s, ERRXSTATUS_EL1:%#llx ERRXMISC0_EL1:%#llx, %s",
+		 cpu, err_type[error_type].msg, errxstatus, errxmisc,
+		 error_msg);
+
+	err_type[error_type].fn(edev_ctl, 0, level, msg);
+}
+
+static void kryo_check_err_type(u64 errxstatus, u64 errxmisc,
+				struct edac_device_ctl_info *edev_ctl,
+				int level)
+{
+	u32 errxstatus_ue, errxstatus_ce, errxstatus_de;
+
+	errxstatus_ce = FIELD_GET(KRYO_ERRXSTATUS_CE, errxstatus);
+	errxstatus_ue = FIELD_GET(KRYO_ERRXSTATUS_UE, errxstatus);
+	errxstatus_de = FIELD_GET(KRYO_ERRXSTATUS_DE, errxstatus);
+
+	switch (level) {
+	case KRYO_L1:
+		if (errxstatus_ce)
+			dump_syndrome_reg(KRYO_L1_CE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_ue)
+			dump_syndrome_reg(KRYO_L1_UE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_de)
+			dump_syndrome_reg(KRYO_L1_DE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else
+			edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
+		break;
+	case KRYO_L2:
+		if (errxstatus_ce)
+			dump_syndrome_reg(KRYO_L2_CE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_ue)
+			dump_syndrome_reg(KRYO_L2_UE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_de)
+			dump_syndrome_reg(KRYO_L2_DE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else
+			edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
+		break;
+	case KRYO_L3:
+		if (errxstatus_ce)
+			dump_syndrome_reg(KRYO_L3_CE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_ue)
+			dump_syndrome_reg(KRYO_L3_UE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else if (errxstatus_de)
+			dump_syndrome_reg(KRYO_L3_DE, level, errxstatus,
+					  errxmisc, edev_ctl);
+		else
+			edac_printk(KERN_ERR, DRV_NAME, "Unknown error\n");
+		break;
+	default:
+		edac_printk(KERN_ERR, DRV_NAME, "Unknown level\n");
+	}
+}
+
+static inline void kryo_clear_error(u64 errxstatus)
+{
+	write_sysreg_s(errxstatus, SYS_ERXSTATUS_EL1);
+	isb();
+}
+
+static void kryo_parse_l1_l2_cache_error(u64 errxstatus, u64 errxmisc,
+					 struct edac_device_ctl_info *edev_ctl,
+					 int cpu)
+{
+	u32 part_num = read_cpuid_part_number();
+
+	switch (part_num) {
+	/* Kryo3XX gold CPU cores do not have a UNIT bitfield */
+	case KRYO3XX_GOLD:
+	case KRYO4XX_SILVER_V1:
+	case KRYO4XX_SILVER_V2:
+		switch (FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc)) {
+		case KRYO_L1:
+			kryo_check_err_type(errxstatus, errxmisc,
+					    edev_ctl, KRYO_L1);
+			break;
+		case KRYO_L2:
+			kryo_check_err_type(errxstatus, errxmisc,
+					    edev_ctl, KRYO_L2);
+			break;
+		default:
+			edac_printk(KERN_ERR, DRV_NAME,
+				    "silver cpu:%d unknown error: %lu\n", cpu,
+				    FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc));
+		}
+		break;
+	/* Kryo4XX gold CPU cores have a UNIT bitfield to identify levels */
+	case KRYO4XX_GOLD:
+		switch (FIELD_GET(KRYO_ERRXMISC0_UNIT, errxmisc)) {
+		case KRYO_L1_UNIT_DC:
+		case KRYO_L1_UNIT_IC:
+			kryo_check_err_type(errxstatus, errxmisc,
+					    edev_ctl, KRYO_L1);
+			break;
+		case KRYO_L2_UNIT:
+		case KRYO_L2_UNIT_TLB:
+			kryo_check_err_type(errxstatus, errxmisc,
+					    edev_ctl, KRYO_L2);
+			break;
+		default:
+			edac_printk(KERN_ERR, DRV_NAME,
+				    "gold cpu:%d unknown error: %lu\n", cpu,
+				    FIELD_GET(KRYO_ERRXMISC0_UNIT, errxmisc));
+		}
+		break;
+	default:
+		edac_printk(KERN_ERR, DRV_NAME,
+			    "Error in matching cpu%d with part num:%u\n",
+			    cpu, part_num);
+	}
+}
+
+static inline bool kryo_check_regs_valid(u64 errxstatus)
+{
+	/* Check if status and misc regs are valid */
+	if (!(FIELD_GET(KRYO_ERRXSTATUS_VALID, errxstatus)) ||
+	    !(FIELD_GET(KRYO_ERRXSTATUS_MV, errxstatus)))
+		return false;
+
+	return true;
+}
+
+static void kryo_check_l1_l2_ecc(void *info)
+{
+	struct edac_device_ctl_info *edev_ctl = info;
+	u64 errxstatus;
+	u64 errxmisc;
+	int cpu;
+
+	cpu = smp_processor_id();
+	/* We know record 0 is L1 and L2 */
+	write_sysreg_s(0, SYS_ERRSELR_EL1);
+	isb();
+
+	errxstatus = read_sysreg_s(SYS_ERXSTATUS_EL1);
+	if (!kryo_check_regs_valid(errxstatus))
+		return;
+
+	errxmisc = read_sysreg_s(SYS_ERXMISC0_EL1);
+	/* Check if L1/L2 error */
+	if (!(FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc) == KRYO_L1) &&
+	    !(FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc) == KRYO_L2))
+		return;
+
+	kryo_parse_l1_l2_cache_error(errxstatus, errxmisc, edev_ctl, cpu);
+	kryo_clear_error(errxstatus);
+}
+
+static irqreturn_t kryo_l1_l2_handler(int irq, void *drvdata)
+{
+	struct edac_device_ctl_info *edev_ctl = *(void **)drvdata;
+
+	kryo_check_l1_l2_ecc(edev_ctl);
+
+	return IRQ_HANDLED;
+}
+
+static bool kryo_check_l3_bus_error(u64 errxstatus)
+{
+	if (FIELD_GET(KRYO_ERRXSTATUS_SERR, errxstatus) == BUS_ERROR) {
+		edac_printk(KERN_ERR, DRV_NAME, "Bus Error\n");
+		return true;
+	}
+
+	return false;
+}
+
+static void kryo_check_l3_scu_ecc(struct edac_device_ctl_info *edev_ctl)
+{
+	u64 errxstatus, errxmisc;
+
+	/* We know record 1 is L3-SCU */
+	write_sysreg_s(1, SYS_ERRSELR_EL1);
+	isb();
+
+	errxstatus = read_sysreg_s(SYS_ERXSTATUS_EL1);
+	if (!kryo_check_regs_valid(errxstatus))
+		return;
+
+	errxmisc = read_sysreg_s(SYS_ERXMISC0_EL1);
+	/* Check if L3/bus error */
+	if (!(FIELD_GET(KRYO_ERRXMISC0_LVL, errxmisc) == KRYO_L3) ||
+	    kryo_check_l3_bus_error(errxstatus))
+		return;
+
+	/* Check if Corrected/Uncorrected/Deferred error and dump regs */
+	kryo_check_err_type(errxstatus, errxmisc, edev_ctl, KRYO_L3);
+	kryo_clear_error(errxstatus);
+}
+
+static irqreturn_t kryo_l3_scu_handler(int irq, void *edev_ctl)
+{
+	kryo_check_l3_scu_ecc(edev_ctl);
+
+	return IRQ_HANDLED;
+}
+
+static void kryo_l1_l2_irq_disable(void *drvdata)
+{
+	int irq = *(int *)drvdata;
+
+	disable_percpu_irq(irq);
+}
+
+static void kryo_l1_l2_irq_enable(void *drvdata)
+{
+	int irq = *(int *)drvdata;
+
+	enable_percpu_irq(irq, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static int kryo_l1_l2_setup_irq(struct platform_device *pdev,
+				struct edac_device_ctl_info *edev_ctl)
+{
+	int cpu, errirq, faultirq, ret;
+
+	edac_dev = devm_alloc_percpu(&pdev->dev, *edac_dev);
+	if (!edac_dev)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		preempt_disable();
+		per_cpu(edac_dev, cpu) = edev_ctl;
+		preempt_enable();
+	}
+
+	faultirq = platform_get_irq_byname(pdev, "l1-l2-faultirq");
+	if (faultirq < 0) {
+		ret = faultirq;
+		goto out_fault;
+	}
+
+	ret = request_percpu_irq(faultirq, kryo_l1_l2_handler,
+				 "kryo_l1_l2_ecc_faultirq",
+				 &edac_dev);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to request l1-l2-faultirq %d\n", faultirq);
+		goto out_fault;
+	}
+
+	on_each_cpu(kryo_l1_l2_irq_enable, &faultirq, 1);
+
+out_fault:
+	errirq = platform_get_irq_byname(pdev, "l1-l2-errirq");
+	if (errirq < 0) {
+		ret = errirq;
+		goto out_err;
+	}
+
+	ret = request_percpu_irq(errirq, kryo_l1_l2_handler,
+				 "kryo_l1_l2_ecc_errirq",
+				 &edac_dev);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to request l1-l2-errirq %d\n", errirq);
+		goto out_err;
+	}
+
+	on_each_cpu(kryo_l1_l2_irq_enable, &errirq, 1);
+
+	return ret;
+
+out_err:
+	free_percpu_irq(faultirq, &edac_dev);
+
+	return ret;
+}
+
+static int kryo_l3_setup_irq(struct platform_device *pdev, void *edev_ctl)
+{
+	int errirq, faultirq, ret;
+
+	faultirq = platform_get_irq_byname(pdev, "l3-scu-faultirq");
+	if (faultirq < 0) {
+		ret = faultirq;
+		goto out_fault;
+	}
+
+	ret = devm_request_irq(&pdev->dev, faultirq, kryo_l3_scu_handler,
+			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			       "kryo_l3_scu_ecc_faultirq", edev_ctl);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to request l3-scu-faultirq %d\n", faultirq);
+	}
+
+out_fault:
+	errirq = platform_get_irq_byname(pdev, "l3-scu-errirq");
+	if (errirq < 0) {
+		ret = errirq;
+		goto out_err;
+	}
+
+	ret = devm_request_irq(&pdev->dev, errirq, kryo_l3_scu_handler,
+			       IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+			       "kryo_l3_scu_ecc_errirq", edev_ctl);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to request l3-scu-errirq %d\n", errirq);
+	}
+
+out_err:
+	return ret;
+}
+
+static int qcom_kryo_edac_setup_irq(struct platform_device *pdev,
+				    struct edac_device_ctl_info *edev_ctl)
+{
+	int ret;
+
+	ret = kryo_l1_l2_setup_irq(pdev, edev_ctl);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to setup l1-l2 irq\n");
+	}
+
+	ret = kryo_l3_setup_irq(pdev, edev_ctl);
+	if (ret) {
+		edac_printk(KERN_DEBUG, DRV_NAME,
+			    "Failed to setup l3-scu irq\n");
+	}
+
+	return ret;
+}
+
+static void kryo_poll_cache_error(struct edac_device_ctl_info *edev_ctl)
+{
+	if (!edev_ctl)
+		edev_ctl = drv_edev_ctl;
+
+	on_each_cpu(kryo_check_l1_l2_ecc, edev_ctl, 1);
+	kryo_check_l3_scu_ecc(edev_ctl);
+}
+
+static inline void kryo_enable_err_record(void)
+{
+	write_sysreg_s(KRYO_ERRXCTLR_ENABLE, SYS_ERXCTLR_EL1);
+	write_sysreg_s(KRYO_ERRXMISC0_CECR | KRYO_ERRXMISC0_CECO,
+		       SYS_ERXMISC0_EL1);
+	isb();
+}
+
+static inline void qcom_kryo_init_l3(void)
+{
+	if (!FIELD_GET(KRYO_ERRXFR_SUPPORTED, read_sysreg_s(SYS_ERXFR_EL1)))
+		return;
+
+	/* L3 is shared */
+	write_sysreg_s(KRYO_ERR_RECORD_L3, SYS_ERRSELR_EL1);
+	kryo_enable_err_record();
+}
+
+static void qcom_kryo_init_l1_l2(void *data)
+{
+	if (!FIELD_GET(KRYO_ERRXFR_SUPPORTED, read_sysreg_s(SYS_ERXFR_EL1)))
+		return;
+
+	/* L1 and L2 is per-cpu */
+	write_sysreg_s(KRYO_ERR_RECORD_L1_L2, SYS_ERRSELR_EL1);
+	kryo_enable_err_record();
+}
+
+static int kryo_edac_pm_notify(struct notifier_block *nb, unsigned long action,
+			       void *data)
+{
+	switch (action) {
+	case CPU_PM_EXIT:
+		qcom_kryo_init_l1_l2(NULL);
+		qcom_kryo_init_l3();
+		kryo_check_l1_l2_ecc(drv_edev_ctl);
+		kryo_check_l3_scu_ecc(drv_edev_ctl);
+		break;
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block kryo_edac_pm_nb = {
+	.notifier_call = kryo_edac_pm_notify,
+};
+
+static inline void qcom_kryo_edac_setup(void)
+{
+	on_each_cpu(qcom_kryo_init_l1_l2, NULL, 1);
+	qcom_kryo_init_l3();
+}
+
+static int qcom_kryo_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edev_ctl;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	qcom_kryo_edac_setup();
+
+	edev_ctl = edac_device_alloc_ctl_info(0, DRV_NAME, 1, "L", 3, 1, NULL,
+					      0, edac_device_alloc_index());
+	if (!edev_ctl)
+		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_EDAC_QCOM_KRYO_POLL)) {
+		edev_ctl->poll_msec = poll_msec;
+		edev_ctl->edac_check = kryo_poll_cache_error;
+	}
+	edev_ctl->dev = dev;
+	edev_ctl->mod_name = DRV_NAME;
+	edev_ctl->dev_name = dev_name(dev);
+	edev_ctl->ctl_name = "qcom_kryo_cache";
+	edev_ctl->panic_on_ue = 1;
+
+	ret = edac_device_add_device(edev_ctl);
+	if (ret)
+		goto out_mem;
+
+	platform_set_drvdata(pdev, edev_ctl);
+	drv_edev_ctl = edev_ctl;
+
+	ret = qcom_kryo_edac_setup_irq(pdev, edev_ctl);
+	if (ret)
+		goto out_dev;
+
+	cpu_pm_register_notifier(&kryo_edac_pm_nb);
+
+	return ret;
+
+out_dev:
+	edac_device_del_device(edev_ctl->dev);
+out_mem:
+	edac_device_free_ctl_info(edev_ctl);
+
+	return ret;
+}
+
+static void qcom_kryo_edac_teardown(struct platform_device *pdev)
+{
+	int errirq, faultirq;
+
+	faultirq = platform_get_irq_byname(pdev, "l1-l2-faultirq");
+	on_each_cpu(kryo_l1_l2_irq_disable, &faultirq, 1);
+	free_percpu_irq(faultirq, &edac_dev);
+
+	errirq = platform_get_irq_byname(pdev, "l1-l2-errirq");
+	on_each_cpu(kryo_l1_l2_irq_disable, &errirq, 1);
+	free_percpu_irq(errirq, &edac_dev);
+
+	cpu_pm_unregister_notifier(&kryo_edac_pm_nb);
+}
+
+static int qcom_kryo_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *edev_ctl = platform_get_drvdata(pdev);
+
+	qcom_kryo_edac_teardown(pdev);
+
+	edac_device_del_device(edev_ctl->dev);
+	edac_device_free_ctl_info(edev_ctl);
+
+	return 0;
+}
+
+static const struct of_device_id qcom_kryo_edac_of_match[] = {
+	{ .compatible = "qcom,kryo-edac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qcom_kryo_edac_of_match);
+
+static struct platform_driver qcom_kryo_edac_driver = {
+	.probe = qcom_kryo_edac_probe,
+	.remove = qcom_kryo_edac_remove,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table	= qcom_kryo_edac_of_match,
+	},
+};
+module_platform_driver(qcom_kryo_edac_driver);
+
+MODULE_DESCRIPTION("QCOM Kryo EDAC driver");
+MODULE_LICENSE("GPL v2");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

