Return-Path: <linux-edac+bounces-3178-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB81A3EC85
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 07:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C11176EF6
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B761FBE8B;
	Fri, 21 Feb 2025 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OlmLdicA"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144133EA;
	Fri, 21 Feb 2025 06:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740117945; cv=none; b=q4g0N2YeZ65DMhd5530R0lYxg9LvQzvyBKjwogRschZobaD1DqrTE6gh3gdmpRU4+FS1j5bsTGcmxL7y5eeFeu95NYM73/7CNxfQdGCFIGuElLqd7Jh6ZFUxej66w5dUvpOchFvNG91OtKsXP9UoeUZrirjbSUjVODAur9jk3QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740117945; c=relaxed/simple;
	bh=J3mDJulnb6FnRs899YTmjo/m9SPZmEhUtyJTy+J1Zkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DixwaKpZZlcCPsJGxLNs3DLwy5qJvotFLF547Sz1EtkKFgccdglOqeRslz0ksf8Psoy6ElLxGfUDk8CK8i1fj5Ty/4EmGQBzQP2RMkbHjfCaoPIy8yxIW64OwDXSveuKfkV8sULlpIQvakafmfCLrKJI43Qj1PcWe/VFoghvQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OlmLdicA; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740117932; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RIQVHMJ2EOCtMNc/t3pzTdzMfo+2yjnJUkeVVbernOw=;
	b=OlmLdicANherrU9AnCn+sibjtWJ0ATqciuoxTmmOZqfXydgGTUxqGeuSi3ts3eIbBpGLihWYFrFZ5VOfJcq/Te95maaVjdTikcwR4tGoDEN73Bz6t9/95JP7ABmLaCk3yLaqROjcRcU3VmKseiwi/dbqkJEGoZvdqpkyz8l2zC4=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPvDVI8_1740117929 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 14:05:31 +0800
Message-ID: <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>
Date: Fri, 21 Feb 2025 14:05:28 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
 <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/21 01:50, Luck, Tony 写道:
>>> We could, but I don't like it much. By taking the page offline from the relatively
>>> kind environment of a regular interrupt, we often avoid taking a machine check
>>> (which is an unfriendly environment for software).
>>
>> Right.
>>
>>> We could make the action in uc_decode_notifier() configurable. Default=off
>>> but with a command line option to enable for systems that are stuck with
>>> broadcast machine checks.
>>
>> So we can figure that out during boot - no need for yet another cmdline
>> option.
> 
> Yup. I think the boot time test might be something like:
> 
> 	// Enable UCNA offline for systems with broadcast machine check
> 	if (!(AMD || LMCE))
> 		mce_register_decode_chain(&mce_uc_nb);
>>
>> It still doesn't fix the race and I'd like to fix that instead, in the optimal
>> case.
>>
>> But looking at Shuai's patch, I guess fixing the reporting is fine too - we
>> need to fix the commit message to explain why this thing even happens.
>>
>> I.e., basically what you wrote and Shuai could use that explanation to write
>> a commit message explaining what the situation is along with the background so
>> that when we go back to this later, we will actually know what is going on.
> 
> Agreed. Shaui needs to harvest this thread to fill out the details in the commit
> messages.

Sure, I'd like to add more backgroud details with Tony's explanation.

> 
>>
>> But looking at
>>
>>    046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
>>
>> That thing was trying to fix the same reporting fail. Why didn't it do that?
>>
>> Ooooh, now I see what the issue is. He doesn't want to kill the process which
>> gets the wrong SIGBUS. Maybe the commit title should've said that:
>>
>>    mm/hwpoison: Do not send SIGBUS to processes with recovered clean pages
>>
>> or so.
>>
>> But how/why is that ok?
>>
>> Are we confident that
>>
>> +        * ret = 0 when poison page is a clean page and it's dropped, no
>> +        * SIGBUS is needed.
>>
>> can *always* and *only* happen when there's a CMCI *and* a #MC race and the
>> CMCI has won the race?
> 
> There are probably other races. Two CPUs both take local #MC on the same page
> (maybe not all that rare in threaded processes ... or even with some hot code in
> a shared library).
> 
>> Can memory poison return 0 there too, for another reason and we end up *not
>> killing* a process which we should have?
>>
>> Hmmm.
> 
> Hmmm indeed. Needs some thought. Though failing to kill a process likely means
> it retries the access and comes right back to try again (without the race this time).
> 

Emmm, if two threaded processes consume a poisond data, there may three CPUs
race, two of which take local #MC on the same page and one take CMCI. For,
example:

#perf script
kworker/48:1-mm 25516 [048]  1713.893549: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa25aa93 uc_decode_notifier+0x73 ([kernel.kallsyms])
         ffffffffaa3068bb notifier_call_chain+0x5b ([kernel.kallsyms])
         ffffffffaa306ae1 blocking_notifier_call_chain+0x41 ([kernel.kallsyms])
         ffffffffaa25bbfe mce_gen_pool_process+0x3e ([kernel.kallsyms])
         ffffffffaa2f455f process_one_work+0x19f ([kernel.kallsyms])
         ffffffffaa2f509c worker_thread+0x20c ([kernel.kallsyms])
         ffffffffaa2fec89 kthread+0xd9 ([kernel.kallsyms])
         ffffffffaa245131 ret_from_fork+0x31 ([kernel.kallsyms])
         ffffffffaa2076ca ret_from_fork_asm+0x1a ([kernel.kallsyms])

einj_mem_uc 44530 [184]  1713.908089: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 44531 [089]  1713.916319: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

It seems to complicate the issue further.

IMHO, we should focus on three main points:

- kill_accessing_process() is only called when the flags are set to
   MF_ACTION_REQUIRED, which means it is in the MCE path.
- Whether the page is clean determines the behavior of try_to_unmap. For a
   dirty page, try_to_unmap uses TTU_HWPOISON to unmap the PTE and convert the
   PTE entry to a swap entry. For a clean page, try_to_unmap uses ~TTU_HWPOISON
   and simply unmaps the PTE.
- When does walk_page_range() with hwpoison_walk_ops return 1?
   1. If the poison page still exists, we should of course kill the current
      process.
   2. If the poison page does not exist, but is_hwpoison_entry is true, meaning
      it is a dirty page, we should also kill the current process, too.
   3. Otherwise, it returns 0, which means the page is clean.


Thanks.
Shuai

