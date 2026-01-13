Return-Path: <linux-edac+bounces-5625-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B14D1AEB0
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 19:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69413021E5E
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A48E33B962;
	Tue, 13 Jan 2026 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VIvl7rJU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC31DEFE9
	for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 18:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330513; cv=none; b=M4XkLaVzhlxnKGQdVmlCKnFXyhjUfv1/Tq63v/lGZqYg7bLdmlEzTgX/k2uxN67R/MJeILQaPz5ltZ3a7jXSdXja+WlkK8SEGy4Bi/LyoPBBZ8lljTiJfTloUjl0OiWxHswaWo3BqzqYknxmsyYOrRwF8neQcV3g3JWXWFcExeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330513; c=relaxed/simple;
	bh=7hQj8LT9Mvb7ef+0Zo1a2zCKdyjeOLScygrgWChbH+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVHtE9ZwMOeCjspbQpzaxxC4LMOlAn0o9rFqGOgNQ9L3Qyq3PYNiErZ5ByI9vAy6lM845vBQf3sEqXWu2yvjwGCQf/3b8LOfW1oGseaayH5BvrF91WuJ410sNOnRqcizsNIVrf1zS8fI28bBjRC7jKVWLLkQuKar04d4NtwJMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VIvl7rJU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso917705e9.0
        for <linux-edac@vger.kernel.org>; Tue, 13 Jan 2026 10:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768330510; x=1768935310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=imf93NrPz8oaw63OLfKye7TxPMFzSokmdBq/pLWmXmY=;
        b=VIvl7rJU/o2njax4VSp4VQZA82eDPT2amPbmqBYaByNEb86rjNg/bKg8CbZKCadqd6
         Jr+aNlgDOb9XTX7CnzD9ZKgxSa6JcKbNBmYti6jUqaNPRCTIubXjquNRI/ox65cMmAZx
         FgEb3ygfaXbWUh+Xmah2h/J1FOwRhpybtmohbBb5i578lLfzcknIf/URL9+kR+B7KvS5
         4o8lEDqSjFLmWskrqibk0a4atGlkzH93nCbm09ImJ6fUmf/lqKtTQE4Aiwj851iMdR5W
         1LgFpg3jEJcFhq8a0AWLZVF9zyiflmxKBA32XwJuuWLGOjfuNis66SDdo5OPU2rxMFth
         sZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768330510; x=1768935310;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imf93NrPz8oaw63OLfKye7TxPMFzSokmdBq/pLWmXmY=;
        b=rLqTE8kn5s2qK+9wMQMVg87k8vHpqot5GbbGVsdj0M36xYwoHTUdMpk1kVx25suwB7
         9RM8huVCnZlJ0a6PRe08N6i1CMLhD54MpXLl3BzLlH+GvNQujbthtJg4AN2LgMwipCLg
         F9bwGHVixtS+4JBpAyak1Di4lxnfLy2aFpyI7l40xSGc45307wg7lFfoidYzQ64FZwjp
         NFcmNcZ5E8GVem8xVyJCtzieAl0rPPSe0f20nMIaEGE5VNIziP1DHBR/N2UkMO5WgkrP
         dz9w7uNJkwUSMS9SyTm9v2UCQj0TJW0T05nuGpisuxf1ivGjH47tEOxxdphp5S7dl73z
         3OcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWa1v4cm8AxQrqMxVNOfD5PZiWbwx3Hndl0whqv2Q1L0IS1oqzW8LnG1IUv5Je5acYm8qce25QIkgWX@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9e3AcmFI5sT1nH74B98xMm+GXKdAnF5zdj3xnexY+mcvBoZWK
	vV0A7cMB0odjcf5o6AibsYULaSnMsSTkv17dPCZZC98DrmJSz7tPdNkERlIp9ka49g8=
X-Gm-Gg: AY/fxX78HxVjAL4awKQBI1+NVCMzw00zIaA6My6z6Pka+k6mtCxqX+pkXl6Ct8WFxlb
	8aMq2STIcmQ9OkFtjLmIfpjh8UIIM1tg9Ja+ZNLWYODSBtmazVPKT7ZVSGem8orAiTIoT3VfGSq
	tRsUl2qcMXs4AKwuZdd2HcBAfxGN6Bkw5K3tLC/5+z5YWoQDkCbf11vLV1E1RBh2GnaSMcG6deI
	dBmfU8PkmvA1PDLBx1Plm0NU49m3gzTjtw5lV0ypF01pGwADgMPXqBGgr8zpp7oBMHnekkXN+ge
	+IsgtV8hzf7wEVhn/jiov9A/pAi4USmWyrbizftLGhlh08i+7H+TOeoNjCby2eTIrTDvn3CzWmB
	PT/8nfEu2FmwQXbAOEh46VMDGeojrf1puVFVYc58sdg/ewNaa8HfCZtSJWXn7fFFzBVF/ZQBVcd
	OwRcxoJFLMDOa04lmk0P2C027BQj4ULoMCjqHo
X-Received: by 2002:a05:600c:a013:b0:477:63b5:6f39 with SMTP id 5b1f17b1804b1-47ee3372fa2mr2462545e9.19.1768330510196;
        Tue, 13 Jan 2026 10:55:10 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.217.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee27dffcdsm3850605e9.6.2026.01.13.10.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 10:55:09 -0800 (PST)
Message-ID: <be786e9a-0302-47be-b2a8-bfa4449c7ab7@suse.com>
Date: Tue, 13 Jan 2026 20:55:08 +0200
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
> 
> I can reproduce here on an Icelake system. Booted with mce=no_cmci to force polling
> (and turned of BIOS firmware first mode).  Injecting an error every 30 seconds I also see
> constant 327 seconds between logs (multiple logs show up because my injection picks memory
> channel "randomly", so there can be several banks with errors when polling happens).
> 
> $ dmesg | grep 'Machine Check Event:'
> [  662.632988] EDAC skx MC4: CPU 40: Machine Check Event: 0x0 Bank 13: 0x8c00014200800090
> [  662.727377] EDAC skx MC6: CPU 40: Machine Check Event: 0x0 Bank 21: 0x8c0000c200800090
> [  990.283484] EDAC skx MC4: CPU 121: Machine Check Event: 0x0 Bank 13: 0x8c00010200800090
> [  990.378233] EDAC skx MC6: CPU 121: Machine Check Event: 0x0 Bank 21: 0x8c00014200800090
> [  990.467199] EDAC skx MC0: CPU 3: Machine Check Event: 0x0 Bank 13: 0x8c00004200800090
> [ 1317.939260] EDAC skx MC4: CPU 122: Machine Check Event: 0x0 Bank 13: 0x8c00010200800090
> [ 1318.033721] EDAC skx MC6: CPU 122: Machine Check Event: 0x0 Bank 21: 0x8c00010200800090
> [ 1318.122612] EDAC skx MC0: CPU 14: Machine Check Event: 0x0 Bank 13: 0x8c00004200800090
> [ 1318.211507] EDAC skx MC2: CPU 14: Machine Check Event: 0x0 Bank 21: 0x8c00004200800090
> [ 1645.590773] EDAC skx MC4: CPU 129: Machine Check Event: 0x0 Bank 13: 0x8c00010200800090
> [ 1645.685153] EDAC skx MC6: CPU 129: Machine Check Event: 0x0 Bank 21: 0x8c00018200800090
> [ 1645.773744] EDAC skx MC0: CPU 100: Machine Check Event: 0x0 Bank 13: 0x8c00004200800090
> 
> -Tony
> 

At this stage I think lirongqi's patch is ok, but in the long run (i.e 
tomorrow) I will send a patch that simply eliminates mce_notify_irq's 
call in mce_timer_fn. I.e that function should be called only from the 
early notifier.

