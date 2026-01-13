Return-Path: <linux-edac+bounces-5631-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44CD1B130
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 20:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EF442300250E
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E300836AB65;
	Tue, 13 Jan 2026 19:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bqI9vevf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCF35E527
	for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768333038; cv=none; b=RqO5mh7x2svSE4BTYJDpBB0SXwygEXQYjLXUktTDVwl1iJIer3jxpGzl5n1r3/g7r5oIKREEAF7GXkxg42b3q2ppb4fnnvrtIDQSbO9FwqoMH9ovBBd4K+hyDQDrIJXac4m9EJ0OBVgqf8pBtCM/rnPKzNdOHrSvgUgDX7ShpYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768333038; c=relaxed/simple;
	bh=iyKKUdsp1Al7lCXGlFsu+ZAkAvvE150fP6eGkaf5zIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhGcdea+IxR1uLqIjLC9yQJH4xoGDwCCnS4e5V8vKKbpGuupZwd6re69tfJjDBUU0h4Bry6ypbyvo/COVlBfX/OqE9pVR+d/8e2KxZSnSHZ70FIVCyVSDXhwchCm/V/Qu4vUgFkBBd9dgcGx+Lh/paXjoMBmp03htTYwPb9W4fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bqI9vevf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42fbc305914so5623672f8f.0
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 11:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768333036; x=1768937836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pMbPCQb+cR1ecNeiu0Q+lKYDn4THA/AxuTToyfvlIoA=;
        b=bqI9vevfUy/2bYueUGElzKewUbuyFLskGwaoAXnuL1+XW9+8wbj46Jd3Uds0vLrPs4
         WqtvbRZcalN2+5ITNTMaI9k7xoZ0OBGr0gIJfMjuE9JHiYa0m0ROcKBTagPvUPHkdRCl
         Gx15SPmrNFcTI/XEShOVziMcg7ppk/Pq3bu0n6fhM8RYHYU/kuWuTkeMy13FoIVOmsBW
         OdK4jFIlfB6rPhvAGOcchjvbC+KnqzqQVjz4N8ZrfhsVCRWjkfKbbSb6/KqXQsOX8aOP
         v5wCl9AJ0vRRgF+Lo9cBvbamkuXjucC5Mc0GjrQ4g3oP8u2NPWKqfrFUnuFJzIKT0E94
         YyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768333036; x=1768937836;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMbPCQb+cR1ecNeiu0Q+lKYDn4THA/AxuTToyfvlIoA=;
        b=hwFLR4JT4q8TxG+W7p51PeqDJDVKfq6KHy0NiP1lSJVnTg9eJQYnA1g3j0cnCmx1GK
         syyCrcUVZnsSePMGgLMvsSiRjgql3oBdCrMPjag1KW8nJYKVoFXofdmIErIT6LCdvd4Z
         e9LMhDF68ARbKQpSzm7+YQ8EU8hCNfGby7Rap0OlaX5MujEqhf4TnzWqeU0RObQ0q7ZB
         EKIJhoV5kofjhc7ijgHF3udGfoi6OYHAAEH1IN4blGX4O7i5dk51KllG4FsL8Qini+GC
         tJ1HwvuUUvgqKwhCQ3+sFA9WjpAOKZ2JieC+szew2IZPmkucy50JrWKTUS66RPXAoJhg
         JlUA==
X-Forwarded-Encrypted: i=1; AJvYcCXacVlz2TjJwbGqXzTX+l/BqtA0nTBShPdIfXpFVLrJNspsEWe2tIcmDJyLVUNZArjC1vt/sUZxmN7j@vger.kernel.org
X-Gm-Message-State: AOJu0YwrR4MxX012kAjYFRs/FBFOx+JFcD8i12Nb+TXFlqKp4+OWVkBw
	Gv7PkGLyNHCdM3ZTcUS135PuBwdN2I+uYvr5kAG0bRhqju73jaSNX+z/e/41K1U/Bvc=
X-Gm-Gg: AY/fxX6U9CrPVbXqbqc4gQSWvNJyjER51RfDL+bHMDPhwHlaXRF0rd5n36TCSKrqT9Y
	jSTiaKG4gDo4BBtiJJDqjvw0gErcvNuvpPYONH1E42xvcePQhrcRhsDd4NhpDrJRZsloBku7EdE
	RhrUMYJUWCz27SLgndS5DMKtMzEwChYdQoJ7Vdh+HMa/S9GaPFLUvajChSJXPP7t25Bx4b4gtSw
	6mzZhuKCE4pyFYvKV42mZk9vokYmS+m/RDXM8dFAKQH1TESKxmIFlBxuoAqwLY7Xq7xANsXw0pq
	53VC3hMTvYvMAaJTB+Ta3FWFE04xqB9U+vAN15yeeVYMnLm8hH8WgSdljR6GcQ+4v838GorlGhi
	f2R0XAzyiiJ64+BDp1D3lsMdks13Ae5cSzNhJo9jDY0d3hBLXQRN2bPvuQ2IS1dbWD1l7ifrSt3
	ZKTWT1LwA7l2HaWkiLF6X+tRaIbT1zrxhEw0ga
X-Received: by 2002:a05:6000:4026:b0:430:f40f:61ba with SMTP id ffacd0b85a97d-4342c54abebmr45937f8f.41.1768333035621;
        Tue, 13 Jan 2026 11:37:15 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee870sm46075376f8f.36.2026.01.13.11.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 11:37:15 -0800 (PST)
Message-ID: <c425bc04-2b01-4616-a244-01c896367f7a@suse.com>
Date: Tue, 13 Jan 2026 21:37:13 +0200
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
References: <56d12335986e41da81581ef724742319@baidu.com>
 <20260112095118.GAaWTEFkUFHMlu0W-A@fat_crate.local>
 <268e2f0512db435685af987a2ba6893c@baidu.com>
 <20260113095111.GHaWYVj4Crd2z8oLp-@fat_crate.local>
 <39cfb093256f4da78fe0bc9e814ce5d0@baidu.com>
 <20260113124837.GHaWY_JVdFi53mh6oO@fat_crate.local>
 <SJ1PR11MB6083F2650A8DB801F0EF26C8FC8EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
 <20260113191351.GQaWaZb6yzj4a9I_0Z@fat_crate.local>
 <6feff2b3-6088-412c-b0c6-1d32aa5a9d50@suse.com>
 <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20260113193327.GCaWaeB1rp7HCFJBHV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13.01.26 г. 21:33 ч., Borislav Petkov wrote:
> On Tue, Jan 13, 2026 at 09:25:19PM +0200, Nikolay Borisov wrote:
>> mce_need_notify even now works just in the early notifier because it's set
>> in mce_early_notifier() and subsequently reset in mce_notify_irq() which is
>> called immediately after the set.
> 
> You still need to call something in mce_timer_fn() to know whether to halve
> the interval or not.

Yes, and why is Li's approach not working, i.e if mc_poll_banks() 
returns a value signalling "i found an MCE" we halve, otherwise we 
double it?


> 
> I wonder if it would be better/cleaner if mce_early_notifier() halves the
> interval and mce_timer_fn() just reads only the current interval value...
> maybe that'll be less logic spread around...
> 

That's certainly doable, but why should the interval setting be coupled 
to the initial notifier and not to mc_poll_banks?

