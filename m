Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEC2C142E16
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jan 2020 15:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATOxS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jan 2020 09:53:18 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:46673 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATOxS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Jan 2020 09:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579531997; x=1611067997;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=057jgfK1HdronAF1AHKfXFpD2PIVIcm1QUPFLoi0iqc=;
  b=A72DNGKn4pEcv1UXWPPakeqQ/R4akDDRw2wHe/XZdkXBw90y2uwEFOW6
   /Hvtr1olP6j93qPncAdSEXHSY2TJ1srl4420sEY6jZTuPTG6yTRRkVN8L
   7jkfthOREw5IgJm4Pf0bGggVreJ1QIB63JDw0nejyBIz++05qtea6gM1X
   c=;
IronPort-SDR: PMEgJVRDn9OMWdmQHZhh3XlVJbV78T+FBt1EyNPD+N60TezKY0x8CEH6pbDdZ+qv3Wljdzjqeq
 hVzcI+vpWa5g==
X-IronPort-AV: E=Sophos;i="5.70,342,1574121600"; 
   d="scan'208";a="11380116"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 20 Jan 2020 14:53:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id ACA8CA2350;
        Mon, 20 Jan 2020 14:53:02 +0000 (UTC)
Received: from EX13D21UWB004.ant.amazon.com (10.43.161.221) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 14:53:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D21UWB004.ant.amazon.com (10.43.161.221) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 14:53:02 +0000
Received: from [10.95.92.21] (10.95.92.21) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 20 Jan 2020 14:52:56 +0000
Subject: Re: [PATCH v7 3/3] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
To:     James Morse <james.morse@arm.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <daniel@iogearbox.net>,
        <paulmck@linux.ibm.com>, <Sudeep.Holla@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@amazon.com>, <ronenk@amazon.com>, <talel@amazon.com>,
        <jonnyc@amazon.com>, <hanochu@amazon.com>
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-4-hhhawa@amazon.com>
 <a6c7d925-22fb-4324-ce12-662b97976e61@arm.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <ce51b629-a9b9-9848-8cbb-620d8a6549c3@amazon.com>
Date:   Mon, 20 Jan 2020 16:52:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <a6c7d925-22fb-4324-ce12-662b97976e61@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 1/15/2020 8:50 PM, James Morse wrote:
> Hi Hanna,
> 
> On 15/10/2019 13:09, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
>> report L2 errors.
> 
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7887a62dc843..0eabcfcf91a9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -748,6 +748,11 @@ M:	Hanna Hawa <hhhawa@amazon.com>
>>   S:	Maintained
>>   F:	drivers/edac/al_l1_edac.c
>>   
>> +AMAZON ANNAPURNA LABS L2 EDAC
>> +M:	Hanna Hawa <hhhawa@amazon.com>
>> +S:	Maintained
>> +F:	drivers/edac/al_l2_edac.c
> 
> (Why not add the file to the previous section? All this does is come up with an email
> address based on the file)

Added new section as this separated driver.

> 
> 
>> diff --git a/drivers/edac/al_l2_edac.c b/drivers/edac/al_l2_edac.c
>> new file mode 100644
>> index 000000000000..156610c85591
>> --- /dev/null
>> +++ b/drivers/edac/al_l2_edac.c
>> @@ -0,0 +1,251 @@
>> +static int al_l2_edac_probe(struct platform_device *pdev)
>> +{
> 
>> +	for_each_possible_cpu(i) {
>> +		struct device_node *cpu;
>> +		struct device_node *cpu_cache;
>> +		struct al_l2_cache *l2_cache;
>> +		bool found = false;
>> +
>> +		cpu = of_get_cpu_node(i, NULL);
>> +		if (!cpu)
>> +			continue;
>> +
>> +		cpu_cache = of_find_next_cache_node(cpu);
>> +		list_for_each_entry(l2_cache, &al_l2->l2_caches, list_node) {
>> +			if (l2_cache->of_node == cpu_cache) {
>> +				found = true;
>> +				break;
>> +			}
>> +		}
>> +
>> +		if (found) {
>> +			cpumask_set_cpu(i, &l2_cache->cluster_cpus);
> 
> 			of_node_put(cpu_cache); ?
> 
> (I can see why you might keep the reference in the else block)

Will be added in next PS.

> 
> 
>> +		} else {
>> +			l2_cache = devm_kzalloc(dev, sizeof(*l2_cache),
>> +						GFP_KERNEL);
>> +			l2_cache->of_node = cpu_cache;
>> +			list_add(&l2_cache->list_node, &al_l2->l2_caches);
>> +			cpumask_set_cpu(i, &l2_cache->cluster_cpus);
>> +		}
>> +
>> +		of_node_put(cpu);
>> +	}
>> +
>> +	if (list_empty(&al_l2->l2_caches)) {
>> +		dev_err(dev, "L2 Cache list is empty for EDAC device\n");
>> +		ret = -EINVAL;
>> +		goto err;
>> +	}
> 
> You are doing this at probe time to create a static list of which CPUs map onto the L2
> caches. cacheinfo does something very similar, but it looks like you can't use it as its
> only populated for online CPUs, and you'd need to walk multiple CPUs cacheinfo leaves to
> find the same information. The alternative is more complicated.

> 
> 
>> +	ret = edac_device_add_device(edac_dev);
>> +	if (ret)
> 
> Any references held in the al_l2->l2_caches list leak here.
> 
> 
>> +		goto err;
>> +
>> +	return 0;
>> +
>> +err:
>> +	dev_err(dev, "Failed to add L2 edac device (%d)\n", ret);
>> +	edac_device_free_ctl_info(edac_dev);
>> +
>> +	return ret;
>> +}
> 
> 
>> +static int al_l2_edac_remove(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
> 
> Do you need to roll over the al_l2->l2_caches list to of_node_put() the l2_cache's ?

will add loop after for_each_possible_cpu() to call of_node_put() on 
each l2_cache.

> 
> 
>> +	edac_device_del_device(edac_dev->dev);
>> +	edac_device_free_ctl_info(edac_dev);
>> +
>> +	return 0;
>> +}
> 
> [..]
> 
>> +static const struct of_device_id al_l2_edac_of_match[] = {
>> +	{ .compatible = "al,alpine-v2" },
>> +	{ .compatible = "amazon,alpine-v3" },
>> +	{}
>> +};
> 
> Same comment on these being machine compatibles and what property that applies to.

Fix comments from your review from L1 driver.

> 
> The code to match the platform and create the platform_device is identical, is there any
> way it can be shared?
> 
> I'm guessing the two-files is because these can be built as independent modules. Would
> anyone ever have one, but not the other? The L1 support is optional, but you've listed the
> same set of platforms in both cases here, so do we need to support one but not the other
> today?

It's not related to that platform will have one, but not the other. The 
two drivers are not related to each other, I agree with you that there 
is identical code in matching platform. But this is not good reason to 
combine the two drivers.

Thanks,
Hanna

> 
> 
> Thanks,
> 
> James
> 
