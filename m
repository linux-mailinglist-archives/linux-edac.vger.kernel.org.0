Return-Path: <linux-edac+bounces-5628-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE97D1B070
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24275302BF60
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39BE36215D;
	Tue, 13 Jan 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NHmQwOPo"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9D342CA7
	for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332324; cv=none; b=tqiZDI4swljMbtW6TFBoC6KN6enBSDj4BdpTfmSE8/5Pdo3N35BrWzm15O690fbmRi6Uczdebz1lc4Jwd/WUlf3lWHeNdN4bmuyo+ffm4GteQmREvmE+yQG7IFj6COf9OYyvD6VSipvkEUEAtoAveBrhMZ6WSN7si4LHlFzEgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332324; c=relaxed/simple;
	bh=3ZkQYQ9Hvmfdk3emBePIfc7xuqN/MKPa0PsuxWo8miE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgBmtdIPPT/LAPYPI+D+1Sy5QfXLAuzp/1xCpi4kn02iyE37MOgeGpeo10+0xT6q2FL+OfR//SegfvuaMHx21wYpZzkoQH89grK5XsKGMORCQLnPYJ+wIOQo8It9PCJTyX1OFjHQADRyINNqNgAulHcd4mbl3DGiIMExFbc86cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NHmQwOPo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ffa5f33so36093425e9.2
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 11:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768332321; x=1768937121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MxhySkez3abPd82MAE9TjK7wo8HA/wmby/FsyIF5Ps=;
        b=NHmQwOPoLjyQOYmMPCJw2g6Xa5+ntlMLGa6Sqc6zf3UwRmLb8NvzL8kz3azSDAn912
         bywk93Kxw5+Cs7Bcpqvj9XlJ1YbwQYIIXPTZkdjRAjlCn3hiaCpxSeJn7TW6W3SSTj/5
         duuStHMzNtmBftCc+xaasKVQnTxzQzrsXQOCdOYmeSMMAvAHfsuV4s0aLLtkK98XLhUg
         NPAKsN/SY8d7DRsrDDcjctkc6I+6PBnSjSpF4UA+Z5t1H3ntpS9kyAIN7UN+3NlAXur2
         2NOHOwLhtEK0RcG19QJ/4jdaXgh/rJa/ktlOu5S0uC7ckgy2luVwHHbm4KpCjecThLeV
         NtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332321; x=1768937121;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MxhySkez3abPd82MAE9TjK7wo8HA/wmby/FsyIF5Ps=;
        b=Rvoc3SLn2hEDBnQYR+d+YTCOrLU8BMIXmzI57fePy9lblu2A4wKIXTV3nfhKJh3MZ2
         gFOQYg+AANmRgiMp0auvK4ccj2SU1jTMxj6nd2RwB9TyRrU4IPB/nDk4tPKK6Vlb56d9
         FT9cG45jEaJljbLLplRP7+CgEzs7xUhsdqSlodwhO4UNIh+i6sWtEIgPNdgVdKFMFQzx
         5lqg4yNlKqlrQ+/8AgjvFkppc/pM/kVj7ocBjI1zfgdIfmqQFa6/Z5XbBME66pARoNPq
         B3elv2wLXHTmq3JzEDSWrWjRR6TlbyH8wrbE7FvDyMV8ZuXf6JrQMPxUqvxbMtrBM05n
         wEhw==
X-Forwarded-Encrypted: i=1; AJvYcCWkmzp7TPLtg1A190y/D3U2UgvqGNl/Ga0dhca4TezmY094iQij7RfDF7euCX0VTgUui4lT4IgFCxm8@vger.kernel.org
X-Gm-Message-State: AOJu0YxKhZlYs3JFNDp3x+vGqo1M9edzuMb7nr/knkWG9Nfiq4RmKv+D
	1wUHmu4G9oU2Z+dZzLYUPGcIwkF5Yj2V6mMg4EWh4q0R6zmlmnvzjxW9YdlBBzdQAhs=
X-Gm-Gg: AY/fxX6BjwW9Fg5mQ4wX6GvFcjhbEOT1+wG9AIkht9eryK1u6tbXdCm4YPO/7gppLdm
	iXW1LN+/1GeWatkrxhddZV8kcQyZUHFKC6Qtnk0xnwj+AvDmEw1ilpBmgSsMGQ+O1KJ+bT+Y57D
	dy0FY6ZVEUPDZA3UIkI7fcMaa2X0Krnn8xQPOr1D7qfto5D8w7artiHI92lPEqdWRSW8b0uXzQY
	Muxh2YAIph8UhhLUolL5mdBGM1KlTFP92+ELcPcP5+0t4RjNoq/uOUFUz9Nq6BHy50zREVuYdtu
	zJZrRG27SxudKenBX+RTSwpimqRsEEsXdQM4/FUc4XcH3R49SWXnk0IYZEdo3QN9s47EhXZdFmm
	CA3x2Shf1Ol5PHhsuzucFPokEG6H6wBQ+A+zRR399JnCNf7zfFTGVKc8OufCvLRJD29sWvkV6QU
	VthqOnb5jzY8srmI8KddIQd9EG0tMQKXndmFgJ
X-Received: by 2002:a05:600c:1f89:b0:47a:810f:1d06 with SMTP id 5b1f17b1804b1-47ee33184c2mr3033035e9.4.1768332321045;
        Tue, 13 Jan 2026 11:25:21 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee283fdcesm3729905e9.15.2026.01.13.11.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 11:25:20 -0800 (PST)
Message-ID: <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
Date: Tue, 13 Jan 2026 21:25:19 +0200
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
To: Borislav Petkov <bp@alien8.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, "Li, Rongqing"
 <lirongqing@baidu.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
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
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.01.26 г. 21:13 ч., Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 08:55:08PM +0200, Nikolay Borisov wrote:
>> tomorrow) I will send a patch that simply eliminates mce_notify_irq's call
>> in mce_timer_fn. I.e that function should be called only from the early
>> notifier.
> 
> You still need to know whether to halve the timeout or not. And that's that
> mce_need_notify thing. And that gets called in the early notifier so it should
> work.
> 
> However, it would be good to be able to bisect this and find a minimal fix to
> backport...
> 

mce_need_notify even now works just in the early notifier because it's 
set in mce_early_notifier() and subsequently reset in mce_notify_irq() 
which is called immediately after the set.

