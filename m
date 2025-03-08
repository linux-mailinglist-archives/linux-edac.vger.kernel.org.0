Return-Path: <linux-edac+bounces-3320-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE92EA579FB
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 12:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F71891536
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 11:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7931B0424;
	Sat,  8 Mar 2025 11:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TF5L0mrB"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB05F1917FB;
	Sat,  8 Mar 2025 11:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741433491; cv=none; b=R9jVpgABCX7269Qb+0kPtiH/3nCriE7GWcVm+RngOCwDm+9UbVcpPWwanfT5IAV6oMe6e+3BrzJGydzPux44QeINOheucucU87IKwn+fDyFfB5mCKiaEMF/TdPSbPRwMFIpuqJOZr9RHbwLCBRMjY14RyRjgHXfFxVa8m6hKvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741433491; c=relaxed/simple;
	bh=JFfAR3S+qYJY2WY6M/D87teeIRVXSJ/RDDc4sMzf00U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmyZlWpNqE9zZLZOsueVqHwTNRHxfmZtS7x6Nax1tKEkHN0SAYqNoq8g8aANwSWqlZgJPGRKsGPdkP2I+Btt5DM8iRZJoYhqbakap0kdh8wIasXang6bC51fjztPWrsqLgGyLxc7RsmUyfNO6b+nR7baVfGT9amPAxmZHrAMz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TF5L0mrB; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741433479; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GM5S3cFClXldgr+roHNekbKFyWqgvgh/iNs0mzaLJow=;
	b=TF5L0mrBQhON+aD3fFDH5RKVFItUGwLKpeoNyoR/4szt8scaLp8HFKWkNuoveojxj4eSMQ80hYlAfthoDiASNMu4Nu1wnPZAMtBrymjHn0NTsU1xkPwne13SSw9l0++dOqi5qPLRjmFhE5uovsDWkD74rePfiSRtljtQc27rC5s=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQukq4m_1741433156 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Mar 2025 19:25:57 +0800
Message-ID: <5966a572-f69b-404d-b632-9b29f52656b0@linux.alibaba.com>
Date: Sat, 8 Mar 2025 19:25:55 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, peterz@infradead.org, catalin.marinas@arm.com,
 yazen.ghannam@amd.com, akpm@linux-foundation.org, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250307054404.73877-1-xueshuai@linux.alibaba.com>
 <20250307054404.73877-2-xueshuai@linux.alibaba.com>
 <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250307204018.GAZ8tZstt11Y4KFprC@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/8 04:40, Borislav Petkov 写道:
> On Fri, Mar 07, 2025 at 01:44:02PM +0800, Shuai Xue wrote:
>> Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new
>> extable fixup type, EX_TYPE_EFAULT_REG, and commit 4c132d1d844a
>> ("x86/futex: Remove .fixup usage") updated the extable fixup type for
>> copy-from-user operations, changing it from EX_TYPE_UACCESS to
>> EX_TYPE_EFAULT_REG. The error context for copy-from-user operations no
>> longer functions as an in-kernel recovery context. Consequently, the error
>> context for copy-from-user operations no longer functions as an in-kernel
>> recovery context, resulting in kernel panics with the message: "Machine
>> check: Data load in unrecoverable area of kernel."
>>
>> The critical aspect is identifying whether the error context involves a
>> read from user memory. We do not care about the ex-type if we know its a
> 
> Please use passive voice in your commit message: no "we" or "I", etc,
> and describe your changes in imperative mood.
> 
> Also, pls read section "2) Describe your changes" in
> Documentation/process/submitting-patches.rst for more details.
> 
> Also, see section "Changelog" in
> Documentation/process/maintainer-tip.rst
> 
> Bottom line is: personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them
> please.
> 
> "ex-type"?
> 
> Please write in plain English - not in a programming language.
> 
>> MOV reading from userspace. is_copy_from_user() return true when both of
>> the following conditions are met:
>>
>>      - the current instruction is copy
> 
> There is no "copy instruction". You mean the "current operation".
> 
>>      - source address is user memory
> 
> So you can simply say "when reading user memory". Simple.
>>
>> So, use is_copy_from_user() to determin if a context is copy user directly.
> 
> Unknown word [determin] in commit message.
> Suggestions: ['determine',
> 
> Please introduce a spellchecker into your patch creation workflow.
> 
> Also, run your commit messages through AI to correct the grammar and
> formulations in them.

Certainly, thank you for bringing that to my attention.
I will refine the commit log accordingly.

> 
> The more important part which I asked for already is, is is_copy_from_user()
> exhaustive in determining the that the operation really is a copy from user?
> 
> The EX_TYPE_UACCESS things *explicitly* marked such places in the code. Does
> is_copy_from_user() guarantee the same, without false positives?
> 

Following your discussion with Tony, it seems that we have reached a conclusion.

Thanks.
Best Regards,
Shuai


