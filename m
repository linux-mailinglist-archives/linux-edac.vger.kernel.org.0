Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09399D2C09
	for <lists+linux-edac@lfdr.de>; Thu, 10 Oct 2019 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfJJOEM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 10 Oct 2019 10:04:12 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:26652 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfJJOEM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 10 Oct 2019 10:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570716251; x=1602252251;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XwGL70t454LegYE7GCchMbvmQ2PqMa2pltoRa32OItM=;
  b=jQwIJqA8CLbo8oDTraE9puZssgxYdMofluM3CwwH6KH+kGm2PVUXQxje
   zsDijHcXwGxnSDNguaGrvkTgLJxczywUThrnxWBjsTQknkK41yFoJUYeK
   fg+/kaUoWj7SPD+pgV193zETmTHneCNQ2bVECBWHOj9YAP1gCJ+Lbpqkw
   0=;
X-IronPort-AV: E=Sophos;i="5.67,280,1566864000"; 
   d="scan'208";a="757243402"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 10 Oct 2019 14:04:08 +0000
Received: from EX13MTAUEB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id B86BAA213E;
        Thu, 10 Oct 2019 14:04:03 +0000 (UTC)
Received: from EX13D08UEB003.ant.amazon.com (10.43.60.11) by
 EX13MTAUEB001.ant.amazon.com (10.43.60.96) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 14:04:03 +0000
Received: from EX13MTAUEB001.ant.amazon.com (10.43.60.96) by
 EX13D08UEB003.ant.amazon.com (10.43.60.11) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 10 Oct 2019 14:04:02 +0000
Received: from [10.107.3.25] (10.107.3.25) by mail-relay.amazon.com
 (10.43.60.129) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 10 Oct 2019 14:03:59 +0000
Subject: Re: [PATCH v6 3/3] edac: Add support for Amazon's Annapurna Labs L2
 EDAC
To:     Rob Herring <robh+dt@kernel.org>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linus Walleij" <linus.walleij@linaro.org>, <daniel@iogearbox.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>, <benh@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        Talel Shenhar <talel@amazon.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        "Hanoch, Uri" <hanochu@amazon.com>
References: <20191007151730.7705-1-hhhawa@amazon.com>
 <20191007151730.7705-4-hhhawa@amazon.com>
 <CAL_JsqLZOHx=3d9jPy+7y0a92wA-VKEDQ4PVNvo6L8fRe7xJCQ@mail.gmail.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <872efced-ec4d-5f24-fca5-c501ed96e570@amazon.com>
Date:   Thu, 10 Oct 2019 17:03:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLZOHx=3d9jPy+7y0a92wA-VKEDQ4PVNvo6L8fRe7xJCQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,


On 10/10/2019 2:19 AM, Rob Herring wrote:
> On Mon, Oct 7, 2019 at 10:18 AM Hanna Hawa <hhhawa@amazon.com> wrote:
>>
>> Adds support for Amazon's Annapurna Labs L2 EDAC driver to detect and
>> report L2 errors.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   MAINTAINERS               |   5 +
>>   drivers/edac/Kconfig      |   8 ++
>>   drivers/edac/Makefile     |   1 +
>>   drivers/edac/al_l2_edac.c | 251 ++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 265 insertions(+)
>>   create mode 100644 drivers/edac/al_l2_edac.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7887a62dc843..0eabcfcf91a9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -748,6 +748,11 @@ M: Hanna Hawa <hhhawa@amazon.com>
>>   S:     Maintained
>>   F:     drivers/edac/al_l1_edac.c
>>
>> +AMAZON ANNAPURNA LABS L2 EDAC
>> +M:     Hanna Hawa <hhhawa@amazon.com>
>> +S:     Maintained
>> +F:     drivers/edac/al_l2_edac.c
>> +
>>   AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
>>   M:     Talel Shenhar <talel@amazon.com>
>>   S:     Maintained
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index e8161d7c7469..cb394aff1cab 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -82,6 +82,14 @@ config EDAC_AL_L1
>>            for Amazon's Annapurna Labs SoCs.
>>            This driver detects errors of L1 caches.
>>
>> +config EDAC_AL_L2
>> +       tristate "Amazon's Annapurna Labs L2 EDAC"
> 
> I still think this should be an "A57 L2 ECC" driver, but if no one
> cares I'll shut up and the 2nd person can rename everything.

> 
>> +       depends on ARCH_ALPINE
> 
> || COMPILE_TEST

Will be add in next patchset.

> 
> Maybe it needs an ARM64 dependency too in this case?

Yes, it need ARM64 dependency, I'll add.

Thanks,
Hanna

> 
>> +       help
>> +         Support for L2 error detection and correction
>> +         for Amazon's Annapurna Labs SoCs.
>> +         This driver detects errors of L2 caches.
>> +
> 
>> +
>> +       ret = platform_driver_register(&al_l2_edac_driver);
>> +       if (ret) {
>> +               pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
>> +               return ret;
>> +       }
>> +
>> +       edac_l2_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
>> +       if (IS_ERR(edac_l2_device)) {
>> +               pr_err("Failed to register EDAC AL L2 platform device\n");
>> +               return PTR_ERR(edac_l2_device);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void __exit al_l2_exit(void)
>> +{
>> +       platform_device_unregister(edac_l2_device);
>> +       platform_driver_unregister(&al_l2_edac_driver);
>> +}
>> +
>> +late_initcall(al_l2_init);
>> +module_exit(al_l2_exit);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Hanna Hawa <hhhawa@amazon.com>");
>> +MODULE_DESCRIPTION("Amazon's Annapurna Lab's L2 EDAC Driver");
>> --
>> 2.17.1
>>
