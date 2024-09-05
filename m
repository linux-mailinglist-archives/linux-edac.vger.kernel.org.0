Return-Path: <linux-edac+bounces-1816-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA796CCFD
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 05:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E30E1F28C9E
	for <lists+linux-edac@lfdr.de>; Thu,  5 Sep 2024 03:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE8D1482FE;
	Thu,  5 Sep 2024 03:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="HO0RoLPt"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6DA13B293;
	Thu,  5 Sep 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725505708; cv=none; b=q/zhph9bMXZZ1eAIsr1dhUkCYFr+b3T1KPdNSM/22i/ES9rPW2HtLOUrSsOoMc3FP9zchRMCqNyItZAIrTTaZNS+pZqftuB45h7grUwCvrjLQCQ/cwVmq9TIvUZEQkMGX/aApfBPPPsFEF8cY3hOrzFvs/iGXt8NfIXCj762T50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725505708; c=relaxed/simple;
	bh=4WJBHv2JKuBgtkRGcG2/w3ZQhO5vK8S09DHEyQPXGiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DogQjhTVnaubDHBmsrF9FBXW1aHWRVZfCqSkl2jiaENzXFR2hKcKUTNlwW+OFJHIw24Q79H6z1ki4pF2UDEKiLo32FEtIFYFQI6U600H0etN1Dy5QFOV2al/NS/WH1XxeTbi/aIQhxhET8ilmclHMzmFeWWigIfBloocee7RRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=HO0RoLPt; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725505704; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jV2+cn/4uNfPspURtuX++pQoMUnXb+at2wi4UK8kjLc=;
	b=HO0RoLPtq1OPCGowW32Xc6MlKKCesvHDPhWKVImWE+7yjrDUzrPFdhQoQVxN5YnFF+szf69QTUN5VhC5eeLo3nXCNfBqlD8ZL7l7FTshxqMzocJph4CCysmNWnhd1PhI8q2b1IdrqSMmhEEyK7qN7ff/q8vpQppXHi0ebfklu5A=
Received: from 30.246.162.144(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WEJd1a5_1725505701)
          by smtp.aliyun-inc.com;
          Thu, 05 Sep 2024 11:08:22 +0800
Message-ID: <b255fe54-4595-487c-b516-d812798e4838@linux.alibaba.com>
Date: Thu, 5 Sep 2024 11:08:20 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/3] mm: memory-failure: move return value
 documentation to function declaration
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
 <20240902030034.67152-3-xueshuai@linux.alibaba.com>
 <D3WS3TK054QR.580Q46WYCDEZ@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <D3WS3TK054QR.580Q46WYCDEZ@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/4 00:10, Jarkko Sakkinen 写道:
> On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c | 7 -------
>>   mm/memory-failure.c            | 9 ++++++---
>>   2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index b85ec7a4ec9e..66693b6dd1cd 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1361,13 +1361,6 @@ static void kill_me_maybe(struct callback_head *cb)
>>   		return;
>>   	}
>>   
>> -	/*
>> -	 * -EHWPOISON from memory_failure() means that it already sent SIGBUS
>> -	 * to the current process with the proper error info,
>> -	 * -EOPNOTSUPP means hwpoison_filter() filtered the error event,
>> -	 *
>> -	 * In both cases, no further processing is required.
>> -	 */
>>   	if (ret == -EHWPOISON || ret == -EOPNOTSUPP)
>>   		return;
>>   
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 7066fc84f351..df26e2ff5e06 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2199,9 +2199,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>    * Must run in process context (e.g. a work queue) with interrupts
>>    * enabled and no spinlocks held.
>>    *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return values:
> 
> s/Return values/Return:/
> 
> https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
> 

Hi, Jarkko,

Thank you for the reminder. Will fix it in next version.

Best Regards,
Shuai


