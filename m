Return-Path: <linux-edac+bounces-3716-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D612A9BC14
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 03:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AE07B47A1
	for <lists+linux-edac@lfdr.de>; Fri, 25 Apr 2025 00:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169E817583;
	Fri, 25 Apr 2025 01:00:44 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE45258;
	Fri, 25 Apr 2025 01:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542844; cv=none; b=cSVYo8tyVdfbGWvEIdMk55xIfEFcw52MJDD0NoC7WJvW/YhI6pu97FjlnKceD737B4XIYpDO/6oqPkAu+fbID/720hzvJStltjFcP4ypS9m4WuNjz4UnRQgzf3bM86w2UOdDwx9Onc0gDhexnFZs2y/E133npPWax2CilWjXE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542844; c=relaxed/simple;
	bh=q3/Ou0SX5DeHbn9YI7b/g85lWDwehl99b7xfTwAuLdA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ATugirr9JXZuPcOpTtJ4hNrOjCw02MczTntVqJ9IcJqZL7OY8mc+eVo5s++j4zUqlJpRzf1TUCjXpmtmHrYDRxrEg9HUMcE1/0ozBN4IldpgJ146zQPFDYhzkq+Kowtv8ZkMtZ/2Wf0guMw5J85H7vetZEv+KEYr7BI3cM6qJOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZkDyH1Qbpz1d0t6;
	Fri, 25 Apr 2025 08:59:35 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 2F1DC180B46;
	Fri, 25 Apr 2025 09:00:36 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Apr 2025 09:00:34 +0800
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Shuai Xue <xueshuai@linux.alibaba.com>, "Luck, Tony"
	<tony.luck@intel.com>, <rafael@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<akpm@linux-foundation.org>, <linux-edac@vger.kernel.org>, <x86@kernel.org>,
	<justin.he@arm.com>, <ardb@kernel.org>, <ying.huang@linux.alibaba.com>,
	<ashish.kalra@amd.com>, <baolin.wang@linux.alibaba.com>,
	<tglx@linutronix.de>, <dave.hansen@linux.intel.com>, <lenb@kernel.org>,
	<hpa@zytor.com>, <robert.moore@intel.com>, <lvying6@huawei.com>,
	<xiexiuqi@huawei.com>, <zhuo.song@linux.alibaba.com>, <sudeep.holla@arm.com>,
	<lpieralisi@kernel.org>, <linux-acpi@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <mark.rutland@arm.com>, <mingo@redhat.com>,
	<robin.murphy@arm.com>, <Jonathan.Cameron@Huawei.com>, <bp@alien8.de>,
	<linux-arm-kernel@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <linmiaohe@huawei.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
 <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
 <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <de5d2417-dc92-b276-1125-4feb5151de7f@huawei.com>
Date: Fri, 25 Apr 2025 09:00:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/4/18 20:35, Shuai Xue wrote:
> 
> 
> 在 2025/4/18 15:48, Hanjun Guo 写道:
>> On 2025/4/14 23:02, Shuai Xue wrote:
>>>
>>>
>>> 在 2025/4/14 22:37, Hanjun Guo 写道:
>>>> On 2025/4/4 19:20, Shuai Xue wrote:
>>>>> Synchronous error was detected as a result of user-space process 
>>>>> accessing
>>>>> a 2-bit uncorrected error. The CPU will take a synchronous error 
>>>>> exception
>>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will 
>>>>> queue a
>>>>> memory_failure() work which poisons the related page, unmaps the 
>>>>> page, and
>>>>> then sends a SIGBUS to the process, so that a system wide panic can be
>>>>> avoided.
>>>>>
>>>>> However, no memory_failure() work will be queued when abnormal 
>>>>> synchronous
>>>>> errors occur. These errors can include situations such as invalid PA,
>>>>> unexpected severity, no memory failure config support, invalid GUID
>>>>> section, etc. In such case, the user-space process will trigger SEA 
>>>>> again.
>>>>> This loop can potentially exceed the platform firmware threshold or 
>>>>> even
>>>>> trigger a kernel hard lockup, leading to a system reboot.
>>>>>
>>>>> Fix it by performing a force kill if no memory_failure() work is 
>>>>> queued
>>>>> for synchronous errors.
>>>>>
>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>>>>> ---
>>>>>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>>>>>   1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>>> index b72772494655..50e4d924aa8b 100644
>>>>> --- a/drivers/acpi/apei/ghes.c
>>>>> +++ b/drivers/acpi/apei/ghes.c
>>>>> @@ -799,6 +799,17 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>>           }
>>>>>       }
>>>>> +    /*
>>>>> +     * If no memory failure work is queued for abnormal synchronous
>>>>> +     * errors, do a force kill.
>>>>> +     */
>>>>> +    if (sync && !queued) {
>>>>> +        dev_err(ghes->dev,
>>>>> +            HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable 
>>>>> error (SIGBUS)\n",
>>>>> +            current->comm, task_pid_nr(current));
>>>>> +        force_sig(SIGBUS);
>>>>> +    }
>>>>
>>>> I think it's reasonable to send a force kill to the task when the
>>>> synchronous memory error is not recovered.
>>>>
>>>> But I hope this code will not trigger some legacy firmware issues,
>>>> let's be careful for this, so can we just introduce arch specific
>>>> callbacks for this?
>>>
>>> Sorry, can you give more details? I am not sure I got your point.
>>>
>>> For x86, Tony confirmed that ghes will not dispatch x86 synchronous 
>>> errors
>>> (a.k.a machine check exception), in previous vesion.
>>> Sync is only used in arm64 platform, see is_hest_sync_notify().
>>
>> Sorry for the late reply, from the code I can see that x86 will reuse
>> ghes_do_proc(), if Tony confirmed that x86 is OK, it's OK to me as well.
> 
> Hi, Hanjun,
> 
> Glad to hear that.
> 
> I copy and paste in the original disscusion with @Tony from mailist.[1]
> 
>> On x86 the "action required" cases are signaled by a synchronous 
>> machine check
>> that is delivered before the instruction that is attempting to consume 
>> the uncorrected
>> data retires. I.e., it is guaranteed that the uncorrected error has 
>> not been propagated
>> because it is not visible in any architectural state.
> 
>> APEI signaled errors don't fall into that category on x86 ... the 
>> uncorrected data
>> could have been consumed and propagated long before the signaling used 
>> for
>> APEI can alert the OS.
> 
> I also add comments in the code.
> 
> /*
>   * A platform may describe one error source for the handling of 
> synchronous
>   * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
>   * or External Interrupt). On x86, the HEST notifications are always
>   * asynchronous, so only SEA on ARM is delivered as a synchronous
>   * notification.
>   */
> static inline bool is_hest_sync_notify(struct ghes *ghes)
> {
>      u8 notify_type = ghes->generic->notify.type;
> 
>      return notify_type == ACPI_HEST_NOTIFY_SEA;
> }
> 
> 
> If you are happy with code, please explictly give me your reviewed-by 
> tags :)

Call force_sig(SIGBUS) directly in ghes_do_proc() is not my favourite,
but I can bear that, please add

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

