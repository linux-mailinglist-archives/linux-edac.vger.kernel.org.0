Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B4B13CC91
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 19:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAOSuQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 13:50:16 -0500
Received: from foss.arm.com ([217.140.110.172]:41368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgAOSuQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 13:50:16 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABDD2328;
        Wed, 15 Jan 2020 10:50:15 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCB283F6C4;
        Wed, 15 Jan 2020 10:50:11 -0800 (PST)
Subject: Re: [PATCH v7 3/3] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     bp@alien8.de, mchehab@kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, frowand.list@gmail.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        daniel@iogearbox.net, paulmck@linux.ibm.com, Sudeep.Holla@arm.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-4-hhhawa@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a6c7d925-22fb-4324-ce12-662b97976e61@arm.com>
Date:   Wed, 15 Jan 2020 18:50:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015120927.10470-4-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hanna,

On 15/10/2019 13:09, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
> report L2 errors.


> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7887a62dc843..0eabcfcf91a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -748,6 +748,11 @@ M:	Hanna Hawa <hhhawa@amazon.com>
>  S:	Maintained
>  F:	drivers/edac/al_l1_edac.c
>  
> +AMAZON ANNAPURNA LABS L2 EDAC
> +M:	Hanna Hawa <hhhawa@amazon.com>
> +S:	Maintained
> +F:	drivers/edac/al_l2_edac.c

(Why not add the file to the previous section? All this does is come up with an email
address based on the file)


> diff --git a/drivers/edac/al_l2_edac.c b/drivers/edac/al_l2_edac.c
> new file mode 100644
> index 000000000000..156610c85591
> --- /dev/null
> +++ b/drivers/edac/al_l2_edac.c
> @@ -0,0 +1,251 @@
> +static int al_l2_edac_probe(struct platform_device *pdev)
> +{

> +	for_each_possible_cpu(i) {
> +		struct device_node *cpu;
> +		struct device_node *cpu_cache;
> +		struct al_l2_cache *l2_cache;
> +		bool found = false;
> +
> +		cpu = of_get_cpu_node(i, NULL);
> +		if (!cpu)
> +			continue;
> +
> +		cpu_cache = of_find_next_cache_node(cpu);
> +		list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node) {
> +			if (l2_cache->of_node == cpu_cache) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (found) {
> +			cpumask_set_cpu(i, &l2_cache->cluster_cpus);

			of_node_put(cpu_cache); ?

(I can see why you might keep the reference in the else block)


> +		} else {
> +			l2_cache = devm_kzalloc(dev, sizeof(*l2_cache),
> +						GFP_KERNEL);
> +			l2_cache->of_node = cpu_cache;
> +			list_add(&l2_cache->list_node, &al_l2->l2_caches);
> +			cpumask_set_cpu(i, &l2_cache->cluster_cpus);
> +		}
> +
> +		of_node_put(cpu);
> +	}
> +
> +	if (list_empty(&al_l2->l2_caches)) {
> +		dev_err(dev, "L2 Cache list is empty for EDAC device\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}

You are doing this at probe time to create a static list of which CPUs map onto the L2
caches. cacheinfo does something very similar, but it looks like you can't use it as its
only populated for online CPUs, and you'd need to walk multiple CPUs cacheinfo leaves to
find the same information. The alternative is more complicated.


> +	ret = edac_device_add_device(edac_dev);
> +	if (ret)

Any references held in the al_l2->l2_caches list leak here.


> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	dev_err(dev, "Failed to add L2 edac device (%d)\n", ret);
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return ret;
> +}


> +static int al_l2_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);

Do you need to roll over the al_l2->l2_caches list to of_node_put() the l2_cache's ?


> +	edac_device_del_device(edac_dev->dev);
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return 0;
> +}

[..]

> +static const struct of_device_id al_l2_edac_of_match[] = {
> +	{ .compatible = "al,alpine-v2" },
> +	{ .compatible = "amazon,alpine-v3" },
> +	{}
> +};

Same comment on these being machine compatibles and what property that applies to.

The code to match the platform and create the platform_device is identical, is there any
way it can be shared?

I'm guessing the two-files is because these can be built as independent modules. Would
anyone ever have one, but not the other? The L1 support is optional, but you've listed the
same set of platforms in both cases here, so do we need to support one but not the other
today?


Thanks,

James
