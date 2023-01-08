Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAABC661724
	for <lists+linux-edac@lfdr.de>; Sun,  8 Jan 2023 17:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjAHQ6Z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 8 Jan 2023 11:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjAHQ6W (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 8 Jan 2023 11:58:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FD617B;
        Sun,  8 Jan 2023 08:58:20 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 26C021EC066E;
        Sun,  8 Jan 2023 17:58:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673197098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=oIhXj0iTmkK7wWzCIhRqyUlDkxjgGwwWXJlLxDVunmA=;
        b=EFE8ohASKHc7e8kYi2uAEqyxzgah1Di6SVFK3taVjjkWWKYUkQ5tFoXteDHlNhwVuFh2tD
        Gc65KQCLUcGQ0qxqasQ1dq57c/1jt4FrjmfuXTJtjPUDPqCeuwRGZE2mdZwZtJwjTgeG3k
        /xFcOSfVfYx9kbrC0TbD1jUQGv44IXU=
Date:   Sun, 8 Jan 2023 17:58:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Message-ID: <Y7r2I5Ij3x8/rMjS@zn.tnic>
References: <20230104084512.1855243-1-sai.krishna.potthuri@amd.com>
 <20230104084512.1855243-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104084512.1855243-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 04, 2023 at 02:15:12PM +0530, Sai Krishna Potthuri wrote:
> Add EDAC support for Xilinx ZynqMP OCM Controller, so this driver
> reports CE and UE errors upon interrupt generation, and also creates UE/CE
> debugfs entries for error injection.
> On Xilinx ZynqMP platform, both OCM Controller driver(zynqmp_edac) and
> DDR Memory Controller driver(synopsys_edac) co-exist which means both
> can be loaded at a time. This scenario is tested on Xilinx ZynqMP
> platform.
> 
> Fix following issue reported by the robot.
> "MAINTAINERS references a file that doesn't exist:
> Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml"
> 
> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  MAINTAINERS                |   7 +
>  drivers/edac/Kconfig       |   9 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/zynqmp_edac.c | 465 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 482 insertions(+)
>  create mode 100644 drivers/edac/zynqmp_edac.c

Some touchups ontop, see below.

I had to revert back to the #ifdeffery because IS_ENABLED doesn't prevent the
compiler from looking inside the conditional...

Anyway, inter-diff below. Holler if something's still amiss.

Thx.

---

 diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
-index 58ab63642e72..7944e40c67da 100644
+index 4cfdefbd744d..68f576700911 100644
 --- a/drivers/edac/Kconfig
 +++ b/drivers/edac/Kconfig
-@@ -539,4 +539,13 @@ config EDAC_DMC520
+@@ -542,4 +542,12 @@ config EDAC_DMC520
  	  Support for error detection and correction on the
  	  SoCs with ARM DMC-520 DRAM controller.
  
-+config EDAC_ZYNQMP_OCM
++config EDAC_ZYNQMP
 +	tristate "Xilinx ZynqMP OCM Controller"
 +	depends on ARCH_ZYNQMP || COMPILE_TEST
 +	help
 +	  This driver supports error detection and correction for the
-+	  Xilinx ZynqMP OCM (On Chip Memory) controller.
-+	  This driver can also be built as a module. If so, the module
-+	  will be called zynqmp_ocm_edac.
++	  Xilinx ZynqMP OCM (On Chip Memory) controller. It can also be
++	  built as a module. In that case it will be called zynqmp_edac.
 +
  endif # EDAC
 diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
-index 2d1641a27a28..47cbda06d7b0 100644
+index 2d1641a27a28..9b025c5b3061 100644
 --- a/drivers/edac/Makefile
 +++ b/drivers/edac/Makefile
 @@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
-+obj-$(CONFIG_EDAC_ZYNQMP_OCM)		+= zynqmp_edac.o
++obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
 diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
 new file mode 100644
-index 000000000000..69069028457b
+index 000000000000..b11f1157d4bb
 --- /dev/null
 +++ b/drivers/edac/zynqmp_edac.c
-@@ -0,0 +1,465 @@
+@@ -0,0 +1,469 @@
 +// SPDX-License-Identifier: GPL-2.0
 +/*
 + * Xilinx ZynqMP OCM ECC Driver
@@ -220,12 +224,14 @@ index 000000000000..69069028457b
 +		p->ceinfo.fault_hi = readl(base + CE_FFD1_OFST);
 +		p->ceinfo.addr = (OCM_BASEVAL | readl(base + CE_FFA_OFST));
 +		writel(ECC_CTRL_CLR_CE_ERR, base + OCM_ISR_OFST);
-+	} else {
++	} else if (mask & OCM_UEINTR_MASK) {
 +		p->ue_cnt++;
 +		p->ueinfo.fault_lo = readl(base + UE_FFD0_OFST);
 +		p->ueinfo.fault_hi = readl(base + UE_FFD1_OFST);
 +		p->ueinfo.addr = (OCM_BASEVAL | readl(base + UE_FFA_OFST));
 +		writel(ECC_CTRL_CLR_UE_ERR, base + OCM_ISR_OFST);
++	} else {
++		WARN_ON_ONCE(1);
 +	}
 +}
 +
@@ -234,7 +240,7 @@ index 000000000000..69069028457b
 + * @dci:	Pointer to the EDAC device instance
 + * @p:		Pointer to the OCM ECC status structure
 + *
-+ * Handles the ECC correctable and uncorrectable error.
++ * Handles correctable and uncorrectable errors.
 + */
 +static void handle_error(struct edac_device_ctl_info *dci, struct ecc_status *p)
 +{
@@ -275,7 +281,7 @@ index 000000000000..69069028457b
 +
 +	regval = readl(priv->baseaddr + OCM_ISR_OFST);
 +	if (!(regval & (OCM_CEINTR_MASK | OCM_UEINTR_MASK))) {
-+		WARN_ONCE(1, "Unhandled IRQ%d.", irq);
++		WARN_ONCE(1, "Unhandled IRQ%d, ISR: 0x%x", irq, regval);
 +		return IRQ_NONE;
 +	}
 +
@@ -403,16 +409,16 @@ index 000000000000..69069028457b
 +	if (ret)
 +		return ret;
 +
-+	ue_bitpos = BIT(priv->ue_bitpos[0]) | BIT(priv->ue_bitpos[1]);
++	if (priv->ue_bitpos[0] > UE_MAX_BITPOS_UPPER ||
++	    priv->ue_bitpos[1] > UE_MAX_BITPOS_UPPER)
++		return -EINVAL;
 +
 +	if (priv->ue_bitpos[0] == priv->ue_bitpos[1]) {
 +		edac_printk(KERN_ERR, EDAC_DEVICE, "Bit positions should not be equal\n");
 +		return -EINVAL;
 +	}
 +
-+	if (priv->ue_bitpos[0] > UE_MAX_BITPOS_UPPER ||
-+	    priv->ue_bitpos[1] > UE_MAX_BITPOS_UPPER)
-+		return -EINVAL;
++	ue_bitpos = BIT(priv->ue_bitpos[0]) | BIT(priv->ue_bitpos[1]);
 +
 +	writel((u32)ue_bitpos, priv->baseaddr + OCM_FID0_OFST);
 +	writel((u32)(ue_bitpos >> 32), priv->baseaddr + OCM_FID1_OFST);
@@ -492,8 +498,9 @@ index 000000000000..69069028457b
 +	/* Enable UE, CE interrupts */
 +	writel((OCM_CEINTR_MASK | OCM_UEINTR_MASK), priv->baseaddr + OCM_IEN_OFST);
 +
-+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
-+		setup_debugfs(dci);
++#ifdef CONFIG_EDAC_DEBUG
++	setup_debugfs(dci);
++#endif
 +
 +	ret = edac_device_add_device(dci);
 +	if (ret)
@@ -515,8 +522,9 @@ index 000000000000..69069028457b
 +	/* Disable UE, CE interrupts */
 +	writel((OCM_CEINTR_MASK | OCM_UEINTR_MASK), priv->baseaddr + OCM_IDS_OFST);
 +
-+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
-+		debugfs_remove_recursive(priv->debugfs_dir);
++#ifdef CONFIG_EDAC_DEBUG
++	debugfs_remove_recursive(priv->debugfs_dir);
++#endif
 +
 +	edac_device_del_device(&pdev->dev);
 +	edac_device_free_ctl_info(dci);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
