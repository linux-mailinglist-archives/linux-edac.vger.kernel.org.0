Return-Path: <linux-edac+bounces-3584-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD29A9372E
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 14:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C6B3AE364
	for <lists+linux-edac@lfdr.de>; Fri, 18 Apr 2025 12:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BEE274FF4;
	Fri, 18 Apr 2025 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H34aLp19"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8D212D8A;
	Fri, 18 Apr 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979720; cv=none; b=Qdl8ILjuO+IOv4CdBS5WQsCOBVny6Z3Jskdt2wOzeCzTWtBeryOECLzAUdMa+zshnm0rdyn03ewb23fGbrYErbo/bzxYB5yAr5mpsGw0S5FAg1B3JHE00lHQ8z9qO5A59E87ACy8qNgRpnxte4WwTZrtUrZIYnOLjUUZuBEMwB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979720; c=relaxed/simple;
	bh=6CrdNbp/demKpRChXxKiOZWkDp7cZPXxIcoSLVsut78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNTfhH2F4W8xrCtYLHZX+eqTYfzh4jSba8VGpduVdcNTJjZfJMZxF9ryJynS636zav1oIlMQzTFbXhqIMD3FQF+KKbwQNvEOJe9zGoyYigfdmx58SlACjdr88mjUwuLNw1iOduHl2VMcNYCPuMq342pFku/37eay3wKQF6XqcuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H34aLp19; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744979708; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ET48gmghr/S6KXKpbHbaUOhbwdjcr6/9oYUul7jTD2Y=;
	b=H34aLp19BoMIW+cp1y5Vo/s4xNLEoZxunukpcExeRIkfjHKzh/kLNOlYCj8KhL3aNaUa2qMPY1V09ht/Dvqw4uZRgIT1ucubKsUsENxHS1GQlzmEUWzi63bFnlsA9l7tUuWBYY5eXO/4EKXqHuDz6x0Sp/5zmQlREyMjTRphEWg=
Received: from 30.246.162.65(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WXJZ5.I_1744979704 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Apr 2025 20:35:06 +0800
Message-ID: <653abdd4-46d2-4956-b49c-8f9c309af34d@linux.alibaba.com>
Date: Fri, 18 Apr 2025 20:35:03 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v18 1/2] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Hanjun Guo <guohanjun@huawei.com>, "Luck, Tony" <tony.luck@intel.com>,
 rafael@kernel.org, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-edac@vger.kernel.org, x86@kernel.org,
 justin.he@arm.com, ardb@kernel.org, ying.huang@linux.alibaba.com,
 ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com, Hanjun Guo <guohanjun@huawei.com>,
 catalin.marinas@arm.com, sudeep.holla@arm.com, lpieralisi@kernel.org,
 linux-acpi@vger.kernel.org, yazen.ghannam@amd.com, mark.rutland@arm.com,
 mingo@redhat.com, robin.murphy@arm.com, Jonathan.Cameron@Huawei.com,
 bp@alien8.de, rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-2-xueshuai@linux.alibaba.com>
 <0c0bc332-0323-4e43-a96b-dd5f5957ecc9@huawei.com>
 <709ee8d2-8969-424c-b32b-101c6a8220fb@linux.alibaba.com>
 <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <353809e7-5373-0d54-6ddb-767bc5af9e5f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/18 15:48, Hanjun Guo 写道:
> On 2025/4/14 23:02, Shuai Xue wrote:
>>
>>
>> 在 2025/4/14 22:37, Hanjun Guo 写道:
>>> On 2025/4/4 19:20, Shuai Xue wrote:
>>>> Synchronous error was detected as a result of user-space process accessing
>>>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>>>> memory_failure() work which poisons the related page, unmaps the page, and
>>>> then sends a SIGBUS to the process, so that a system wide panic can be
>>>> avoided.
>>>>
>>>> However, no memory_failure() work will be queued when abnormal synchronous
>>>> errors occur. These errors can include situations such as invalid PA,
>>>> unexpected severity, no memory failure config support, invalid GUID
>>>> section, etc. In such case, the user-space process will trigger SEA again.
>>>> This loop can potentially exceed the platform firmware threshold or even
>>>> trigger a kernel hard lockup, leading to a system reboot.
>>>>
>>>> Fix it by performing a force kill if no memory_failure() work is queued
>>>> for synchronous errors.
>>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>>>> ---
>>>>   drivers/acpi/apei/ghes.c | 11 +++++++++++
>>>>   1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>> index b72772494655..50e4d924aa8b 100644
>>>> --- a/drivers/acpi/apei/ghes.c
>>>> +++ b/drivers/acpi/apei/ghes.c
>>>> @@ -799,6 +799,17 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>           }
>>>>       }
>>>> +    /*
>>>> +     * If no memory failure work is queued for abnormal synchronous
>>>> +     * errors, do a force kill.
>>>> +     */
>>>> +    if (sync && !queued) {
>>>> +        dev_err(ghes->dev,
>>>> +            HW_ERR GHES_PFX "%s:%d: synchronous unrecoverable error (SIGBUS)\n",
>>>> +            current->comm, task_pid_nr(current));
>>>> +        force_sig(SIGBUS);
>>>> +    }
>>>
>>> I think it's reasonable to send a force kill to the task when the
>>> synchronous memory error is not recovered.
>>>
>>> But I hope this code will not trigger some legacy firmware issues,
>>> let's be careful for this, so can we just introduce arch specific
>>> callbacks for this?
>>
>> Sorry, can you give more details? I am not sure I got your point.
>>
>> For x86, Tony confirmed that ghes will not dispatch x86 synchronous errors
>> (a.k.a machine check exception), in previous vesion.
>> Sync is only used in arm64 platform, see is_hest_sync_notify().
> 
> Sorry for the late reply, from the code I can see that x86 will reuse
> ghes_do_proc(), if Tony confirmed that x86 is OK, it's OK to me as well.

Hi, Hanjun,

Glad to hear that.

I copy and paste in the original disscusion with @Tony from mailist.[1]

> On x86 the "action required" cases are signaled by a synchronous machine check
> that is delivered before the instruction that is attempting to consume the uncorrected
> data retires. I.e., it is guaranteed that the uncorrected error has not been propagated
> because it is not visible in any architectural state.

> APEI signaled errors don't fall into that category on x86 ... the uncorrected data
> could have been consumed and propagated long before the signaling used for
> APEI can alert the OS.

I also add comments in the code.

/*
  * A platform may describe one error source for the handling of synchronous
  * errors (e.g. MCE or SEA), or for handling asynchronous errors (e.g. SCI
  * or External Interrupt). On x86, the HEST notifications are always
  * asynchronous, so only SEA on ARM is delivered as a synchronous
  * notification.
  */
static inline bool is_hest_sync_notify(struct ghes *ghes)
{
	u8 notify_type = ghes->generic->notify.type;

	return notify_type == ACPI_HEST_NOTIFY_SEA;
}


If you are happy with code, please explictly give me your reviewed-by tags :)


> 
> Thanks
> Hanjun

Thanks.

Best Regards,
Shuai

[1] https://lore.kernel.org/lkml/CAJZ5v0hdgxsDiXqOmeqBQoZUQJ1RssM=3jpYpWt3qzy0n2eyaA@mail.gmail.com/t/#u


