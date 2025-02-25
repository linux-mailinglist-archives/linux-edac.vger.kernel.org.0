Return-Path: <linux-edac+bounces-3197-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD2A432A6
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 02:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16063B67D3
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 01:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE7C101F2;
	Tue, 25 Feb 2025 01:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qvwfQcGc"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59B74059;
	Tue, 25 Feb 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740448295; cv=none; b=vGURk247R3muwCcN1DCWWUsXLf/42KZcjiJqX9OaqVsTtmgQyUu45vXXM/h5ZeTtAoPjhouy5gir4/Tfv5CC8ay5R816taJMIxIf2+tCiE2AIfedmXeF2ke1ajSUnwE5inp8E6kJlvwUpC2pauSMrIMLTQnbyV09X1JApAMj9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740448295; c=relaxed/simple;
	bh=Sk1QTUCGTk72KsMzQM6GlXFASWKIaYnHSoJrWIVnYd4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dmfQDc60M382jXaK+mmNak6n84bCCN+K9244GPOHGYwFDD+/b/p+znn+kad38jJ4BHyKjjgr8ok/n3ozqZrl2kgzfRQF0hGuBon8NtuLUaVaZO/SlcRCDAoQmXvjAYDBIscNR/U1uf91Q7Ztsb6Hdo4tbUDhKAU9DeFgnLVFM38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qvwfQcGc; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740448288; h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type;
	bh=XLFzlWyNgA2NvZExDRHffNi/+7Rg7mFUz7UnwELeKFs=;
	b=qvwfQcGcTaCwMtJlJda33qk4Jj9MBV8TZCmAaT/STfc+l6Ee5sv/iTnBLGevltErPM7ijfuoZj1vsr0EkXIq+bAWie42hx0tJe5ikOlPYI0Nx3ZjxZLERoG0e+Qp301ll6YBFMUEPkrGhdN247+8U6vwnfnfNJo9MfuWt/5H+Ig=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQChn5i_1740448285 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 09:51:27 +0800
Message-ID: <6f34c17c-4113-46d9-aa66-53ff5a1feed5@linux.alibaba.com>
Date: Tue, 25 Feb 2025 09:51:25 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
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
 <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>
 <20250224220146.GBZ7zsSnXLftyqWzW_@fat_crate.local>
In-Reply-To: <20250224220146.GBZ7zsSnXLftyqWzW_@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/25 06:01, Borislav Petkov 写道:
> On Fri, Feb 21, 2025 at 02:05:28PM +0800, Shuai Xue wrote:
>> #perf script
>> kworker/48:1-mm 25516 [048]  1713.893549: probe:memory_failure: (ffffffffaa622db4)
>>          ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>>          ffffffffaa25aa93 uc_decode_notifier+0x73 ([kernel.kallsyms])
>>          ffffffffaa3068bb notifier_call_chain+0x5b ([kernel.kallsyms])
>>          ffffffffaa306ae1 blocking_notifier_call_chain+0x41 ([kernel.kallsyms])
>>          ffffffffaa25bbfe mce_gen_pool_process+0x3e ([kernel.kallsyms])
>>          ffffffffaa2f455f process_one_work+0x19f ([kernel.kallsyms])
>>          ffffffffaa2f509c worker_thread+0x20c ([kernel.kallsyms])
>>          ffffffffaa2fec89 kthread+0xd9 ([kernel.kallsyms])
>>          ffffffffaa245131 ret_from_fork+0x31 ([kernel.kallsyms])
>>          ffffffffaa2076ca ret_from_fork_asm+0x1a ([kernel.kallsyms])
>>
>> einj_mem_uc 44530 [184]  1713.908089: probe:memory_failure: (ffffffffaa622db4)
>>          ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>>          ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
>>          ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
>>          ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
>>          ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
>>          ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
>>                    405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)
>>
>> einj_mem_uc 44531 [089]  1713.916319: probe:memory_failure: (ffffffffaa622db4)
>>          ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
>>          ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
>>          ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
>>          ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
>>          ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
>>          ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
>>                    405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)
> 
> What are those stack traces supposed to say?
> 
> Two processes are injecting, cause a #MC and a kworker gets to handle the UC?
> 
> All injecting to the same page?

Yes, I inject poison to a page and create two process with pthread_create() which
trigger the same poison page.

> 
> What's the upper limit on CPUs seeing the same hw error and all raising
> a CMCI/#MC?

It depends on the forked process which trying to read the poison.

> 
>> - kill_accessing_process() is only called when the flags are set to
>>    MF_ACTION_REQUIRED, which means it is in the MCE path.
>> - Whether the page is clean determines the behavior of try_to_unmap. For a
>>    dirty page, try_to_unmap uses TTU_HWPOISON to unmap the PTE and convert the
>>    PTE entry to a swap entry. For a clean page, try_to_unmap uses ~TTU_HWPOISON
>>    and simply unmaps the PTE.
>> - When does walk_page_range() with hwpoison_walk_ops return 1?
>>    1. If the poison page still exists, we should of course kill the current
>>       process.
>>    2. If the poison page does not exist, but is_hwpoison_entry is true, meaning
>>       it is a dirty page, we should also kill the current process, too.
>>    3. Otherwise, it returns 0, which means the page is clean.
> 
> I think you're too deep into detail. What I'd do is step back, think what
> would be the *proper* recovery action and then make sure memory_failure does
> that. If it doesn't - fix it to do so.
> 
> So, what should really happen wrt recovery action if any number of CPUs see
> the same memory error?
> 

IMHO, we should send a SIGBUS signal to the processes running on the CPUs that
detect a memory error for dirty page, which is the current behavior in the
memory_failure.

Thanks
Shuai

