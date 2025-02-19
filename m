Return-Path: <linux-edac+bounces-3151-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61966A3B740
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 10:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E843A9920
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 09:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AE51E51EA;
	Wed, 19 Feb 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fJ7KdH/K"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF221E503C;
	Wed, 19 Feb 2025 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739955265; cv=none; b=YDzzBOF7DWmwL2wLhb3EZyu6FpP6ry7QzuNJfvbur5IwH3j1oZg4Bw8OuPza5HGVwLbeX4SG6ZDlDediIf+ruy+2hW28P+SV7QnrLRqPnOHG2QrN4X2Oq3nci2ARGtDSN9BMwYLe6v+bPqkO5lmxVf+4UcTegTmbP3k+WH5Y0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739955265; c=relaxed/simple;
	bh=WbVaw2/nHiWPAhg2Q5UF4l7mCXnfTdBf8CKGlpNFqWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LsOHJSQLG0SwzDgFnvkXkbm51DLn51a7pv/ibTEN/M+mtQ2ZOujvPr60jy4NnWeUVt/51mKBtWBV9+h84/mD3ptyZPIM4mzurHZI3iiDDSeZ/HjQ3fUnQTQjkfcYxi5QxaSoiQ7R0cB9VTNzrDf/SDsl5zNpW2Zrd/okptxZ4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fJ7KdH/K; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739955257; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/XNFU2Vaq0TopySEX+e+5ydilqlPx+5/Lqq5YswmjCo=;
	b=fJ7KdH/KwGsWmCoFasmc0bfMTFXFLdHq+P0ppH+zTtQrkWYAuZWqMNiBFOGAzIoAYQMgxOnNd7DQs3LKxd1HajrK1XFdd7stn2opcdRVfMuLlff0hBYYNkmxq7KC6UJdFTSNLIlMwLIZx/3n6Qnn8ahwrpqniuMOi947/75R2rE=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPoiyp9_1739955255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 16:54:16 +0800
Message-ID: <be78641b-becc-4cdb-a90e-574734638869@linux.alibaba.com>
Date: Wed, 19 Feb 2025 16:54:14 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] mm/hwpoison: Fix incorrect "not recovered" report
 for recovered clean pages
To: Miaohe Lin <linmiaohe@huawei.com>, "Luck, Tony" <tony.luck@intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
 peterz@infradead.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 tony.luck@intel.com, bp@alien8.de, nao.horiguchi@gmail.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-5-xueshuai@linux.alibaba.com>
 <ddd769c2-a17d-9e34-822d-66f72bd654ac@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <ddd769c2-a17d-9e34-822d-66f72bd654ac@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 14:34, Miaohe Lin 写道:
> On 2025/2/17 14:33, Shuai Xue wrote:
>> When an uncorrected memory error is consumed there is a race between
>> the CMCI from the memory controller reporting an uncorrected error
>> with a UCNA signature, and the core reporting and SRAR signature
>> machine check when the data is about to be consumed.
>>
>> If the CMCI wins that race, the page is marked poisoned when
>> uc_decode_notifier() calls memory_failure(). For dirty pages,
>> memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
>> converting the PTE to a hwpoison entry. As a result,
>> kill_accessing_process():
>>
>> - call walk_page_range() and return 1 regardless of whether
>>    try_to_unmap() succeeds or fails,
>> - call kill_proc() to make sure a SIGBUS is sent
>> - return -EHWPOISON to indicate that SIGBUS is already sent to the
>>    process and kill_me_maybe() doesn't have to send it again.
>>
>> However, for clean pages, the TTU_HWPOISON flag is cleared, leaving the
>> PTE unchanged and not converted to a hwpoison entry. Conversely, for
>> clean pages where PTE entries are not marked as hwpoison,
>> kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to
>> send a SIGBUS.
>>
>> Console log looks like this:
>>
>>      Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
>>      Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
>>      Memory failure: 0x827ca68: already hardware poisoned
>>      mce: Memory error not recovered
>>
>> To fix it, return 0 for "corrupted page was clean", preventing an
>> unnecessary SIGBUS.
>>
>> Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Cc: stable@vger.kernel.org
>> ---
>>   mm/memory-failure.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 995a15eb67e2..b037952565be 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -881,12 +881,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
>>   	mmap_read_lock(p->mm);
>>   	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
>>   			      (void *)&priv);
>> +	/*
>> +	 * ret = 1 when CMCI wins, regardless of whether try_to_unmap()
>> +	 * succeeds or fails, then kill the process with SIGBUS.
>> +	 * ret = 0 when poison page is a clean page and it's dropped, no
>> +	 * SIGBUS is needed.
>> +	 */
>>   	if (ret == 1 && priv.tk.addr)
>>   		kill_proc(&priv.tk, pfn, flags);
>> -	else
>> -		ret = 0;
>>   	mmap_read_unlock(p->mm);
>> -	return ret > 0 ? -EHWPOISON : -EFAULT;
>> +
>> +	return ret > 0 ? -EHWPOISON : 0;
> 
> The caller kill_me_maybe will do set_mce_nospec + sync_core again.
> 
> static void kill_me_maybe(struct callback_head *cb)
> {
> 	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
> 	int flags = MF_ACTION_REQUIRED;
> 	...
> 	ret = memory_failure(pfn, flags);
> 	if (!ret) {
> 		set_mce_nospec(pfn);
> 		sync_core();
> 		return;
> 	}
> 
> Is this expected?
> 

the second set_mce_nospec do nothing and have no side affect.

sync_core() is introduced by Tony [1]:

Also moved sync_core(). The comments for this function say that it should
only be called when instructions have been changed/re-mapped. Recovery for
an instruction fetch may change the physical address. But that doesn't happen
until the scheduled work runs (which could be on another CPU).

[1]https://lore.kernel.org/all/20200824221237.5397-1-tony.luck@intel.com/T/#u

IMHO, I think it also has no side affect.

@Tony, could you help to confirm this?

Thank.
Shuai




