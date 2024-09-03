Return-Path: <linux-edac+bounces-1773-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47F2969412
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 08:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D531F2144C
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E061CF29C;
	Tue,  3 Sep 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKQRWhuG"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29FF1C62B2;
	Tue,  3 Sep 2024 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346064; cv=none; b=KHVjelBP5olGEXJ2w/NneKS/wgTsOHNHdcW+2Hru6O6SYUywFTwpom++7OiMNPNZVkD+6lT6IR3hZXBKfYV1odkcFh8ejh+TmXAwcBsbpBc0txkbVcY4YDFGJhkvzfotsg0mtWh4Tt3sAYE7iNqdIeXjqKXipoxbjxte5PFPO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346064; c=relaxed/simple;
	bh=EQkIndtccDDEeOKmo5Phhl8fdv2L3+KxXXStytcrfFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti5iFyV0E5MArNJFaz3TYg7s/UmSdNAldnk/ibCbY0fGyJ64YIN38Qvw0VHovHhHhW3ZUXYqAVZFEnfMTTXxnYGr/x++pb+emiEO0VxlXtasENT+1gsEz7EWLPBsEBjmt/8a8KA0F/K1+MQefWwtH/r6GIBq5AbkZF5L+baJQIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKQRWhuG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C847C4CEC5;
	Tue,  3 Sep 2024 06:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725346063;
	bh=EQkIndtccDDEeOKmo5Phhl8fdv2L3+KxXXStytcrfFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKQRWhuGHlaT6J8yCXfLBy1Io+e/P9EsO83U1RDW3xFACV2bogjp3j2FDM1kKOwvI
	 incunCtU+VahDJR8uWtDdWmVZBTXwfPMBHXW37LagNIC1534lhoAIn6T6g0xZNCNU4
	 USDZc3y104VrxKA9vApTYdzo591fpFNyqrbxRaTT2lwzdXJ1UQcfE4NGy64ilsOWEa
	 5ZzXpaGEuosfWkQRHiyEQtR8vp2V8wMe954JFKsIApjfRLwOKuv4CFKHdDl8RYmStY
	 3mnAfoKFE5fTfF+d54HPK8YqfpQeCFYWHzY/k1msAL4SzqNtyNefBAqlmLHGr3Hp/x
	 x+nZgaDBm6U/w==
Date: Tue, 3 Sep 2024 08:47:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	chenhuacai@kernel.org, linux-edac@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com, 
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
Message-ID: <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903015354.9443-3-zhaoqunqin@loongson.cn>

On Tue, Sep 03, 2024 at 09:53:54AM +0800, Zhao Qunqin wrote:
> Report single bit errors (CE) only.
> 
> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
> ---
>  MAINTAINERS                  |   1 +
>  arch/loongarch/Kconfig       |   1 +
>  drivers/edac/Kconfig         |   8 ++
>  drivers/edac/Makefile        |   1 +
>  drivers/edac/ls3a5000_edac.c | 187 +++++++++++++++++++++++++++++++++++
>  5 files changed, 198 insertions(+)
>  create mode 100644 drivers/edac/ls3a5000_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6cc8cfc8f..b43f82279 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
> +F:	drivers/edac/ls3a5000_edac.c
>  
>  LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>  M:	Sathya Prakash <sathya.prakash@broadcom.com>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 70f169210..348030c24 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -182,6 +182,7 @@ config LOONGARCH
>  	select PCI_QUIRKS
>  	select PERF_USE_VMALLOC
>  	select RTC_LIB
> +	select EDAC_SUPPORT

I think you got here comment before. How did you address it?

>  	select SPARSE_IRQ
>  	select SYSCTL_ARCH_UNALIGN_ALLOW
>  	select SYSCTL_ARCH_UNALIGN_NO_WARN
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 16c8de505..2d10256f0 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>  	  Support injecting both correctable and uncorrectable errors
>  	  for debugging purposes.
>  

...

 +
> +static int loongson_edac_probe(struct platform_device *pdev)
> +{
> +	struct resource *rs;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[2];
> +	struct loongson_edac_pvt *pvt;
> +	u64 *vbase = NULL;
> +
> +	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	/* not return if can not find resource or resource start equals NULL */

Why?

> +	if (rs && rs->start) {
> +		vbase = devm_ioremap_resource(&pdev->dev, rs);
> +		if (IS_ERR(vbase))
> +			return PTR_ERR(vbase);
> +	}
> +
> +	/* allocate a new MC control structure */
> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	layers[1].type = EDAC_MC_LAYER_SLOT;
> +	layers[1].size = 1;
> +	layers[1].is_virt_csrow = true;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
> +	if (mci == NULL)
> +		return -ENOMEM;
> +
> +	edac_dbg(0, "MC: mci = %p\n", mci);

Nope, drop. You should never print pointers.

> +
> +	mci->mc_idx = edac_device_alloc_index();
> +	mci->mtype_cap = MEM_FLAG_RDDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
> +	mci->edac_cap = EDAC_FLAG_NONE;
> +	mci->mod_name = "loongson_edac.c";
> +	mci->ctl_name = "loongson_edac_ctl";
> +	mci->dev_name = "loongson_edac_dev";
> +	mci->ctl_page_to_phys = NULL;
> +	mci->pdev = &pdev->dev;
> +	mci->error_desc.grain = 8;
> +	/* Set the function pointer to an actual operation function */
> +	mci->edac_check = loongson_edac_check;
> +
> +	loongson_pvt_init(mci, vbase);
> +	get_dimm_config(mci);
> +
> +	if (edac_mc_add_mc(mci)) {
> +		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
> +		edac_mc_free(mci);

That's still a success of probe? Weird a bit.

> +	}
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	return 0;
> +}
> +
> +static void loongson_edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
> +
> +	if (mci)
> +		edac_mc_free(mci);
> +}
> +
> +static const struct of_device_id loongson_edac_of_match[] = {
> +	{ .compatible = "loongson,ls3a5000-mc-edac", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
> +
> +static struct platform_driver loongson_edac_driver = {
> +	.probe		= loongson_edac_probe,
> +	.remove		= loongson_edac_remove,
> +	.driver		= {
> +		.name	= "ls-mc-edac",
> +		.of_match_table = loongson_edac_of_match,
> +	},
> +};
> +
> +module_platform_driver(loongson_edac_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");

Drop \n.

> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
> -- 
> 2.43.0
> 

