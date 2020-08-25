Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB229251CCF
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHYQDO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 12:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHYQCw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 12:02:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4172BC061756
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so1489786pjb.1
        for <linux-edac@vger.kernel.org>; Tue, 25 Aug 2020 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Msjpy1I7gPlWRtRVg2Bli+/d+lSvFcjgfwGKLe96W7w=;
        b=MhJjuXdtauJWGiFGMyBUhB8w7n905fCcZtN/nEKJnHQ5bpdPSitrULrFdxchJP1Xxy
         K0cicK2mhLC8tLeC02a8FDe8CpII55EG+97FApnnbBd2ckNWQvL3/2ADXQ0X+M4fLTO7
         jSmC3fSQZzV2NktT5Mi3Bc8BD+vTANHMsavE2elq/pl6Ihr97S5lUOlFwCLMiBYIzZo2
         aVzn0hLwB7OsomZKMi0qlXj1mHmuTd39mUVi5NISrY0hu/c1Pa/oeb68cAOhocC5du2V
         qPCyc59bNOgoBDfjAlWu0dOMK/Z3TY99taljzEgrIMtoxBAg02WYvDZi3dRpv3mXkbjV
         vc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Msjpy1I7gPlWRtRVg2Bli+/d+lSvFcjgfwGKLe96W7w=;
        b=R4uCQQsik/cmlMhIy4yMVKlytdg1MWPzLEtm+c/2/7ygdVbOy+abymXUZmYEfoXx7C
         LxjuMNWBw80zBfD/IacexDtBNNnjgPCAmq1BMcTEJ9nmPEAznWvkqpjAS9atk/cM0Rdh
         IsUnHPxRNXFLe1TItPoXzlHM8KcF5pZVosEVeHREmqHJfq5Ea5ZPh0/FkjrJ/cwgYboq
         yEzU5tN02/Uc7aBAvCNUikcRHzUmb2KKUWYBfzh6gX6SpCK5Mbq1X64d+LjEJtgyR6Rv
         SYwBedzM+IfMSLMejAv+2cgr5ioOdkO4S0SgFkrQWKsPhhkeMUXqpJQ3ozTE76p2l1M+
         zvYA==
X-Gm-Message-State: AOAM530ppwx48mjoNYgK5gna0H0HJZeqH7j53wWn1PgkXtTkavgx2gCg
        pV9F9/YKvsqJX5Fy3hIWLoKzEw==
X-Google-Smtp-Source: ABdhPJyM3WkQVkjNW2BFGPrFXN6f/zYk99lIwmBRlwyxazYNgpCdUEJGoEDidELLzMwf6VcDVbEl+A==
X-Received: by 2002:a17:90a:1741:: with SMTP id 1mr2265282pjm.173.1598371370970;
        Tue, 25 Aug 2020 09:02:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q82sm17807271pfc.139.2020.08.25.09.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:02:50 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:02:50 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Aug 2020 07:54:07 PDT (-0700)
Subject:     Re: [PATCH 2/3] soc: sifive: Add SiFive specific Cadence DDR controller driver
In-Reply-To: <1598357182-4226-3-git-send-email-yash.shah@sifive.com>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        aou@eecs.berkeley.edu, james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com, yash.shah@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yash.shah@sifive.com
Message-ID: <mhng-f3b4681f-2fc1-4384-94b6-efeae830795e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 25 Aug 2020 05:06:21 PDT (-0700), yash.shah@sifive.com wrote:
> Add a driver to manage the Cadence DDR controller present on SiFive SoCs
> At present the driver manages the EDAC feature of the DDR controller.
> Additional features may be added to the driver in future to control
> other aspects of the DDR controller.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/soc/sifive/Kconfig      |   6 ++
>  drivers/soc/sifive/Makefile     |   3 +-
>  drivers/soc/sifive/sifive_ddr.c | 207 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/sifive/sifive_ddr.h |  73 ++++++++++++++
>  4 files changed, 288 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/sifive/sifive_ddr.c
>  create mode 100644 include/soc/sifive/sifive_ddr.h
>
> diff --git a/drivers/soc/sifive/Kconfig b/drivers/soc/sifive/Kconfig
> index 58cf8c4..f41d8fe 100644
> --- a/drivers/soc/sifive/Kconfig
> +++ b/drivers/soc/sifive/Kconfig
> @@ -7,4 +7,10 @@ config SIFIVE_L2
>  	help
>  	  Support for the L2 cache controller on SiFive platforms.
>
> +config SIFIVE_DDR
> +	bool "Sifive DDR controller driver"
> +	help
> +	  Support for the management of cadence DDR controller on SiFive
> +	  platforms.
> +
>  endif
> diff --git a/drivers/soc/sifive/Makefile b/drivers/soc/sifive/Makefile
> index b5caff7..b4acb5c 100644
> --- a/drivers/soc/sifive/Makefile
> +++ b/drivers/soc/sifive/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -obj-$(CONFIG_SIFIVE_L2)	+= sifive_l2_cache.o
> +obj-$(CONFIG_SIFIVE_L2)		+= sifive_l2_cache.o
> +obj-$(CONFIG_SIFIVE_DDR)	+= sifive_ddr.o
> diff --git a/drivers/soc/sifive/sifive_ddr.c b/drivers/soc/sifive/sifive_ddr.c
> new file mode 100644
> index 0000000..b1b421c
> --- /dev/null
> +++ b/drivers/soc/sifive/sifive_ddr.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SiFive specific cadence DDR controller Driver
> + *
> + * Copyright (C) 2019-2020 SiFive, Inc.
> + *
> + */
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/delay.h>
> +#include <soc/sifive/sifive_ddr.h>
> +
> +static ATOMIC_NOTIFIER_HEAD(ddr_err_chain);
> +
> +int register_sifive_ddr_error_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_register(&ddr_err_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(register_sifive_ddr_error_notifier);
> +
> +int unregister_sifive_ddr_error_notifier(struct notifier_block *nb)
> +{
> +	return atomic_notifier_chain_unregister(&ddr_err_chain, nb);
> +}
> +EXPORT_SYMBOL_GPL(unregister_sifive_ddr_error_notifier);
> +
> +static void handle_ce(struct sifive_ddr_priv *pv)
> +{
> +	u64 err_c_addr = 0x0;
> +	u64 err_c_data = 0x0;
> +	u32 err_c_synd, err_c_id;
> +	u32 sig_val_l, sig_val_h;
> +
> +	sig_val_l = readl(pv->reg + ECC_C_ADDR_L_REG);
> +	sig_val_h = (readl(pv->reg + ECC_C_ADDR_H_REG) &
> +		     ECC_ADDR_H_MASK);
> +	err_c_addr = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +	sig_val_l = readl(pv->reg + ECC_C_DATA_L_REG);
> +	sig_val_h = readl(pv->reg + ECC_C_DATA_H_REG);
> +	err_c_data = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +	err_c_id = ((readl(pv->reg + ECC_U_C_ID_REG) &
> +		     ECC_C_ID_MASK) >> ECC_C_ID_SHIFT);
> +
> +	err_c_synd = ((readl(pv->reg + ECC_C_SYND_REG) &
> +		      ECC_SYND_MASK) >> ECC_SYND_SHIFT);
> +
> +	pv->error_count = 1;
> +	pv->page_frame_number = err_c_addr >> PAGE_SHIFT;
> +	pv->offset_in_page = err_c_addr & ~PAGE_MASK;
> +	pv->syndrome = err_c_synd;
> +	pv->top_layer = 0;
> +	pv->mid_layer = 0;
> +	pv->low_layer = -1;
> +
> +	atomic_notifier_call_chain(&ddr_err_chain, SIFIVE_DDR_ERR_TYPE_CE, pv);
> +}
> +
> +static void handle_ue(struct sifive_ddr_priv *pv)
> +{
> +	u64 err_u_addr = 0x0;
> +	u64 err_u_data = 0x0;
> +	u32 err_u_synd, err_u_id;
> +	u32 sig_val_l, sig_val_h;
> +
> +	sig_val_l = readl(pv->reg + ECC_U_ADDR_L_REG);
> +	sig_val_h = (readl(pv->reg + ECC_U_ADDR_H_REG) &
> +		     ECC_ADDR_H_MASK);
> +	err_u_addr = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +	sig_val_l = readl(pv->reg + ECC_U_DATA_L_REG);
> +	sig_val_h = readl(pv->reg + ECC_U_DATA_H_REG);
> +	err_u_data = (((ulong)sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +	err_u_id = ((readl(pv->reg + ECC_U_C_ID_REG) &
> +		    ECC_U_ID_MASK) >> ECC_U_ID_SHIFT);
> +
> +	err_u_synd = ((readl(pv->reg + ECC_U_SYND_REG) &
> +		      ECC_SYND_MASK) >> ECC_SYND_SHIFT);
> +
> +	pv->error_count = 1;
> +	pv->page_frame_number = err_u_addr >> PAGE_SHIFT;
> +	pv->offset_in_page = err_u_addr & ~PAGE_MASK;
> +	pv->syndrome = err_u_synd;
> +	pv->top_layer = 0;
> +	pv->mid_layer = 0;
> +	pv->low_layer = -1;
> +
> +	atomic_notifier_call_chain(&ddr_err_chain, SIFIVE_DDR_ERR_TYPE_UE, pv);
> +}
> +
> +static irqreturn_t ecc_isr(int irq, void *ptr)
> +{
> +	struct sifive_ddr_priv *pv = ptr;
> +	u32 intr_status;
> +	u32 val;
> +
> +	/* Check the intr status and confirm ECC error intr */
> +	intr_status = readl(pv->reg + ECC_CTL_INT_STATUS_REG);
> +
> +	dev_dbg(pv->dev, "InterruptStatus : 0x%x\n", intr_status);
> +	val = intr_status & (ECC_INT_CE_UE_MASK);
> +	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))
> +		return IRQ_NONE;
> +
> +	if (val & ECC_CE_INTR_MASK) {
> +		handle_ce(pv);
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_CE_EVENT)
> +			writel(ECC_INT_CE_EVENT,
> +			       pv->reg + ECC_CTL_INT_ACK_REG);
> +		else if (val & ECC_INT_SECOND_CE_EVENT)
> +			writel(ECC_INT_SECOND_CE_EVENT,
> +			       pv->reg + ECC_CTL_INT_ACK_REG);
> +		else
> +			dev_err(pv->dev, "Failed to clear IRQ\n");
> +	}
> +
> +	if (val & ECC_UE_INTR_MASK) {
> +		handle_ue(pv);
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_UE_EVENT)
> +			writel(ECC_INT_UE_EVENT,
> +			       pv->reg + ECC_CTL_INT_ACK_REG);
> +		else if (val & ECC_INT_SECOND_UE_EVENT)
> +			writel(ECC_INT_SECOND_UE_EVENT,
> +			       pv->reg + ECC_CTL_INT_ACK_REG);
> +		else
> +			dev_err(pv->dev, "Failed to clear IRQ\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int sifive_ddr_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct sifive_ddr_priv *priv;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = dev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(priv->reg))
> +		return PTR_ERR(priv->reg);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(dev, irq, ecc_isr, 0, "sifive-fu540-ddr", priv);
> +	if (ret) {
> +		dev_err(dev, "request_irq failed\n");
> +		return ret;
> +	}
> +
> +	/* Enable & set CE/UE Interrupts for DDR4 Controller */
> +	writel(~(ECC_INT_CE_UE_MASK), priv->reg + ECC_CTL_INT_MASK_REG);
> +
> +	platform_set_drvdata(pdev, priv);
> +	dev_info(dev, "SiFive DDR probe successful\n");

I'm not sure what the rules are here, but this doesn't seem like a particularly
useful print.

> +
> +	return 0;
> +}
> +
> +static int sifive_ddr_remove(struct platform_device *pdev)
> +{
> +	struct sifive_ddr_priv *priv = platform_get_drvdata(pdev);
> +
> +	/* Disable All ECC Interrupts for DDR4 Controller */
> +	writel(ECC_INT_CE_UE_MASK, priv->reg + ECC_CTL_INT_MASK_REG);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id sifive_ddr_of_match[] = {
> +	{ .compatible = "sifive,fu540-c000-ddr"},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, sifive_ddr_of_match);
> +
> +static struct platform_driver sifive_ddr_driver = {
> +	.driver = {
> +		.name = "sifive-ddr",
> +		.of_match_table = sifive_ddr_of_match,
> +	},
> +	.probe = sifive_ddr_probe,
> +	.remove = sifive_ddr_remove,
> +};
> +
> +module_platform_driver(sifive_ddr_driver);
> +
> +MODULE_AUTHOR("SiFive");
> +MODULE_DESCRIPTION("SiFive DDR Controller driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/soc/sifive/sifive_ddr.h b/include/soc/sifive/sifive_ddr.h
> new file mode 100644
> index 0000000..2ff8623
> --- /dev/null
> +++ b/include/soc/sifive/sifive_ddr.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * SiFive DDR Controller header file
> + *
> + */
> +
> +#ifndef __SOC_SIFIVE_DDR_H
> +#define __SOC_SIFIVE_DDR_H
> +
> +int register_sifive_ddr_error_notifier(struct notifier_block *nb);
> +int unregister_sifive_ddr_error_notifier(struct notifier_block *nb);
> +
> +struct sifive_ddr_priv {
> +	void __iomem *reg;
> +	struct device *dev;
> +	u16 error_count;
> +	unsigned long page_frame_number;
> +	unsigned long offset_in_page;
> +	unsigned long syndrome;
> +	int top_layer;
> +	int mid_layer;
> +	int low_layer;
> +};
> +
> +#define SIFIVE_DDR_ERR_TYPE_CE	(0)
> +#define SIFIVE_DDR_ERR_TYPE_UE	(1)
> +#define SIFIVE_DDR_EDAC_GRAIN	(1)
> +#define SIFIVE_MEM_TYPE_DDR4	0xA
> +#define SIFIVE_DDR_WIDTH_16	(2)
> +#define SIFIVE_DDR_WIDTH_32	(1)
> +#define SIFIVE_DDR_WIDTH_64	(0)
> +
> +#define DDR_CTL_MEM_TYPE_REG	0x000
> +#define DDR_CTL_MEM_WIDTH_REG	0x004
> +#define ECC_CTL_CONTROL_REG	0x174
> +#define ECC_U_ADDR_L_REG	0x180
> +#define ECC_U_ADDR_H_REG	0x184
> +#define ECC_U_DATA_L_REG	0x188
> +#define ECC_U_DATA_H_REG	0x18c
> +
> +#define ECC_C_ADDR_L_REG	0x190
> +#define ECC_C_ADDR_H_REG	0x194
> +#define ECC_C_DATA_L_REG	0x198
> +#define ECC_C_DATA_H_REG	0x19c
> +#define ECC_U_C_ID_REG		0x1A0
> +#define ECC_CTL_INT_STATUS_REG	0x210
> +#define ECC_CTL_INT_ACK_REG	0x218
> +#define ECC_CTL_INT_MASK_REG	0x220
> +#define ECC_C_SYND_REG		ECC_C_ADDR_H_REG
> +#define ECC_U_SYND_REG		ECC_U_ADDR_H_REG
> +
> +#define ECC_CTL_MTYPE_MASK	GENMASK(11, 8)
> +#define CTL_MEM_MAX_WIDTH_MASK	GENMASK(31, 24)
> +#define ECC_ADDR_H_MASK		GENMASK(3, 0)
> +#define ECC_INT_CE_UE_MASK	GENMASK(6, 3)
> +#define ECC_CE_INTR_MASK	GENMASK(4, 3)
> +#define ECC_UE_INTR_MASK	GENMASK(6, 5)
> +#define ECC_INT_CE_EVENT	BIT(3)
> +#define ECC_INT_SECOND_CE_EVENT	BIT(4)
> +#define ECC_INT_UE_EVENT	BIT(5)
> +#define ECC_INT_SECOND_UE_EVENT	BIT(6)
> +#define ECC_CTL_ECC_ENABLE	BIT(16)
> +
> +#define ECC_C_ID_MASK		GENMASK(28, 16)
> +#define ECC_U_ID_MASK		GENMASK(12, 0)
> +#define ECC_C_ID_SHIFT		(16)
> +#define ECC_U_ID_SHIFT		(0)
> +#define ECC_SYND_MASK		GENMASK(15, 8)
> +#define ECC_SYND_SHIFT		(8)
> +
> +#define CTL_REG_WIDTH_SHIFT	(32)
> +
> +#endif /* __SOC_SIFIVE_DDR_H */

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
