Return-Path: <linux-edac+bounces-3137-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EACA3A39DF8
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 14:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70391885B34
	for <lists+linux-edac@lfdr.de>; Tue, 18 Feb 2025 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551B9262811;
	Tue, 18 Feb 2025 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rJB2Iy0D"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9EB1E526;
	Tue, 18 Feb 2025 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739886808; cv=none; b=X9Q657zKHpWLIx4QMGQQ1oKuyDCziYY8Ybja8+/5ucL3slVRpmYrWvZJhqsf26bkJX0OmYbeD7tcZ3p5m9qxhYS3ZPVdyEf1qDOBolObSrWcnUTh4tE6awSN4oZUBE9FYQ5C3wWCehWyHS6LqaDnluFWHUhspjXhpZ1cj1S944M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739886808; c=relaxed/simple;
	bh=nBN9QF3figC4DUAzfruLKZVcFf4yKnpP1nz3h1qBJ1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Afii2bI0aNu92gRn4ZkN5Psm84uRJB5Jje8xjK6xJXAZ52fyFPvUyl9eLhdK671Q/G6VVyC7KA/63T+SisqcAyUYg6yUFM9ut+dRRb3PSsQKGHwytjxIEq8Czf0aaW/gdRM6Y7rox3tx0Z6CgI8aoOLapsZ2ywlPNqYUrqU1zF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rJB2Iy0D; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739886801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YtCd0F7R2Ociq9DloB/HtONRO/iL2JXm/ytjU64+K00=;
	b=rJB2Iy0DHX4Pi9J3+kdZnT2KnfG9PLZRgp/a+mzDwdX5iwKQL3ODMOORpoHIMGAsMhpB35WdQ3jL6cyo6SJLTCA6byBJxuIo7UqDH3ObBnpxUTEiO4Kbu7B/8kU9AtA/yAxxc/2hVptIDCKdlgMue/OVnEiHZkZfe/jeV7xd27M=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPm.KiR_1739886798 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 18 Feb 2025 21:53:19 +0800
Message-ID: <4b52e6cd-1315-4b0b-8b6e-95a3d4ed96cc@linux.alibaba.com>
Date: Tue, 18 Feb 2025 21:53:17 +0800
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
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
 <20250218131753.GIZ7SIgRZBJokysBeX@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218131753.GIZ7SIgRZBJokysBeX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 21:17, Borislav Petkov 写道:
> On Tue, Feb 18, 2025 at 09:08:25PM +0800, Shuai Xue wrote:
>> Yes, the poison is found on user pages.
>>
>> Form commit log, the mechanism is added by Tony and suggested by you.
>> https://lkml.kernel.org/r/20210818002942.1607544-3-tony.luck@intel.com
> 
> I'm not talking about how it is detected - I'm asking about *what* you're
> doing exactly. I want to figure out what and why you're doing what you're
> doing.
> 
>> It's the same as with real issue. There's no magic to it.
> 
> Magic or not, doesn't matter. The only question is whether this can happen in
> real life and it is not just you using some tools and "fixing" things that
> ain't broke.

The regression is reported by end user and we also observed in the production.

[5056863.064239] task: ffff8837d2a2a0c0 task.stack: ffffc90065814000
[5056863.137299] RIP: 0010:[<ffffffff813ad231>]  [<ffffffff813ad231>] __get_user_8+0x21/0x2b
...
[5056864.512018] Call Trace:
[5056864.543440]  [<ffffffff8111c203>] ? exit_robust_list+0x33/0x110
[5056864.616456]  [<ffffffff81088399>] mm_release+0x109/0x140
[5056864.682178]  [<ffffffff8108faf9>] do_exit+0x159/0xb60
[5056864.744785]  [<ffffffff81090583>] do_group_exit+0x43/0xb0
[5056864.811551]  [<ffffffff8109bdc9>] get_signal+0x289/0x630
[5056864.877277]  [<ffffffff8102d227>] do_signal+0x37/0x690
[5056864.940925]  [<ffffffff8111c4e5>] ? do_futex+0x205/0x520
[5056865.006651]  [<ffffffff8111c885>] ? SyS_futex+0x85/0x170
[5056865.072378]  [<ffffffff81003726>] exit_to_usermode_loop+0x76/0xc0
[5056865.147464]  [<ffffffff81003d01>] do_syscall_64+0x171/0x180
[5056865.216311]  [<ffffffff81741c8e>] entry_SYSCALL_64_after_swapgs+0x58/0xc6
> 
>>> What do futexes have to do with copying user memory?
>>
>> Return -EFAULT to userspace.
> 
> This doesn't even begin to answer my question so I'll ask again:
> 
> "What do futexes have to do with copying user memory?"
> 

Sorry, I did not get your point.

Thanks.
Shuai

