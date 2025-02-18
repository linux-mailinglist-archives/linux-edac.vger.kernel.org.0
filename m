Return-Path: <linux-edac+bounces-3132-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E42A39D0B
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304BF188BABC
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219CB266F12;
	Tue, 18 Feb 2025 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="te4yLQt3"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3F14B08E;
	Tue, 18 Feb 2025 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884116; cv=none; b=eGGBk3x4IWk5J6XuFGzCtOzXugVzgWOW0RS0qURWrTCICQviA+6+HfmhmwWeubF1+M/1Qjdsdoa6NzRN1ouGiYgWqbpzbHWwpDRbVOKvzYQLnvQAHpmccyRcL1DoBDkg/ayy1nnLFVJPmfd9+Oh77oGK3qztGqIcQj9/2IR48QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884116; c=relaxed/simple;
	bh=zUGJQYvkoYyUTwZAaC2dBc9u4vBNL9q0NxuPj2rPCF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DG5BpWvbbsELgjQif7ma+b++GZTLzExAdRUsosQiRZDAJ23iuiecdMJ1yT/JOfVDg3111Mig0SHd63vUrbYyc8VWAYRfiJmR67m/BHNnB0RLTB4fzpKbyMtqkibtY25GLkp9Yhhx/REa/3SC4JtJ7AX+WYBTKz3UW0IY7ys+nAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=te4yLQt3; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739884109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TbbAJDp0lKjl1Ir7re/8wHjJPIfZzfK9AVrTv+4wnSo=;
	b=te4yLQt3IkVitrMmD8NtCuyfHcUOstyhxIqy2jCUbQqE1F7VU3NMGpvlyvyBPvU2Ro1pP9tF7xk8wXsWu71Za+zYRjkW+CqzyEFmqGnw1SgWBhibUWOYMmd9t4HewKD5TDOwiw6WYjr/9ZxA7gzmsbNKxeES+IEaM3kYMWG/YGA=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPlu2WV_1739884106 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 21:08:27 +0800
Message-ID: <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
Date: Tue, 18 Feb 2025 21:08:25 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
To: Borislav Petkov <bp@alien8.de>, tony.luck@intel.com
Cc: nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linmiaohe@huawei.com, akpm@linux-foundation.org, peterz@infradead.org,
 jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 20:24, Borislav Petkov 写道:
> On Tue, Feb 18, 2025 at 07:31:34PM +0800, Shuai Xue wrote:
>> Kernel can recover from poison found while copying from user space.
> 
> Where was that poison found? On user pages? So reading them consumes the
> poison?

Yes, the poison is found on user pages.

Form commit log, the mechanism is added by Tony and suggested by you.
https://lkml.kernel.org/r/20210818002942.1607544-3-tony.luck@intel.com

> 
> So you're not really seeing real issues on real hw - you're using ras tools to
> trigger those, correct?
> 
> If so, what guarantees ras tools are doing the right thing?

Ras-tools do it by three step:

- alloc memory in userspace
- inject two bit ECC error (uncorretable error) to the memory (by EINJ interface)
- write the memory to a file fd ( by write(2) )

It's the same as with real issue. There's no magic to it.

Doesn't AMD support it?

> 
>> MCE check the fixup handler type to decide whether an in kernel #MC can be
>> recovered.  When EX_TYPE_UACCESS is found,
> 
> Sounds like poison on user memory...

Yes, sorry for confusion.

> 
>> the PC jumps to recovery code specified in _ASM_EXTABLE_FAULT() and return
>> a -EFAULT to user space.
> 
>> For instr case:
>>
>> If a poison found while instruction fetching in user space, full recovery is
>> possible. User process takes #PF, Linux allocates a new page and fills by
>> reading from storage.
>>
>>> 3. What actually happens and why
>>
>> For copyin case: kernel panic since v5.17
>>
>> Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new extable
>> fixup type, EX_TYPE_EFAULT_REG, and later patches updated the extable fixup
>> type for copy-from-user operations, changing it from EX_TYPE_UACCESS to
>> EX_TYPE_EFAULT_REG.
> 
> What do futexes have to do with copying user memory?

Return -EFAULT to userspace.

> 
>> For instr case: user process is killed by a SIGBUS signal
>>
>> Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported "not
>> recovered"") introduced a bug that kill_accessing_process() return -EHWPOISON
>> for instr case, as result, kill_me_maybe() send a SIGBUS to user process.
> 
> This makes my head hurt... a race between the CMCI reporting an uncorrected
> error... why does the CMCI report uncorrected errors? This sounds like some
> nasty confusion.
> 
> And you've basically reused the format and wording of 046545a661af for your
> commit message and makes staring at those a PITA.
> 
> Tony, what's going on with that CMCI and SRAR race?
> 

I try to answer why the CMCI reporting an uncorrected error. Tony, please
correct me if I missed anyting.

When core issue a memory to a memory controller finds a 2 bit ECC error, it
will pass data with a poison flag through bus.

1. Home Agent logs UNCA error and signals CMCI ifenable.
2. Home Agent forwards data with poison indication bit set.
3. DCU detects the posion data, logs SRAR eror and triggers #MCE if recoverable.


Thanks.
Shuai

