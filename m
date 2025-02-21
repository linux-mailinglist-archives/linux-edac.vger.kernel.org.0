Return-Path: <linux-edac+bounces-3179-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C31C4A3ED06
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 07:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF1D3B67B6
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 06:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978201FC7C6;
	Fri, 21 Feb 2025 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KR6NbsZo"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F745948;
	Fri, 21 Feb 2025 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740120760; cv=none; b=ZsLdhwGMEU1w4eyQ2VWGRvaCPhGvTf7vr5eehlvFijczz/cFBeIKQhk7i6R2ehQVE62ag7HC0lsUIMvNF4YwKAdob6nEVscsyDUcOyLKA07naVGN3DNXnZrfTNw7vPEHF0A/CcNELzaV+XgHQUQEqg24Vi4Yf6/Trlpcv7yzUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740120760; c=relaxed/simple;
	bh=/12jEPiLRqlltL/nDh/QR9kLZro+Iv5ZrHFnWhRK2uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQ46BziYT7wHslwxOB5pg+KMUwQSy7mFTf3swMYhNJtj5512XR4l84PUxEEMsgcv/m2QNyrF0uPDd12YFiAYD3W3R+IL6p3rsSmfIPz71FtST67AMBnWdCbNgsh6ZmcKPmtOFPZy1k13FmoaeTFSxXYoElLbgHYRPaoU9NvYzow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KR6NbsZo; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740120748; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oZUpS/ivXDgL9A5kntB0JwVQqbeL7smqaFnK4yBbM34=;
	b=KR6NbsZodesxkyvr9RHg9ZhB9BxhZd1OHTZr+DIQfWKqZ6xZSmEpP8DkHG770n7XHzL3Ity16q6ZDS5BXxzqJW596b2/99w66X1qr6VpR6gOpFFZdcumzW9ltzu+S5FDc8T8ieS4pDs0WgB2MpKUrJjWL1mMByp/BwM11ZuLE6g=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPvN845_1740120745 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Feb 2025 14:52:26 +0800
Message-ID: <5ff00e53-957b-4a4e-a893-f83c4995c1ed@linux.alibaba.com>
Date: Fri, 21 Feb 2025 14:52:24 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] x86/mce: add EX_TYPE_EFAULT_REG as in-kernel
 recovery context to fix copy-from-user operations regression
To: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>,
 "Luck, Tony" <tony.luck@intel.com>
Cc: nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linmiaohe@huawei.com, akpm@linux-foundation.org, jpoimboe@kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com,
 tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-4-xueshuai@linux.alibaba.com>
 <20250218125408.GD40464@noisy.programming.kicks-ass.net>
 <1ff716d3-eb3d-477e-ae30-1abe97eee01b@linux.alibaba.com>
 <20250218141535.GC34567@noisy.programming.kicks-ass.net>
 <20250218164800.GNZ7S5wL1A4dTaySOP@fat_crate.local>
 <20250219104037.GG40464@noisy.programming.kicks-ass.net>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250219104037.GG40464@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 18:40, Peter Zijlstra 写道:
> On Tue, Feb 18, 2025 at 05:48:00PM +0100, Borislav Petkov wrote:
>> On Tue, Feb 18, 2025 at 03:15:35PM +0100, Peter Zijlstra wrote:
>>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>>> index dac4d64dfb2a..cfdae25eacd7 100644
>>> --- a/arch/x86/kernel/cpu/mce/severity.c
>>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>>> @@ -301,18 +301,19 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
>>>   	instrumentation_end();
>>>   
>>>   	switch (fixup_type) {
>>> -	case EX_TYPE_UACCESS:
>>> -		if (!copy_user)
>>> -			return IN_KERNEL;
>>> -		m->kflags |= MCE_IN_KERNEL_COPYIN;
>>> -		fallthrough;
>>> -
>>>   	case EX_TYPE_FAULT_MCE_SAFE:
>>>   	case EX_TYPE_DEFAULT_MCE_SAFE:
>>>   		m->kflags |= MCE_IN_KERNEL_RECOV;
>>>   		return IN_KERNEL_RECOV;
>>>   
>>>   	default:
>>> +		if (copy_user) {
>>
>> As said on chat, if we can make is_copy_from_user() *always* correctly detect
>> user access, then sure but I'm afraid EX_TYPE_UACCESS being generated at the
>> handful places where we do user memory access is there for a reason as it
>> makes it pretty explicit.
> 
> Thing is, we have copy routines that do not know if its user or not.
> is_copy_from_user() must be reliable.
> 
> Anyway, if you all really want to go all funny, try the below.
> 
> Someone has to go and stick some EX_FLAG_USER on things, but I just
> really don't believe that's doing to be useful. Because while you're
> doing that, you should also audit if is_copy_from_user() will catch it
> and if it does, you don't need the tag.
> 
> See how much tags you end up with..

Agreed, I think the key point whether the error context is in a read from user
memory. We do not care about the ex-type if we know its a MOV
reading from userspace.

is_copy_from_user() return true when both of the following two checks are
true:

- the current instruction is copy
- source address is user memory

If copy_user is true, we set

m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;

Then do_machine_check will try fixup_exception first.

	/*
	 * Handle an MCE which has happened in kernel space but from
	 * which the kernel can recover: ex_has_fault_handler() has
	 * already verified that the rIP at which the error happened is
	 * a rIP from which the kernel can recover (by jumping to
	 * recovery code specified in _ASM_EXTABLE_FAULT()) and the
	 * corresponding exception handler which would do that is the
	 * proper one.
	 */
	if (m->kflags & MCE_IN_KERNEL_RECOV) {
		if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
			mce_panic("Failed kernel mode recovery", &err, msg);
	}

	if (m->kflags & MCE_IN_KERNEL_COPYIN)
		queue_task_work(&err, msg, kill_me_never);

So Peter's code is fine to me.

---
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index dac4d64dfb2a..cb021058165f 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -300,13 +300,12 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
  	copy_user  = is_copy_from_user(regs);
  	instrumentation_end();
  
-	switch (fixup_type) {
-	case EX_TYPE_UACCESS:
-		if (!copy_user)
-			return IN_KERNEL;
-		m->kflags |= MCE_IN_KERNEL_COPYIN;
-		fallthrough;
+	if (copy_user) {
+		m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
+		return IN_KERNEL_RECOV
+	}
  
+	switch (fixup_type) {
  	case EX_TYPE_FAULT_MCE_SAFE:
  	case EX_TYPE_DEFAULT_MCE_SAFE:
  		m->kflags |= MCE_IN_KERNEL_RECOV;


Is that ok? Please correct me if I missed anyting.

Thanks.
Shuai

