Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4D755E50
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jul 2023 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjGQITK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jul 2023 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGQITJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Jul 2023 04:19:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7361C1B1;
        Mon, 17 Jul 2023 01:19:08 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CFF571EC0C97;
        Mon, 17 Jul 2023 10:19:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689581946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E8Mc8hrwNRZNiGGRUF+jDN/TTdRi0hE+BapCL3Hbkds=;
        b=mxRCdyr7tROwiYi/hC8BSkqTYwGSYxpI0dvWR+nFXOpK16WChegjgi0bL7zc+Yvsaf0R9c
        XEOccbcN8KwX6mDrUnVNvjmz66aMfQxG0s+ZT6SRfYqKAggO5oMZ7H13mkxwNIwabgr876
        yI+Syb/Ljcmsxwhn14qcVr25tpUNEQg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kVW6yaRpHO0d; Mon, 17 Jul 2023 08:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689581942; bh=E8Mc8hrwNRZNiGGRUF+jDN/TTdRi0hE+BapCL3Hbkds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KmhJoEmJoS9fgW2NvK78czo8MUDWlBvaqU6eG/d2yC7Zwj4dloVJj7PaXI+0iSKNx
         5V5UnB98M3MGbyHVJmnYSD5UsXzRRUkQqeChW/3pT1kK0H8yzBm5BY399CDOOd0hph
         HKA16LvvoyZs8V2CJefK/AEMeAdEl8cxKYNekytwFiQ/dSTiOwy3azqnO5zD+eqJOg
         5v03utDyB98MJDfrWsjgd8qLN4/MEcJ3iUyJD6VinFLSehkPFuYvTMxK4CAz5E1Ey+
         /X9kKOq9F+6mHtWLgwcGOqBnIYb5QBnKC6cn8Mcz631sHcx8U6ztviZjbXbajH4X1P
         LgE/sGuYzoL0t6j5V2YMaxkis3qGSK4zE75NBs8S3u+ElzOXx9gIhYNv8oeUTY9twK
         vqr3A+Z1NuSRWtYsYoh3uKT4LA+eM/iAwPlVbSm+fg9q81+3lLLLy2hz/kebH5ZvYT
         SvJj8cJImiTmx85LW+ZNrnDvAQW3PnL4Q2BJ8RUDOt45C6bQSVUyizeeFmk8yCwuhC
         +K127P3+LJ7hqMugWhSC84ENJXV0mxlE0EZD1SvsT0D5Vsm+P9t5PKb0sWY2qVk0R4
         wSZWg4YpklgDzl0tzikTpVorjxfuyzZobzr56+iNZVtwQD0Y6ZitnXAq6+g8yL2r+w
         cWAvsiHy492SusNXmq2xs/KQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0706940E0033;
        Mon, 17 Jul 2023 08:18:47 +0000 (UTC)
Date:   Mon, 17 Jul 2023 10:18:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-edac@vger.kernel.org, git@amd.com,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, michal.simek@amd.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Subject: Re: [PATCH v7 2/2] EDAC/versal: Add a Xilinx Versal memory
 controller driver
Message-ID: <20230717081841.GDZLT5Yc/PT77hZ+Xa@fat_crate.local>
References: <20230614042852.5575-1-shubhrajyoti.datta@amd.com>
 <20230614042852.5575-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614042852.5575-3-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 14, 2023 at 09:58:52AM +0530, Shubhrajyoti Datta wrote:
>  MAINTAINERS                          |    7 +
>  drivers/edac/Kconfig                 |   11 +
>  drivers/edac/Makefile                |    1 +
>  drivers/edac/versal_edac.c           | 1065 ++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |   10 +
>  5 files changed, 1094 insertions(+)
>  create mode 100644 drivers/edac/versal_edac.c

I've done some changes ontop, see below:

That toggling of interrupts at the end of mc_probe() happens only for
debugfs's sake so they can move inside the ifdef.

Right?

---
diff --git a/MAINTAINERS b/MAINTAINERS
index 4f3514e8116a..569c48368458 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23410,7 +23410,7 @@ M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
 M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
-F:	drivers/edac/xilinx_ddrmc_edac.c
+F:	drivers/edac/versal_edac.c
 
 XILINX WATCHDOG DRIVER
 M:	Srinivas Neeli <srinivas.neeli@amd.com>
diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 4aa073ffa827..07a07641172c 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -195,7 +195,7 @@ union edac_info {
 struct ecc_status {
 	union ecc_error_info ceinfo[2];
 	union ecc_error_info ueinfo[2];
-	bool channel;
+	u8 channel;
 	u8 error_type;
 };
 
@@ -637,38 +637,38 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	init_csrows(mci);
 }
 
-static void enable_intr(struct edac_priv *priv)
+static void disable_all_intr(struct edac_priv *priv)
 {
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 
-	/* Enable UE and CE Interrupts to support the interrupt case */
-	writel(XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK,
-	       priv->ddrmc_baseaddr + XDDR_IRQ_EN_OFFSET);
+	writel(XDDR_IRQ_ALL,
+	       priv->ddrmc_baseaddr + XDDR_IRQ_DIS_OFFSET);
+	writel(XDDR_IRQ_ALL,
+	       priv->ddrmc_baseaddr + XDDR_IRQ1_DIS_OFFSET);
 
-	writel(XDDR_IRQ_UE_MASK,
-	       priv->ddrmc_baseaddr + XDDR_IRQ1_EN_OFFSET);
 	/* Lock the PCSR registers */
 	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
-static void disable_all_intr(struct edac_priv *priv)
+#ifdef CONFIG_EDAC_DEBUG
+#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
+
+static void enable_intr(struct edac_priv *priv)
 {
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 
-	writel(XDDR_IRQ_ALL,
-	       priv->ddrmc_baseaddr + XDDR_IRQ_DIS_OFFSET);
-	writel(XDDR_IRQ_ALL,
-	       priv->ddrmc_baseaddr + XDDR_IRQ1_DIS_OFFSET);
+	/* Enable UE and CE Interrupts to support the interrupt case */
+	writel(XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK,
+	       priv->ddrmc_baseaddr + XDDR_IRQ_EN_OFFSET);
 
+	writel(XDDR_IRQ_UE_MASK,
+	       priv->ddrmc_baseaddr + XDDR_IRQ1_EN_OFFSET);
 	/* Lock the PCSR registers */
 	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 }
 
-#ifdef CONFIG_EDAC_DEBUG
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
-
 /**
  * poison_setup - Update poison registers.
  * @priv:	DDR memory controller private instance data.
@@ -787,7 +787,7 @@ static const struct file_operations xddr_inject_enable_fops = {
 	.llseek = generic_file_llseek,
 };
 
-static void edac_create_debugfs_attributes(struct mem_ctl_info *mci)
+static void create_debugfs_attributes(struct mem_ctl_info *mci)
 {
 	struct edac_priv *priv = mci->pvt_info;
 
@@ -1012,13 +1012,12 @@ static int mc_probe(struct platform_device *pdev)
 		goto del_mc;
 	}
 
-	disable_all_intr(priv);
 #ifdef CONFIG_EDAC_DEBUG
-	edac_create_debugfs_attributes(mci);
-
+	disable_all_intr(priv);
+	create_debugfs_attributes(mci);
 	setup_address_map(priv);
-#endif
 	enable_intr(priv);
+#endif
 	return rc;
 
 del_mc:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
