Return-Path: <linux-edac+bounces-1823-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA37496E763
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2024 03:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEADF1C21BF2
	for <lists+linux-edac@lfdr.de>; Fri,  6 Sep 2024 01:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6142517C77;
	Fri,  6 Sep 2024 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ITtirQEP"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504A1EA87;
	Fri,  6 Sep 2024 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725587626; cv=none; b=KhA5+O4126RmT3W+qaYDTTwfN+E+8WgxHQpNoo1Oza0FFxpeqeQlcZr3SiTz50Pni3+lHWhUOH7mnyhOCobMvUeqPEW8aiZuIFpNglwE0BO4u+waJgssoXNMJRgfFVhrjW7EKKtdVP0dmKI3gwe2on/3XKBQPMlcTef1IoNzWPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725587626; c=relaxed/simple;
	bh=a72T8cDYzUMTleXuRPYVQQflQxStcn2RcQeqC/p5UYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfWFUDbgTzqam5hifoLnku2kuOXU8WxOJQvuTYJdHZwhZSuARkrt2WyIJzbPAc2ENLHBDlhn5IRzncFPCxuOidWe9VvdmN+vNvaOQ9EoAYZl6TLT7j1FltOKdlXwuttgfuA8Hl3K8OwSCHXsbFAiIXna4KRSstokI6zcR1yXObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ITtirQEP; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725587615; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yXCCgOuWDZJBwrrZhsFP69ynA9Ps5ml3WXCsMeJVNTQ=;
	b=ITtirQEPxGpi9kdKM+EdwFUZccl3xC2+TtkJSry5nuuL9eQWkVmhdX+h8aMjIKLt/GXC92uLdY73yTr5jfYnHamKgkq6k3i0nSZjmyi/H+zjcdafJ4grlNyE/CwGStFMZ+dOANiVMiwCRbPYsIzNNqNcO4q8bsfWsQFlJrP5i1E=
Received: from 30.246.162.144(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WENXsHu_1725587611)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 09:53:33 +0800
Message-ID: <34d5d58b-7fc2-4f93-9d3b-3051ec5e6a23@linux.alibaba.com>
Date: Fri, 6 Sep 2024 09:53:30 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
To: Jarkko Sakkinen <jarkko@kernel.org>, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-2-xueshuai@linux.alibaba.com>
 <D3WS2P2DU0CE.SANBOLMHG6TC@kernel.org>
 <bf984773-2a8e-4528-9af1-9775fdc7c4e2@linux.alibaba.com>
 <D3YEWCUXEWY3.ALFECJPKZMMG@kernel.org> <D3YEYH69KMV4.13SX59Y2HT6D@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <D3YEYH69KMV4.13SX59Y2HT6D@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/5 22:17, Jarkko Sakkinen 写道:
> On Thu Sep 5, 2024 at 5:14 PM EEST, Jarkko Sakkinen wrote:
>> On Thu Sep 5, 2024 at 6:04 AM EEST, Shuai Xue wrote:
>>>
>>>
>>> 在 2024/9/4 00:09, Jarkko Sakkinen 写道:
>>>> On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
>>>>> Synchronous error was detected as a result of user-space process accessing
>>>>> a 2-bit uncorrected error. The CPU will take a synchronous error exception
>>>>> such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
>>>>> memory_failure() work which poisons the related page, unmaps the page, and
>>>>> then sends a SIGBUS to the process, so that a system wide panic can be
>>>>> avoided.
>>>>>
>>>>> However, no memory_failure() work will be queued unless all bellow
>>>>> preconditions check passed:
>>>>>
>>>>> - `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handle_memory_failure()
>>>>> - `if (flags == -1)` in ghes_handle_memory_failure()
>>>>> - `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memory_failure()
>>>>> - `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in ghes_do_memory_failure()
>>>>>
>>>>> In such case, the user-space process will trigger SEA again.  This loop
>>>>> can potentially exceed the platform firmware threshold or even trigger a
>>>>> kernel hard lockup, leading to a system reboot.
>>>>>
>>>>> Fix it by performing a force kill if no memory_failure() work is queued
>>>>> for synchronous errors.
>>>>>
>>>>> Suggested-by: Xiaofei Tan <tanxiaofei@huawei.com>
>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>>
>>>>> ---
>>>>>    drivers/acpi/apei/ghes.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>>>> index 623cc0cb4a65..b0b20ee533d9 100644
>>>>> --- a/drivers/acpi/apei/ghes.c
>>>>> +++ b/drivers/acpi/apei/ghes.c
>>>>> @@ -801,6 +801,16 @@ static bool ghes_do_proc(struct ghes *ghes,
>>>>>    		}
>>>>>    	}
>>>>>    
>>>>> +	/*
>>>>> +	 * If no memory failure work is queued for abnormal synchronous
>>>>> +	 * errors, do a force kill.
>>>>> +	 */
>>>>> +	if (sync && !queued) {
>>>>> +		pr_err("Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>>>>> +			current->comm, task_pid_nr(current));
>>>>
>>>> Hmm... doest this need "hardware" or would "memory corruption" be
>>>> enough?
>>>>
>>>> Also, does this need to say that it is sending SIGBUS when the signal
>>>> itself tells that already?
>>>>
>>>> I.e. could "%s:%d has memory corruption" be enough information?
>>>
>>> Hi, Jarkko,
>>>
>>> Thank you for your suggestion. Maybe it could.
>>>
>>> There are some similar error info which use "hardware memory error", e.g.
>>
>> By tweaking my original suggestion just a bit:
>>
>> "%s:%d: hardware memory corruption"
>>
>> Can't get clearer than that, right?
> 
> And obvious reason that shorter and more consistent klog message is easy
> to spot and grep. It is simply less convoluted.
> 
> If you want also SIGBUS, I'd just put it as "%s:%d: hardware memory
> corruption (SIGBUS)"
> 
> BR, Jarkko

Hi, Jarkko,

I will change it to "%s:%d: hardware memory corruption (SIGBUS)".

Thank you for valuable suggestion.

Best Regards,
Shuai


