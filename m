Return-Path: <linux-edac+bounces-2629-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7589D6A52
	for <lists+linux-edac@lfdr.de>; Sat, 23 Nov 2024 17:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AAE5281A15
	for <lists+linux-edac@lfdr.de>; Sat, 23 Nov 2024 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9484EB50;
	Sat, 23 Nov 2024 16:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvwIJKwl"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B829125B9;
	Sat, 23 Nov 2024 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380581; cv=none; b=OxnsNDAbA9Vt8SimJb2ojhH+XfqSbTiJVd/Ai1z6s5Trjc9OughW57iTKrhLFE3mMVTAHXbcBSMCk4FiydMo5aCR/KCpZFJgX8EfTeY4LK75HcmkNMAirKBR8A2/fFfxDP5HVAtwCGRbfZ+tsBO58IbUmpmrGLVrSyqzZp3j6Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380581; c=relaxed/simple;
	bh=B1KIgU2isjJTKVuNXyXyTbNnTlMSO6X5FDflqG/k0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqkgG3hfoWVuf4yWHb+SVHfK2Lu73yN5M38jOYQOAZUNQuDrvLkmdHsmrctfPsF57sekDI5otBAsbZnsWtNQ4hkvWroa/qIxyodVOkTxD+dggz2ByI5/K/xO6J8fz/7aSagu3k8i80w8EGGIYUHeJYVdy3t3zftgbX+taaQ7uHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvwIJKwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1466C4CECD;
	Sat, 23 Nov 2024 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380580;
	bh=B1KIgU2isjJTKVuNXyXyTbNnTlMSO6X5FDflqG/k0S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvwIJKwlFX6MKBUrKCWtoEL6TfHll2FlQoMCo9HI8+HRmkeGaZcXJKAAL8LHit8ye
	 y+eovBtxZezZF2YxkEg6hoN08BsrGTxxcCAmVLoAlq0Pp3iyAAsh/7QieuzXY/rWyF
	 tfYQQkH+/Zt85UN3/+a/Gs0DcpjntjVjwQtNK0X/GXGzQ1qd/Tb2WLR/78jOXlnqEi
	 bwGF0CPlnlvTd1athuQeL10tUZFpbykeDlXetn9P4LeDGMaibc7Jev3KRs98/be6z8
	 3SS4kbuKrtM1K+OBsZh3fHehCCqFw6sHi8e7LEUNy0cNNw766SzdO/fEqPReL6FC9b
	 ZDVU42Uyq6QhA==
Date: Sat, 23 Nov 2024 17:49:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-edac@vger.kernel.org, git@amd.com, krzk@kernel.or, robh@kernel.org, 
	conor+dt@kernel.org, bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, 
	mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH 3/3] EDAC: Versal NET: Add support for error notification
Message-ID: <6zhoh5mqzrzqf4mq7lbahwtqvw45dpaqsqd7kj3tkfvencaftu@3r7yculmy4ex>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
 <20241122100625.24571-4-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241122100625.24571-4-shubhrajyoti.datta@amd.com>

On Fri, Nov 22, 2024 at 03:36:25PM +0530, Shubhrajyoti Datta wrote:
> The Versal NET edac listens to the notifications from NMC(Network
> management controller) on rpmsg. The driver registers on the error_edac
> channel. Send a RAS event trace upon a notification. On reading
> the notification the user space application can decide on the response.
> A sysfs reset entry is created for the same that sends an acknowledgment
> back to the NMC. For reporting events register to the RAS framework. For
> memory mc events are used other events use non-standard events.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  .../ABI/testing/sysfs-driver-versalnet-edac   |   11 +
>  drivers/edac/Kconfig                          |    9 +
>  drivers/edac/Makefile                         |    1 +
>  drivers/edac/versalnet_rpmsg_edac.c           | 1321 +++++++++++++++++
>  4 files changed, 1342 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-versalnet-edac
>  create mode 100644 drivers/edac/versalnet_rpmsg_edac.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-versalnet-edac b/Documentation/ABI/testing/sysfs-driver-versalnet-edac
> new file mode 100644
> index 000000000000..598a6c6cef39
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-versalnet-edac
> @@ -0,0 +1,11 @@
> +What:		/sys/devices/system/edac/.../reset
> +Date:		Nov 2024
> +Contact:	shubhrajyoti.datta@amd.com
> +Description:
> +		Writing 1/2 to this file will send a reset request to the NMC (Network
> +		Management Controller). 1 will request a SRST (Soft reset) and 2 will
> +		request a POR ( Power-On Reset).
> +
> +		For example::
> +
> +		  # echo 1 > /sys/devices/system/edac/.../reset

ABI docs are always separate patches.

Anyway, sysfs entry to reset memory is a NAK.

NAK.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 81af6c344d6b..c3e0644aed0d 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -564,5 +564,14 @@ config EDAC_VERSAL
>  	  Support injecting both correctable and uncorrectable errors
>  	  for debugging purposes.
>  
> +config EDAC_VERSALNET
> +	tristate "AMD Versal NET EDAC"

No dependency on ARCH? Is this for OF platforms?

> +	depends on CDX_CONTROLLER
> +	help
> +	  Support for error detection and correction on the AMD Versal NET DDR
> +	  memory controller.
> +
> +	  The memory controller supports single bit error correction, double bit
> +	  error detection. Report various errors to the userspace.
>  
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index faf310eec4a6..7b1a8525c021 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
>  obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
> +obj-$(CONFIG_EDAC_VERSALNET)		+= versalnet_rpmsg_edac.o

...

> +};
> +
> +/* The driver should have only one instance */
> +static int probe_once;

Oh, no, this is just poor coding and design style. Such stuff is a big
warning sign. How, really, how, OF platform could have two instances?

...

> +static int mc_probe(struct platform_device *pdev)
> +{
> +	struct edac_mc_layer layers[2];
> +	u32 num_chans, rank, dwidth;
> +	struct mem_ctl_info *mci;
> +	struct edac_priv *priv;
> +	int rc;
> +
> +	rc = device_property_read_u32(&pdev->dev, "amd,rank", &rank);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "unable to read rank property");
> +		return rc;
> +	}
> +
> +	rc = device_property_read_u32(&pdev->dev, "amd,num-chans", &num_chans);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "unable to read num-chans property");
> +		return rc;
> +	}
> +
> +	rc = device_property_read_u32(&pdev->dev, "amd,dwidth", &dwidth);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "unable to read dwidth property");
> +		return rc;
> +	}
> +
> +	mutex_lock(&vnet_edac_lock);
> +	if (probe_once) {

Not possible. Drop. Fix your DTS (and the binding) instead.

> +		rc = -ENODEV;
> +		goto free_lock;
> +	}
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = rank;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = num_chans;
> +	layers[1].is_virt_csrow = false;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct edac_priv));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed memory allocation for mc instance\n");
> +		rc = -ENOMEM;
> +		goto free_lock;
> +	}
> +
> +	priv = mci->pvt_info;
> +	priv->dwidth = dwidth;
> +
> +	mc_init(mci, pdev);
> +
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register with EDAC core\n");
> +		goto free_edac_mc;
> +	}
> +
> +	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)mci;
> +	INIT_WORK(&priv->work, amd_rpmsg_post_probe_work);
> +	rc = register_rpmsg_driver(&amd_rpmsg_driver);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register RPMsg driver: %d\n", rc);
> +		goto del_edac_mc;
> +	}
> +
> +	rc = device_create_file(&mci->dev, &dev_attr_reset);
> +	if (rc < 0)
> +		goto unregister;
> +
> +	probe_once = 1;
> +	mutex_unlock(&vnet_edac_lock);
> +
> +	return 0;
> +
> +unregister:
> +	unregister_rpmsg_driver(&amd_rpmsg_driver);
> +del_edac_mc:
> +	edac_mc_del_mc(&pdev->dev);
> +free_edac_mc:
> +	edac_mc_free(mci);
> +free_lock:
> +	mutex_unlock(&vnet_edac_lock);
> +
> +	return rc;
> +}
> +
> +static void mc_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&vnet_edac_lock);
> +	probe_once = 0;
> +	unregister_rpmsg_driver(&amd_rpmsg_driver);
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);
> +	mutex_unlock(&vnet_edac_lock);
> +}
> +
> +static const struct of_device_id amd_edac_match[] = {
> +	{ .compatible = "amd,versalnet-edac", },
> +	{
> +		/* end of table */

Really? No, drop.

> +	}
> +};
> +MODULE_DEVICE_TABLE(of, amd_edac_match);
> +
> +static struct platform_driver amd_ddr_edac_mc_driver = {
> +	.driver = {
> +		.name = "amd-ddrmc-edac",
> +		.of_match_table = amd_edac_match,
> +	},
> +	.probe = mc_probe,
> +	.remove = mc_remove,
> +};
> +
> +module_platform_driver(amd_ddr_edac_mc_driver);
> +
> +MODULE_AUTHOR("AMD Inc");
> +MODULE_DESCRIPTION("AMD DDRMC ECC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.17.1
> 

