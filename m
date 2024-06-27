Return-Path: <linux-edac+bounces-1408-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0243D91AE1F
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522F5B2777B
	for <lists+linux-edac@lfdr.de>; Thu, 27 Jun 2024 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ADD19D8AF;
	Thu, 27 Jun 2024 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8b9i8SN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAED919A298;
	Thu, 27 Jun 2024 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509593; cv=none; b=UvRX4GHz+8j5dgYA9qyPs9qCAx23mVZKXLgD2d9F1ADK0VALaSUzJ/Zk9NhdqpmW7B/7Pc4O1cYREvUlGhy0NPS9nkFhailywjs0dL9dKNbJ6LW3+y+2Qs7O8XlZju6l00osgPQPO3AQU4JIfJg1xDHrIA9Ikd3wGfpdA7MG07s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509593; c=relaxed/simple;
	bh=3aEJtQZZdTyCyC7Qz3Syowf9Ac3dmNj/1O2N4QH1H/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOZ2zqT0czMESPPfhvUqw9LGGPvh1rC3DfNmGJHpnkRs4OJr89YH88+Vk8wgel2M41PhPeMNFZZWdb+4NbJX3gABOF6mP1XrvtDHrv8eXKKDnI1B01xBsTOtNuxcrQewEUPt2NKqz8XA5GT593Hypx2yDB5RwGn0oT0tuJ/chSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8b9i8SN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52ccc40e72eso6138244e87.3;
        Thu, 27 Jun 2024 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719509590; x=1720114390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q3q+xT5MPRJcZYJhNdlSBmu8zuhUccl7jl0aAoFmLU=;
        b=C8b9i8SNLEwV88MU/aW5B3xujh90vpBpYRjdqxG2aXgDh/AvR/DRxQFBewSNi++ZwX
         wOP0VIS+qNA7HIsKMwde2u9dH6AQVgGkG1utet8tG2/MupedC0d64jBFoeFle6xdQVXO
         6VQzH8l65+kF5aAO0X98PEtHClOKTLRHL5mch4Qr/Ippur6B8eTv/f6of1uw+DB0Wzjd
         DSoHYde5OrQ82MPDJrvksgGOlorBLQXMyZwxK3oPg0w2mrUmZiJY7d0CzpStMSgtlWnI
         3SJ7pDaXtcig+yzb26UDepqfcSjKFMfBD6FyBfIOL7A7bLUPtEJQ7IEV+Uq+DWHUdj9T
         B8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509590; x=1720114390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q3q+xT5MPRJcZYJhNdlSBmu8zuhUccl7jl0aAoFmLU=;
        b=FDA8sf48XkStrTAqmpCHOpVt2Y2UhuBfjVavtCgxkFvrHM0bYNX4aFBDWGkluREAzr
         rnB2BjZ28b+yOngk2ZhxH3tYpXCHlYzrS8CnRjlf4FjRZpvDWHYXuI+gyEV+T2uy1kvx
         ZN2qyXHcjmIdAPT9gyRblVi+erINuBKbTiGOw/mWBd+CkLsm1hNuq4QeWBB+l3lcoGkL
         vc6d/HosjhsbT7tgSuORspKrlW14ZIbVY7jRCKaG3wTEpxG1itOHjYg0SRd/RtUfftQ+
         31Fs7wsYFuanirHQJ49SYqAwNZ3OvfdsklBNw5u3HiyTFsDRW1GoUQlAuvfw8P43P2hU
         p54Q==
X-Forwarded-Encrypted: i=1; AJvYcCU1VOqQWGboZo8apB8t6vpzuc1vfL2uCiGE+wqyalxn1nMVVWM3stb9lIf7jZuxvotA37cjo+rWwgcry7oLkRg5JhH9L2RaZ7EehuWmxsd1okuRhxIGb0yE9GirSRCIa2yeizobmoz3qw==
X-Gm-Message-State: AOJu0Yxzsqjr0fT7C6o6Nc/IFBA51TaaB2YP05ARTeprAZECi8owS6jO
	6QRHEfKOGYjn+QBaa2+jCFwYjDbIG71ZgLi30BknNzEUKRCNwOYp
X-Google-Smtp-Source: AGHT+IFuvvTDYWwoQnylcqlybwEt888ixoO1oUxW7i3MAlC2Thvrxl8QAKN2Axgs4eY16r67ktLCTQ==
X-Received: by 2002:a05:6512:2353:b0:52c:d20b:22c8 with SMTP id 2adb3069b0e04-52ce186172dmr13987712e87.64.1719509587894;
        Thu, 27 Jun 2024 10:33:07 -0700 (PDT)
Received: from localhost ([213.79.110.82])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab10248sm1111e87.101.2024.06.27.10.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 10:33:07 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH RESEND v6 05/18] EDAC/synopsys: Fix misleading IRQ self-cleared quirk flag
Date: Thu, 27 Jun 2024 20:32:12 +0300
Message-ID: <20240627173251.25718-6-fancer.lancer@gmail.com>
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

The DDR_ECC_INTR_SELF_CLEAR quirk flag was initially added in the commit
f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys
EDAC DDR") in order to distinguish the ZynqMP DDRC (based on DW uMCTL2
DDRC v2.40a) and the announced in that commit Synopsys DDR controller
v3.80a. The selected name is misleading for the next reasons:

1. None of the Synopsys DW uMCTL2 DDR IP-core has the UE/CE IRQs
auto or self cleared. The IRQ signals (ecc_corrected_err_intr and
ecc_uncorrected_err_intr) are cleared together with the rest of the ECC
error data by means of writing 1's to the respective ECCCLR bits. It
worked like that in DW uMCTL2 DDRC v2.x IP-core and it's still true for
the modern DW uMCTL2 DDRC v3.x.

2. The IRQ-related registers accessed unless the denoted quirk is
specified are actually Xilinx Zynq-specific. None of the Synopsys DW uMCTL
DDRC IP-core have any registers at the offsets 0x20200/0x20208/0x2020C.
The most modern DW uMCTL2 DDRC v3.91a IP-core available has CSRs space end
at the 0x43dc offset. The older IP-cores have even smaller registers
space.

3. What was actually introduced in the DW uMCTL2 DDRC v3.10 by Synopsys is
the IRQ enable flags which older DW uMCTL2 DDRC IP-core didn't have. They
were added to the ECCCLR register (the CSR was also renamed to ECCCTL in
the v3.10 IP-core HW databook). So since then there have been no point in
having a vendor-specific IRQs masking solution like described in 2. and
the IRQ signal can be now shared even for the native DW uMCTL2 DDR
controllers.

So let's harmonize the quirked IRQs code based on the statements above:
rename the DDR_ECC_INTR_SELF_CLEAR quirk flag to SYNPS_ZYNQMP_IRQ_REGS
thus indicating the ZynqMP-specific IRQ CSRs; add the new quirk flag to
the ZynqMP platform data; drop the misleading comments about the
auto-cleared ue/ce flags; add a comment about the new IRQ enable flags
added in v3.10 IP-core.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

---

Changelog v4:
- This is a new patch detached from
  [PATCH v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
---
 drivers/edac/synopsys_edac.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 6d578f4b03b1..3e98e907e2b9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -88,7 +88,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -526,7 +526,7 @@ static void enable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Enable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
@@ -535,6 +535,10 @@ static void enable_intr(struct synps_edac_priv *priv)
 
 	spin_lock_irqsave(&priv->reglock, flags);
 
+	/*
+	 * IRQs Enable/Disable flags have been available since v3.10a.
+	 * This is noop for the older controllers.
+	 */
 	writel(DDR_UE_MASK | DDR_CE_MASK,
 	       priv->baseaddr + ECC_CLR_OFST);
 
@@ -546,7 +550,7 @@ static void disable_intr(struct synps_edac_priv *priv)
 	unsigned long flags;
 
 	/* Disable UE/CE Interrupts */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
 
@@ -577,11 +581,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
-	/*
-	 * v3.0 of the controller has the ce/ue bits cleared automatically,
-	 * so this condition does not apply.
-	 */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 		if (!(regval & ECC_CE_UE_INTR_MASK))
@@ -598,8 +598,8 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	/* v3.0 of the controller does not have this register */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 
 	return IRQ_HANDLED;
@@ -913,7 +913,7 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
+	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
@@ -925,7 +925,7 @@ static const struct synps_platform_data synopsys_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
-- 
2.43.0


