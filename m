Return-Path: <linux-edac+bounces-3138-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B884A39E34
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58836188766A
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9B241C90;
	Tue, 18 Feb 2025 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F/e/9K5p"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9617C12E5B;
	Tue, 18 Feb 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887396; cv=none; b=WYQ4mNUeDvP2RMiLWRMy4NAtLSFA3JFRcazAxzM7LZ+blm37+VZGzbQ9tSM+uEu5dsuhrH799+4Du4SnJfDTjO2hkN864iQdJwQaJ5O+Am5R0OGGNkJ9IbnrLCTv5/XDpIDmFlCovcbzswbS1RCvZF1UMzL3cQf6Th/AbqOVCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887396; c=relaxed/simple;
	bh=Q/YzryvaIdViYAFp7IAk8iAJE5zATK7Hu1M9w/i7znY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFQUEt4o6Y9SvCGFPMQML9CpJtDIsasZYh25CjNVP8N6st0W9Pzuy++emPOPmVwUG6cSwjWL0TWt0C0EU4o1hlcgusncYzqEP2AJNvnEmWNWx1+cIy8xb3TnCTXtD3vr9uHDh3R5c98eX8rC2qiOcAVvB3iJVgfvsjYml3oFypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F/e/9K5p; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739887388; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FGxkxMyCr19+prFTLkQbJspUc0S4KTDBWWJMv8u7r+s=;
	b=F/e/9K5pe5tH0MO+is4V1vv3Lu2PeRZoOnXwpuAGYz7tHkpyZ57lKTxwqgOihVNOaIMeRaqVFVkz2L5Oybb+GVx4KScyxKot+KBSaG+1c2O5b21HvG/1DknyJp/cKbb/UgFjU5l2KXcbAuH+Y8cCxFiDiatEFZbFBJEDbtELdio=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPluIKo_1739887384 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 22:03:06 +0800
Message-ID: <88a674d7-4898-4bdd-aba9-65019bc5bb8c@linux.alibaba.com>
Date: Tue, 18 Feb 2025 22:03:02 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, bp@alien8.de, nao.horiguchi@gmail.com,
 tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linmiaohe@huawei.com,
 akpm@linux-foundation.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
 <20250218130202.GG31462@noisy.programming.kicks-ass.net>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218130202.GG31462@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 21:02, Peter Zijlstra 写道:
> On Tue, Feb 18, 2025 at 01:54:08PM +0100, Peter Zijlstra wrote:
> 
>> ---
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index dac4d64dfb2a..cb021058165f 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>   	copy_user  = is_copy_from_user(regs);
>>   	instrumentation_end();
>>   
>> -	switch (fixup_type) {
>> -	case EX_TYPE_UACCESS:
>> -		if (!copy_user)
>> -			return IN_KERNEL;
>> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
>> -		fallthrough;
>> +	if (copy_user) {
>> +		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
> 
> Typing is hard, obviously that second should'be been _RECOV.

Hah, it doesn't matter, I got your point.

> 
>> +		return IN_KERNEL_RECOV
> 
> But why are we having that bit *and* a return value saying the same
> thing?

Yes, it is rather redundant. I can refactor this out if @Borislav is
happy with that.

> 
>> +	}
>>   
>> +	switch (fixup_type) {
>>   	case EX_TYPE_FAULT_MCE_SAFE:
>>   	case EX_TYPE_DEFAULT_MCE_SAFE:
>>   		m->kflags |= MCE_IN_KERNEL_RECOV;

Thanks.
Shuai

