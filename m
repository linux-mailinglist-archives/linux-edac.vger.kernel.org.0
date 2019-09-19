Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A509B7539
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2019 10:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfISIg1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Sep 2019 04:36:27 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:62326 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbfISIg0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Sep 2019 04:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568882184; x=1600418184;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=peYmu9C6wVgjhm29Lt+//jwlKJnQBBI6R1TRcKcWe7s=;
  b=jaDPDGHJJlh2HqOBo8rR38uPHwPpzx+7pVGRkJtIfhP8VDAdwapmk/ux
   daAiNm0qtXS7Wp/v2N+A66e0ZESJTBj3vJiEZmMpKXEikv42AwN8aaynS
   RuvUDvXP1S7iGzlkCp+fDMawPS8qNOXLjZBlDapDMv5fPVrY7WfB1mJCw
   A=;
X-IronPort-AV: E=Sophos;i="5.64,522,1559520000"; 
   d="scan'208";a="421981783"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 19 Sep 2019 08:36:22 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-6f38efd9.us-west-2.amazon.com (Postfix) with ESMTPS id D0453A1C03;
        Thu, 19 Sep 2019 08:36:20 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 08:36:20 +0000
Received: from [10.125.238.52] (10.43.160.153) by EX13D01EUB001.ant.amazon.com
 (10.43.166.194) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 19 Sep
 2019 08:36:11 +0000
Subject: Re: [PATCH v2 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
To:     James Morse <james.morse@arm.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <hhhawa@amazon.com>,
        <ronenk@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <amirkl@amazon.com>, <barakw@amazon.com>
References: <1568529835-15319-1-git-send-email-talel@amazon.com>
 <1568529835-15319-3-git-send-email-talel@amazon.com>
 <4f6cd17c-c56f-b9d2-d6e0-1711de415f47@arm.com>
From:   "Shenhar, Talel" <talel@amazon.com>
Message-ID: <fe52b9bb-6d3a-92be-b54a-c93003cc9b4b@amazon.com>
Date:   Thu, 19 Sep 2019 11:36:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <4f6cd17c-c56f-b9d2-d6e0-1711de415f47@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.43.160.153]
X-ClientProxiedBy: EX13D21UWA002.ant.amazon.com (10.43.160.246) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thanks for the review.


On 9/18/2019 8:47 PM, James Morse wrote:
> Hi Talel,
>
> On 15/09/2019 07:43, Talel Shenhar wrote:
>> The Amazon's Annapurna Labs Memory Controller EDAC supports ECC capability
>> for error detection and correction (Single bit error correction, Double
>> detection). This driver introduces EDAC driver for that capability.
> Is there any documentation for this memory controller?
Unfortunately, we don't have public documentation for it.
>
>
>> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
>> new file mode 100644
>> index 0000000..f9763d4
>> --- /dev/null
>> +++ b/drivers/edac/al_mc_edac.c
>> @@ -0,0 +1,382 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
>> + */
>> +#include <linux/bitfield.h>
> #include <linux/bitops.h> for hweight_long()

shall be part of v3.

btw: do you use some tool to catch those missing includes?

>
>> +#include <linux/edac.h>
>> +#include <linux/of_irq.h>
> #include <linux/platform_device.h> for platform_get_resource()
shall be part of v3.
>
>> +#include "edac_module.h"
>> +/* Registers Values */
>> +#define AL_MC_MSTR_DEV_CFG_X4	0
>> +#define AL_MC_MSTR_DEV_CFG_X8	1
>> +#define AL_MC_MSTR_DEV_CFG_X16	2
>> +#define AL_MC_MSTR_DEV_CFG_X32	3
>> +#define AL_MC_MSTR_RANKS_MAX 4
> Is this a fixed property of the memory controller, or is it a limit imposed from somewhere
> else. (Does it need to come from the DT?)

Yes. this is a fixed behavior hence not part of dt.

>
>
>> +#define AL_MC_MSTR_DATA_BUS_WIDTH_X64	0
>> +
>> +#define DRV_NAME "al_mc_edac"
>> +#define AL_MC_EDAC_MSG_MAX 256
>> +#define AL_MC_EDAC_MSG(message, buffer_size, type,			\
>> +		       rank, row, bg, bank, column, syn0, syn1, syn2)	\
>> +	snprintf(message, buffer_size,					\
>> +		 "%s rank=0x%x row=0x%x bg=0x%x bank=0x%x col=0x%x "	\
>> +		 "syn0: 0x%x syn1: 0x%x syn2: 0x%x",			\
>> +		 type == HW_EVENT_ERR_UNCORRECTED ? "UE" : "CE",	\
>> +		 rank, row, bg, bank, column, syn0, syn1, syn2)
>> +
>> +struct al_mc_edac {
>> +	void __iomem *mmio_base;
>> +	int irq_ce;
>> +	int irq_ue;
>> +};
>> +
>> +static int al_mc_edac_handle_ce(struct mem_ctl_info *mci)
>> +{
>> +	struct al_mc_edac *al_mc = mci->pvt_info;
>> +	u32 eccerrcnt;
>> +	u16 ce_count;
>> +	u32 ecccaddr0;
>> +	u32 ecccaddr1;
>> +	u32 ecccsyn0;
>> +	u32 ecccsyn1;
>> +	u32 ecccsyn2;
>> +	u8 rank;
>> +	u32 row;
>> +	u8 bg;
>> +	u8 bank;
>> +	u16 column;
>> +	char msg[AL_MC_EDAC_MSG_MAX];
> (Some of these could go on the same line, same with UE below)
Shall be part of v3
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +			     ce_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);
> You used active_ranks as the layer size in al_mc_edac_probe(). Can't you supply the rank here?
>
> (If its not useful, why is it setup like this in al_mc_edac_probe()?)

Seems it can be removed from probe.

Shall be part of v3.

>
>
> +	u8 bank;
> +	u16 column;
> +	char msg[AL_MC_EDAC_MSG_MAX];
> +
> +	eccerrcnt = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_ERR_COUNT);
> +	ue_count = FIELD_GET(AL_MC_ECC_ERR_COUNT_UE, eccerrcnt);
> +	if (!ue_count)
> +		return 0;
> +
> +	eccuaddr0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR0);
> +	eccuaddr1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR1);
> +	eccusyn0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND0);
> +	eccusyn1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND1);
> +	eccusyn2 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND2);
> +
> +	writel(AL_MC_ECC_CLEAR_UE_COUNT | AL_MC_ECC_CLEAR_UE_ERR,
> +	       al_mc->mmio_base + AL_MC_ECC_CLEAR);
> +
> +	dev_dbg(mci->pdev, "eccuaddr0=0x%08x eccuaddr1=0x%08x\n",
> +		eccuaddr0, eccuaddr1);
> +
> +	rank = FIELD_GET(AL_MC_ECC_UE_ADDR0_RANK, eccuaddr0);
> +	row = FIELD_GET(AL_MC_ECC_UE_ADDR0_ROW, eccuaddr0);
> +
> +	bg = FIELD_GET(AL_MC_ECC_UE_ADDR1_BG, eccuaddr1);
> +	bank = FIELD_GET(AL_MC_ECC_UE_ADDR1_BANK, eccuaddr1);
> +	column = FIELD_GET(AL_MC_ECC_UE_ADDR1_COLUMN, eccuaddr1);
> +
> +	AL_MC_EDAC_MSG(msg, sizeof(msg), HW_EVENT_ERR_UNCORRECTED,
> +		       rank, row, bg, bank, column,
> +		       eccusyn0, eccusyn1, eccusyn2);
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +			     ue_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);
>
> What happens when this code runs at the same time as the corrected error handler calling
> edac_mc_handler_error() with this same mci?
>
> This could happen on a second CPU, or on one cpu if the corrected handler is polled.
>
> edac_mc_handle_error() memset's the edac_raw_error_desc in mci, so it can't be called in
> parallel, or twice on the same cpu.
>
> I think you need an irqsave spinlock around the calls to edac_mc_handle_error().

shall add locks in v3.

>
>> +
>> +static irqreturn_t al_mc_edac_irq_handler_ue(int irq, void *info)
>> +{
>> +	struct platform_device *pdev = info;
>> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
>> +	int ue_count;
>> +
>> +	ue_count = al_mc_edac_handle_ue(mci);
>> +	if (ue_count)
>> +		return IRQ_HANDLED;
>> +	else
>> +		return IRQ_NONE;
>> +}
> As you don't use ue_count, wouldn't this be clearer:
>
> | if (al_mc_edac_handle_ue(mci))
> | 	return IRQ_HANDLED;
> | return IRQ_NONE;
>
> ?
ack, shall add to v3
>
>> +static int al_mc_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *resource;
>> +	void __iomem *mmio_base;
>> +	unsigned int active_ranks;
>> +	struct edac_mc_layer layers[1];
>> +	struct mem_ctl_info *mci;
>> +	struct al_mc_edac *al_mc;
>> +	int ret;
>> +
>> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> platform_get_resource() can fail, returning NULL.
ack, shall add to v3
>
>
> +
> +	if (al_mc->irq_ue > 0) {
> +		ret = devm_request_irq(&pdev->dev,
> +				       al_mc->irq_ue,
> +				       al_mc_edac_irq_handler_ue,
>> +				       0,
> As you know when your device has triggered the interrupt from the error counter, could
> these be IRQF_SHARED?
ack, shall add to v3
>
>> +static int al_mc_edac_remove(struct platform_device *pdev)
>> +{
>> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
>> +
>> +	edac_mc_del_mc(&pdev->dev);
>> +	edac_mc_free(mci);
> What stops your interrupt firing here? You've free'd the memory it uses.
>
> I think you need to devm_free_irq() the interrupts before you free the memory.
ack, shall add to v3
>
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Talel Shenhar");
>> +MODULE_DESCRIPTION("Amazon's Annapurna Lab's Memory Controller EDAC Driver");
> (Kconfig says this is 'bool', so it can't be built as a module, having these is a bit odd)

ack, shall add to v3

while at it, shall consider changing to trisate so it can really be 
build as a module as well.

>
>
>
> Thanks,
>
> James
