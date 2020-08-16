Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65860245708
	for <lists+linux-edac@lfdr.de>; Sun, 16 Aug 2020 11:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgHPJRz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 16 Aug 2020 05:17:55 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:13505 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgHPJRw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 16 Aug 2020 05:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597569472; x=1629105472;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0KiFD7MKYJeA21r8+YOIjXyPutiEhZpN89Zy2Fhpttg=;
  b=ZF60OjM5ubDRZZi+iSITPnWcBtWZw/Fv6U8o+YkaS3ujh67GNG+T74M9
   B20vlMwbfeIlw7+g/vH6efsskSwQYACDw3m66b3jTxKi0niOLyyRpkXF6
   +yG8ALGXUf6OU7mt285fsZB2DlTkNMWaEoqJ6vGAg6gaeKvm39FUd/FBk
   c=;
X-IronPort-AV: E=Sophos;i="5.76,319,1592870400"; 
   d="scan'208";a="60062486"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 16 Aug 2020 09:17:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 68A39A1C5B;
        Sun, 16 Aug 2020 09:17:45 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 16 Aug 2020 09:17:44 +0000
Received: from [192.168.3.188] (10.43.162.140) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 16 Aug
 2020 09:17:35 +0000
Subject: Re: [PATCH v9 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <james.morse@arm.com>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-edac@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <eitan@amazon.com>, <talel@amazon.com>
References: <20200728095155.18506-1-talel@amazon.com>
 <20200728095155.18506-3-talel@amazon.com> <20200815183358.GE25814@zn.tnic>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <5d516c64-ecd8-6f36-5f95-6708fe0f3fd5@amazon.com>
Date:   Sun, 16 Aug 2020 12:17:31 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200815183358.GE25814@zn.tnic>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Originating-IP: [10.43.162.140]
X-ClientProxiedBy: EX13D32UWB004.ant.amazon.com (10.43.161.36) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 8/15/2020 9:33 PM, Borislav Petkov wrote:
> On Tue, Jul 28, 2020 at 12:51:55PM +0300, Talel Shenhar wrote:
>> +static void al_mc_edac_check(struct mem_ctl_info *mci)
>> +{
>> +     struct al_mc_edac *al_mc = mci->pvt_info;
>> +
>> +     if (al_mc->irq_ue <= 0)
>> +             handle_ue(mci);
>> +
>> +     if (al_mc->irq_ce <= 0)
>> +             handle_ce(mci);
>> +}
>> +
>> +static irqreturn_t al_mc_edac_irq_handler_ue(int irq, void *info)
>> +{
>> +     struct platform_device *pdev = info;
>> +     struct mem_ctl_info *mci = platform_get_drvdata(pdev);
>> +
>> +     if (handle_ue(mci))
>> +             return IRQ_HANDLED;
>> +     return IRQ_NONE;
>> +}
>> +
>> +static irqreturn_t al_mc_edac_irq_handler_ce(int irq, void *info)
>> +{
>> +     struct platform_device *pdev = info;
>> +     struct mem_ctl_info *mci = platform_get_drvdata(pdev);
>> +
>> +     if (handle_ce(mci))
>> +             return IRQ_HANDLED;
>> +     return IRQ_NONE;
>> +}
>> +
>> +static enum scrub_type al_mc_edac_get_scrub_mode(void __iomem *mmio_base)
>> +{
>> +     u32 ecccfg0;
>> +
>> +     ecccfg0 = readl(mmio_base + AL_MC_ECC_CFG);
>> +
>> +     if (FIELD_GET(AL_MC_ECC_CFG_SCRUB_DISABLED, ecccfg0))
>> +             return SCRUB_NONE;
>> +     else
>> +             return SCRUB_HW_SRC;
>> +}
>> +
>> +static void devm_al_mc_edac_free(void *data)
>> +{
>> +     edac_mc_free(data);
>> +}
>> +
>> +static void devm_al_mc_edac_del(void *data)
>> +{
>> +     edac_mc_del_mc(data);
>> +}
>  From a previous review:
>
> I said:
>
>> Drop the "al_mc_edac_" prefix from most of the static functions. You can
>> leave it in the probe function or the IRQ handler so that it is visible
>> in stack traces but all those small functions don't need that prefix.
> You replied with:
>
>> Shall be part of v7.
> and yet it ain't part of any v<num>.
>
> Why?

Thanks for taking a look.

 From cover letter:

- removed static function names prefix from internal functions (external
   used function, such as devm/interrupts-handlers/probe, left with the
   prefix to allow stack trace visibility)

As you can see, part of the functions got their prefix removed, e.g. 
prepare_msg, handle_ce, handle_ue.

I did take your advise for leaving prefix for having visibility for 
functions being used outside. hence, some were left with the prefix.

Let me know what you think.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
