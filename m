Return-Path: <linux-edac+bounces-3245-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE86A4AC78
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 16:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511D81711F7
	for <lists+linux-edac@lfdr.de>; Sat,  1 Mar 2025 15:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE13D1DED66;
	Sat,  1 Mar 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iuDAsKEm"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6F842048;
	Sat,  1 Mar 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740841483; cv=none; b=MEn0JyZtape0X/v//21SmJQLfPVQen9nyLkYI3RL//F0qXCndN3ygdRC1Jh69TURpU3cp2EBOOZ09bcnSS77oX8rNZ2iUUuivmV0EDa1IRRD5TDhM7+CHT+ATb4G+2YxKalvadFbHdJyGStxoBrUKhqman9YjYv0v62bLfL7/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740841483; c=relaxed/simple;
	bh=75r440TZgQQLny74eqnSL+1jADOvVWn/JC9H0vYrwCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5iJUTms1A1QNp/B/laDH/JO4AllJ/nC39GVlheDmJJ7j5Lxh9Kfy+Kgg5HruNHXUXNcdINclpZOkmhssKuVVw2KZDYMv8tMyQvPZ7elr0G/zQ6G/LHRYu1tziwnGPTV22JHswfyzImr1h8H+N5x1mI6u6bS+Pv8rdvd0N6cU5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iuDAsKEm; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740841478; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n4mjhg+z8Ag43SI258ptgwqtySGPYzf97j5mfKNZEzY=;
	b=iuDAsKEms3P76DmwilYpwBUJVydBqU27jhuhim/y8H97udzZQusf6PJ3o5kn9sRNt3GwcouNSsyVxyXYOeavBX9tBkucby6ATevYrvR4tL6C2bQfr6x8D30lLtMx2kkYUMMGLFZwBk9JfA5tboaaLV28HVttMWwiEb8bsKcVrs0=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQSaLac_1740837796 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 01 Mar 2025 22:03:17 +0800
Message-ID: <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
Date: Sat, 1 Mar 2025 22:03:13 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, nao.horiguchi@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, linmiaohe@huawei.com, akpm@linux-foundation.org,
 peterz@infradead.org, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/1 19:10, Borislav Petkov 写道:
> On Sat, Mar 01, 2025 at 02:16:12PM +0800, Shuai Xue wrote:
>> For instance, it does not specify whether the error occurred in the
>> context of IN_KERNEL or IN_KERNEL_RECOV, which are crucial for
>> understanding the error's circumstances.
> 
> 1. Crucial for whom? For you? Or for users?
> 
> You need to explain how this error message is going to be used. Because simply
> issuing such a message causes a lot of panicked people calling a lot of admins
> to figure out why their machine is broken. Because they see "mce" and think
> "hw broken, need to replace it immediately."
> 
> This is one of the reasons we did the cec.c thing - just to save people from
> panicking unnecessarily and causing expensive and useless maintenance calls.


For me, and cloud providers which maintains million servers.

(By the way, Cenots/Redhat build kernel without CONFIG_RAS_CEC set, becase
it breaks EDAC decoding. We do not use CEC in production at all for the same
reasion.)

> 
> 2. This message goes to dmesg which means something needs to parse it, beside
>     a human. An AI?

Yes, we collect all kernel message from host, parse the logs and predict panic
with AI tools. The more details we collect, the better the performance of
the AI model.

> 
> 3. Dmesg is a ring buffer which gets overwritten and this message is
>     eventually lost
> 
> There's a reason why MCEs get logged with the notifiers and through
> a tracepoint - so that agents can act upon them properly.
> 
> And we have had this discussion for years now - I'm sorry that you're late to
> the party.

Agreed, tracepoint is a more elegant way. However, it does not include error context,
just some hardware registers.

> 
>> For the regression cases (copy from user) in Patch 3, an error message
>>
>>      "mce: Action required: data load in error recoverable area of kernel"
> 
> See above.
> 
> Besides, this message is completely useless as it has no concrete info about
> the error and what is being done about it.

I don't think so,

"Action required" means MCI_UC_AR
"data load" means MCACOD_DATA
"recoverable area of kernel" means KERNEL_RECOV

It is more readable and concrete than "Uncorrected hardware memory error", e.g.
message in kill_me_maybe():

     "mce: Uncorrected hardware memory error in user-access at 3b116c400"

> 
>> I could add more explanations in next version if you have no objection.
> 
> All of the above are objections.
> 
> Please go into git history and read why we're avoiding dumping useless
> messages instead of proposing silly patches.
> 

Anyway, I respect the maintainer's opinion.

Thanks
Shuai


