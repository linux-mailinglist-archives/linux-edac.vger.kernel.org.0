Return-Path: <linux-edac+bounces-4792-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793EB52E33
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 12:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A79E1C827AE
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F30930FC03;
	Thu, 11 Sep 2025 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PcWnWvkB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CA23BD02
	for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586137; cv=none; b=aW0wD5nmQG2E/l+8JPYy6ew6ShBMW/0OosYoThWDiVi6rZezhtj68pxjM+KpH1IL729+AZv8+G1V+tiXQiVVZYYHgdOqrmZWpmOVpHpogaXcJItJeEkYEnICR4zOV4y3eBUYg6hjh5pUG3LdvYUfg8y7IalWixwjTJ9HZW2/6yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586137; c=relaxed/simple;
	bh=XrchZecD+iM0UHQWDWdbk069oueZ5j4zUVkEyhba5FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEHFkzpbHUxybJ5gbIeWb13N/s1py/B2Wl3VCR9p3n8k1icV2bPKCj7sKrk4ErAAUnm5A3FDfgMPpYWl/zofTTVGhraWUMDw4pjeo6A3WFEiHsncMPLP6rHvi/Yl9OTqYVnbDHq2HXW7NuxuTuNsAwH1Y+sQvvimoHWYYteahwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PcWnWvkB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso482843f8f.3
        for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757586133; x=1758190933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VaCvqUSodMr/1P2WtmBAIMqveOipHOIUI7cFp3Ss9Ls=;
        b=PcWnWvkB3iPoBTeA0nh9D2k7ccmlWyznXVGUl4GhqBz4HtkOWo33DA7p7pJqlO4KN8
         l59H0o/XmraFZ5d93/e6H+vxd9unI5KEqdLdQ4omfw49dCl4yrQxFwa4h3hos4aXsS3R
         c6pKLIml89XzmMSVvHAS5VzYFuLv60Aac7qLFpwOOc7ScMLSbeInCpzfGiyc/pDfj5eS
         754yoR9m2On8B1t3MMzL6sGEbmx5S22Cm5rtsCe4pDPjBkV2ciSvk3HuClsxMadtiUOg
         pnn6BpH88LjBwyB5alhgb2EeEUiky9hJsrZxCM02rAz6pERSLQexnKJjSzqL0BdDfEQj
         QBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757586133; x=1758190933;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VaCvqUSodMr/1P2WtmBAIMqveOipHOIUI7cFp3Ss9Ls=;
        b=nuDs4+JOBezmDNUU0np3+szjevvbq9PZh0W2sEmC9K/gMl/TslHZqKGv57JOAb/I0v
         MS949q250nl3CquMc2y8Zc8afjj7dY3kBy8Cn9a3k28hintqy7fNG5myKQnLYC7w0mdR
         e5GunKatSRaI9ObjOR2aTjgYWNRKgMaY+0OnrBbf+3HFoYVg00HyzxDAvepdmf7gDIwf
         CYEUPJCV+gN0FpvXckCa0YB4owUmtoIvpobjHZpUEvtsayUP+w6ZllHqi3if93uDWKcw
         LREPHPYNayiIeSUqgmRCyCjxJDxDqvoOdwiQCvZ4zcGNqEIdh+j0lmC7KAEnmpiXlXwi
         ZLYA==
X-Forwarded-Encrypted: i=1; AJvYcCWE7E/MAywEDCHOMDrTxxKTZPA3v+YYeEQgz/uMktogD3Y9X7FWmaHQot7YXVSfSl4iEtxxGbjovzJc@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhIVSbHIP32Xrev9sLnH1V6EQg+FVHHqmr8PryvP9xxbkxH7d
	fphpGMAJrHPyeWMyCd+WbwkouxQ8xavLEYxtSXDd8eR/lWruOKlPM/0DJ8pQZpR9vKk=
X-Gm-Gg: ASbGncs8UaZOBMkxqChxPeinvVMc2zxBVSpdFv+S0rY6QqIgQeX2+Idn4CPSdiiHCZy
	gYYjwz9j2Xr6DhBkhEEE1EInhKr64U2ptPpQIFhFma1ulG4WxPToj1wzAnYz0dEeXQ0kXovSZ7Q
	iUUOU6fnXqXQ6ewhCMvoSRhzKFneTybimjbA2dVxm9C8qDKmpv9aqOA8rAUkiiRSx2s4Z2cD86Q
	96uawfbKqrQu5mPIdPnAo6++AIH87oxikUP5lu6Zk3zw3c3JgyTh3m3wS/CaJRaHsLYE3LssXKm
	DousNrc8Df3ux1RUJcI4i2WPKEqU4sGR5ExJfzn4u0WO25YL7KCWx+5OFrSy3pe869ha6tEVxcr
	fMkPXkLrD5KEJdYRW+US/SLnc7w==
X-Google-Smtp-Source: AGHT+IEecA9OPjkM3C+7UWPq2SdB0g7szX8lW/R9PZkVY1wz6UP3d6yUKt66x8EDdhmdc25mwV4zFA==
X-Received: by 2002:a05:6000:40da:b0:3e2:b2f0:6e57 with SMTP id ffacd0b85a97d-3e642f91589mr16285645f8f.36.1757586133265;
        Thu, 11 Sep 2025 03:22:13 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015621a3sm12130445e9.0.2025.09.11.03.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 03:22:12 -0700 (PDT)
Message-ID: <d5377e66-dbbc-4883-b223-ef6c0360e0dd@suse.com>
Date: Thu, 11 Sep 2025 13:22:10 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/15] x86/mce/amd: Enable interrupt vectors once
 per-CPU on SMCA systems
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-10-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250908-wip-mca-updates-v6-10-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/25 18:40, Yazen Ghannam wrote:
> Scalable MCA systems have a per-CPU register that gives the APIC LVT
> offset for the thresholding and deferred error interrupts.
> 
> Currently, this register is read once to set up the deferred error
> interrupt and then read again for each thresholding block. Furthermore,
> the APIC LVT registers are configured each time, but they only need to
> be configured once per-CPU.
> 
> Move the APIC LVT setup to the early part of CPU init, so that the
> registers are set up once. Also, this ensures that the kernel is ready
> to service the interrupts before the individual error sources (each MCA
> bank) are enabled.
> 
> Apply this change only to SMCA systems to avoid breaking any legacy
> behavior. The deferred error interrupt is technically advertised by the
> SUCCOR feature. However, this was first made available on SMCA systems.
> Therefore, only set up the deferred error interrupt on SMCA systems and
> simplify the code.
> 
> Guidance from hardware designers is that the LVT offsets provided from
> the platform should be used. The kernel should not try to enforce
> specific values. However, the kernel should check that an LVT offset is
> not reused for multiple sources.
> 
> Therefore, remove the extra checking and value enforcement from the MCE
> code. The "reuse/conflict" case is already handled in
> setup_APIC_eilvt().
> 
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-15-865768a2eef8@amd.com
>      
>      v5->v6:
>      * Applied "bools to flags" and other fixups from Boris.
>      
>      v4->v5:
>      * Added back to set.
>      * Updated commit message with more details.
>      
>      v3->v4:
>      * Dropped from set.
>      
>      v2->v3:
>      * Add tags from Tony.
>      
>      v1->v2:
>      * Use new per-CPU struct.
>      * Don't set up interrupt vectors.
> 
>   arch/x86/kernel/cpu/mce/amd.c | 121 ++++++++++++++++++------------------------
>   1 file changed, 53 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 1b1b83b3aef9..a6f5c9339d7c 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -43,9 +43,6 @@
>   /* Deferred error settings */
>   #define MSR_CU_DEF_ERR		0xC0000410

nit: While touching this code why not finally rename this in line with 
the APM, section 9.3.1.4: MCA_INTR_CFG

Perhaps as a separate patch. I see that you did send a patch containing 
this rename: 
https://lore.kernel.org/all/20231118193248.1296798-13-yazen.ghannam@amd.com/ 
But I guess it didn't land.

