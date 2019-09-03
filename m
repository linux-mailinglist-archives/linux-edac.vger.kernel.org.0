Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C761EA63D4
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2019 10:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfICI1u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Sep 2019 04:27:50 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:43641 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfICI1t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Sep 2019 04:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567499268; x=1599035268;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=KuPZeQju7vhEp+UkqVn9efqnEIKWk9EHCgp5USgIAM4=;
  b=uCKpyBQavByrJYs+zzmcs7KYHgYENDhi29A+4EgntRUc3DDfMgz1JU9Q
   8HEk8/rmi9iBOmkLvB5GSp7H54NtMrVTcLXp0b2eFcaRSlJ7phoNmZfUL
   atVWwDxcVLRqT34mm9GquuzrNhbIlQARyEUWKXUuUR7f04eYNcVZ8x2ql
   o=;
X-IronPort-AV: E=Sophos;i="5.64,462,1559520000"; 
   d="scan'208";a="413268000"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 03 Sep 2019 08:27:46 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 85317A2434;
        Tue,  3 Sep 2019 08:27:42 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:27:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 3 Sep 2019 08:27:41 +0000
Received: from [10.85.97.90] (10.85.97.90) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Tue, 3 Sep 2019 08:27:35 +0000
Subject: Re: [PATCH v3 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     Robert Richter <rrichter@marvell.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
 <20190903072427.ptmde6hda5uyauhf@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <3521cf92-55a0-70d9-9c1c-a1f4ca8bc725@amazon.com>
Date:   Tue, 3 Sep 2019 11:27:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903072427.ptmde6hda5uyauhf@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/3/2019 10:24 AM, Robert Richter wrote:
> On 15.07.19 16:24:07, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
>> report L1 errors.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> Reviewed-by: James Morse <james.morse@arm.com>
>> ---
>>   MAINTAINERS               |   6 ++
>>   drivers/edac/Kconfig      |   8 +++
>>   drivers/edac/Makefile     |   1 +
>>   drivers/edac/al_l1_edac.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 171 insertions(+)
>>   create mode 100644 drivers/edac/al_l1_edac.c
> 
>> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
>> new file mode 100644
>> index 0000000..70510ea
>> --- /dev/null
>> +++ b/drivers/edac/al_l1_edac.c
> 
> [...]
> 
>> +static void al_l1_edac_cpumerrsr(void *arg)
> 
> Could this being named to something meaningful, such as
> *_read_status() or so?
> 
>> +{
>> +	struct edac_device_ctl_info *edac_dev = arg;
>> +	int cpu, i;
>> +	u32 ramid, repeat, other, fatal;
>> +	u64 val = read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
>> +	char msg[AL_L1_EDAC_MSG_MAX];
>> +	int space, count;
>> +	char *p;
>> +
>> +	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
>> +		return;
> 
> [...]
> 
>> +static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
>> +{
>> +	on_each_cpu(al_l1_edac_cpumerrsr, edac_dev, 1);
>> +}
>> +
>> +static int al_l1_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *edac_dev;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	edac_dev = edac_device_alloc_ctl_info(0, (char *)dev_name(dev), 1, "L",
> 
> This type cast looks broken. dev_name() is a constant string already.
> 
> Other drivers do not use the dynamically generated dev_name() string
> here, instead a fix string such as mod_name or ctl_name could be used.
> edac_device_alloc_ctl_info() later generates a unique instance name
> derived from name + index.

Ack, will fix and use DRV_NAME.

> 
> Regarding the type, this seems to be an API issue of edac_device_
> alloc_ctl_info() that should actually use const char* in its
> interface. So if needed (from what I wrote above it is not) the type
> in the argument list needs to be changed instead.
> 
>> +					      1, 1, NULL, 0,
>> +					      edac_device_alloc_index());
>> +	if (IS_ERR(edac_dev))
>> +		return -ENOMEM;
> 
> Use the original error code instead.

Actually it return NULL in case of failure, it was changed in v5 to 
check if error/NULL.

> 
>> +
>> +	edac_dev->edac_check = al_l1_edac_check;
>> +	edac_dev->dev = dev;
>> +	edac_dev->mod_name = DRV_NAME;
>> +	edac_dev->dev_name = dev_name(dev);
>> +	edac_dev->ctl_name = "L1 cache";
> 
> Should not contain spaces and maybe a bit more specific.

L1_cache_ecc_err? or L1_cache_err?

> 
>> +	platform_set_drvdata(pdev, edac_dev);
>> +
>> +	ret = edac_device_add_device(edac_dev);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to add L1 edac device\n");
> 
> Move this printk below to the error path and maybe print the error
> code. You do not cover the -ENOMEM failure.

Ack.

> 
> -Robert
> 
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +err:
>> +	edac_device_free_ctl_info(edac_dev);
>> +
>> +	return ret;
>> +}
