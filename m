Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED531C53BE
	for <lists+linux-edac@lfdr.de>; Tue,  5 May 2020 12:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgEEKzh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 May 2020 06:55:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64406 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728180AbgEEKzh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 May 2020 06:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1588676137; x=1620212137;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=d+CEbn7A/FPIqL1jOQZTyvaEHjqgjmk+7wJrPTIxaDI=;
  b=hH5li0cCQyA95pXCky4VHnK/DXKnbokYgcZYO7AGa4zn1JpeDQcyQLnb
   iC/XyRxONchsGZQUicN0MNI2RLy5HehjsUdvBf9L8LK47vHrkozHjSGmF
   InHn18BH0Nqtc/u8yb2uyuGCc+VjY6RUTwQv/GGy47jnponizGZLi8aod
   4=;
IronPort-SDR: tlE+amf1pNeoaJJ8vIvp5QLiqKx84kCjBNW5fwiQZiFwB3PSprJ4URmfFVjtexdLicbaDyD5MG
 PSMFi22s28ZQ==
X-IronPort-AV: E=Sophos;i="5.73,354,1583193600"; 
   d="scan'208";a="33009948"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 05 May 2020 10:55:34 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id C645EA1F53;
        Tue,  5 May 2020 10:55:28 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 5 May 2020 10:55:28 +0000
Received: from [192.168.13.172] (10.43.162.38) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 5 May
 2020 10:55:19 +0000
Subject: Re: [PATCH v6 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <eitan@amazon.com>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-3-talel@amazon.com> <20200428113950.GB11272@zn.tnic>
 <46ccdb47-f28d-63f7-e759-1ba34e98add8@amazon.com>
 <20200504183716.GJ15046@zn.tnic>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <4d389169-89d1-4512-f6f0-c98477ab3623@amazon.com>
Date:   Tue, 5 May 2020 13:55:14 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504183716.GJ15046@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Originating-IP: [10.43.162.38]
X-ClientProxiedBy: EX13D14UWC003.ant.amazon.com (10.43.162.19) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 5/4/2020 9:37 PM, Borislav Petkov wrote:
>
> On Mon, May 04, 2020 at 01:16:10PM +0300, Shenhar, Talel wrote:
>>>> +     mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
>>>> +                         sizeof(struct al_mc_edac));
>>> You can let that line stick out.
>> I rather avoid having this as a checkpatch warnning... (automation and
>> stuff...)
> checkpatch.pl - while useful - should not be taken to the letter and
> human brain should be applied to sanity check it what it warns about.
>
>> This line break does seems to my eye as too hard to read.
>>
>> Let me know if you feel strongly about it.
> I'm just sayin' - in the end of the day you'll be staring at that code -
> not me - so whatever *you* prefer. :-)
>
> Just don't follow tools blindly.
Thanks, I will leave it that way as it will make my life easier (with 
automatic vim tools and automation) and doesn't really break code 
understanding.
>
>>>> +     if (al_mc->irq_ue <= 0 || al_mc->irq_ce <= 0)
>>> Shouldn't this be && here?
>>>
>>> I mean, you want to poll when neither of the IRQs can be found. But then
>>> if you find one of them and not the other, what do you do? Poll and
>>> interrupt? Is that case even possible?
>> Correct.
>>
>> In case dt defined interrupt line only for one type and not for the other,
>> than the interrupt mode shall be used for one of them while polling mode for
>> the other.
> That warrants a comment above it.
Shall be part of v7.
>
> Thx.
>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
