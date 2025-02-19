Return-Path: <linux-edac+bounces-3146-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9A0A3B15F
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 07:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87553188A182
	for <lists+linux-edac@lfdr.de>; Wed, 19 Feb 2025 06:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803391ADC76;
	Wed, 19 Feb 2025 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="knduSAl/"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3BC1A8F7F;
	Wed, 19 Feb 2025 06:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739945096; cv=none; b=ewarqwBcseZVk2vpl7sB+lgZ9Z54r4sVEQww37q5ut0/iXt59GKNPd4FwKp20VDA8//q5LoswrSsG7ZF7FqaQ6JrPOPqAE7J5IWnfg9lcOOD45AeV0PmjNcyXHK47/nzoU0U4b56zgbXR6mH7WqHWpu2q1vWHJ19o+Ya2ZXPaG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739945096; c=relaxed/simple;
	bh=L9lhN3ilKtmL2zG8PvbZYD0i1c8yFuaKYcME16EVnEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIbU+jicgDIEE08pgYZY9wHIIiNur2Sc7LMayUgaO3IML3xbI3Kx8ztt5kqu6/ELnEjr4u/Gg0fnOtd8wW267MvTLuhobhw20eP4JX3ouzQ55q2u+Rp5CyQCAq0N9Q+PNt9BGfXFHrooTwJW5W4CQ8ht2x9U9xrrHcwAIb03LkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=knduSAl/; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739945083; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DZZPumA5Upa6XmHFJ6/5ZqK43Kre79RXvyxCQ8Q750M=;
	b=knduSAl/+Jh/fOglTFd1q0bBli5gYI6tKnuO8luOsm5wvgsiNdk78SV/zxVGrwbzmWkY3SElMXsLHZC3loBFJC76vtoks1fBX4HAGvaupoAJiuWPGh07Mm4GR8DuzI7fzJfuekDLcU98jCcgbBOFzO+Rs/XWrie7bbPFbmaHvzk=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPo8aUr_1739945080 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 14:04:41 +0800
Message-ID: <3437892f-60ed-4e76-9028-7feac46425e4@linux.alibaba.com>
Date: Wed, 19 Feb 2025 14:04:39 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mm/hwpoison: Fix regressions in memory failure
 handling
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
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
 <20250218082727.GCZ7REb7OG6NTAY-V-@fat_crate.local>
 <7393bcfb-fe94-4967-b664-f32da19ae5f9@linux.alibaba.com>
 <20250218122417.GHZ7R78fPm32jKYUlx@fat_crate.local>
 <02164ab7-c65b-4b2e-8686-5539bdcb8f43@linux.alibaba.com>
 <SJ1PR11MB60830555A8B1621CA62D4FC3FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <SJ1PR11MB60830555A8B1621CA62D4FC3FCFA2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 01:59, Luck, Tony 写道:
>>> What do futexes have to do with copying user memory?
>>
>> Return -EFAULT to userspace.
> 
> Missed this bit. Kernel code for futex does a get_user() to read the
> value of the futex from user memory.
> 
> -Tony
> 
> 

Tony, you saved me.

Thanks.
Shuai

