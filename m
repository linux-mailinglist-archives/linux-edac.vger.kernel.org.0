Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C015142DD2
	for <lists+linux-edac@lfdr.de>; Mon, 20 Jan 2020 15:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgATOmI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 20 Jan 2020 09:42:08 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:10433 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgATOmI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 20 Jan 2020 09:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1579531326; x=1611067326;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=gKcvgCuvnxsmMrSqVMP8I3jCbAOxHqI5Zf/I7NhlmXQ=;
  b=nxitAyNLRyMa4au2N332a/Bsqwy4YCZ7h63cp2T2P4JJFxyY6gSJfnBH
   StSkBy6Eo22kTAdFlfH1rM4fixi4tFeVCyrSM1B4L+5xOineNBKkkRxRh
   yJGuuF5UVcn6xoIUjcbcu9QxRz6Bpg31Ft/zXKFfdKn17Ibhj20jCnI4M
   4=;
IronPort-SDR: kOowB5dfeAw9jGKaq9Bzmkt5Bc8aqgZFC80RStNdKmrg03CU0XAmMXUbIHCvIAs6AljMKHU1Bs
 D0u3sXDiWluQ==
X-IronPort-AV: E=Sophos;i="5.70,342,1574121600"; 
   d="scan'208";a="13773069"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Jan 2020 14:42:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id CAB4B240F67;
        Mon, 20 Jan 2020 14:42:00 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 14:41:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 20 Jan 2020 14:41:59 +0000
Received: from [10.95.92.21] (10.95.92.21) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 20 Jan 2020 14:41:53 +0000
Subject: Re: [PATCH v7 1/3] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     James Morse <james.morse@arm.com>, <Sudeep.Holla@arm.com>
CC:     <bp@alien8.de>, <mchehab@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <linus.walleij@linaro.org>, <daniel@iogearbox.net>,
        <paulmck@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>
References: <20191015120927.10470-1-hhhawa@amazon.com>
 <20191015120927.10470-2-hhhawa@amazon.com>
 <9ef0917d-b1d1-53c1-e459-309e509c2ff2@arm.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <0bd30915-71ca-cba2-f273-f7a1ff6d5a8d@amazon.com>
Date:   Mon, 20 Jan 2020 16:41:51 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <9ef0917d-b1d1-53c1-e459-309e509c2ff2@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 1/15/2020 8:49 PM, James Morse wrote:
> Hi Hanna,
> 
> (This was still on my list. I've not seen a newer version, its not in next, and it still
> applies, so:)

Thank you.

> 
> On 15/10/2019 13:09, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
>> report L1 errors.
> 
>> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
>> new file mode 100644
>> index 000000000000..e363a80b4d13
>> --- /dev/null
>> +++ b/drivers/edac/al_l1_edac.c
>> @@ -0,0 +1,190 @@
> 
>> +#include <asm/sysreg.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/of.h>
>> +#include <linux/smp.h>
> 
> You need <linux/platform_device.h> for platform_device_register_simple().

Will be added in next PS.

> 
> [...]
> 
>> +static void al_l1_edac_cpumerrsr_read_status(void *arg)
>> +{
> 
>> +	for (i = 0; i < repeat; i++) {
>> +		if (fatal)
>> +			edac_device_handle_ue(edac_dev, 0, 0, msg);
>> +		else
>> +			edac_device_handle_ce(edac_dev, 0, 0, msg);
>> +	}
> 
> What serialises these? You kick this off from on_each_cpu(), what stops two CPUs calling
> this at the same time? 'edac_dev->counters.ce_count += count;' will go wrong in this case.
> 
> I think you need a spinlock around the edac_device_* calls that take edac_dev so that only
> one occurs at a time.

Agree with you, will add spinlock in next PS.

> 
> 
>> +}
>> +
>> +static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
>> +{
>> +	on_each_cpu(al_l1_edac_cpumerrsr_read_status, edac_dev, 1);
>> +}
>> +
>> +static int al_l1_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *edac_dev;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	edac_dev = edac_device_alloc_ctl_info(0, DRV_NAME, 1, "L", 1, 1, NULL,
>> +					      0, edac_device_alloc_index());
>> +	if (!edac_dev)
>> +		return -ENOMEM;
>> +
>> +	edac_dev->edac_check = al_l1_edac_check;
>> +	edac_dev->dev = dev;
>> +	edac_dev->mod_name = DRV_NAME;
>> +	edac_dev->dev_name = dev_name(dev);
>> +	edac_dev->ctl_name = "L1_cache";
>> +	platform_set_drvdata(pdev, edac_dev);
>> +
>> +	ret = edac_device_add_device(edac_dev);
>> +	if (ret)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
> 
> (this goto has one user, meaning you can remove it by restructuring the code)

Will be fixed in next PS.

> 
> 
>> +	dev_err(dev, "Failed to add L1 edac device (%d)\n", ret);
>> +	edac_device_free_ctl_info(edac_dev);
>> +
>> +	return ret;
>> +}
>> +
> 
>> +static const struct of_device_id al_l1_edac_of_match[] = {
>> +	{ .compatible = "al,alpine-v2" },
>> +	{ .compatible = "amazon,alpine-v3" },
>> +	{}
>> +};
> 
> Unusually these are machine compatibles. It may be worth a comment that these are the
> platforms which are known to have Cortex-A57/A72 configured with this support, and access
> to the registers enabled by firmware.

Will be added.

> 
> 
>> +MODULE_DEVICE_TABLE(of, al_l1_edac_of_match);
> 
> [..]
> 
>> +static int __init al_l1_init(void)
>> +{
>> +	struct device_node *root = of_find_node_by_path("/");
>> +	int ret;
> 
> root could be NULL here.

Will be fixed.

> 
> 
>> +	if (!of_match_node(al_l1_edac_of_match, root))
>> +		return 0;
>> +
>> +	ret = platform_driver_register(&al_l1_edac_driver);
>> +	if (ret) {
>> +		pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
>> +		return ret;
>> +	}
>> +
>> +	edac_l1_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
>> +	if (IS_ERR(edac_l1_device)) {
>> +		pr_err("Failed to register EDAC AL L1 platform device\n");
>> +		return PTR_ERR(edac_l1_device);
>> +	}
>> +
>> +	return 0;
>> +}
> 
> With the edac_device_handle_ce() race fixed:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks,
Hanna

> 
> 
> Thanks,
> 
> James
> 
