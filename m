Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 379127D740
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2019 10:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbfHAIUl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Aug 2019 04:20:41 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:50558 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729694AbfHAIUl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Aug 2019 04:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1564647640; x=1596183640;
  h=from:subject:to:cc:references:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=sFJVYY4R0DtMFkdcM3gunR4WptMme/o4VaCvg83kd0A=;
  b=IOrCLLlUbUdas+MMPlF29g/g4X/3ypZouP9kZ/+qLmNNlYIDStbiIM0K
   s3Gf3j0IVSTpQXqzDKoXDHXORaIsl0l1o8z7qOVb2lu6S45uX8rQSUU8Q
   F2wlw3/s0E4Mse8p2sBqh8ojFgQB7+LvgJT016IJIb8BEVnzt6nrPGt/3
   g=;
X-IronPort-AV: E=Sophos;i="5.64,333,1559520000"; 
   d="scan'208";a="407593540"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 01 Aug 2019 08:20:39 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 9AA64A1F5C;
        Thu,  1 Aug 2019 08:20:34 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 08:20:34 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 1 Aug 2019 08:20:33 +0000
Received: from [10.107.3.19] (10.107.3.19) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 1 Aug 2019 08:20:28 +0000
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Subject: Re: [PATCH v3 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     James Morse <james.morse@arm.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
 <a2dc6760-50e2-6e98-5b61-002836d92dd2@arm.com>
Message-ID: <59075138-f819-a59c-a72a-663062c78c86@amazon.com>
Date:   Thu, 1 Aug 2019 11:20:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a2dc6760-50e2-6e98-5b61-002836d92dd2@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 7/26/2019 7:49 PM, James Morse wrote:
> Hi Hanna,
> 
> On 15/07/2019 14:24, Hanna Hawa wrote:
>> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
>> report L1 errors.
> 
>> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
>> new file mode 100644
>> index 0000000..70510ea
>> --- /dev/null
>> +++ b/drivers/edac/al_l1_edac.c
>> @@ -0,0 +1,156 @@
> 
>> +#include <linux/bitfield.h>
> 
> You need <linux/smp.h> for on-each_cpu().
> 
>> +#include "edac_device.h"
>> +#include "edac_module.h"
> 
> You need <asm/sysreg.h> for the sys_reg() macro. The ARCH_ALPINE dependency doesn't stop
> this from being built on 32bit arm, where this sys_reg() won't work/exist.

Will fix.

> 
> [...]
> 
>> +static void al_l1_edac_cpumerrsr(void *arg)
>> +{
>> +	struct edac_device_ctl_info *edac_dev = arg;
>> +	int cpu, i;
>> +	u32 ramid, repeat, other, fatal;
>> +	u64 val = read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
>> +	char msg[AL_L1_EDAC_MSG_MAX];
>> +	int space, count;
>> +	char *p;
>> +	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
>> +		return;
>> +	space = sizeof(msg);
>> +	p = msg;
>> +	count = snprintf(p, space, "CPU%d L1 %serror detected", cpu,
>> +			 (fatal) ? "Fatal " : "");
>> +	p += count;
>> +	space -= count;
> 
> snprintf() will return the number of characters it would have generated, even if that is
> more than space. If this happen, space becomes negative, p points outside msg[] and msg[]
> isn't NULL terminated...
> 
> It looks like you want scnprintf(), which returns the number of characters written to buf
> instead. (I don't see how 256 characters would be printed by this code)

Will use scnprintf() instead.

> 
> 
>> +	switch (ramid) {
>> +	case ARM_CA57_L1_I_TAG_RAM:
>> +		count = snprintf(p, space, " RAMID='L1-I Tag RAM'");
>> +		break;
>> +	case ARM_CA57_L1_I_DATA_RAM:
>> +		count = snprintf(p, space, " RAMID='L1-I Data RAM'");
>> +		break;
>> +	case ARM_CA57_L1_D_TAG_RAM:
>> +		count = snprintf(p, space, " RAMID='L1-D Tag RAM'");
>> +		break;
>> +	case ARM_CA57_L1_D_DATA_RAM:
>> +		count = snprintf(p, space, " RAMID='L1-D Data RAM'");
>> +		break;
>> +	case ARM_CA57_L2_TLB_RAM:
>> +		count = snprintf(p, space, " RAMID='L2 TLB RAM'");
>> +		break;
>> +	default:
>> +		count = snprintf(p, space, " RAMID='unknown'");
>> +		break;
>> +	}
>> +
>> +	p += count;
>> +	space -= count;
>> +	count = snprintf(p, space,
>> +			 " repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)",
>> +			 repeat, other, val);
>> +
>> +	for (i = 0; i < repeat; i++) {
>> +		if (fatal)
>> +			edac_device_handle_ue(edac_dev, 0, 0, msg);
>> +		else
>> +			edac_device_handle_ce(edac_dev, 0, 0, msg);
>> +	}
>> +
>> +	write_sysreg_s(0, ARM_CA57_CPUMERRSR_EL1);
> 
> Writing 0 just after you've read the value would minimise the window where repeat could
> have increased behind your back, or another error was counted as other, when it could have
> been reported more accurately.

Good point, I will move the write after checking the valid bit.

> 
> 
>> +}
> 
> 
>> +static int al_l1_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *edac_dev;
>> +	struct device *dev = &pdev->dev;
>> +	int ret;
>> +
>> +	edac_dev = edac_device_alloc_ctl_info(0, (char *)dev_name(dev), 1, "L",
>> +					      1, 1, NULL, 0,
>> +					      edac_device_alloc_index());
>> +	if (IS_ERR(edac_dev))
> 
> edac_device_alloc_ctl_info() returns NULL, or dev_ctl, which comes from kzalloc(). I think
> you need to check for NULL here, IS_ERR() only catches the -errno range. (there is an
> IS_ERR_OR_NULL() if you really needed both)

Will fix.

> 
> 
>> +		return -ENOMEM;
> 
> 
> With the header-includes and edac_device_alloc_ctl_info() NULL check:
> Reviewed-by: James Morse <james.morse@arm.com>

Thanks James.

Thanks,
Hanna
> 
> 
> Thanks,
> 
> James
> 
