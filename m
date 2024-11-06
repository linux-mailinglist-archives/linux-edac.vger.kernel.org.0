Return-Path: <linux-edac+bounces-2456-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DAE9BDE9B
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 07:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9C4282010
	for <lists+linux-edac@lfdr.de>; Wed,  6 Nov 2024 06:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAC21922E1;
	Wed,  6 Nov 2024 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bA5Wgbxz"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F048D1922D8;
	Wed,  6 Nov 2024 06:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730873553; cv=none; b=RLgzTwDC7ULh444A8Ap+5bIqPxboBTdO+HYc9lAwg0btd7jsO11eBXzMacHFHom7DJM1vIgzPhzYmfA7cCDgFIqwmfsSCbL6AjqtWeznigBTboAz+uP8KScGWsL4/MhCOtMDZVH5FIfgJ5ecGNc0/9Ap3euTgW0HYRT06vjIaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730873553; c=relaxed/simple;
	bh=D0JUw2XPORngfrUnmh8daZdEZBtqjSX+Eg0u7JDObeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3RgcA3G9/9tUy85uQT/q3HAAVOugz0ZnLYChNc5Y+eJpkG5+U1+OgS4ZGtks/zAd33WCDNmKM4duFvG0hwbnk+fc3v/5HDxPgNv5jIZ14ChzjM7eGmOhcud1maNWoJVVYKHV0rT1Hr5h+a3vAOPKZHWL/qf44cNLxlu/kPh0H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bA5Wgbxz; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730873542; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F1x8diBjxJZ/wui4j6BD6zQoh/rM6nkCqZnmZjoErlo=;
	b=bA5WgbxzsEjmnuiwqp+S1YnVdLU6xmpUJqru8ye8glTWbTLwYPbL11IR4s2mU5rp8NpM8FRF2+aYM8DaErDKvaLxV/Ae5QiMLAjAIkMEPx5Pq/WmnRUogUQAK3dyJqpq/yeC08qBr3eqTJQB+FeaAU5KkeT221MiIh2ow278cXE=
Received: from 30.246.162.170(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIqAQVZ_1730873538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 14:12:19 +0800
Message-ID: <4decd52b-a2c9-4e04-9793-4d1553689b92@linux.alibaba.com>
Date: Wed, 6 Nov 2024 14:12:17 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 2/3] mm: memory-failure: move return value
 documentation to function declaration
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241104015430.98599-3-xueshuai@linux.alibaba.com>
 <20241105151847.GF916505@yaz-khff2.amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241105151847.GF916505@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/5 23:18, Yazen Ghannam 写道:
> On Mon, Nov 04, 2024 at 09:54:29AM +0800, Shuai Xue wrote:
>> Part of return value comments for memory_failure() were originally
>> documented at the call site. Move those comments to the function
>> declaration to improve code readability and to provide developers with
>> immediate access to function usage and return information.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c | 7 -------
>>   mm/memory-failure.c            | 9 ++++++---
>>   2 files changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 2a938f429c4d..c90d8fcd246a 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1373,13 +1373,6 @@ static void kill_me_maybe(struct callback_head *cb)
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
>> index 96ce31e5a203..1c5098f32d48 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2209,9 +2209,12 @@ static void kill_procs_now(struct page *p, unsigned long pfn, int flags,
>>    * Must run in process context (e.g. a work queue) with interrupts
>>    * enabled and no spinlocks held.
>>    *
>> - * Return: 0 for successfully handled the memory error,
>> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
>> - *         < 0(except -EOPNOTSUPP) on failure.
>> + * Return:
>> + *   0             - success,
> 
> One more obvious one from this function:
> 
> 	-ENXIO        - memory not managed by the kernel

Yes, will fix it.

> 
>> + *   -EOPNOTSUPP   - hwpoison_filter() filtered the error event,
>> + *   -EHWPOISON    - the page was already poisoned, potentially
>> + *                   kill process,
>> + *   other negative values - failure.
>>    */
>>   int memory_failure(unsigned long pfn, int flags)
>>   {
>> -- 
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen

Thank you for valuable comments.
Shuai

