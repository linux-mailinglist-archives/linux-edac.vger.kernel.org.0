Return-Path: <linux-edac+bounces-4242-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3D8AE84A9
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6A81692B9
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810F26739E;
	Wed, 25 Jun 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OsckGUNl"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4C2609FA
	for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857783; cv=none; b=cHyG65UA4+wf6LmayhWQY//MNG5CdHmn43qrULhybP0cRgi6gKX9pNR4tlWeutdOiueZnk9NE3n0aYWUNOsSq6cDDx/3OA2z6CzZRBT7i1RrHlxoNgDrNBV3zhSXUjicH76d+ulP3R7nYvjv9sWvyYu+fwFd+pZ5yWqqoiZfnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857783; c=relaxed/simple;
	bh=u97qOISPJaT3WV2nX99ofuyg+QvAdJ71vrV2d3v6F2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxiEcv7qJye5G4eaSYtDXyw7J+9GAh0BUwqnfwRjuf9fmuJ7kXnc2DQ/8kO67S2eP+NR8GAP+jgCodvxZ0fGAuFHJP1Xnja5YbZZfsMu1BIi9IxZlqZ/khe4k+BYS2uFbrO1LXhl+HijrZku0s4o9/KvgJze8OcDe1m8kPMsXWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OsckGUNl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d6ade159so49323785e9.1
        for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 06:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750857778; x=1751462578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bABGSHCQTbqZmqC1BoeQalaD2pO0xVeiLfITLkYqkXA=;
        b=OsckGUNlmJv55yuT2o7rTME67lfRbp81+ZxkweC/vcssR97WBFzjEhQq5tyj48Mokc
         HBtN45rvirxdV5EiEntj2DjjZ+/ttM7CdyqlaklTO+ziFLJy7j+XaavKSnH5JMS9VB5/
         MouNdfiF72KrHVHVSyl8etpiiY8dPiv5UcnCazxq0tzjgA5LAQSx+lBtmMkvswOzuaX1
         6WUYgXMwDelOYAXk86ivCbJtmzVXrxn6W1zO37WtLz35Q5T00SfW++oOU0rXowlfCGiB
         F4H6eJVrevAvP/hgdA7iWQN9yZ+4oIlvXlxQrZdmKrb5dvbEPoKGclXH2b5dpMeNpoyT
         2fFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750857778; x=1751462578;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bABGSHCQTbqZmqC1BoeQalaD2pO0xVeiLfITLkYqkXA=;
        b=kFiJUdltH0iTSNV6Zfe33mJvt5t7Uy4GUL4nzEWai+VSl50/FVsdppbiXgtvshigkc
         kTCFAQEIMKndQrHUlFL1UgsmyPAWHlZmceyizbIkkkV4pGTIluJCMaD3nrJQVZzXOtm5
         ZuiCnWrZniFe/DmnnbBHNigfOHt1Lz+B3lvcQLo0PvDyiyFiseYDTAVb5wcLLm9jKKG3
         bqQ49D8xcTnNYIh6pgZdyzL0UQMgabuwlUoS0dj3zMcyfQeFxTwSr/gsJcCBXGgb07E+
         swIxBFlzAmF5Ng3ke457LxhMmtJVOWBjt1glZ4XrRYpEWyrERKeqwfCuSK2AS9CrNtu9
         uRIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrf1WLAgHuMp99dUFg5zaaCzuHvA9sbjMSouvqasaUikJJS46oUZWEdbIgRcSEWuk9JfOxsEgj9U5d@vger.kernel.org
X-Gm-Message-State: AOJu0YyEOBhwAF7/bPys5LamvKAW0Syj0ztCx+1Z5xhD9H25j65MScbP
	A7xHw0S8JteOkm3gwCkbjmtiX2eKEg0uGPrC/2ZcefLwfVLwLfoLQwL/Wr5xosyfMKc=
X-Gm-Gg: ASbGncsFStmYzixqvespRYcJBUBKeWhrDmop4fqlmowJe7bM2etX+dyNH9IOqviDD9V
	b/Kn4qmm/17o4RF3Jwz3uryQ+rcFkOZt6qcc0OiCYA+ZR/lf0kDtP6mQww+g0BQXskN6tZGA33o
	tHwDMdhBh241gCfaEMzn4ruXKw6bx2ohn4LXS10toz7xEXguBA2cSl7SACd7WczB25smhqBnfrI
	zAMykkYDP8+rnCHWb5QnLpK4LJ232C8T4NrHbl5AQpL317a/iVTNRRBByhOY4DR+SwRt28zw+x3
	DoDF+Fb/BzDqgptpV4mgEF8zFig6/vazUlTSfKv/fmFidCH6qr6Fv3pIRe+FO+xdNQ==
X-Google-Smtp-Source: AGHT+IFZ7ECpggmMtWg6NFvDPFP6Ox75KssuEaqJy0eDAckBmjnyg9K1E81fMEIDhXv9aqRdsbcWMw==
X-Received: by 2002:a05:600c:5305:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-45381ae787fmr29144605e9.6.1750857778330;
        Wed, 25 Jun 2025 06:22:58 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2a4csm4686258f8f.65.2025.06.25.06.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 06:22:58 -0700 (PDT)
Message-ID: <38243641-6aea-4d85-aeea-310c849f1043@suse.com>
Date: Wed, 25 Jun 2025 16:22:56 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/22] x86/mce: Restore poll settings after storm
 subsides
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250624-wip-mca-updates-v4-2-236dd74f645f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 17:15, Yazen Ghannam wrote:
> Users can disable MCA polling by setting the "ignore_ce" parameter or by
> setting "check_interval=0". This tells the kernel to *not* start the MCE
> timer on a CPU.
> 
> If the user did not disable CMCI, then storms can occur. When these
> happen, the MCE timer will be started with a fixed interval. After the
> storm subsides, the timer's next interval is set to check_interval.

I think the subject of the patch doesn't do justice to the patch 
content. In fact, what this change does is ensure the timer function 
honors CE handling being disabled either via ignore_ce or check_interval 
being 0 when a CMCI storm subsides. So a subject along the lines of:

"Ensure user settings are considered when CMCI storm subsides" or 
something like that is more descriptive of what you are doing.

At the very least you are not restoring anything, because even without 
this patch when the storm subsided you'd start the timer with a value of 
'iv'.

> 
> This disregards the user's input through "ignore_ce" and
> "check_interval". Furthermore, if "check_interval=0", then the new timer
> will run faster than expected.
> 
> Create a new helper to check these conditions and use it when a CMCI
> storm ends.
> 
> Fixes: 7eae17c4add5 ("x86/mce: Add per-bank CMCI storm mitigation")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Cc: stable@vger.kernel.org
> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com
>      
>      v3->v4:
>      * Update commit message.
>      * Move to beginning of set.
>      * Note: Polling vs thresholding use case updates not yet addressed.
>      
>      v2->v3:
>      * New in v3.
> 
>   arch/x86/kernel/cpu/mce/core.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 07d61937427f..ae2e2d8ec99b 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1740,6 +1740,11 @@ static void mc_poll_banks_default(void)
>   
>   void (*mc_poll_banks)(void) = mc_poll_banks_default;
>   
> +static bool should_enable_timer(unsigned long iv)
> +{
> +	return !mca_cfg.ignore_ce && iv;
> +}
> +
>   static void mce_timer_fn(struct timer_list *t)
>   {
>   	struct timer_list *cpu_t = this_cpu_ptr(&mce_timer);
> @@ -1763,7 +1768,7 @@ static void mce_timer_fn(struct timer_list *t)
>   
>   	if (mce_get_storm_mode()) {
>   		__start_timer(t, HZ);
> -	} else {
> +	} else if (should_enable_timer(iv)) {
>   		__this_cpu_write(mce_next_interval, iv);
>   		__start_timer(t, iv);
>   	}
> @@ -2156,7 +2161,7 @@ static void mce_start_timer(struct timer_list *t)
>   {
>   	unsigned long iv = check_interval * HZ;
>   
> -	if (mca_cfg.ignore_ce || !iv)
> +	if (!should_enable_timer(iv))
>   		return;
>   
>   	this_cpu_write(mce_next_interval, iv);
> 


