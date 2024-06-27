Return-Path: <linux-edac+bounces-1419-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B2C91AE3B
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 288901F27FA4
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95F1A2FDC;
	Thu, 27 Jun 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUQp5YUz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9541A2FCE;
	Thu, 27 Jun 2024 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509619; cv=none; b=VwMGsFyNdp/RCk6aSdxX+kpTzMyG5fIToRV2Y/acR/Hc+j16h6Xep0FJ+QRfe8w++qZAq76yWhd/ipfX932A4LGmp/KIJqUbaI3yoanuud2fDlq9CBHtiK4ixcfPWIKWTmqbrQ9eG9ASJomc3/9vIEVys+ANDHNbYgT5J8EbF4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509619; c=relaxed/simple;
	bh=u+PmNdptXMwR5KPv1GAroKgDqv5Lz1l/qDx4/H6Axe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHEfVWHbO2B/+FkJMH9vdvEOOVRUhFlawWGtghhnaxKxKBDStze6D0bWUMYqmHWe22UNc7KFHILi6yuKJr8YHsSWon9/TnHRPh29Qy/VVZXNuSkpnb/BFYK+snHXrbGdTJd1mhT09pV9/bqnw6iNlfMuFisQNF7oJSMWSd0Awyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUQp5YUz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so8346198e87.1;
        Thu, 27 Jun 2024 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509616; x=1720114416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZa91h6JHbvpzFhbsgcXRu/FV0fHLPTukVYlit5Rupc=;
        b=aUQp5YUzvlnzQy3jRdUaCPJG20siHZp69o5h/GsI9DY8KUPUVofIvcYVUw2K1Hl7Cc
         6HwQxHuZnTO0d8TF3ONVlqfoiV4rEYYGSX5dPYWUQe4vaGxrP7/ejPOA4L5RDqfguXzM
         DOFYNSjPq7xERIZSnxEL0IwCm5ho1Zrdzldz0oiA0iMm70u9TjbP4fXzpueglKJpEz8/
         EbgfWasMrTBeEkdypUpTk94JXtEYUQ7stSj9I9ZxvXJiupHMPGlJAZJkQJApoHkjCCbw
         9wXWhBEwhpGqKaUIz5Rs3vpDUdOLUucEbzzknDvixz2PG3Z1A2iHvM15Z7rjzKQQyaGi
         ezVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509616; x=1720114416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZa91h6JHbvpzFhbsgcXRu/FV0fHLPTukVYlit5Rupc=;
        b=sUhLkuzmRIrJxq9mVFUQ5Qmeld7tKA3oAyW/zUJzuiuZA4LnQlnkY9BHRjijslj3T5
         5ybAKTZ+PlGVTskMfzDqt7FXlQbBQuZzK01iZ3JM/qtjf2Kb0vqLRU32ErDABBNNeM1c
         tx6/iOoeva2SM9/qgfzv59o2PJLLn2dvgUwuSAYbKDC0p5NEUzt/NHdA+1Jmh7Zz7HlJ
         HP0F5DORnHidJcM340Z8vi2gXqCA8gFpoh7Q7GclNsu2LVVjzaG1kd1WTP5ykW2YICxo
         ih+0wYQISGXfkUjIvFqL1mDU386gWLJ1RqtMjZRP79AuArTB3Fp09B1OCMx7WDUS9CE0
         +ktA==
X-Forwarded-Encrypted: i=1; AJvYcCWTWwE1du8NUBdj5k3gNpy9d/dxU9sUfrnuhxlnAJ820hPaUl8SR70eoNGxyjPqE6LCiTLPxU93Wi0raLuXuHfhQMjF6q779kC1xXh74VkDOhaCMMbrWXRsmL6pIQno5fplMpu40phYkA==
X-Gm-Message-State: AOJu0YyRJbL8bG/6xj+EVW/J/iYgqFfL9GmqHGNvGGLW7V5dphnX+r5Y
	U49z+l1q4p3bwtArsJK0CLR1EWmTI0eOBFVBpr1AGk2DxL2R7Qw4DbNTwgNI
X-Google-Smtp-Source: AGHT+IFQPd2z7z8/jzojDMq3jNKV/pXbP52IPlrBLwBzxdJ/4vsV6ETxbhRdstJb5WoQAIqbExN8+A==
X-Received: by 2002:a05:6512:1590:b0:52e:7a2c:96ee with SMTP id 2adb3069b0e04-52e7a2c987amr207372e87.34.1719509613733;
        Thu, 27 Jun 2024 10:33:33 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0bbf0sm1339e87.25.2024.06.27.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:33 -0700 (PDT)
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
Subject: [PATCH RESEND v6 16/18] EDAC/synopsys: Unify CSRs macro declarations
Date: Thu, 27 Jun 2024 20:32:23 +0300
Message-ID: <20240627173251.25718-17-fancer.lancer@gmail.com>
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

Originally the device CSR macros were supposed to be defined following the
next local convention: first CSR offsets are listed, then their fields and
flags are described in the same order; CSRs offset macros are supposed to
have _OFST suffix; ECC-related macros shall have ECC_ prefix, generic
DDR-related macros - DDR_ prefix. After all the years the driver has been
living in kernel the CSRs macros have turned to be partly deviated away
from the denoted convention.

Fix all the related inconsistencies: move several CSRs offset macros to be
defined before the CSRs fields and flags macros; replace OFFSET suffix
with OFST; replace DDRC_ prefix with DDR_ and ECC_ with DDR_ where it's
appropriate; group DDR_MSTR and ECC_CTRL (ECC_CLR) sibling fields macros
together and make sure their prefixes match to the CSRs offset macros. In
addition to that drop _MASK suffix from the macros which aren't used as
masks and add ZYNQMP_ prefix to the ZYNQMP-specific macros to distinguish
them from the generic Synopsys memory controller macros.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v4:
- This is a new patch collected from the rest of the series to simplify
  the review process.
---
 drivers/edac/synopsys_edac.c | 134 +++++++++++++++++------------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 8ed942735e23..6d2fc8a53447 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -77,20 +77,34 @@
 #define ECC_POISON0_OFST		0xB8
 #define ECC_POISON1_OFST		0xBC
 
-#define ECC_ADDRMAP0_OFFSET		0x200
-
-/* Control register bitfield definitions */
-#define ECC_CTRL_CLR_CE_ERR		BIT(0)
-#define ECC_CTRL_CLR_UE_ERR		BIT(1)
-#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
-#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
-
-/* DDR Control Register width definitions  */
+/* DDR Address Map Registers */
+#define DDR_ADDRMAP0_OFST		0x200
+
+/* DDR Software Control Register */
+#define DDR_SWCTL			0x320
+
+/* ZynqMP DDR QOS Registers */
+#define ZYNQMP_DDR_QOS_IRQ_STAT_OFST	0x20200
+#define ZYNQMP_DDR_QOS_IRQ_EN_OFST	0x20208
+#define ZYNQMP_DDR_QOS_IRQ_DB_OFST	0x2020C
+
+/* DDR Master register definitions */
+#define DDR_MSTR_DEV_CFG_MASK		0xC0000000
+#define DDR_MSTR_DEV_CFG_SHIFT		30
+#define DDR_MSTR_DEV_X4			0
+#define DDR_MSTR_DEV_X8			1
+#define DDR_MSTR_DEV_X16		2
+#define DDR_MSTR_DEV_X32		3
 #define DDR_MSTR_BUSWIDTH_MASK		0x3000
 #define DDR_MSTR_BUSWIDTH_SHIFT		12
-#define DDRCTL_EWDTH_16			2
-#define DDRCTL_EWDTH_32			1
-#define DDRCTL_EWDTH_64			0
+#define DDR_MSTR_BUSWIDTH_16		2
+#define DDR_MSTR_BUSWIDTH_32		1
+#define DDR_MSTR_BUSWIDTH_64		0
+#define DDR_MSTR_MEM_LPDDR4		0x20
+#define DDR_MSTR_MEM_DDR4		0x10
+#define DDR_MSTR_MEM_LPDDR3		0x8
+#define DDR_MSTR_MEM_DDR2		0x4
+#define DDR_MSTR_MEM_DDR3		0x1
 
 /* ECC CFG0 register definitions */
 #define ECC_CFG0_MODE_MASK		0x7
@@ -103,23 +117,19 @@
 #define ECC_STAT_CECNT_SHIFT		8
 #define ECC_STAT_BITNUM_MASK		0x7F
 
+/* ECC control/clear register definitions */
+#define ECC_CTRL_CLR_CE_ERR		BIT(0)
+#define ECC_CTRL_CLR_UE_ERR		BIT(1)
+#define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
+#define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+#define ECC_CTRL_EN_CE_IRQ		BIT(8)
+#define ECC_CTRL_EN_UE_IRQ		BIT(9)
+
 /* ECC error count register definitions */
 #define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
 #define ECC_ERRCNT_UECNT_SHIFT		16
 #define ECC_ERRCNT_CECNT_MASK		0xFFFF
 
-/* DDR QOS Interrupt register definitions */
-#define DDR_QOS_IRQ_STAT_OFST		0x20200
-#define DDR_QOSUE_MASK			0x4
-#define	DDR_QOSCE_MASK			0x2
-#define	ECC_CE_UE_INTR_MASK		0x6
-#define DDR_QOS_IRQ_EN_OFST		0x20208
-#define DDR_QOS_IRQ_DB_OFST		0x2020C
-
-/* DDR QOS Interrupt register definitions */
-#define DDR_UE_MASK			BIT(9)
-#define DDR_CE_MASK			BIT(8)
-
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -141,28 +151,11 @@
 #define ECC_POISON1_ROW_SHIFT		0
 #define ECC_POISON1_ROW_MASK		0x3FFFF
 
-/* DDR Memory type defines */
-#define MEM_TYPE_DDR3			0x1
-#define MEM_TYPE_LPDDR3			0x8
-#define MEM_TYPE_DDR2			0x4
-#define MEM_TYPE_DDR4			0x10
-#define MEM_TYPE_LPDDR4			0x20
-
-/* DDRC Software control register */
-#define DDRC_SWCTL			0x320
-
 /* DDRC ECC CE & UE poison mask */
 #define ECC_CEPOISON_MASK		0x3
 #define ECC_UEPOISON_MASK		0x1
 
-/* DDRC Device config masks */
-#define DDRC_MSTR_CFG_MASK		0xC0000000
-#define DDRC_MSTR_CFG_SHIFT		30
-#define DDRC_MSTR_CFG_X4_MASK		0x0
-#define DDRC_MSTR_CFG_X8_MASK		0x1
-#define DDRC_MSTR_CFG_X16_MASK		0x2
-#define DDRC_MSTR_CFG_X32_MASK		0x3
-
+/* DDRC Device config shifts/masks */
 #define DDR_MAX_ROW_SHIFT		18
 #define DDR_MAX_COL_SHIFT		14
 #define DDR_MAX_BANK_SHIFT		3
@@ -215,6 +208,11 @@
 
 #define RANK_B0_BASE			6
 
+/* ZynqMP DDR QOS Interrupt register definitions */
+#define ZYNQMP_DDR_QOS_UE_MASK		0x4
+#define ZYNQMP_DDR_QOS_CE_MASK		0x2
+#define ZYNQMP_DDR_QOS_IRQ_MASK		0x6
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @row:	Row number.
@@ -397,8 +395,8 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	/* Enable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_EN_OFST);
 
 		return;
 	}
@@ -409,7 +407,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	 * IRQs Enable/Disable flags have been available since v3.10a.
 	 * This is noop for the older controllers.
 	 */
-	writel(DDR_UE_MASK | DDR_CE_MASK,
+	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
 	       priv->baseaddr + ECC_CLR_OFST);
 
 	spin_unlock_irqrestore(&priv->reglock, flags);
@@ -421,8 +419,8 @@ static void disable_intr(struct synps_edac_priv *priv)
 
 	/* Disable UE/CE Interrupts */
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
-		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+		writel(ZYNQMP_DDR_QOS_UE_MASK | ZYNQMP_DDR_QOS_CE_MASK,
+		       priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_DB_OFST);
 
 		return;
 	}
@@ -450,9 +448,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
-		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-		if (!(regval & ECC_CE_UE_INTR_MASK))
+		regval = readl(priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
+		regval &= (ZYNQMP_DDR_QOS_CE_MASK | ZYNQMP_DDR_QOS_UE_MASK);
+		if (!(regval & ZYNQMP_DDR_QOS_IRQ_MASK))
 			return IRQ_NONE;
 	}
 
@@ -463,7 +461,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	handle_error(mci, &priv->stat);
 
 	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
-		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		writel(regval, priv->baseaddr + ZYNQMP_DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
 }
@@ -482,18 +480,18 @@ static enum dev_type synps_get_dtype(const void __iomem *base)
 	u32 regval;
 
 	regval = readl(base + DDR_MSTR_OFST);
-	if (!(regval & MEM_TYPE_DDR4))
+	if (!(regval & DDR_MSTR_MEM_DDR4))
 		return DEV_UNKNOWN;
 
-	regval = (regval & DDRC_MSTR_CFG_MASK) >> DDRC_MSTR_CFG_SHIFT;
+	regval = (regval & DDR_MSTR_DEV_CFG_MASK) >> DDR_MSTR_DEV_CFG_SHIFT;
 	switch (regval) {
-	case DDRC_MSTR_CFG_X4_MASK:
+	case DDR_MSTR_DEV_X4:
 		return DEV_X4;
-	case DDRC_MSTR_CFG_X8_MASK:
+	case DDR_MSTR_DEV_X8:
 		return DEV_X8;
-	case DDRC_MSTR_CFG_X16_MASK:
+	case DDR_MSTR_DEV_X16:
 		return DEV_X16;
-	case DDRC_MSTR_CFG_X32_MASK:
+	case DDR_MSTR_DEV_X32:
 		return DEV_X32;
 	}
 
@@ -547,11 +545,11 @@ static enum mem_type synps_get_mtype(const void __iomem *base)
 
 	memtype = readl(base + DDR_MSTR_OFST);
 
-	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
+	if ((memtype & DDR_MSTR_MEM_DDR3) || (memtype & DDR_MSTR_MEM_LPDDR3))
 		mt = MEM_DDR3;
-	else if (memtype & MEM_TYPE_DDR2)
+	else if (memtype & DDR_MSTR_MEM_DDR2)
 		mt = MEM_RDDR2;
-	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
+	else if ((memtype & DDR_MSTR_MEM_LPDDR4) || (memtype & DDR_MSTR_MEM_DDR4))
 		mt = MEM_DDR4;
 	else
 		mt = MEM_EMPTY;
@@ -756,12 +754,12 @@ static ssize_t inject_data_poison_store(struct device *dev,
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct synps_edac_priv *priv = mci->pvt_info;
 
-	writel(0, priv->baseaddr + DDRC_SWCTL);
+	writel(0, priv->baseaddr + DDR_SWCTL);
 	if (strncmp(data, "CE", 2) == 0)
 		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
 	else
 		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
-	writel(1, priv->baseaddr + DDRC_SWCTL);
+	writel(1, priv->baseaddr + DDR_SWCTL);
 
 	return count;
 }
@@ -878,8 +876,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
 			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
 					COL_MAX_VAL_MASK) + COL_B9_BASE);
-	if (width == DDRCTL_EWDTH_64) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	if (width == DDR_MSTR_BUSWIDTH_64) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = ((addrmap[4] &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				((addrmap[4] & COL_MAX_VAL_MASK) +
@@ -898,8 +896,8 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
 				 COL_B11_BASE);
 		}
-	} else if (width == DDRCTL_EWDTH_32) {
-		if (memtype & MEM_TYPE_LPDDR3) {
+	} else if (width == DDR_MSTR_BUSWIDTH_32) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 24) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
@@ -919,7 +917,7 @@ static void setup_column_address_map(struct synps_edac_priv *priv, u32 *addrmap)
 				 COL_B10_BASE);
 		}
 	} else {
-		if (memtype & MEM_TYPE_LPDDR3) {
+		if (memtype & DDR_MSTR_MEM_LPDDR3) {
 			priv->col_shift[10] = (((addrmap[3] >> 16) &
 				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
 				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
@@ -994,7 +992,7 @@ static void setup_address_map(struct synps_edac_priv *priv)
 	for (index = 0; index < 12; index++) {
 		u32 addrmap_offset;
 
-		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
+		addrmap_offset = DDR_ADDRMAP0_OFST + (index * 4);
 		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
 	}
 
-- 
2.43.0


