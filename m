Return-Path: <linux-edac+bounces-5629-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D4D1B0E5
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5F8730021F5
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C535E527;
	Tue, 13 Jan 2026 19:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AeJg0F59"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28535B143
	for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332684; cv=none; b=QcvFHOeca5vuNYe/eZXSD+3X6onLk1sUGinbtOnoRdD035h7CtexzrTauVWo/R+swKmMF0FaxCsObOO5q4ZPIqSUZyzMuVGlRz6UcpYOBCRQIbpJKMxPncO4vcLeCXXyb2i/oN4FETTsfUedbeAn0GhIt6AxJD4SFglwnw5iS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332684; c=relaxed/simple;
	bh=wzmMnNWWT6BfV1epUm9llBn9KAdtDYsf/ppiReTh1EY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qWlEZ6sU25Ctl4PgfSGGFyLCHLwTYomdYGkYS5fl81Cda6QpmfaBjAMsxdOTI/DvBYPyg3HWMh37ECGdICcQU4ha3/Jdzjyx1ivNFHIdE/1mA1wJmMV0fK0I0b3OV8M5z3bToBlY8LsHsFZtSYt4Tb17A/5e9792AVJHl+8bj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AeJg0F59; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso39844165e9.0
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768332681; x=1768937481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mZ+/SSm8Yk1STJqtuMveMdb2USAPK03seI/OasqORyI=;
        b=AeJg0F59PJmA20XDlgPDnX0Gj7Q5w5g3TQfJe756gDVYWawZ+7DysuoDyJ5oIAu/ne
         X/yyT/k/xKJRhMqJgFHw/hLJobXHsi+j9/omOIJCw+LEP0ByinmDqTHQh510nZ/+Jxbb
         2rL5iFEegprUf8NUemUG3iM7msrGTzIZJ+JCwbMiEl68hE/h1oCkAWdkEs0f2KdoTR7X
         IASuRQmrpPH6Bi6YOUa6jXyP7A452Wn9XfK6Qoj+lvpvYlcm8IuWvf1SZYJXpldCVK4J
         GqzAIk8aRHZOUW4XwFfEzz68CEfzLiB1eme/ojQp50SFrV6NCIh4bjZNkgcZzwDrkQHL
         2NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332681; x=1768937481;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ+/SSm8Yk1STJqtuMveMdb2USAPK03seI/OasqORyI=;
        b=emlOB/+E1KrEIPU2+R7oe9U4zsDxxhHxvsOfu7PDzVNps8G0xdJ8OMdjYTKfpk5Gx6
         ljuI36Big0Jg9SBSm9XbNr8ZSaPZYljDHiQtbzaX/bYfUwmkv3Vo4doA3pXOe9Udq9vS
         a5NjCaZO++eONP8f77OaHQOQ6GIClu8teCkTTnoBsKx9bduigXVWqDASBdLOmhRThIZJ
         TEfQMGFAydz1QtXjIV0zBo9ryIYsIDRL7gyNwrEiZo8XQKPow6AWi70lmAnmLjLwz56N
         4C+OtJfmK3LOnPBR5p2huoJhEQ9+GXguTwY/d8J8VSjyRhH6hjHeOHwcnybIpWRooI8u
         H/ig==
X-Forwarded-Encrypted: i=1; AJvYcCUEsRx4k/GXEpDI4EBuQ7eYqLtoWBJrwKiR1ejnto2HvAgsj2xM25yIIxzGK0uu1xBRpfkPSM4x09mR@vger.kernel.org
X-Gm-Message-State: AOJu0YziyKo1Lbw1VyZmSq1VxG7WMj+/igBIZ847KtSTOdHq6aDOSG/A
	eNJkPdOfO4O0Zmx7fK6mCq09kzoEqBwbdkYSqJRYlkGmpCe8U5iphSOckpGhGYDVI4MMqwVm8F9
	evxrt
X-Gm-Gg: AY/fxX6YzmZzxdyT8kboO6fyMFu72DZ0mHSie2eaaakDcU5bhjgKZkp2CpJo5mihHdB
	8b/cv69RVsSxpfwPGzoV0XAA7Oql5F9yYq63yk6g24H3qyy3b3gllVucm4rK9WfhxAAwh+dGM8M
	ziE5MCDFVe+8ayDjwa9uyM9RBepQwOCudEpQce0kxK4Rkssfg7+qOLOxfxoAY1jHrQssBtJ/WwP
	FdQMdtQwoTE6SFHatrptgzl54QJGxJR8V9Bj9meNrHx8cn0Jv7cxkXax6EROhw3dQX+NidbxoUB
	KBCZZI3FaavA0yjpAjhHX47VcbEh8HRKD0hpofqRDqyWqav33Mrzgb3Peop1kU2cvLDmHevtuaH
	G1zMdlPW4ak82GkmSU+DDbiGGpHtZ/hhF0wrSwpsu7AdOnntECbb6XwM9t0DcWrj/2FCGSdjhVv
	sVfjodN23lK0wc/xEloGGtt7lerjW9FLXzjX7ImGPHyAa4SOU=
X-Received: by 2002:a05:600c:3acb:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-47ee3353e2emr3522635e9.21.1768332681559;
        Tue, 13 Jan 2026 11:31:21 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f7035f2sm402672305e9.12.2026.01.13.11.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 11:31:21 -0800 (PST)
Message-ID: <3eaf01db-6f51-4125-a4bd-bc54c6576e28@suse.com>
Date: Tue, 13 Jan 2026 21:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiDnrZTlpI06IFvlpJbpg6jpgq7ku7Zd?=
 =?UTF-8?Q?_Re=3A_=5BPATCH=5D_x86/mce=3A_Fix_timer_interval_adjustment_after?=
 =?UTF-8?Q?_logging_a_MCE_event?=
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
 "Li, Rongqing" <lirongqing@baidu.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 Avadhut Naik <avadhut.naik@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20260112082747.2842-1-lirongqing@baidu.com>
 <36b42ced-f1e8-4eb0-b6f8-2a9434d5d26c@suse.com>
 <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.01.26 г. 20:53 ч., Luck, Tony wrote:
>>> The comment in mce_timer_fn says to adjust the polling interval, but
>>> I notice the kernel log always shows an MCE log every 5 minutes. Is this
>>> normal?
>>
>> Use git annotate to figure out which patch added this comment and in context
>> of what and that'll tell you why.
>>
>> As to the 5 minutes, look at how the check interval gets established.
> 
> Once upon a time the polling interval started out at 5 minutes, but the
> interval was halved each time an error was found (so interval went
> 150s, 75s, 37s, ... down to 1s). If no error was found, then the interval
> was doubled (going back up to 300s).
> 
> This is described in the comment:
> 
>          /*
>           * Alert userspace if needed. If we logged an MCE, reduce the polling
>           * interval, otherwise increase the polling interval.
>           */
> 
> It seems that the kernel isn't doing that today. Polling at a fixed 300 seconds
> event though errors are being found and logged. Interesting that the timestamps
> are 327.68 seconds apart, rather than 300 and change. So there is some strange
> stuff going on.

I think Li Rongqing patch does exactly that, since it predicates the 
halving/doubling of the interval based on whether an error was found and 
not whether it was reported to user space (what mce_notify_irq() ) does. 
Both concepts seems to be independent and the former being the core one 
we care about w.r.t to the decision how to adjust the interval, no ?

<snip>

