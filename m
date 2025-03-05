Return-Path: <linux-edac+bounces-3268-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6914BA4F412
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 02:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5D3167867
	for <lists+linux-edac@lfdr.de>; Wed,  5 Mar 2025 01:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA81215252D;
	Wed,  5 Mar 2025 01:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qKjIG5Se"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4E1519A1;
	Wed,  5 Mar 2025 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741139429; cv=none; b=jA+vxPnfNef22C8dsKVt8VgqXJJFYQZa4dRcXb7RaiMow8TTbgMgyOUkapbeEECDuSZFBUbhisAYJNEpNoaWt/r/hCbpgMmfYfHLyz9Xo0dku26wXwKwMm5DoUdCQmtFzzEEfuH8C3AP5xcD2yJS9cA+IE7it/EKIZEB+J9kLgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741139429; c=relaxed/simple;
	bh=cIPyLVhfmzrb7O4X70B+qBi4Kw/RKxNjF6qMFllIjkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzSx4WMNGwVw1o2X6ivmtKh5ZI0c7QU/tz44NG2SFzLE97u/S4Gj5Yw7LIE1jRccYO8R/zl8yq6EvvDgJSXFWwufFsY2MIl8h9jTOh7hjTlwdSt7eMyoi3kxeWRYTH0TKK8gui8Sfh1ADJ7JePeYYKR7RU5WBNjJdHCR/BEObzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qKjIG5Se; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741139417; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Bn1xeCRo3XM3e/RHN56us/V1x3j8UE+PxVIiqcDKx80=;
	b=qKjIG5SeTJ50t0ejEtUytT5/wre8+BPsbx7yy7i4mF47RNnL0ccFCOuN592hsJr0+s1F7gv11VTlNmllozBuEJ4CDvsj8PjnmPPrk9blUh+KYM3pHwiIs4tZ7oFo4TMjN6Y9Bg95iwAyoXGdtxBrINlDrVCx7Yv5lOCXfPiF0C4=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQjj2Fs_1741139414 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Mar 2025 09:50:15 +0800
Message-ID: <89027155-8ca3-46a5-8c3a-e24b903cb3eb@linux.alibaba.com>
Date: Wed, 5 Mar 2025 09:50:13 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Yazen.Ghannam@amd.com" <yazen.ghannam@amd.com>
Cc: "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "tianruidong@linux.alibaba.com" <tianruidong@linux.alibaba.com>
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
 <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB6083697C08D8B6B8BFD3CC98FCC92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/4 00:49, Luck, Tony 写道:
>> The error context is in the behavior of the hw. If the error is fatal, you
>> won't see it - the machine will panic or do something else to prevent error
>> propagation. It definitely won't run any software anymore.
>>
>> If you see the error getting logged, it means it is not fatal enough to kill
>> the machine.
> 
> One place in the fatal case where I would like to see more information is the
> 
>    "Action required: data load in error *UN*recoverable area of kernel"
> 
> [emphasis on the "UN" added].

Do you mean this one?

     MCESEV(
         PANIC, "Data load in unrecoverable area of kernel",
         SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
         KERNEL
        ),


> 
> case.  We have a few places where the kernel does recover. And most places
> we crash. Our code for the recoverable cases is fragile.Most of this series is
> about repairing regressions where we used to recover from places where kernel
> is doing get_user() or copy_from_user() which can be recovered if those places
> get an error return and the kernel kills the process instead of crashing.

I can’t agree with you more.


> A long time ago I posted some patches to include a stack trace for this type
> of crash. It didn't make it into the kernel, and I got distracted by other things.
> 
> If we had that, it would have been easier to diagnose this regression (Shaui
> Xie would have seen crashes with a stack trace pointing to code that used
> to recover in older kernels). Folks with big clusters would also be able to
> point out other places where the kernel crashes often enough that additional
> EXTABLE recovery paths would be worth investigating.

Agreed, a stack trace will be helpful for debug unrecoverable cases.
The current panic message is bellow:

[ 1879.726794] mce: [Hardware Error]: CPU 178: Machine Check Exception: f Bank 1: bd80000000100134
[ 1879.726798] mce: [Hardware Error]: RIP 10:<ffffffff981d7af3> {futex_wait_setup+0x83/0xf0}
[ 1879.726807] mce: [Hardware Error]: TSC 49a1e6001c1 ADDR 80f7ada400 MISC 86 PPIN fc6b80e0ba9d616
[ 1879.726809] mce: [Hardware Error]: PROCESSOR 0:806f4 TIME 1741091252 SOCKET 1 APIC c5 microcode 2b000571
[ 1879.726811] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
[ 1879.726813] mce: [Hardware Error]: Machine check events logged
[ 1879.727166] mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
[ 1879.727168] Kernel panic - not syncing: Fatal local machine check


It only provides a RIP and I spent a lot time to figure out the root cause about
why get_user() and copy_from_user() fail in upstream kernel.

> 
> So:
> 
> 1) We need to fix the regressions. That just needs new commit messages
> for these patches that explain the issue better.

I will polish commit message.

> 
> 2) I'd like to see a patch for a stack trace for the unrecoverable case.

Could you provide any reference link to your previous patch?

> 
> 3) I don't see much value in a message that reports the recoverable case.
> 

Got it.

Thanks
Shuai

