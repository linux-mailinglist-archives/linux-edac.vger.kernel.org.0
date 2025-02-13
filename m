Return-Path: <linux-edac+bounces-3055-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39E1A3386B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 08:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B92168692
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3E5207A2B;
	Thu, 13 Feb 2025 07:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ul6ddq7E"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8DC207DF5;
	Thu, 13 Feb 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430018; cv=none; b=DKKMhv/elDzLTLzy1zEqkMAH3jQziler3Tn+VZm0nhlgPnAAbksou4MJbA4+7plAGPPU8QJZbX9NwYNTqgL5SSonIOdXJMPPzcdCJbvlws6OlPSw+Z/Bjbynjvb7EX2ACJsSqzBxsNRkmVvKF5cpIiVOb9HFz9mebcaSreCppqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430018; c=relaxed/simple;
	bh=aJh6nSKaICqSNF+iI/ooHpvy89tomykFTx7tOziXDIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KE9e1WyKMMeC73VxeIkcWxXMZyTcku9tnm44RxczGesFmnPIuYql5AQkK+BXWLkHyJmIVLJS7nwqPGUsy7M6rauyIb5933pc5xIv/9tb8YUbR57SHSmp13VZBCKV4XSO6KkjqMsJimegwv+8gF8WTqumWiCY6Yx3qsGu16avtKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ul6ddq7E; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739430001; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tB5Kve4S2OJd5zNjPgLzfRSqSz5A4e7GPCbqNbIsUvY=;
	b=Ul6ddq7Es5HcFXmYIw7jKU7SgawhByhx1xNXUg1l6olEBgw4W/KrfIQAeb6/CMAoBuzYtXGY1Zs+4fxHxKxvjv1x7WfoyRz1etgGeVxr/lYRaBkV1sW7WxhggLbKuZXkLCmnitxrYdl+Yq+ug+PtO/mTuegX5Z2USSHmCqCTeb8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPMZXZn_1739429998 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 13 Feb 2025 14:59:59 +0800
Message-ID: <84ed4048-606e-47bf-98ad-d850cf30d60d@linux.alibaba.com>
Date: Thu, 13 Feb 2025 14:59:57 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/4] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 tianruidong@linux.alibaba.com, tony.luck@intel.com, bp@alien8.de,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>
References: <20250211060200.33845-1-xueshuai@linux.alibaba.com>
 <20250211060200.33845-5-xueshuai@linux.alibaba.com>
 <5f116840-60df-c6d9-d7ff-dcf1dce7773f@huawei.com>
 <3820329d-20e3-49ee-a329-aac7393c6df3@linux.alibaba.com>
 <23251c74-cc50-012c-409f-c45117b52b16@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <23251c74-cc50-012c-409f-c45117b52b16@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/13 11:20, Miaohe Lin 写道:
> On 2025/2/12 21:55, Shuai Xue wrote:
>>
>>
>> 在 2025/2/12 16:09, Miaohe Lin 写道:
>>> On 2025/2/11 14:02, Shuai Xue wrote:
>>>> When an uncorrected memory error is consumed there is a race between
>>>> the CMCI from the memory controller reporting an uncorrected error
>>>> with a UCNA signature, and the core reporting and SRAR signature
>>>> machine check when the data is about to be consumed.
>>>>
>>>> If the CMCI wins that race, the page is marked poisoned when
>>>> uc_decode_notifier() calls memory_failure(). For dirty pages,
>>>> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
>>>> converting the PTE to a hwpoison entry. However, for clean pages, the
>>>> TTU_HWPOISON flag is cleared, leaving the PTE unchanged and not converted
>>>> to a hwpoison entry. Consequently, for an unmapped dirty page, the PTE is
>>>> marked as a hwpoison entry allowing kill_accessing_process() to:
>>>>
>>>> - call walk_page_range() and return 1
>>>> - call kill_proc() to make sure a SIGBUS is sent
>>>> - return -EHWPOISON to indicate that SIGBUS is already sent to the process
>>>>     and kill_me_maybe() doesn't have to send it again.
>>>>
>>>> Conversely, for clean pages where PTE entries are not marked as hwpoison,
>>>> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to send a
>>>> SIGBUS.
>>>>
>>>> Console log looks like this:
>>>>
>>>>       Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>>>>       Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>>>>       Memory failure: 0x827ca68: already hardware poisoned
>>>>       mce: Memory error not recovered
>>>>
>>>> To fix it, return -EHWPOISON if no hwpoison PTE entry is found, preventing
>>>> an unnecessary SIGBUS.
>>>
>>> Thanks for your patch.
>>>
>>>>
>>>> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> ---
>>>>    mm/memory-failure.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 995a15eb67e2..f9a6b136a6f0 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -883,10 +883,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>>>>                      (void *)&priv);
>>>>        if (ret == 1 && priv.tk.addr)
>>>>            kill_proc(&priv.tk, pfn, flags);
>>>> -    else
>>>> -        ret = 0;
>>>>        mmap_read_unlock(p->mm);
>>>> -    return ret > 0 ? -EHWPOISON : -EFAULT;
>>>> +
>>>> +    return ret >= 0 ? -EHWPOISON : -EFAULT;
>>>
>>> IIUC, kill_accessing_process() is supposed to return -EHWPOISON to notify that SIGBUS is already
>>> sent to the process and kill_me_maybe() doesn't have to send it again. But with your change,
>>> kill_accessing_process() will return -EHWPOISON even if SIGBUS is not sent. Does this break
>>> the semantics of -EHWPOISON?
>>
>> Yes, from the comment of kill_me_maybe(),
>>
>>       * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>>       * to the current process with the proper error info,
>>       * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>>
>> this patch break the comment.
>>
>> But the defination of EHWPOISON is quite different from the comment.
>>
>>   #define EHWPOISON    133    /* Memory page has hardware error */
>>
>> As for this issue, returning 0 or EHWPOISON can both prevent a SIGBUS signal
>> from being sent in kill_me_maybe().
>>
>> Which way do you prefer?
>>
>>>
>>> BTW I scanned the code of walk_page_range(). It seems with implementation of hwpoison_walk_ops
>>> walk_page_range() will only return 0 or 1, i.e. always >= 0. So kill_accessing_process() will always
>>> return -EHWPOISON if this patch is applied.
>>>
>>> Correct me if I miss something.
>>
>> Yes, you are right. Let's count the cases one by one:
>>
>> 1. clean page: try_to_remap(!TTU_HWPOISON), walk_page_range() will return 0 and
> 
> Do you mean try_to_unmap?

Yes, sorry for the typo.
> 
>> we should not send sigbus in kill_me_maybe().
>>
>> 2. dirty page:
>> 2.1 MCE wins race
>>            CMCI:w/o Action Require         MCE: w/ Action Require
>>                                        TestSetPageHWPoison
>>        TestSetPageHWPoison
>>        return -EHWPOISON
>>                                        try_to_unmap(TTU_HWPOISON)
>>                                        kill_proc in hwpoison_user_mappings()
>>
>> If MCE wins the race, because the flag of memory_fialure() called by CMCI is
>> not set as MF_ACTION_REQUIRED, everything goes well, kill_proc() will send
>> SIGBUS in hwpoison_user_mappings().
>>
>> 2.2 CMCI win
>>            CMCI:w/o Action Require         MCE: w/ Action Require
>>      TestSetPageHWPoison
>>      try_to_unmap(TTU_HWPOISON)
>>                                         walk_page_range() return 1 due to hwpoison PTE entry
>>                                         kill_proc in kill_accessing_process()
>>
>> If the CMCI wins the race, we need to kill the process in
>> kill_accessing_process(). And if try_to_remap() success, everything goes well,
>> kill_proc() will send SIGBUS in kill_accessing_process().
>>
>> But if try_to_remap() fails, the PTE entry will not be marked as hwpoison, and
>> walk_page_range() return 0 as case 1 clean page, NO SIGBUS will be sent.
> 
> If try_to_unmap() fails, the PTE entry will still point to the dirty page. Then in
> check_hwpoisoned_entry(), we will have pfn == poisoned_pfn. So walk_page_range()
> will return 1 in this case. Or am I miss something?
> 

You’re right; I overlooked the pte_present() branch.

Therefore, in the walk_page_range() function:
- It returns 0 when the poison page is a clean page.
- It returns 1 when CMCI wins, regardless of whether try_to_unmap succeeds
   or fails.

Then the patch will be like:

@@ -883,10 +883,9 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
  			      (void *)&priv);
  	if (ret == 1 && priv.tk.addr)
  		kill_proc(&priv.tk, pfn, flags);
-	else
-		ret = 0;
  	mmap_read_unlock(p->mm);
-	return ret > 0 ? -EHWPOISON : -EFAULT;
+
+	return ret > 0 ? -EHWPOISON : 0;

Here, returning 0 indicates that memory_failure() successfully handled the
error by dropping the clean page.


>>
>> In summary, hwpoison_walk_ops cannot distinguish between try_to_unmap failing
>> and causing the PTE entry not to be set to hwpoison, and a clean page that
>> originally does not have the PTE entry set to hwpoison.
> 
> Is it possible current process is not the one accessing the hwpoisoned page? E.g. memory_failure
> is deferred and called from kworker context or something like that. If it's possible, this is
> another scene needs to be considered.

Yes, it possibale.

But kill_accessing_process() will only be called with MF_ACTION_REQUIRED.
MF_ACTION_REQUIRED indates that current process is exactly the one accesing the
poison data.

Fox x86 platform, GHES driver may queue a kwoker to defer memory_failure() with
flag=0.  So kill_accessing_process() will not be called in such case.

Thanks.
Shuai

