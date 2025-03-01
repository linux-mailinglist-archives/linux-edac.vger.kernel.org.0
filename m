Return-Path: <linux-edac+bounces-3242-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3EEA4A934
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 06:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A9A3BB206
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52571BD9FA;
	Sat,  1 Mar 2025 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FkSNu3gG"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8030442C;
	Sat,  1 Mar 2025 05:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740808454; cv=none; b=X+lXouD/guoYJqt52DYicNeEZ3n/761U/uSx6XmOTJ63Xmg/0CriZPQcF43rOajcz5to2LOsVdI8vUP2IlASozGfzSmPmIksXAB9DApwylBO92OZXCf51re1sJimrnKJ+PnVr/SyQAeCc/tk3cC38eKLBEZXrkm57Wg2/kcWLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740808454; c=relaxed/simple;
	bh=n0KfLE0lUOtf7gNL1UolR8HQMLVPuZskvBP1OiG7xBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foZBBzAD2nWt9QMh7GVyZDbLdr8fjeKpL2p49BFr82j34iAFHCu4pRBUhfbBOZlTjIDrMzj4mbxHWEsowTlOe5f1pQUM7GxnIMcrcTELVitiHeDhtm1HMroye83ZgMZ5YrqFEEg6dufFDDNKsQHrwbPTgsdHtDRelAkesd/N/Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FkSNu3gG; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740808447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=u2eBPXUoeE47ene7JxTrxiOlqV8Ez8vfqaaOsrJND8Q=;
	b=FkSNu3gGpjGVDtF8m0YtrfiXqTow0lnwduRq7u2M5VDp6QjU+4AuS6cu2Ujl5Xq3n64yj/sxtG/gWxlwH/s8F1joWWaJ1SS3+7ZdlcFVh7oqkHMyywUDRH64zbJpxs/s9f7yQ7U/9cWoX4Kn+BaJgyyeBjfaT2lbREaKdB/MCbw=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQRfULE_1740808444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 13:54:05 +0800
Message-ID: <d41853e8-0594-4359-bba7-18969725d8ac@linux.alibaba.com>
Date: Sat, 1 Mar 2025 13:54:03 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
References: <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <SJ1PR11MB60836781C4CE26C4B43AFF0BFCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250219081037.GAZ7WR_YmRtRvN_LKA@fat_crate.local>
 <SJ1PR11MB6083F7AC9C5AED072141B8CAFCC52@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20250220111903.GDZ7cPp1qVq3t9Jgs6@fat_crate.local>
 <SJ1PR11MB608335ACA7AEC51F7F6A75D2FCC42@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4e13bef2-7402-4f75-8f0c-4a3cc210c5a6@linux.alibaba.com>
 <20250224220146.GBZ7zsSnXLftyqWzW_@fat_crate.local>
 <6f34c17c-4113-46d9-aa66-53ff5a1feed5@linux.alibaba.com>
 <20250228123553.GCZ8GtqbSq9kaYOaCi@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250228123553.GCZ8GtqbSq9kaYOaCi@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/28 20:35, Borislav Petkov 写道:
> On Tue, Feb 25, 2025 at 09:51:25AM +0800, Shuai Xue wrote:
>> It depends on the forked process which trying to read the poison.
> 
> And? Can you try creating more processes and see what happens then?
> 

Sure.

The experimental model includes:

1. inject UE to a memory buffer
2. create 10 processes
3. all 10 process read the posioned buffer
4. 10 MCEs and 1 UCNA will be triggered
5. each process receives a SIGBUS

Some details:

#perf record -e probe:memory_failure -agR -- ./einj_mem_uc thread
0: thread   vaddr = 0x7f65f08da400 paddr = 82702ec400
injecting ...
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
>> trigger_thread
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
signal 7 code 4 addr 0x7f65f08da000
page not present
Unusual number of MCEs seen: 10
Test passed
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.640 MB perf.data (11 samples) ]


#perf script
einj_mem_uc 1722254 [151] 695128.161644: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722255 [014] 695128.161712: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722256 [153] 695128.161716: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722257 [124] 695128.161759: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722258 [154] 695128.161782: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722259 [026] 695128.161819: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722260 [157] 695128.161852: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722261 [158] 695128.161895: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

kworker/50:3-mm 1714430 [050] 695128.168736: probe:memory_failure: (ffffffffaa622db4)
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

einj_mem_uc 1722252 [050] 695128.183025: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

einj_mem_uc 1722253 [051] 695128.191348: probe:memory_failure: (ffffffffaa622db4)
         ffffffffaa622db5 memory_failure+0x5 ([kernel.kallsyms])
         ffffffffaa2594fb kill_me_maybe+0x5b ([kernel.kallsyms])
         ffffffffaa2fac29 task_work_run+0x59 ([kernel.kallsyms])
         ffffffffaaf52347 irqentry_exit_to_user_mode+0x1c7 ([kernel.kallsyms])
         ffffffffaaf50bce noist_exc_machine_check+0x3e ([kernel.kallsyms])
         ffffffffaa001303 asm_exc_machine_check+0x33 ([kernel.kallsyms])
                   405046 thread+0xe (/home/shawn.xs/ras-tools/einj_mem_uc)

>> IMHO, we should send a SIGBUS signal to the processes running on the CPUs that
>> detect a memory error for dirty page, which is the current behavior in the
>> memory_failure.
> 
> And for all those other processes which do get to see the already
> poisoned/clean page, they should continue on their merry way instead of
> getting killed by a SIGBUS?
> 

Yes, memory_failure() only sends a SIGBUS signal to the process that
is actively reading a poisoned page. Other processes that share the
poisoned page will not receive a SIGBUS signal unless they have the
PF_MCE_EARLY flag set.[1]

[1]https://lkml.kernel.org/r/20220218090118.1105-4-linmiaohe@huawei.com

Thanks.
Shuai



