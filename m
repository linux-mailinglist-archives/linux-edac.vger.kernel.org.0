Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7D13CC8C
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 19:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgAOStw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 13:49:52 -0500
Received: from foss.arm.com ([217.140.110.172]:41342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgAOStw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 13:49:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B414328;
        Wed, 15 Jan 2020 10:49:51 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF9B3F6C4;
        Wed, 15 Jan 2020 10:49:48 -0800 (PST)
Subject: Re: [PATCH v7 1/3] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     Hanna Hawa <hhhawa@amazon.com>, Sudeep.Holla@arm.com
Cc:     bp@alien8.de, mchehab@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, frowand.list@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        daniel@iogearbox.net, paulmck@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-2-hhhawa@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9ef0917d-b1d1-53c1-e459-309e509c2ff2@arm.com>
Date:   Wed, 15 Jan 2020 18:49:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015120927.10470-2-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hanna,

(This was still on my list. I've not seen a newer version, its not in next, and it still
applies, so:)

On 15/10/2019 13:09, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
> report L1 errors.

> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
> new file mode 100644
> index 000000000000..e363a80b4d13
> --- /dev/null
> +++ b/drivers/edac/al_l1_edac.c
> @@ -0,0 +1,190 @@

> +#include <asm/sysreg.h>
> +#include <linux/bitfield.h>
> +#include <linux/of.h>
> +#include <linux/smp.h>

You need <linux/platform_device.h> for platform_device_register_simple().

[...]

> +static void al_l1_edac_cpumerrsr_read_status(void *arg)
> +{

> +	for (i = 0; i < repeat; i++) {
> +		if (fatal)
> +			edac_device_handle_ue(edac_dev, 0, 0, msg);
> +		else
> +			edac_device_handle_ce(edac_dev, 0, 0, msg);
> +	}

What serialises these? You kick this off from on_each_cpu(), what stops two CPUs calling
this at the same time? 'edac_dev->counters.ce_count += count;' will go wrong in this case.

I think you need a spinlock around the edac_device_* calls that take edac_dev so that only
one occurs at a time.


> +}
> +
> +static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	on_each_cpu(al_l1_edac_cpumerrsr_read_status, edac_dev, 1);
> +}
> +
> +static int al_l1_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	edac_dev = edac_device_alloc_ctl_info(0, DRV_NAME, 1, "L", 1, 1, NULL,
> +					      0, edac_device_alloc_index());
> +	if (!edac_dev)
> +		return -ENOMEM;
> +
> +	edac_dev->edac_check = al_l1_edac_check;
> +	edac_dev->dev = dev;
> +	edac_dev->mod_name = DRV_NAME;
> +	edac_dev->dev_name = dev_name(dev);
> +	edac_dev->ctl_name = "L1_cache";
> +	platform_set_drvdata(pdev, edac_dev);
> +
> +	ret = edac_device_add_device(edac_dev);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:

(this goto has one user, meaning you can remove it by restructuring the code)


> +	dev_err(dev, "Failed to add L1 edac device (%d)\n", ret);
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return ret;
> +}
> +

> +static const struct of_device_id al_l1_edac_of_match[] = {
> +	{ .compatible = "al,alpine-v2" },
> +	{ .compatible = "amazon,alpine-v3" },
> +	{}
> +};

Unusually these are machine compatibles. It may be worth a comment that these are the
platforms which are known to have Cortex-A57/A72 configured with this support, and access
to the registers enabled by firmware.


> +MODULE_DEVICE_TABLE(of, al_l1_edac_of_match);

[..]

> +static int __init al_l1_init(void)
> +{
> +	struct device_node *root = of_find_node_by_path("/");
> +	int ret;

root could be NULL here.


> +	if (!of_match_node(al_l1_edac_of_match, root))
> +		return 0;
> +
> +	ret = platform_driver_register(&al_l1_edac_driver);
> +	if (ret) {
> +		pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
> +		return ret;
> +	}
> +
> +	edac_l1_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +	if (IS_ERR(edac_l1_device)) {
> +		pr_err("Failed to register EDAC AL L1 platform device\n");
> +		return PTR_ERR(edac_l1_device);
> +	}
> +
> +	return 0;
> +}

With the edac_device_handle_ce() race fixed:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
