Return-Path: <linux-edac+bounces-5248-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DBC18885
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 07:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7DE4F6867
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDEE3081CD;
	Wed, 29 Oct 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeDvyJ2Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA573081CA;
	Wed, 29 Oct 2025 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761720777; cv=none; b=YsbYyU8vOP7doHtXw6ouUoD1rPnDKiYYInV3Hg7EZAVyhMYM6xTGVe8pJEza0oF1zedKpML0RGylbJpOd4rRam59zuOzL8zYPhuf9xTzOt81zDmo/gKdttPwB7mf70XQyXAAXWMhH3ZxXqXwlNzTwrirM8WrU3jIjJENnl0lrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761720777; c=relaxed/simple;
	bh=wLvkhakhduQOY2vhLJheVjgPnyTOxK3Ps1mJoXA9jHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDBVMKm0hoDVLKcUEqzRM8ciESasRToyckHwuzUcFPh5gqWKU4RGFK98Tb79tEmhgLeg7hw5pXmchW04xQblwZyaGMUSQu6IcTsrB5ZsUkrrTxSodsPf6/Y4MkNxdXGqGMGGPCWK1KmatdZ6dToh1F6wMiP/Z0qtoMAjAG8drEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeDvyJ2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F474C4CEF7;
	Wed, 29 Oct 2025 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761720777;
	bh=wLvkhakhduQOY2vhLJheVjgPnyTOxK3Ps1mJoXA9jHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeDvyJ2Z+gTp2mFQGlLJeqXbER6gGXl07XSBLxOsgkquHKB+VKpSvWFDBw5zlA/fk
	 RwgyDq6IFy3J8MA5p0nAhZ2yDkhcuqj6jc4Y02tsqykFpBmrcTdlkFsUV4KCEKTSuA
	 vGMDtldMmloj2f+PtVtqx4Gv3+fX3+2zSZQudN5otZP9j4NdgQoQ7dzR4Fw59qnfO0
	 2Clqp/iFUWPx+3cehGasieYo5LrNtvRhQTIZwVbiVQnw1f+MRbOuVmtnI+dLhM4HEo
	 qz4rYrGLL6rNHfCYX2xEOL4i8tNRaSi4T06fHD9+g+0RxyA173PX0YxNdysAEfOLaW
	 rVVMlHQdIvnJw==
Date: Wed, 29 Oct 2025 07:52:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, matthew.gerlach@altera.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, 
	linux-edac@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] EDAC/altera: Add support for CRAM SEU error handling
 on SoCFPGA
Message-ID: <20251029-new-placid-woodlouse-6b975c@kuoka>
References: <20251028092232.773991-1-niravkumarlaxmidas.rabara@altera.com>
 <20251028092232.773991-6-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251028092232.773991-6-niravkumarlaxmidas.rabara@altera.com>

On Tue, Oct 28, 2025 at 05:22:31PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> Add new EDAC driver support for detecting and handling Single Event Upset
> (SEU) errors in the FPGA Configuration RAM (CRAM) on Altera SoCFPGA
> devices.
> 
> The Secure Device Manager (SDM) is responsible for detecting correctable
> and uncorrectable SEU errors and notifies the CPU through a dedicated
> interrupt. Upon receiving the interrupt, the driver invokes an SMC call
> to the ARM Trusted Firmware (ATF) to query the error status.
> The ATF, in turn, communicates with the SDM via the mailbox interface to
> retrieve the error details and returns to the driver.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
>  drivers/edac/Kconfig                         |  12 ++
>  drivers/edac/altera_edac.c                   | 178 +++++++++++++++++++
>  drivers/edac/altera_edac.h                   |   9 +
>  include/linux/firmware/intel/stratix10-smc.h |  37 ++++
>  4 files changed, 236 insertions(+)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 33a9fccde2fe..701b15e73a39 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -477,6 +477,18 @@ config EDAC_ALTERA_SDMMC
>  	  Support for error detection and correction on the
>  	  Altera SDMMC FIFO Memory for Altera SoCs.
>  
> +config EDAC_ALTERA_CRAM_SEU
> +	bool "Altera CRAM SEU"
> +	depends on EDAC_ALTERA=y && 64BIT
> +	help
> +	  Support for error detection and correction on Altera SoCs for
> +	  FPGA Configuration RAM(CRAM) Single Event Upset(SEU).
> +	  The SEU errors caused by radiation or other transient events are
> +	  monitored by the Secure Device Manager (SDM), which notifies the
> +	  CPU through a dedicated interrupt.
> +	  This driver uses an SMC interface to query the error status and
> +	  report events to the EDAC framework.
> +
>  config EDAC_SIFIVE
>  	bool "Sifive platform EDAC driver"
>  	depends on EDAC=y && SIFIVE_CCACHE
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index a82c3b01be1a..ac2151c625a2 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -656,6 +656,19 @@ static const struct file_operations altr_edac_a10_device_inject_fops __maybe_unu
>  	.llseek = generic_file_llseek,
>  };
>  
> +#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
> +static ssize_t __maybe_unused
> +altr_edac_seu_trig(struct file *file, const char __user *user_buf,
> +		   size_t count, loff_t *ppos);
> +
> +static const struct file_operations
> +altr_edac_cram_inject_fops __maybe_unused = {
> +	.open = simple_open,
> +	.write = altr_edac_seu_trig,
> +	.llseek = generic_file_llseek,
> +};
> +#endif
> +
>  #ifdef CONFIG_EDAC_ALTERA_IO96B
>  static ssize_t __maybe_unused
>  altr_edac_io96b_device_trig(struct file *file, const char __user *user_buf,
> @@ -1492,6 +1505,56 @@ static const struct edac_device_prv_data a10_usbecc_data = {
>  
>  #endif	/* CONFIG_EDAC_ALTERA_USB */
>  
> +#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
> +static irqreturn_t seu_irq_handler(int irq, void *dev_id)
> +{
> +	struct altr_edac_device_dev *dci = dev_id;
> +	struct arm_smccc_res result;
> +
> +	arm_smccc_smc(INTEL_SIP_SMC_SEU_ERR_STATUS, 0,
> +		      0, 0, 0, 0, 0, 0, &result);
> +
> +	if ((u32)result.a0) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "SEU %s: Count=0x%X, SecAddr=0x%X, ErrData=0x%X\n",
> +			    ((u32)result.a2 & BIT(28)) == 0 ? "UE" : "CE",
> +			    (u32)result.a0, (u32)result.a1, (u32)result.a2);
> +
> +		if ((u32)result.a2 & BIT(28))
> +			edac_device_handle_ce(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +		else
> +			edac_device_handle_ue(dci->edac_dev, 0, 0, dci->edac_dev_name);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t __maybe_unused
> +altr_edac_seu_trig(struct file *file, const char __user *user_buf,
> +		   size_t count, loff_t *ppos)
> +{
> +	struct edac_device_ctl_info *edac_dci = file->private_data;
> +	struct altr_edac_device_dev *dev = edac_dci->pvt_info;
> +	u8 trig_type;
> +	struct arm_smccc_res result;
> +
> +	if (!user_buf || get_user(trig_type, user_buf))
> +		return -EFAULT;
> +
> +	if (trig_type == ALTR_UE_TRIGGER_CHAR)
> +		arm_smccc_smc(INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR,
> +			      ((u64)dev->seu.ue_msb << 32) |
> +			      dev->seu.ue_lsb,
> +			      2, 0, 0, 0, 0, 0, &result);
> +	else
> +		arm_smccc_smc(INTEL_SIP_SMC_SAFE_INJECT_SEU_ERR,
> +			      ((u64)dev->seu.ce_msb << 32) |
> +			      dev->seu.ce_lsb, 2, 0, 0, 0,
> +			      0, 0, &result);
> +
> +	return count;
> +}
> +#endif
> +
>  /********************** QSPI Device Functions **********************/
>  
>  #ifdef CONFIG_EDAC_ALTERA_QSPI
> @@ -2031,6 +2094,117 @@ static int get_s10_sdram_edac_resource(struct device_node *np,
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_EDAC_ALTERA_CRAM_SEU)
> +static int altr_edac_seu_device_add(struct altr_arria10_edac *edac,
> +				    struct platform_device *pdev, struct device_node *dev_node)
> +{
> +	struct edac_device_ctl_info *dci;
> +	struct altr_edac_device_dev *altdev;
> +	char *ecc_name = kstrdup(dev_node->name, GFP_KERNEL);
> +	int edac_idx;
> +	int seu_irq;
> +	int rc = 0;
> +
> +	seu_irq = platform_get_irq_byname(pdev, "sdm_seu");
> +	if (seu_irq < 0) {
> +		dev_warn(&pdev->dev, "no %s IRQ defined\n", "sdm_seu");
> +		return 0;
> +	}
> +
> +	edac_idx = edac_device_alloc_index();
> +	dci = edac_device_alloc_ctl_info(sizeof(*altdev), ecc_name,
> +					 1, ecc_name, 1, 0, edac_idx);
> +	if (!dci) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "%s: Unable to allocate EDAC device\n", ecc_name);

NAK, you never print errors on ENOMEM.

Best regards,
Krzysztof


