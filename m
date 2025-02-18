Return-Path: <linux-edac+bounces-3128-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75875A39B08
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 12:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A94218952F9
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556B23ED76;
	Tue, 18 Feb 2025 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vtiQGfvg"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED7241127;
	Tue, 18 Feb 2025 11:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878309; cv=none; b=dL5xQeuxZd/zYobLFJ5fvYdFyYi/QV6yRuqXFHc/2SXtrahqHgUWYKNyUD1+VWLpXoCOxXo3N55+6hg5pRmoGhp5wu4jsdCx1jghtM8URrRILGlwquKpyZJMRTBMKUlJkOxZPsXlLwc4yHaxl2+1uU+6xau7HaC9Z5XYKHFhhPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878309; c=relaxed/simple;
	bh=25UmRnOZo8qvZPSZAu1jCVZODfy0POMnpuZwO0h0XUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HYDcZIa26hgIXO0B0I5Z5T8C7g/mxfjnb6poiSSzH8dIqrJsBPr/uOVoHpCELzum2TXJ/3fHkqb752bWHE1aHPfncFFzoB29Ni8rs5sI3FYmrgYhCR9ciF6+CuVCWv4FxLQ8sgM9oLF79U2rJx3zMV12ryfZeKse+8AT45tofbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vtiQGfvg; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739878298; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EWVJ71id1yIhfjixFRHSzlaInctlB+NfwpsqQ3pyVes=;
	b=vtiQGfvgHVyxgEKRbhzd60E9/dp8565IFZizhKJGXovuaBJn/IzTpXUx/JfUzq6PCMPw2IE9/a/gR8+CrdLnS8925RSb6SMSUN79zGIzdSKkSS5kKq7UQiNxPmza0eqDjuwg8MQ+ZnbhOjfnuUrT5HuPiXG7zrrsDp2WP0a2H3A=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPlhBQs_1739878295 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 19:31:36 +0800
Message-ID: <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
Date: Tue, 18 Feb 2025 19:31:34 +0800
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
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
 peterz@infradead.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 16:27, Borislav Petkov 写道:
> On Mon, Feb 17, 2025 at 02:33:30PM +0800, Shuai Xue wrote:
>> changes singce v1:
>> - Patch 1: Fix cur_sev and sev type to `int` per Tony
>> - Patch 4: Fix return value to 0 for clean pages per Miaohe
>> - Patch 5: pick return value comments of memory-failure()
>>
>> This patch addresses three regressions identified in memory failure
>> handling, as discovered using ras-tools[1]:
>>
>> - `./einj_mem_uc copyin -f`
>> - `./einj_mem_uc futex -f`
>> - `./einj_mem_uc instr`
> 
> This is not how you write a problem statement and explain why your patches
> exist.
> 
> You need to state:
> 
> 1. What are you trying to do
> 2. What is the expected outcome and why
> 3. What actually happens and why
> 4. The fix, in your opinion, should be X or Y
> 
> Not quote some ras tools commands. Show me that you actually know what you're
> doing and explain the problem in human understandable way.  And then we can
> talk fixes.
> 
> Thx.
> 

Sorry for the confusion.

> 1. What are you trying to do

I am tring to fix two memory failure regression in upstream kernel compared
with 5.10 LTS.

- copyin case: poison found while copying from user space.
- instr case: poison found while instruction fetching in user space

> 2. What is the expected outcome and why

For copyin case:

Kernel can recover from poison found while copying from user space.  MCE check
the fixup handler type to decide whether an in kernel #MC can be recovered.
When EX_TYPE_UACCESS is found, the PC jumps to recovery code specified in
_ASM_EXTABLE_FAULT() and return a -EFAULT to user space.

For instr case:

If a poison found while instruction fetching in user space, full recovery is
possible. User process takes #PF, Linux allocates a new page and fills by
reading from storage.

> 3. What actually happens and why

For copyin case: kernel panic since v5.17

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new extable
fixup type, EX_TYPE_EFAULT_REG, and later patches updated the extable fixup
type for copy-from-user operations, changing it from EX_TYPE_UACCESS to
EX_TYPE_EFAULT_REG.

For instr case: user process is killed by a SIGBUS signal

Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported "not
recovered"") introduced a bug that kill_accessing_process() return -EHWPOISON
for instr case, as result, kill_me_maybe() send a SIGBUS to user process.

> 4. The fix, in your opinion, should be X or Y

For copyin case: add EX_TYPE_EFAULT_REG as a recovery type.
For instr case: let kill_accessing_process return 0 to prevent a SIGBUS.

For patch 1 and 2:

While debuging the two regression, I found `msg` in predefined `severities`, e.g.

     MCESEV(
         AO, "Action optional: last level cache writeback error",
         SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
         ),

is helpful for me to know what kind of MCE is happened. For a fatal machine
check, kernel panic use the message and I want to extend to collect the message
and print it out for non-fatal one.

For patch 5:

The return value of memory_failure() is quite important while discussed instr
case regression with Tony and Miaohe for patch 4, so move comment to the place
it belongs to.

I hope the information provided above effectively addresses your concerns.
Please feel free to let me know if you have any further questions or need
additional clarification.

Thanks.
Shuai

