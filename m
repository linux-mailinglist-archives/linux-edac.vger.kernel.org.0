Return-Path: <linux-edac+bounces-3249-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74F1A4B0D3
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 10:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB821891CA7
	for <lists+linux-edac@lfdr.de>; Sun,  2 Mar 2025 09:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B761D7984;
	Sun,  2 Mar 2025 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ttqw2z0I"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEBEFC0E;
	Sun,  2 Mar 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740907123; cv=none; b=C6nZGxrtq+1rtFS4vIx/6PmKJYLlUcmv7nqvadEJCpR3zJgL08dkuUiMUVSQ5yjlSQeotDmE/onGDviU/6zCXkaMtflAF+IYSaJxSWa+lmhMoFX8ddNrLkqnNnjr+X0RCRPMdFqqS/bPQAEh/Weo41nZtRsdHAwCIKtvccg7Eg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740907123; c=relaxed/simple;
	bh=BCWIzUYPr0otBX9N7K29gGEj0nj94luEgQ1uEfs4Ipc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vg9fNN3uR374Tpk9HExoqwH4sgl429S4VmCWuNrjMGBANM1qaY31x4i96FymiCzVJViLTYcUr/Jj6jDYisoMhnPzmKo81gtN4v72ERYdV2cWfOTzQTloReyd4rF1P1MhJUamQiBCb8ubM8/XXJmabu/ziYwoCNX7e1Fcl0o+UIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ttqw2z0I; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740907109; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HzSBbXwNMGob2tgfp9EcarAihO9UwDHktg0BwdEeoQ4=;
	b=ttqw2z0IDaQ7Tism7KboxGBIu5o0lJPcHane+hQkoCQggp4YH/eJ/qAwwXrpGMLV3WnCvVEG86IqHF+2XNTtIatLEpWZt8lR8pSvWsSik/NA1RCa5E0SUPIrJoZ1nNNwb3dn6CwN+iH65M49wHou7Xf+EdMlDIroGOepWj2uzy8=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQUlzlk_1740906787 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 02 Mar 2025 17:13:08 +0800
Message-ID: <0fb57eb8-ae5b-4909-9afb-2104766e59e8@linux.alibaba.com>
Date: Sun, 2 Mar 2025 17:13:06 +0800
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
 <7eddced6-bf45-44c8-abbf-7d0d541511ab@linux.alibaba.com>
 <20250302073711.GBZ8QKp1QstGaVGqBR@fat_crate.local>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250302073711.GBZ8QKp1QstGaVGqBR@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/2 15:37, Borislav Petkov 写道:
> On Sun, Mar 02, 2025 at 03:14:52PM +0800, Shuai Xue wrote:
>>>>       "mce: Uncorrected hardware memory error in user-access at 3b116c400"
>>
>> It is the current message in kill_me_maybe(), not added by me.
> 
> Doesn't change the fact that it is not really helpful when it comes to logging
> all errors properly.
> 
>    [ Properly means using a structured log format with the tracepoint and not
>      dumping it into dmesg. ]
> 
> And figuring out what hw is failing so that it can be replaced. No one has
> come with a real need for making it better, more useful.
> 
> You're coming with what I think is such a need and I'm trying to explain to
> you what needs to be done. But you want to feed your AI with dmesg and solve
> it this way.
> 
> If you wanna do it right, we can talk. Otherwise, have fun.

I see. So I am just curious why we define `msg` in `severities`?

I perfer to use structured log format with the tracepoint, and we do use it in
production, but it lacks of process context.

AMD folks add error message for panic errors[1] to help debugging
in which the EDAC driver is not able to decode.

For non-fatal errors, is it reasonable to assume that all users are using
tracepoint-based tools like Rasdaemon?

[1]https://lore.kernel.org/all/20220405183212.354606-1-carlos.bilbao@amd.com/

> 
>> 3. We need to identify and implement potential improvements.
>>
>> "mce: Uncorrected hardware memory error in user-access at 3b116c400"
>>
>> is *nothing* but
>>
>> "mce: Action required: data load in error recoverable area of kernel"
>>
>> helps.
> 
> I don't think you've read what I wrote but that's ok. If you think it helps,
> you can keep it in your kernels.
> 

Fine, I could drop patch 1 and 2 in next version.

Thanks.
Shuai

