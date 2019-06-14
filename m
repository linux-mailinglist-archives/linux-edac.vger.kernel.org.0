Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCF0546314
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfFNPjF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 11:39:05 -0400
Received: from foss.arm.com ([217.140.110.172]:36890 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbfFNPjF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 11:39:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84DED28;
        Fri, 14 Jun 2019 08:39:04 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E22873F718;
        Fri, 14 Jun 2019 08:39:02 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] EDAC: add EDAC driver for DMC520
To:     "Lei Wang (BSP)" <Wang.Lei@microsoft.com>,
        Lei Wang <leiwang_git@outlook.com>
Cc:     "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Rui Zhao <ruizhao@outlook.com>,
        Rui Zhao <ruizhao@microsoft.com>,
        Hang Li <hangl@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
References: <CY1PR0401MB1244FDD9E720C9D9C1F41FEE860A0@CY1PR0401MB1244.namprd04.prod.outlook.com>
 <b1e360bc-2329-3f8b-3c93-65380f62d6fd@arm.com>
 <BYAPR21MB131946E0B469E74D6054C33390EF0@BYAPR21MB1319.namprd21.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <2ca1143b-3251-7a40-5c8f-6c13f445562f@arm.com>
Date:   Fri, 14 Jun 2019 16:39:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR21MB131946E0B469E74D6054C33390EF0@BYAPR21MB1319.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Lei,

On 13/06/2019 19:31, Lei Wang (BSP) wrote:
> Please see inline(tagged with [Lei]) below. Thanks!

Please don't do this. Top posting is discouraged[0]. Creating a reply treasure hunt is
even worse!

You probably need to change your mail client as your mail is also arriving base64 encoded.
To the maintainer's scripts its going to look like this:
https://lore.kernel.org/lkml/BYAPR21MB131946E0B469E74D6054C33390EF0@BYAPR21MB1319.namprd21.prod.outlook.com/raw


> -----Original Message-----
> From: James Morse <james.morse@arm.com> 
> On 16/05/2019 03:55, Lei Wang wrote:
>> New driver supports error detection and correction on the devices with ARM DMC-520 memory controller.
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS index 7d1246b..23894ac 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5573,6 +5573,12 @@ F:	Documentation/driver-api/edac.rst
>>  F:	drivers/edac/
>>  F:	include/linux/edac.h
>>  
>> +EDAC-DMC520
>> +M:	Rui Zhao <ruizhao@microsoft.com>
>> +L:	linux-edac@vger.kernel.org
>> +S:	Supported
>> +F:	drivers/edac/dmc520_edac.c
> 
> Hmm, you're listing someone else as maintainer of this driver.
> I think we'd need to see an Ack from Rui Zhao...
> 
> This patch was previously posted by Rui Zhao, this version has your changes and you as author. (But how you arrange the attribution is up to the two of you...)
> [Lei] And Rui and I sync-ed up on this code and this patch was after addressing his feedbacks and his Ack.

And Rui commented that you should be listed as maintainer:
https://lore.kernel.org/lkml/CY4PR21MB0279BB0E40B86CEA485CF19AB3010@CY4PR21MB0279.namprd21.prod.outlook.com/T/#u

Please don't add someone else!


>> diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c 
>> new file mode 100644 index 0000000..c81bfcc
>> --- /dev/null
>> +++ b/drivers/edac/dmc520_edac.c

>> +static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
>> +					  bool is_ce)
>> +{
>> +	struct ecc_error_info info;
>> +	struct dmc520_edac *edac;
>> +	u32 cnt;
>> +	char message[EDAC_MSG_BUF_SIZE];
>> +
>> +	edac = mci->pvt_info;
>> +	dmc520_get_dram_ecc_error_info(edac, is_ce, &info);
>> +
>> +	cnt = dmc520_get_dram_ecc_error_count(edac, is_ce);
>> +
>> +	if (cnt > 0) {
>> +		snprintf(message, ARRAY_SIZE(message),
>> +			 "rank:%d bank:%d row:%d col:%d",
>> +			 info.rank, info.bank,
>> +			 info.row, info.col);
>> +
>> +		edac_mc_handle_error((is_ce ? HW_EVENT_ERR_CORRECTED :
>> +				     HW_EVENT_ERR_UNCORRECTED),
>> +				     mci, cnt, 0, 0, 0, info.rank, -1, -1,
>> +				     message, "");
> 
> Because you have multiple interrupts, you can be calling edac_mc_handle_error() in
> parallel on different CPUs, for the same mci.
> 
> edac_mc_handle_error() packs all these arguments into mci->error_desc, so two CPUs will
> stomp over each other's values.
> 
> Please add a spinlock in 'struct dmc520_edac' to prevent this.
> 
> [Lei] This round of patch moved away from using mci->error_desc, and the message is on stack now. 

It's not just the message buffer this is a problem for. You call edac_mc_handle_error(),
you can call it with the same mci on two different CPUs, at the same time.

> edac_mc_handle_error() packs all these arguments into mci->error_desc, so two CPUs will
> stomp over each other's values.

From drivers/edac/edac_mc.c::edac_mc_handle_error():
|	struct edac_raw_error_desc *e = &mci->error_desc;
[...]
|	e->error_count = error_count;
|	e->top_layer = top_layer;
|	e->mid_layer = mid_layer;
|	e->low_layer = low_layer;
|	e->page_frame_number = page_frame_number;
|	e->offset_in_page = offset_in_page;
|	e->syndrome = syndrome;
|	e->msg = msg;
|	e->other_detail = other_detail;

If this happens one two CPUs at the same time, e->msg could point to the other CPU's stack.


Thanks,

James

[0] The best summary I found after a quick search is:
https://kernelnewbies.org/PatchCulture 's 'Email etiquette.'
