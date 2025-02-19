Return-Path: <linux-edac+bounces-3149-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F3A3B202
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 08:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC75F173517
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 07:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC5B1C07FC;
	Wed, 19 Feb 2025 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nWm0g8/S"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21691C07F6;
	Wed, 19 Feb 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739949202; cv=none; b=AJfVNG4b6kyaa9w/F/BCPAp3+/A6zcfKEUyJjmwKUpgigBkGp0J1LYSGUFr2WshuMxn18MO/O6D3R6jXzZ8C2MDzSokdr39fHkTk1FlXSx3GvmEmNbFJnE0pKNeCs3Ke8W27wKj7a0r2Uv8AtR6VlB/+QVgrdzT0sNCUQy+FWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739949202; c=relaxed/simple;
	bh=mVgqgalZxh98OYlrB0DCV8GNZFm710rtMlcq+mkJ2DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIcHaAKdAdLBvnLzMBkFCtk1Y6NERlvCzOYn26BcEWeTK0k441h4IrIN6gYXXrVMUOCI+q4MVW0/wSPzw9ab0+ufuZwz/hJnKuCRBs1ykF31vsAUGBqHMA4qE8isNfpLvETUTtOwbSqVzT0Dz1z/+pO+ELlKWe1rJr5f4EtCBXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nWm0g8/S; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739949187; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=z3ce28cI/UYUnnn8SipU968k3tBURYYhJt6vjOG3Rvw=;
	b=nWm0g8/SgVYKn1MhK6m6rsly/cKKbQf5lscL2JPN7l9KO5uQPFW6FmtB4QLELtIVY2FivmbYWiuk13HgYUYS8u+khVew6iBYfqo6vZIXvGr48PQP03B+GJ5Nmtr0tzK8jp4/A6fvez4hWxrU8C2LPCPo0TU1pVsnVYqdltfaRYY=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPoMl3s_1739949185 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 15:13:06 +0800
Message-ID: <a122d218-9326-482c-8347-64d8ff719c7c@linux.alibaba.com>
Date: Wed, 19 Feb 2025 15:13:04 +0800
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
 <4b52e6cd-1315-4b0b-8b6e-95a3d4ed96cc@linux.alibaba.com>
 <20250218153138.GLZ7Sn2inSAgMo1aAM@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250218153138.GLZ7Sn2inSAgMo1aAM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 23:31, Borislav Petkov 写道:
> On Tue, Feb 18, 2025 at 09:53:17PM +0800, Shuai Xue wrote:
>> The regression is reported by end user and we also observed in the production.
> 
> Where is that report? How many times do I have to ask about different aspects
> of your patches until you explain the *whole* picture?

Sorry, I can not provide the internal report.

Thank you for your continued attention to this matter.

I appreciate your thoroughness, and I'd like to clarify a few points: I've made
every effort to explain the issue comprehensively in my previous responses,
following your previous instructions. And I do not have a more bigger picture.
My picture is not introducing a new feature but addressing a regression caused
by previous commits and improving system reliability. The root cause and its
impact are detailed in patches 3 and 4.

> 
>> [5056863.064239] task: ffff8837d2a2a0c0 task.stack: ffffc90065814000
>> [5056863.137299] RIP: 0010:[<ffffffff813ad231>]  [<ffffffff813ad231>] __get_user_8+0x21/0x2b
>> ...
>> [5056864.512018] Call Trace:
> 
> This tells me exactly 0 - I see some truncated stack trace.
> 
>> Sorry, I did not get your point.
> 
> I don't get your text either. Until this is explained and debugged properly,
> it is not going anywhere.
> 

Tony helped to answer this answer. If you are a asking for how futex trigger a
poison and handle it, hope bellow callstack helps.

futex(2)
     do_futex
         futex_wait
	    __futex_wait
	        futex_wait_setup
    		    get_user // return -EFAULT to top futex(2)

I've strived to provide all the relevant information within the constraints I'm
operating under. If there are specific aspects you feel need further
clarification, please let me know, and I'll do my best to address them.

Thank you for your patience and guidance throughout this process. I look
forward to your feedback and to moving this patch forward.

Shuai

