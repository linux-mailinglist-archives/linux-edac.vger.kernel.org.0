Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16A3126DD6
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2019 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfLSTRD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Dec 2019 14:17:03 -0500
Received: from foss.arm.com ([217.140.110.172]:43338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfLSTRD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 19 Dec 2019 14:17:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA0171FB;
        Thu, 19 Dec 2019 11:17:02 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3D983F67D;
        Thu, 19 Dec 2019 11:17:00 -0800 (PST)
Subject: Re: [PATCH v5 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
References: <1571911407-29379-1-git-send-email-talel@amazon.com>
 <1571911407-29379-3-git-send-email-talel@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <411bd52f-a714-9b8d-c18c-2d7bcec3d850@arm.com>
Date:   Thu, 19 Dec 2019 19:16:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571911407-29379-3-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Talel,

On 24/10/2019 11:03, Talel Shenhar wrote:
> The Amazon's Annapurna Labs Memory Controller EDAC supports ECC capability
> for error detection and correction (Single bit error correction, Double
> detection). This driver introduces EDAC driver for that capability.

> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
> new file mode 100644
> index 00000000..b9ef7dd
> --- /dev/null
> +++ b/drivers/edac/al_mc_edac.c
> @@ -0,0 +1,355 @@

> +static void devm_al_mc_edac_del(void *data)
> +{
> +	edac_mc_del_mc(data);
> +}
> +
> +static void devm_al_mc_edac_free(void *data)
> +{
> +	edac_mc_free(data);
> +}
> +
> +static int al_mc_edac_probe(struct platform_device *pdev)
> +{
> +	void __iomem *mmio_base;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct al_mc_edac *al_mc;
> +	int ret;
> +
> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio_base)) {
> +		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
> +			PTR_ERR(mmio_base));
> +		return PTR_ERR(mmio_base);
> +	}
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct al_mc_edac));
> +	if (!mci)
> +		return -ENOMEM;

> +	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
> +	if (ret) {
> +		edac_mc_free(mci);
> +		return ret;
> +	}

Cool. (edac_mc.c should probably provide a devm_edac_mc_alloc() that does this, but that
can be future)


> +static struct platform_driver al_mc_edac_driver = {
> +	.probe = al_mc_edac_probe,


(Looks like you can still remove the module even though there is no .remove here.)


Reviewed-by: James Morse <james.morse@arm.com>



Thanks,

James
