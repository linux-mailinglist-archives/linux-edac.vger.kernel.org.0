Return-Path: <linux-edac+bounces-1420-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DEE91AE3D
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B831F24826
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17091A38E4;
	Thu, 27 Jun 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECugPmxW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607F1A38C1;
	Thu, 27 Jun 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509622; cv=none; b=BCEMXcPA4JcnGgdkvotjGbk2WkpKDWl8ZgtE7LPjf0C7Y1g6xXG+A2SjFfU98Hbfm9N91uSot/+1wnGXCTpF5xroD0cu3j5lTaAq46AFW0jnOI/tNZ6Lp0Hqcph0boEiFZMpSRHo81AdfHoFLH1y+fWa3gM8n/Rdyer4vOo+TEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509622; c=relaxed/simple;
	bh=SZ+8zrywW44BOxbajqny9vdlenaAxBnhESom28XDiLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FB4atXZfAWNAHEyiatjQwfx3BjTix/0YJJFYvafuj1ZOWiTmG2c82/EpaT1mbhC+37myoGzmuoHHhZn9NoLZgyUeGxr8ivNZkDXD3NcUxjEQIwJAqf3eU0qp/EwjlsQzyAcrVD8OVUOcORWmduu4HKJiQTvJH4jaXH1LU4UInl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECugPmxW; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso6138707e87.3;
        Thu, 27 Jun 2024 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509618; x=1720114418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou9xwQ4kh82pazxEVShgZVlO81wRyh1QR5WaIV7jx88=;
        b=ECugPmxWAbRxYKBy8oZP4DzU4AGUd0qIskZmze+VrAo4g5g8mAN9RpDf8TMM6hMZ5R
         K5WRqB2j7ugUffz0Va1g99WB4AvGLiCaQhNmDmxSmQK1QsYQrYnEwmudYYR8EJ3tQuT1
         J5oqaT6JIyeKU8h2lu5FQpptIyySTeOyn2amvjeiifTS2Lc9qtdcZ/xcIkyzH9mgcfVA
         y5etyMaqhb/ssbylQih+pJEqAXvNvoK79k3X12Sfqrcs3YMaPe4FTLxd5h41MxFJ6KG9
         D8GDyUoTdhsl9eV3kZWExsIEQDi+sjQOvPz6Rjah4VHLRnX0da8DV/oM/eGu2+weBeX1
         CVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509618; x=1720114418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ou9xwQ4kh82pazxEVShgZVlO81wRyh1QR5WaIV7jx88=;
        b=J1LH/XcABewykViHd74qjI+rf1Ui4CNNhc97P5uvP6kWwzjLap3+cjwVbf2zZvRgUR
         Jk2udIacdZWUwimMgbmZW7zSqB1vz8Da+PaDXRiSFamsJSTL2mZJu9pSxGpJuAOi1vlv
         hQP6a+0WeeH7oKbUCzsmXFnjoclCwDESyYaBCUlpAZgXhgIFWPrg+lTA4VtXNk9uSHjN
         VOcHmyz+RzEboIL3Ut7dlLVaJl6FbKAq6+zphn7l3nH6j11mePgyRCC9Qfum+o+f1e81
         r1sxhTwWlp/+jAYh4issQZRZ06hvPat/4ziwr1cB9wGFGtniDTW1G+kXYuQIaVPNxG0y
         q+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfkwvBmL3gZj08MzJWWkb0fJ9RVETktR+ehvjkWgOxZnHgARfIyjPTMbHy4ZSvHynVeGwJFHETzuqnjSEZPVcQlk1OeUSytR0RlUqa+yS8Q4Gy+ePin4bPwKIhjhiVumarkvZpoXMH4A==
X-Gm-Message-State: AOJu0YzfHFKlYgnTH2gMfof2XQeiQ3Pmt7IrwjjqawzbywCDSvhqQJ0N
	3gU81gL+uZw1Hod1/h49gT9zfEQ3+s9TnVD6QkeLLDF1UZUxFDCX
X-Google-Smtp-Source: AGHT+IGue7iBUBFMyG0Nzu2F9Ny6M6LolDWN26yUw6FghVpbqKGSzNMD/EMMdmINivFvLt4RyaMH/g==
X-Received: by 2002:ac2:4197:0:b0:52c:d76f:7f61 with SMTP id 2adb3069b0e04-52ce186148amr9982368e87.56.1719509617888;
        Thu, 27 Jun 2024 10:33:37 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab2778csm47e87.133.2024.06.27.10.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:37 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Michal Simek <michal.simek@amd.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Punnaiah Choudary Kalluri <punnaiah.choudary.kalluri@xilinx.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 17/18] EDAC/synopsys: Unify struct/macro/function prefixes
Date: Thu, 27 Jun 2024 20:32:24 +0300
Message-ID: <20240627173251.25718-18-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627173251.25718-1-fancer.lancer@gmail.com>
References: <20240627173251.25718-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the driver entities naming schema is kind of random. There are
structures and methods with the "synps" prefix, there are structures and
methods with no driver-specific prefix, there are methods with the "edac"
prefix, there are structure instances with "zynqmp" and "synopsys"
prefixes, there are macros with "SYNPS", "ECC" and "DDR" prefixes.
Moreover some time ago some of function names were shortened out by
completely removing the vendor-specific prefixes thus leaving the driver
with no strict entities naming convention (see commit bb894bc46ed0 ("EDAC,
synopsys: Shorten static function names")).

All of that makes the code much harder to read for no much reason (except
shorter names utilization) since there is no easy way to distinguish now
the local, EDAC core and global name spaces right from the code context.
Similarly the kernel code index services (like elixir) gets to find the
different functions with the same name, which harden the kernel hacking.

Fix all of that by unifying the driver local entity names like functions,
structures and non-CSR-related macros especially seeing the same approach
has been used in the most of the EDAC LLDD. Use the "snps" prefix here as
the shortest version of the controller vendor name. While at it add a more
detailed controller name (DW uMCTL2 DDRC) to the driver comments and
string literals where it's appropriate.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note "dw" prefix would be even shorter alternative. But we decided to
stick with "snps" since "synopsys" has already been used in the module
name.

Changelog v2:
- Forgot to fix some of the SYNPS_ZYNQMP_IRQ_REGS macro utilizations.
  (@tbot)
---
 drivers/edac/synopsys_edac.c | 241 ++++++++++++++++++-----------------
 1 file changed, 121 insertions(+), 120 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6d2fc8a53447..a17d1a2bf388 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Synopsys DDR ECC Driver
+ * Synopsys DW uMCTL2 DDR ECC Driver
  * This driver is based on ppc4xx_edac.c drivers
  *
  * Copyright (C) 2012 - 2014 Xilinx, Inc.
@@ -16,23 +16,23 @@
 #include "edac_module.h"
 
 /* Number of cs_rows needed per memory controller */
-#define SYNPS_EDAC_NR_CSROWS		1
+#define SNPS_EDAC_NR_CSROWS		1
 
 /* Number of channels per memory controller */
-#define SYNPS_EDAC_NR_CHANS		1
+#define SNPS_EDAC_NR_CHANS		1
 
 /* Granularity of reported error in bytes */
-#define SYNPS_EDAC_ERR_GRAIN		1
+#define SNPS_EDAC_ERR_GRAIN		1
 
-#define SYNPS_EDAC_MSG_SIZE		256
+#define SNPS_EDAC_MSG_SIZE		256
 
-#define SYNPS_EDAC_MOD_STRING		"synps_edac"
-#define SYNPS_EDAC_MOD_VER		"1"
+#define SNPS_EDAC_MOD_STRING		"snps_edac"
+#define SNPS_EDAC_MOD_VER		"1"
 
 /* DDR ECC Quirks */
-#define SYNPS_ZYNQMP_IRQ_REGS		BIT(0)
+#define SNPS_ZYNQMP_IRQ_REGS		BIT(0)
 
-/* Synopsys DDR memory controller registers that are relevant to ECC */
+/* Synopsys uMCTL2 DDR controller registers that are relevant to ECC */
 
 /* DDRC Master 0 Register */
 #define DDR_MSTR_OFST			0x0
@@ -214,7 +214,7 @@
 #define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
 
 /**
- * struct ecc_error_info - ECC error log information.
+ * struct snps_ecc_error_info - ECC error log information.
  * @row:	Row number.
  * @col:	Column number.
  * @bank:	Bank number.
@@ -222,7 +222,7 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  */
-struct ecc_error_info {
+struct snps_ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
@@ -232,21 +232,21 @@ struct ecc_error_info {
 };
 
 /**
- * struct synps_ecc_status - ECC status information to report.
+ * struct snps_ecc_status - ECC status information to report.
  * @ce_cnt:	Correctable error count.
  * @ue_cnt:	Uncorrectable error count.
  * @ceinfo:	Correctable error log information.
  * @ueinfo:	Uncorrectable error log information.
  */
-struct synps_ecc_status {
+struct snps_ecc_status {
 	u32 ce_cnt;
 	u32 ue_cnt;
-	struct ecc_error_info ceinfo;
-	struct ecc_error_info ueinfo;
+	struct snps_ecc_error_info ceinfo;
+	struct snps_ecc_error_info ueinfo;
 };
 
 /**
- * struct synps_edac_priv - DDR memory controller private instance data.
+ * struct snps_edac_priv - DDR memory controller private data.
  * @baseaddr:		Base address of the DDR controller.
  * @reglock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
@@ -259,12 +259,12 @@ struct synps_ecc_status {
  * @bankgrp_shift:	Bit shifts for bank group bit.
  * @rank_shift:		Bit shifts for rank bit.
  */
-struct synps_edac_priv {
+struct snps_edac_priv {
 	void __iomem *baseaddr;
 	spinlock_t reglock;
-	char message[SYNPS_EDAC_MSG_SIZE];
-	struct synps_ecc_status stat;
-	const struct synps_platform_data *p_data;
+	char message[SNPS_EDAC_MSG_SIZE];
+	struct snps_ecc_status stat;
+	const struct snps_platform_data *p_data;
 #ifdef CONFIG_EDAC_DEBUG
 	ulong poison_addr;
 	u32 row_shift[18];
@@ -276,22 +276,22 @@ struct synps_edac_priv {
 };
 
 /**
- * struct synps_platform_data - Synopsys uMCTL2 DDRC platform data.
+ * struct snps_platform_data - Synopsys uMCTL2 DDRC platform data.
  * @quirks:	IP-core specific quirks.
  */
-struct synps_platform_data {
+struct snps_platform_data {
 	u32 quirks;
 };
 
 /**
- * synps_get_error_info - Get the current ECC error info.
+ * snps_get_error_info - Get the current ECC error info.
  * @priv:	DDR memory controller private instance data.
  *
  * Return: one if there is no error otherwise returns zero.
  */
-static int synps_get_error_info(struct synps_edac_priv *priv)
+static int snps_get_error_info(struct snps_edac_priv *priv)
 {
-	struct synps_ecc_status *p;
+	struct snps_ecc_status *p;
 	u32 regval, clearval;
 	unsigned long flags;
 	void __iomem *base;
@@ -350,21 +350,21 @@ static int synps_get_error_info(struct synps_edac_priv *priv)
 }
 
 /**
- * handle_error - Handle Correctable and Uncorrectable errors.
+ * snps_handle_error - Handle Correctable and Uncorrectable errors.
  * @mci:	EDAC memory controller instance.
  * @p:		Synopsys ECC status structure.
  *
  * Handles ECC correctable and uncorrectable errors.
  */
-static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
+static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *p)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
-	struct ecc_error_info *pinf;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_ecc_error_info *pinf;
 
 	if (p->ce_cnt) {
 		pinf = &p->ceinfo;
 
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
 			 "Row %d Col %d Bank %d Bank Group %d Bit %d Data 0x%08x",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp,
 			 pinf->bitpos, pinf->data);
@@ -377,7 +377,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	if (p->ue_cnt) {
 		pinf = &p->ueinfo;
 
-		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
+		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
 			 "Row %d Col %d Bank %d Bank Group %d",
 			 pinf->row, pinf->col, pinf->bank, pinf->bankgrp);
 
@@ -389,12 +389,12 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 	memset(p, 0, sizeof(*p));
 }
 
-static void enable_intr(struct synps_edac_priv *priv)
+static void snps_enable_irq(struct snps_edac_priv *priv)
 {
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
 		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_EN_OFST);
 
@@ -413,12 +413,12 @@ static void enable_intr(struct synps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->reglock, flags);
 }
 
-static void disable_intr(struct synps_edac_priv *priv)
+static void snps_disable_irq(struct snps_edac_priv *priv)
 {
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
 		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_DB_OFST);
 
@@ -433,41 +433,41 @@ static void disable_intr(struct synps_edac_priv *priv)
 }
 
 /**
- * intr_handler - Interrupt Handler for ECC interrupts.
+ * snps_irq_handler - Interrupt Handler for ECC interrupts.
  * @irq:        IRQ number.
  * @dev_id:     Device ID.
  *
  * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static irqreturn_t intr_handler(int irq, void *dev_id)
+static irqreturn_t snps_irq_handler(int irq, void *dev_id)
 {
 	struct mem_ctl_info *mci = dev_id;
-	struct synps_edac_priv *priv;
+	struct snps_edac_priv *priv;
 	int status, regval;
 
 	priv = mci->pvt_info;
 
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
 		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
 			return IRQ_NONE;
 	}
 
-	status = synps_get_error_info(priv);
+	status = snps_get_error_info(priv);
 	if (status)
 		return IRQ_NONE;
 
-	handle_error(mci, &priv->stat);
+	snps_handle_error(mci, &priv->stat);
 
-	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
+	if (priv->p_data->quirks & SNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
 }
 
 /**
- * synps_get_dtype - Return the DDR memory chips type.
+ * snps_get_dtype - Return the DDR memory chips type.
  * @base:	DDR memory controller base address.
  *
  * Get the attached DDR chips type based on the current controller
@@ -475,7 +475,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
  *
  * Return: type of the memory DRAM chips.
  */
-static enum dev_type synps_get_dtype(const void __iomem *base)
+static enum dev_type snps_get_dtype(const void __iomem *base)
 {
 	u32 regval;
 
@@ -499,14 +499,14 @@ static enum dev_type synps_get_dtype(const void __iomem *base)
 }
 
 /**
- * synps_get_ecc_state - Return the controller ECC enable/disable status.
+ * snps_get_ecc_state - Return the controller ECC enable/disable status.
  * @base:	DDR memory controller base address.
  *
  * Get the ECC enable/disable status for the controller.
  *
  * Return: a ECC status boolean i.e true/false - enabled/disabled.
  */
-static bool synps_get_ecc_state(void __iomem *base)
+static bool snps_get_ecc_state(void __iomem *base)
 {
 	u32 regval;
 
@@ -516,11 +516,11 @@ static bool synps_get_ecc_state(void __iomem *base)
 }
 
 /**
- * get_memsize - Read the size of the attached memory device.
+ * snps_get_memsize - Read the size of the attached memory device.
  *
  * Return: the memory size in bytes.
  */
-static u32 get_memsize(void)
+static u32 snps_get_memsize(void)
 {
 	struct sysinfo inf;
 
@@ -530,7 +530,7 @@ static u32 get_memsize(void)
 }
 
 /**
- * synps_get_mtype - Returns controller memory type.
+ * snps_get_mtype - Returns controller memory type.
  * @base:	Synopsys ECC status structure.
  *
  * Get the EDAC memory type appropriate for the current controller
@@ -538,7 +538,7 @@ static u32 get_memsize(void)
  *
  * Return: a memory type enumeration.
  */
-static enum mem_type synps_get_mtype(const void __iomem *base)
+static enum mem_type snps_get_mtype(const void __iomem *base)
 {
 	enum mem_type mt;
 	u32 memtype;
@@ -558,15 +558,15 @@ static enum mem_type synps_get_mtype(const void __iomem *base)
 }
 
 /**
- * init_csrows - Initialize the csrow data.
+ * snps_init_csrows - Initialize the csrow data.
  * @mci:	EDAC memory controller instance.
  *
  * Initialize the chip select rows associated with the EDAC memory
  * controller instance.
  */
-static void init_csrows(struct mem_ctl_info *mci)
+static void snps_init_csrows(struct mem_ctl_info *mci)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	struct csrow_info *csi;
 	struct dimm_info *dimm;
 	u32 size, row;
@@ -574,21 +574,21 @@ static void init_csrows(struct mem_ctl_info *mci)
 
 	for (row = 0; row < mci->nr_csrows; row++) {
 		csi = mci->csrows[row];
-		size = get_memsize();
+		size = snps_get_memsize();
 
 		for (j = 0; j < csi->nr_channels; j++) {
 			dimm		= csi->channels[j]->dimm;
 			dimm->edac_mode	= EDAC_SECDED;
-			dimm->mtype	= synps_get_mtype(priv->baseaddr);
+			dimm->mtype	= snps_get_mtype(priv->baseaddr);
 			dimm->nr_pages	= (size >> PAGE_SHIFT) / csi->nr_channels;
-			dimm->grain	= SYNPS_EDAC_ERR_GRAIN;
-			dimm->dtype	= synps_get_dtype(priv->baseaddr);
+			dimm->grain	= SNPS_EDAC_ERR_GRAIN;
+			dimm->dtype	= snps_get_dtype(priv->baseaddr);
 		}
 	}
 }
 
 /**
- * mc_init - Initialize one driver instance.
+ * snps_mc_init - Initialize one driver instance.
  * @mci:	EDAC memory controller instance.
  * @pdev:	platform device.
  *
@@ -596,7 +596,7 @@ static void init_csrows(struct mem_ctl_info *mci)
  * related driver-private data associated with the memory controller the
  * instance is bound to.
  */
-static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
+static void snps_mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
 	mci->pdev = &pdev->dev;
 	platform_set_drvdata(pdev, mci);
@@ -608,21 +608,22 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-	mci->ctl_name = "synps_ddr_controller";
-	mci->dev_name = SYNPS_EDAC_MOD_STRING;
-	mci->mod_name = SYNPS_EDAC_MOD_VER;
+	mci->ctl_name = "snps_umctl2_ddrc";
+	mci->dev_name = SNPS_EDAC_MOD_STRING;
+	mci->mod_name = SNPS_EDAC_MOD_VER;
 
 	edac_op_state = EDAC_OPSTATE_INT;
 
 	mci->ctl_page_to_phys = NULL;
 
-	init_csrows(mci);
+	snps_init_csrows(mci);
 }
 
-static int setup_irq(struct mem_ctl_info *mci,
-		     struct platform_device *pdev)
+
+
+static int snps_setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
 {
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 	int ret, irq;
 
 	irq = platform_get_irq(pdev, 0);
@@ -632,14 +633,14 @@ static int setup_irq(struct mem_ctl_info *mci,
 		return irq;
 	}
 
-	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
+	ret = devm_request_irq(&pdev->dev, irq, snps_irq_handler,
 			       0, dev_name(&pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
 		return ret;
 	}
 
-	enable_intr(priv);
+	snps_enable_irq(priv);
 
 	return 0;
 }
@@ -647,13 +648,13 @@ static int setup_irq(struct mem_ctl_info *mci,
 #ifdef CONFIG_EDAC_DEBUG
 
 /**
- * ddr_poison_setup -	Update poison registers.
+ * snps_data_poison_setup - Update poison registers.
  * @priv:		DDR memory controller private instance data.
  *
  * Update poison registers as per DDR mapping.
  * Return: none.
  */
-static void ddr_poison_setup(struct synps_edac_priv *priv)
+static void snps_data_poison_setup(struct snps_edac_priv *priv)
 {
 	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
 	int index;
@@ -711,7 +712,7 @@ static ssize_t inject_data_error_show(struct device *dev,
 				      char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
 			"Error injection Address: 0x%lx\n\r",
@@ -725,12 +726,12 @@ static ssize_t inject_data_error_store(struct device *dev,
 				       const char *data, size_t count)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	if (kstrtoul(data, 0, &priv->poison_addr))
 		return -EINVAL;
 
-	ddr_poison_setup(priv);
+	snps_data_poison_setup(priv);
 
 	return count;
 }
@@ -740,7 +741,7 @@ static ssize_t inject_data_poison_show(struct device *dev,
 				       char *data)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	return sprintf(data, "Data Poisoning: %s\n\r",
 			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
@@ -752,7 +753,7 @@ static ssize_t inject_data_poison_store(struct device *dev,
 					const char *data, size_t count)
 {
 	struct mem_ctl_info *mci = to_mci(dev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
 	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
@@ -767,7 +768,7 @@ static ssize_t inject_data_poison_store(struct device *dev,
 static DEVICE_ATTR_RW(inject_data_error);
 static DEVICE_ATTR_RW(inject_data_poison);
 
-static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
+static int snps_create_sysfs_attributes(struct mem_ctl_info *mci)
 {
 	int rc;
 
@@ -780,13 +781,13 @@ static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)
 	return 0;
 }
 
-static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
+static void snps_remove_sysfs_attributes(struct mem_ctl_info *mci)
 {
 	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
 	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
 }
 
-static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_row_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 addrmap_row_b2_10;
 	int index;
@@ -845,7 +846,7 @@ static void setup_row_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
 }
 
-static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_column_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	u32 width, memtype;
 	int index;
@@ -947,7 +948,7 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_bank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
 	priv->bank_shift[1] = ((addrmap[1] >> 8) &
@@ -959,7 +960,7 @@ static void setup_bank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_bg_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->bankgrp_shift[0] = (addrmap[8] &
 				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
@@ -969,7 +970,7 @@ static void setup_bg_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 
 }
 
-static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
+static void snps_setup_rank_address_map(struct snps_edac_priv *priv, u32 *addrmap)
 {
 	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
 				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
@@ -977,14 +978,14 @@ static void setup_rank_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 }
 
 /**
- * setup_address_map -	Set Address Map by querying ADDRMAP registers.
+ * snps_setup_address_map -	Set Address Map by querying ADDRMAP registers.
  * @priv:		DDR memory controller private instance data.
  *
  * Set Address Map by querying ADDRMAP registers.
  *
  * Return: none.
  */
-static void setup_address_map(struct synps_edac_priv *priv)
+static void snps_setup_address_map(struct snps_edac_priv *priv)
 {
 	u32 addrmap[12];
 	int index;
@@ -996,20 +997,20 @@ static void setup_address_map(struct synps_edac_priv *priv)
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
-	setup_row_address_map(priv, addrmap);
+	snps_setup_row_address_map(priv, addrmap);
 
-	setup_column_address_map(priv, addrmap);
+	snps_setup_column_address_map(priv, addrmap);
 
-	setup_bank_address_map(priv, addrmap);
+	snps_setup_bank_address_map(priv, addrmap);
 
-	setup_bg_address_map(priv, addrmap);
+	snps_setup_bg_address_map(priv, addrmap);
 
-	setup_rank_address_map(priv, addrmap);
+	snps_setup_rank_address_map(priv, addrmap);
 }
 #endif /* CONFIG_EDAC_DEBUG */
 
 /**
- * mc_probe - Check controller and bind driver.
+ * snps_mc_probe - Check controller and bind driver.
  * @pdev:	platform device.
  *
  * Probe a specific controller instance for binding with the driver.
@@ -1017,11 +1018,11 @@ static void setup_address_map(struct synps_edac_priv *priv)
  * Return: 0 if the controller instance was successfully bound to the
  * driver; otherwise, < 0 on error.
  */
-static int mc_probe(struct platform_device *pdev)
+static int snps_mc_probe(struct platform_device *pdev)
 {
-	const struct synps_platform_data *p_data;
+	const struct snps_platform_data *p_data;
 	struct edac_mc_layer layers[2];
-	struct synps_edac_priv *priv;
+	struct snps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
 	int rc;
@@ -1034,20 +1035,20 @@ static int mc_probe(struct platform_device *pdev)
 	if (!p_data)
 		return -ENODEV;
 
-	if (!synps_get_ecc_state(baseaddr)) {
+	if (!snps_get_ecc_state(baseaddr)) {
 		edac_printk(KERN_INFO, EDAC_MC, "ECC not enabled\n");
 		return -ENXIO;
 	}
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-	layers[0].size = SYNPS_EDAC_NR_CSROWS;
+	layers[0].size = SNPS_EDAC_NR_CSROWS;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-	layers[1].size = SYNPS_EDAC_NR_CHANS;
+	layers[1].size = SNPS_EDAC_NR_CHANS;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(EDAC_AUTO_MC_NUM, ARRAY_SIZE(layers), layers,
-			    sizeof(struct synps_edac_priv));
+			    sizeof(struct snps_edac_priv));
 	if (!mci) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Failed memory allocation for mc instance\n");
@@ -1059,9 +1060,9 @@ static int mc_probe(struct platform_device *pdev)
 	priv->p_data = p_data;
 	spin_lock_init(&priv->reglock);
 
-	mc_init(mci, pdev);
+	snps_mc_init(mci, pdev);
 
-	rc = setup_irq(mci, pdev);
+	rc = snps_setup_irq(mci, pdev);
 	if (rc)
 		goto free_edac_mc;
 
@@ -1073,13 +1074,13 @@ static int mc_probe(struct platform_device *pdev)
 	}
 
 #ifdef CONFIG_EDAC_DEBUG
-	rc = edac_create_sysfs_attributes(mci);
+	rc = snps_create_sysfs_attributes(mci);
 	if (rc) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to create sysfs entries\n");
 		goto free_edac_mc;
 	}
 
-	setup_address_map(priv);
+	snps_setup_address_map(priv);
 #endif
 
 	return rc;
@@ -1091,52 +1092,52 @@ static int mc_probe(struct platform_device *pdev)
 }
 
 /**
- * mc_remove - Unbind driver from controller.
+ * snps_mc_remove - Unbind driver from device.
  * @pdev:	Platform device.
  *
  * Return: Unconditionally 0
  */
-static void mc_remove(struct platform_device *pdev)
+
+static void snps_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
-	struct synps_edac_priv *priv = mci->pvt_info;
+	struct snps_edac_priv *priv = mci->pvt_info;
 
-	disable_intr(priv);
+	snps_disable_irq(priv);
 
 #ifdef CONFIG_EDAC_DEBUG
-	edac_remove_sysfs_attributes(mci);
+	snps_remove_sysfs_attributes(mci);
 #endif
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 }
 
-static const struct synps_platform_data zynqmp_edac_def = {
-	.quirks = SYNPS_ZYNQMP_IRQ_REGS,
+static const struct snps_platform_data zynqmp_edac_def = {
+	.quirks = SNPS_ZYNQMP_IRQ_REGS,
 };
 
-static const struct synps_platform_data synopsys_edac_def = {
+static const struct snps_platform_data snps_edac_def = {
 	.quirks = 0,
 };
 
-static const struct of_device_id synps_edac_match[] = {
+static const struct of_device_id snps_edac_match[] = {
 	{ .compatible = "xlnx,zynqmp-ddrc-2.40a", .data = &zynqmp_edac_def },
-	{ .compatible = "snps,ddrc-3.80a", .data = &synopsys_edac_def },
+	{ .compatible = "snps,ddrc-3.80a", .data = &snps_edac_def },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, synps_edac_match);
+MODULE_DEVICE_TABLE(of, snps_edac_match);
 
-static struct platform_driver synps_edac_mc_driver = {
+static struct platform_driver snps_edac_mc_driver = {
 	.driver = {
-		   .name = "synopsys-edac",
-		   .of_match_table = synps_edac_match,
+		   .name = "snps-edac",
+		   .of_match_table = snps_edac_match,
 		   },
-	.probe = mc_probe,
-	.remove_new = mc_remove,
+	.probe = snps_mc_probe,
+	.remove_new = snps_mc_remove,
 };
-
-module_platform_driver(synps_edac_mc_driver);
+module_platform_driver(snps_edac_mc_driver);
 
 MODULE_AUTHOR("Xilinx Inc");
-MODULE_DESCRIPTION("Synopsys DDR ECC driver");
+MODULE_DESCRIPTION("Synopsys uMCTL2 DDR ECC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.43.0


