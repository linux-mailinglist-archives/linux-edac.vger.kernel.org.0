Return-Path: <linux-edac+bounces-164-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7B98002FB
	for <lists+linux-edac@lfdr.de>; Fri,  1 Dec 2023 06:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B835E1C20D53
	for <lists+linux-edac@lfdr.de>; Fri,  1 Dec 2023 05:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D45B747E;
	Fri,  1 Dec 2023 05:22:41 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A950C10FC;
	Thu, 30 Nov 2023 21:22:35 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0VxVHB4Y_1701408150;
Received: from 30.240.114.121(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VxVHB4Y_1701408150)
          by smtp.aliyun-inc.com;
          Fri, 01 Dec 2023 13:22:32 +0800
Message-ID: <c89342d5-79a2-47cb-b1dc-e69f0d528862@linux.alibaba.com>
Date: Fri, 1 Dec 2023 13:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/2] ACPI: APEI: set memory failure flags as
 MF_ACTION_REQUIRED on synchronous events
Content-Language: en-US
To: James Morse <james.morse@arm.com>, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
 stable@vger.kernel.org, x86@kernel.org, justin.he@arm.com, ardb@kernel.org,
 ying.huang@intel.com, ashish.kalra@amd.com, baolin.wang@linux.alibaba.com,
 bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20231007072818.58951-2-xueshuai@linux.alibaba.com>
 <c77e1909-8e03-6b2f-ecaf-c5b395642688@arm.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <c77e1909-8e03-6b2f-ecaf-c5b395642688@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/1 01:39, James Morse wrote:
> Hi Shuai,
> 
> On 07/10/2023 08:28, Shuai Xue wrote:
>> There are two major types of uncorrected recoverable (UCR) errors :
> 
> Is UCR a well known x86 acronym? It's best to just spell this out each time,
> there is enough jargon in this area already.

Quite agreed, will replace the commit log with "uncorrected recoverable error".

> 
>>
>> - Action Required (AR): The error is detected and the processor already
>>   consumes the memory. OS requires to take action (for example, offline
>>   failure page/kill failure thread) to recover this uncorrectable error.
>>
>> - Action Optional (AO): The error is detected out of processor execution
>>   context. Some data in the memory are corrupted. But the data have not
>>   been consumed. OS is optional to take action to recover this
>>   uncorrectable error.
> 
> As elsewhere, please don't think of errors as 'action required', this is how
> things get reported to user-space. Action-required for one thread may be
> action-optional for another that has the same page mapped - its really not a
> property of the error.
> It would be better to describe this as synchronous and asynchronous, or in-band
> and out-of-band.

Thank you for explanation. I will change to "synchronous and asynchronous".

> 
> 
>> The essential difference between AR and AO errors is that AR is a
>> synchronous event, while AO is an asynchronous event. The hardware will
>> signal a synchronous exception (Machine Check Exception on X86 and
>> Synchronous External Abort on Arm64) when an error is detected and the
>> memory access has been architecturally executed.
> 
>> When APEI firmware first is enabled, a platform may describe one error
>> source for the handling of synchronous errors (e.g. MCE or SEA notification
>> ), or for handling asynchronous errors (e.g. SCI or External Interrupt
>> notification). In other words, we can distinguish synchronous errors by
>> APEI notification. For AR errors, kernel will kill current process
>> accessing the poisoned page by sending SIGBUS with BUS_MCEERR_AR. In
>> addition, for AO errors, kernel will notify the process who owns the
>> poisoned page by sending SIGBUS with BUS_MCEERR_AO in early kill mode.
>> However, the GHES driver always sets mf_flags to 0 so that all UCR errors
>> are handled as AO errors in memory failure.
> 
> To make this easier to read:
>  UCR and AR -> synchronous
>  AO -> asynchronous
> 

Will do that.

> 
>> To this end, set memory failure flags as MF_ACTION_REQUIRED on synchronous
>> events.
> 
>> Fixes: ba61ca4aab47 ("ACPI, APEI, GHES: Add hardware memory error recovery support")'
> 
> Erm, this predates arm64 support, and what you have here doesn't change the behaviour on x86.
> 
> You can blame 7f17b4a121d0d50 ("ACPI: APEI: Kick the memory_failure() queue for
> synchronous errors"), which should have covered this.

Do you mean just drop the "Fixes" tags?

> 
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ef59d6ea16da..88178aa6222d 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -101,6 +101,20 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  	return ghes->generic->header.type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
>>  }
>>  
>> +/*
>> + * A platform may describe one error source for the handling of synchronous
>> + * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>> + * or External Interrupt). On x86, the HEST notifications are always
>> + * asynchronous, so only SEA on ARM is delivered as a synchronous
>> + * notification.
>> + */
>> +static inline bool is_hest_sync_notify(struct ghes *ghes)
>> +{
>> +	u8 notify_type = ghes->generic->notify.type;
>> +
>> +	return notify_type == ACPI_HEST_NOTIFY_SEA;
>> +}
> 
> and as you had in earlier versions, sometimes SDEI.
> SDEI can report by synchronous and asynchronous errors, I wouldn't too surprised if the
> hardware NMI can be used for the same. It would be good to chase up having a hint of this
> in the CPER records and pass that in here as a hint.> 
> Unfortunately, its not safe to assume either way for SDEI.

For SDEI notification, only x0-x17 has preserved by firmware.  As SDEI
TRM[1] describes "the dispatcher can simulate an exception-like entry into
the client, **with the client providing an additional asynchronous entry
point similar to an interrupt entry point**".  The client (kernel) lacks
complete synchronous context, e.g. system register (ELR, ESR, etc). So I
think SDEI notification should not be used for asynchronous error, can you
help to confirm this?

For NMI notification, as far as I know, AArch64 (aka arm64 in the Linux
tree) does not provide architected NMIs.

> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 

Thank you for valuable comments.

Best Regards,
Shuai

[1] https://developer.arm.com/documentation/den0054/latest/

