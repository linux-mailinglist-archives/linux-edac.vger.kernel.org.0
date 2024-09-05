Return-Path: <linux-edac+bounces-1817-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C34896CD07
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 05:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321831F2982F
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 03:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83678140E30;
	Thu,  5 Sep 2024 03:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BAxgEyN2"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223C25634;
	Thu,  5 Sep 2024 03:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505802; cv=none; b=Dq+7JeDfO6kDPzP0Sj1ix2LvyFIWpXMgZAkkCnmXLIAkV9NXBsOEK81ycEYGgYK8YEK+vdviIKQFbKxR9AizZmYq8nXy0weTsoNSng/cUkIQEYrFrNVpy2fNYaCXbYUxex5bqLZZ79Le07wfXBIHcqzq/cTz0WNd+dIh0S8OuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505802; c=relaxed/simple;
	bh=iXpc5nwT9T8D773UI6C/JrWPJ2zYuJYUq2vKFdkUIb8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBRXjXcFSefk0zT4ZgfMoTIADwMgg+18HK8Vo7sVuELM1p1MC5t2hQf2O+yGAxPrVBhYcJ0nzEKXvEEOxWnOp1KV5MJGju/FpRC90OVEP44bc27LtIhPwEOvbjvJjsC7S4QK2T/JyBuZEvItH6oWdbnY8Ceuwm1dVj2JD0u6WEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BAxgEyN2; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505797; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EEK3tU0+O04g/bTYssKY4oUfiGHLfHkoGwUrwDWQSJo=;
	b=BAxgEyN2X8Qmzl+WgU/TJczxDcEwwwzEuX/aEs80gX4BJ9mq8b7mFyls/gkwj99naX/V3tlg+xGjtuppdFqfLj/TORzMv5320uX3IZE81c3SfrDqWOle0gU/yxObmmnAmF1cNBKs7L1vgRmZz+K1QTwKN60I5/VW8aVwmTiL/R8=
Received: from 30.246.162.144(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WEJd2C3_1725505794)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:09:55 +0800
Message-ID: <d539c09c-4064-4511-9a1e-cff51b1f35f4@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:09:53 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/3] ACPI: APEI: handle synchronous exceptions in task
 work
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
 <20240902030034.67152-4-xueshuai@linux.alibaba.com>
 <D3WS4D64BTGD.217F1PPA4VQSF@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <D3WS4D64BTGD.217F1PPA4VQSF@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/4 00:11, Jarkko Sakkinen 写道:
> On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
>> The memory uncorrected error could be signaled by asynchronous interrupt
>> (specifically, SPI in arm64 platform), e.g. when an error is detected by
>> a background scrubber, or signaled by synchronous exception
>> (specifically, data abort excepction in arm64 platform), e.g. when a CPU
>> tries to access a poisoned cache line. Currently, both synchronous and
>> asynchronous error use memory_failure_queue() to schedule
>> memory_failure() exectute in kworker context.
>>
>> As a result, when a user-space process is accessing a poisoned data, a
>> data abort is taken and the memory_failure() is executed in the kworker
>> context:
>>
>>    - will send wrong si_code by SIGBUS signal in early_kill mode, and
>>    - can not kill the user-space in some cases resulting a synchronous
>>      error infinite loop
>>
>> Issue 1: send wrong si_code in early_kill mode
>>
>> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
>> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
>> could be used to determine whether a synchronous exception occurs on
>> ARM64 platform.  When a synchronous exception is detected, the kernel is
>> expected to terminate the current process which has accessed poisoned
>> page. This is done by sending a SIGBUS signal with an error code
>> BUS_MCEERR_AR, indicating an action-required machine check error on
>> read.
>>
>> However, when kill_proc() is called to terminate the processes who have
>> the poisoned page mapped, it sends the incorrect SIGBUS error code
>> BUS_MCEERR_AO because the context in which it operates is not the one
>> where the error was triggered.
>>
>> To reproduce this problem:
>>
>>    # STEP1: enable early kill mode
>>    #sysctl -w vm.memory_failure_early_kill=1
>>    vm.memory_failure_early_kill = 1
>>
>>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 5 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
>> error and it is not fact.
>>
>> To fix it, queue memory_failure() as a task_work so that it runs in
>> the context of the process that is actually consuming the poisoned data.
>>
>> After this patch set:
> 
> s/patch set/patch/
> 

Hi, Jarkko,

Will fix the typo in next version.

Thank you.

Best Regards,
Shuai

