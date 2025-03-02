Return-Path: <linux-edac+bounces-3247-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB0BA4B04D
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 08:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557073BD3C5
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B61E0E0C;
	Sun,  2 Mar 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DWCNcg2g"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCA1DE3C0;
	Sun,  2 Mar 2025 07:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740899704; cv=none; b=BGEWJ2ri91+nbMgcNC/pg3aWy6vwytp/Vy6taDD/ETUzttP/EjxvTWKYpgfv+6sk2OLLF0Dgz7DUwWwfvNX/7aP+RidVpJqjItfNV2qvAkstgTHvuZvxNQSconoOUJizfjV4lJRPUrEqs0dBv3X7J2LNgUnDdqqlLtsdjcyupBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740899704; c=relaxed/simple;
	bh=dDTZtxtMP+ASRgLGhbT+WUH+lROdEMNi84C84Y2oI6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bjDrkHHGsHVQPRtwXYa611eIfuOYMMY5RfS0Kj+vvt7h2VdUCTx7grbqYE+eSBcBAAxbmRKRVoYyvsAXTUXWfSe0LZ/+kFKX9mSnXSqTQSq3osUHn6lIY4OTWnjlIUzvpNgbIR82Tyfgv5eP/RYs8N64fXNOWgtcjGHpYDnltlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DWCNcg2g; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740899696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=v69h+SOeTjqXpJtalLZZCoQPIBTBXQ3ns0RzzvJWsFw=;
	b=DWCNcg2gCQe1KgQu3n1JrBv7DPoMbTQ/GnWyqwMSt8WY+h9hmpuvcHJLg6nhqbdb079CLXeanSB+lBMbPHXjwd/EcDP66sweVHbx3psJOUJcHbGPkPg54AtsaQE4zyJ2mUXbY6bGqtru8PY3jd47CWBiH4dbeNLYyqyF7Bn1Iqs=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQUXm6t_1740899693 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 02 Mar 2025 15:14:54 +0800
Message-ID: <7eddced6-bf45-44c8-abbf-7d0d541511ab@linux.alibaba.com>
Date: Sun, 2 Mar 2025 15:14:52 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/mce: dump error msg from severities
To: Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: nao.horiguchi@gmail.com, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 linmiaohe@huawei.com, akpm@linux-foundation.org, peterz@infradead.org,
 jpoimboe@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
References: <20250217063335.22257-1-xueshuai@linux.alibaba.com>
 <20250217063335.22257-3-xueshuai@linux.alibaba.com>
 <20250228123724.GDZ8GuBOuDy5xeHvjc@fat_crate.local>
 <cf9ef89c-ca91-476a-895d-2af50616242f@linux.alibaba.com>
 <20250301111022.GAZ8LrHkal1bR4G1QR@fat_crate.local>
 <dee8d758-dd65-4438-8e42-251fb1a305a7@linux.alibaba.com>
 <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250301184724.GGZ8NWPI2Ys_BX-w2F@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/2 02:47, Borislav Petkov 写道:
> On Sat, Mar 01, 2025 at 10:03:13PM +0800, Shuai Xue wrote:
>> (By the way, Cenots/Redhat build kernel without CONFIG_RAS_CEC set, becase
>> it breaks EDAC decoding. We do not use CEC in production at all for the same
>> reasion.)
> 
> It doesn't "break" error decoding - it collects every correctable DRAM error
> and puts it in "leaky" bucket of sorts. And when a certain error address
> generates too many errors, it memory_failure()s the page and poisons it.
> 
> You do not use it in production because you want to see every error, collect
> it, massage it and perhaps decide when DIMMs go bad and you can replace
> them... or whatever you do.
> 
> All the others who enable it and we can sleep properly, without getting
> unnecessarily upset about a correctable error.

Yes, we want to see event CE error and use the CE pattern (e.g. correctable
error-bit)[1][2] to  predict whether a row fault is prone to UEs or not.
And we are not upset to CE error, becasue it have corrected by hardware :)

[1]https://www.intel.com/content/dam/www/public/us/en/documents/white-papers/fault-aware-prediction-guide.pdf
[2]https://arxiv.org/html/2312.02855v2

> 
>> Yes, we collect all kernel message from host, parse the logs and predict panic
>> with AI tools. The more details we collect, the better the performance of
>> the AI model.
> 
> LOL.
> 
> We go the great effort of going a MCE tracepoint which gives a *structured*
> error record, show an example how to use
> it in rasdaemon and you go and do the crazy hard and, at the same time, silly
> thing and parse dmesg?!??!
> 
> This is priceless. Oh boy.
> 
>> Agreed, tracepoint is a more elegant way. However, it does not include error
>> context, just some hardware registers.
> 
> The error context is in the behavior of the hw. If the error is fatal, you
> won't see it - the machine will panic or do something else to prevent error
> propagation. It definitely won't run any software anymore.
> 
> If you see the error getting logged, it means it is not fatal enough to kill
> the machine.

Agreed.

> 
>>> Besides, this message is completely useless as it has no concrete info about
>>> the error and what is being done about it.
>>
>> I don't think so,
> 
> I think so and you're not reading my mail.
> 
>>      "mce: Uncorrected hardware memory error in user-access at 3b116c400"

It is the current message in kill_me_maybe(), not added by me.

> 
> Ask yourself: what can you do when you see a message like that?
> 
> Exactly *nothing* because there's not nearly enough information to recover
> from it or log it or whatever. That error message is *totally useless* and
> you're upsetting your users unnecessarily and even if they report it to you,
> you can't help them.
> 

I believe we are approaching this issue from different perspectives.
As a cloud service provider, I need to address the following points:

1. I must be able to explain to end users why the MCE has occurred.
2. It is important to determine whether there are any kernel bugs that could
    compromise the overall stability of the cloud platform.
3. We need to identify and implement potential improvements.

"mce: Uncorrected hardware memory error in user-access at 3b116c400"

is *nothing* but

"mce: Action required: data load in error recoverable area of kernel"

helps.


Thanks for your time.
Shuai

