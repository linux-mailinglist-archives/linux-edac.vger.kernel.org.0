Return-Path: <linux-edac+bounces-3135-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D660DA39D87
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139B21894AF4
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D46726E64B;
	Tue, 18 Feb 2025 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uwF7svuu"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09C26E152;
	Tue, 18 Feb 2025 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885329; cv=none; b=kh6BzbRSr8RJHTRZCrxtdtQS/lP83zHtN2/tP37+1nRcCkssKPJzIcWOUuYbZygUeqykJByhmXVdsjOjQRqmpV8i+XpM/h0FnsN17RH04KROBPqtVJfpZ0Rv5O8BEaQZpM3sDZDQ2m/TPij6f9fGlUcSkrpfLby0tJdHrbIBKpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885329; c=relaxed/simple;
	bh=hU3cyUTbcCnOC4Ck5W+EqPKAWf9MZ2HjG3H3gIuscbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJ4UyEyXRFaUoKtM04KnkkIylDxt5lzH6uVlPmsbfCq9S3uxl6g1gFwMPce9OFaRrwsWxZuys6apnFLoZm+CoJN7Hd/pTbEkKg6ICswy81EO399RbEnr8TvTubATRKacY7F4KymBC9AGQ2UvquQ+GcnVt4fULC2b8LgiIl18Yls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uwF7svuu; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739885317; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Y5AyiJ/PFt2OYj7VTelaJEhdAfegG77Q/50N6RHUleo=;
	b=uwF7svuu1Jde0U6ruCv/NcbMWPtPF1G6RKA6kZGGIG3HZFxEnwik09jAv2+eb2IEIEcigKS0wr2XdTlmz7NKNhVdyqJF+YuRFYa8c3rlzqFc5HznHlnlPeNDCrYdxMJ8DCjc1k+eO77685Zd+egpddlJBP0u3rZH2RHaJzgYKrw=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPlxWAh_1739885314 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 21:28:35 +0800
Message-ID: <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>
Date: Tue, 18 Feb 2025 21:28:33 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
To: Peter Zijlstra <peterz@infradead.org>
Cc: tony.luck@intel.com, bp@alien8.de, nao.horiguchi@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linmiaohe@huawei.com,
 akpm@linux-foundation.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218125408.GD40464@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Peter

在 2025/2/18 20:54, Peter Zijlstra 写道:
> On Mon, Feb 17, 2025 at 02:33:33PM +0800, Shuai Xue wrote:
> 
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index dac4d64dfb2a..14c2d71c3ce1 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -16,6 +16,7 @@
>>   #include <asm/traps.h>
>>   #include <asm/insn.h>
>>   #include <asm/insn-eval.h>
>> +#include <linux/extable.h>
>>   
>>   #include "internal.h"
>>   
>> @@ -285,7 +286,8 @@ static bool is_copy_from_user(struct pt_regs *regs)
>>    */
>>   static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   {
>> -	int fixup_type;
>> +	const struct exception_table_entry *e;
>> +	int fixup_type, imm;
>>   	bool copy_user;
>>   
>>   	if ((m->cs & 3) == 3)
>> @@ -294,9 +296,14 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   	if (!mc_recoverable(m->mcgstatus))
>>   		return IN_KERNEL;
>>   
>> +	e = search_exception_tables(m->ip);
>> +	if (!e)
>> +		return IN_KERNEL;
> 
> You didn't actually build this, did you? Or did you ignore the extra
> noinstr warnings?

I did build and test this patch set on it. But I did not find any warnings.
Could you provide more details?

> 
>>   	/* Allow instrumentation around external facilities usage. */
>>   	instrumentation_begin();
>> -	fixup_type = ex_get_fixup_type(m->ip);
>> +	fixup_type = FIELD_GET(EX_DATA_TYPE_MASK, e->data);
>> +	imm  = FIELD_GET(EX_DATA_IMM_MASK,  e->data);
>>   	copy_user  = is_copy_from_user(regs);
>>   	instrumentation_end();
>>   
>> @@ -304,9 +311,13 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   	case EX_TYPE_UACCESS:
>>   		if (!copy_user)
>>   			return IN_KERNEL;
>> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
>> -		fallthrough;
>> -
>> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
>> +		return IN_KERNEL_RECOV;
>> +	case EX_TYPE_IMM_REG:
>> +		if (!copy_user || imm != -EFAULT)
>> +			return IN_KERNEL;
>> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;
>> +		return IN_KERNEL_RECOV;
> 
> Maybe I'm justnot understanding things, but what's wrong with something
> like the below; why do we care about the ex-type if we know its a MOV
> reading from userspace?
> 
> The less we muck about with the extable here, the better.

We need to make sure that we have register a fixup handler for the copy_user
case.  If no fixup handler found, the PC accessing posion will trigger #MCE
again and again resulting a hardlock up.

> 
> ---
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index dac4d64dfb2a..cb021058165f 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>   	copy_user  = is_copy_from_user(regs);
>   	instrumentation_end();
>   
> -	switch (fixup_type) {
> -	case EX_TYPE_UACCESS:
> -		if (!copy_user)
> -			return IN_KERNEL;
> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
> -		fallthrough;
> +	if (copy_user) {
> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
> +		return IN_KERNEL_RECOV
> +	}
>   
> +	switch (fixup_type) {
>   	case EX_TYPE_FAULT_MCE_SAFE:
>   	case EX_TYPE_DEFAULT_MCE_SAFE:
>   		m->kflags |= MCE_IN_KERNEL_RECOV;

Thanks.
Shuai

