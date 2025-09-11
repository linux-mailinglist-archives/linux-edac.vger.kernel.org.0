Return-Path: <linux-edac+bounces-4797-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D611AB539CE
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 19:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C1F7A94A9
	for <lists+linux-edac@lfdr.de>; Thu, 11 Sep 2025 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA14F21019C;
	Thu, 11 Sep 2025 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sp/YRrM/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693382B9A4
	for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610082; cv=none; b=oTSOUK8JyFHjE2wOOSXJRx1kt+ULKQjo8z3MTzZGFOAP9zs8IBuYX0AhictqwE+OqX6nU8lDgRSE9uMKkzbM2udUn5PFJ+IexkrdZA3EVlA0sL8TlYySufMF5/LyBBKQ2s1uoRIGW5gCqj9R/o3J+PpU9stMSm2GP5T7ZuBghdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610082; c=relaxed/simple;
	bh=gVSxVqSCDq0YtaIw+KB6d437wvZCu0xUFkD4L8LCKrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSrIQhF40Wj6hbZRgvHnpNe94Tqa4yYEeM28kQimkyfsZcS7CmyKH5PB2e9WkZ17mqVJpeBijHznMHwzUxylrcbVFV1dV49zJtuo1T+eiTWH4BRaDLbhQdc2Kl8jC2AUWi1w/6mfFPJqHWmwCt3F4gVz3iT/n3jJWgyz+PIDAOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sp/YRrM/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45cb6180b60so7011105e9.0
        for <linux-edac@vger.kernel.org>; Thu, 11 Sep 2025 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757610079; x=1758214879; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=01u7NqNId6dlrMx1BxA4hAG06Z7Pre1ggKG23uhNj48=;
        b=Sp/YRrM/1UqmztQMCy4R8n/G9j8xjjuq2T9dEYKapzNqjZ/Y5xs1DECUKISc9Dfg6x
         qxJNNM+y8GMk9ckuPehq3jN6+GueOrzwNQplmI53OwSJ72uaJ9EorCN5shH5OW9szzuj
         w5ToWDxxrVaDiN7uwWoZ0M3+ohUpXbEE2Ha4ys5H7D/RVpVRjfZjTJ+LO3/0a3qvsOvx
         x/EhiqAEO8NHp3M7eaxOSOdv0e0a59niDJYFTc0mY8G8TSCxezbk+NiYHdDu0dnMim0J
         lzJbvYy/oJ5tjsSXZ6rQerZ5kdqsjNJWWMFpPZ1ljO1fU7ViVxOcLjo5tlKo5LkZJauT
         AfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757610079; x=1758214879;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01u7NqNId6dlrMx1BxA4hAG06Z7Pre1ggKG23uhNj48=;
        b=Mj4H9aKVzbv1jyk/vVs+8x6Ma+Dpb6WI5EjgJZzlzZtg27glota6LGnu5bmu3tYXMp
         yYV2apX3qsX+chVWwXI8exFNMWUIQMMIEBNre3aQ55hQTjwfhuAkbQQcroUDCwL8OG/p
         SOcQhQg1BDVCY14D/hTWsXwHUbekX2UU4skUvP0E27D9FYk5v0LQFqmkCIe13eOrPGQA
         JUiwU4JreMUDHf+LHfWPcJMJ0nXwJwia/BiIuZNs48FkC0KF8qn94vQpi0KKYpPF6GK9
         Lmq+g0r7C3HkcJA69ZiCPVT31CNr7FnC3iZktk1DpigXVizV748wGJ8awPuv+oNC4wnQ
         ceGA==
X-Forwarded-Encrypted: i=1; AJvYcCXsWW6PuIUBNtmRc+KUreNT25EIwRpu+Vtvk5XVuVV82oZYVrXTFklVQe3E3peIer2hKdFv8/GpRlF0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15sp1e0zq/Y/htQNg6q1mY0jyo7R+pVZV7mV3pL1+n1+bgJ80
	RXup0pDurXiN3G9fQPHfqrCg0lEjERAxOyI62Vz9k7v9avlQRUsXpVFQd/8md25ress=
X-Gm-Gg: ASbGncuhkqIiRSYCA3vcaLrjLDFn04wWiJQ75ejXbodQv9JWfo0KZsDWl7c7e3xJiFj
	aIHZJMqkU2yi+xkwjxroI0mWYmIqXkknQJAhngA2U+aWDU6M3tEHWIvWjQYNEuOxXXjZvLkvzvM
	u8WKCg/pHsfx+8OCzkukTHN43k21HoVV+EookAGu1YTQ1Rq4NPBA+t+KJEGhxqraooTHdy0VN9k
	aWEsMC5+qUROXS36UoK07va+KRKaqOxjrenc382A1454CpZLl3rKn6UHM8IEJt1B7/8sy/RMuqQ
	aJLvFT1mjxqKDYNHxOuqdHQ5cO7+4DzAoJBVqVp6fn15h4wMOfmnM02vwFuB623seZPZEe3uS8F
	MunTOOiVVKSlRRXGW7qEyc+oVR/z1ZDrDlEGX
X-Google-Smtp-Source: AGHT+IH/Pk5uPTAhHY4LoaceFxcx/IkHYdnyisfdHIQ6V8prgqn4yWMmzIvuKttH/oGmg8vryV4/bA==
X-Received: by 2002:a05:600c:4685:b0:458:a559:a693 with SMTP id 5b1f17b1804b1-45f211f88abmr1670575e9.18.1757610078478;
        Thu, 11 Sep 2025 10:01:18 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156c64bsm33140945e9.2.2025.09.11.10.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 10:01:18 -0700 (PDT)
Message-ID: <64314c7a-5212-4bf0-8181-8bbada0e81b5@suse.com>
Date: Thu, 11 Sep 2025 20:01:17 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/15] x86/mce: Save and use APEI corrected threshold
 limit
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 xsFNBGcrpvIBEAD5cAR5+qu30GnmPrK9veWX5RVzzbgtkk9C/EESHy9Yz0+HWgCVRoNyRQsZ
 7DW7vE1KhioDLXjDmeu8/0A8u5nFMqv6d1Gt1lb7XzSAYw7uSWXLPEjFBtz9+fBJJLgbYU7G
 OpTKy6gRr6GaItZze+r04PGWjeyVUuHZuncTO7B2huxcwIk9tFtRX21gVSOOC96HcxSVVA7X
 N/LLM2EOL7kg4/yDWEhAdLQDChswhmdpHkp5g6ytj9TM8bNlq9I41hl/3cBEeAkxtb/eS5YR
 88LBb/2FkcGnhxkGJPNB+4Siku7K8Mk2Y6elnkOctJcDvk29DajYbQnnW4nhfelZuLNupb1O
 M0912EvzOVI0dIVgR+xtosp66bYTOpX4Xb0fylED9kYGiuEAeoQZaDQ2eICDcHPiaLzh+6cc
 pkVTB0sXkWHUsPamtPum6/PgWLE9vGI5s+FaqBaqBYDKyvtJfLK4BdZng0Uc3ijycPs3bpbQ
 bOnK9LD8TYmYaeTenoNILQ7Ut54CCEXkP446skUMKrEo/HabvkykyWqWiIE/UlAYAx9+Ckho
 TT1d2QsmsAiYYWwjU8igXBecIbC0uRtF/cTfelNGrQwbICUT6kJjcOTpQDaVyIgRSlUMrlNZ
 XPVEQ6Zq3/aENA8ObhFxE5PLJPizJH6SC89BMKF3zg6SKx0qzQARAQABzSZOaWtvbGF5IEJv
 cmlzb3YgPG5pay5ib3Jpc292QHN1c2UuY29tPsLBkQQTAQoAOxYhBDuWB8EJLBUZCPjT3SRn
 XZEnyhfsBQJnK6byAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJECRnXZEnyhfs
 XbIQAJxuUnelGdXbSbtovBNm+HF3LtT0XnZ0+DoR0DemUGuA1bZAlaOXGr5mvVbTgaoGUQIJ
 3Ejx3UBEG7ZSJcfJobB34w1qHEDO0pN9orGIFT9Bic3lqhawD2r85QMcWwjsZH5FhyRx7P2o
 DTuUClLMO95GuHYQngBF2rHHl8QMJPVKsR18w4IWAhALpEApxa3luyV7pAAqKllfCNt7tmed
 uKmclf/Sz6qoP75CvEtRbfAOqYgG1Uk9A62C51iAPe35neMre3WGLsdgyMj4/15jPYi+tOUX
 Tc7AAWgc95LXyPJo8069MOU73htZmgH4OYy+S7f+ArXD7h8lTLT1niff2bCPi6eiAQq6b5CJ
 Ka4/27IiZo8tm1XjLYmoBmaCovqx5y5Xt2koibIWG3ZGD2I+qRwZ0UohKRH6kKVHGcrmCv0J
 YO8yIprxgoYmA7gq21BpTqw3D4+8xujn/6LgndLKmGESM1FuY3ymXgj5983eqaxicKpT9iq8
 /a1j31tms4azR7+6Dt8H4SagfN6VbJ0luPzobrrNFxUgpjR4ZyQQ++G7oSRdwjfIh1wuCF6/
 mDUNcb6/kA0JS9otiC3omfht47yQnvod+MxFk1lTNUu3hePJUwg1vT1te3vO5oln8lkUo9BU
 knlYpQ7QA2rDEKs+YWqUstr4pDtHzwQ6mo0rqP+zzsFNBGcrpvIBEADGYTFkNVttZkt6e7yA
 LNkv3Q39zQCt8qe7qkPdlj3CqygVXfw+h7GlcT9fuc4kd7YxFys4/Wd9icj9ZatGMwffONmi
 LnUotIq2N7+xvc4Xu76wv+QJpiuGEfCDB+VdZOmOzUPlmMkcJc/EDSH4qGogIYRu72uweKEq
 VfBI43PZIGpGJ7TjS3THX5WVI2YNSmuwqxnQF/iVqDtD2N72ObkBwIf9GnrOgxEyJ/SQq2R0
 g7hd6IYk7SOKt1a8ZGCN6hXXKzmM6gHRC8fyWeTqJcK4BKSdX8PzEuYmAJjSfx4w6DoxdK5/
 9sVrNzaVgDHS0ThH/5kNkZ65KNR7K2nk45LT5Crjbg7w5/kKDY6/XiXDx7v/BOR/a+Ryo+lM
 MffN3XSnAex8cmIhNINl5Z8CAvDLUtItLcbDOv7hdXt6DSyb65CdyY8JwOt6CWno1tdjyDEG
 5ANwVPYY878IFkOJLRTJuUd5ltybaSWjKIwjYJfIXuoyzE7OL63856MC/Os8PcLfY7vYY2LB
 cvKH1qOcs+an86DWX17+dkcKD/YLrpzwvRMur5+kTgVfXcC0TAl39N4YtaCKM/3ugAaVS1Mw
 MrbyGnGqVMqlCpjnpYREzapSk8XxbO2kYRsZQd8J9ei98OSqgPf8xM7NCULd/xaZLJUydql1
 JdSREId2C15jut21aQARAQABwsF2BBgBCgAgFiEEO5YHwQksFRkI+NPdJGddkSfKF+wFAmcr
 pvICGwwACgkQJGddkSfKF+xuuxAA4F9iQc61wvAOAidktv4Rztn4QKy8TAyGN3M8zYf/A5Zx
 VcGgX4J4MhRUoPQNrzmVlrrtE2KILHxQZx5eQyPgixPXri42oG5ePEXZoLU5GFRYSPjjTYmP
 ypyTPN7uoWLfw4TxJqWCGRLsjnkwvyN3R4161Dty4Uhzqp1IkNhl3ifTDYEvbnmHaNvlvvna
 7+9jjEBDEFYDMuO/CA8UtoVQXjy5gtOhZZkEsptfwQYc+E9U99yxGofDul7xH41VdXGpIhUj
 4wjd3IbgaCiHxxj/M9eM99ybu5asvHyMo3EFPkyWxZsBlUN/riFXGspG4sT0cwOUhG2ZnExv
 XXhOGKs/y3VGhjZeCDWZ+0ZQHPCL3HUebLxW49wwLxvXU6sLNfYnTJxdqn58Aq4sBXW5Un0Q
 vfbd9VFV/bKFfvUscYk2UKPi9vgn1hY38IfmsnoS8b0uwDq75IBvup9pYFyNyPf5SutxhFfP
 JDjakbdjBoYDWVoaPbp5KAQ2VQRiR54lir/inyqGX+dwzPX/F4OHfB5RTiAFLJliCxniKFsM
 d8eHe88jWjm6/ilx4IlLl9/MdVUGjLpBi18X7ejLz3U2quYD8DBAGzCjy49wJ4Di4qQjblb2
 pTXoEyM2L6E604NbDu0VDvHg7EXh1WwmijEu28c/hEB6DwtzslLpBSsJV0s1/jE=
In-Reply-To: <20250908-wip-mca-updates-v6-15-eef5d6c74b9c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/25 18:40, Yazen Ghannam wrote:
> The MCA threshold limit generally is not something that needs to change
> during runtime. It is common for a system administrator to decide on a
> policy for their managed systems.
> 
> If MCA thresholding is OS-managed, then the threshold limit must be set
> at every boot. However, many systems allow the user to set a value in
> their BIOS. And this is reported through an APEI HEST entry even if
> thresholding is not in FW-First mode.
> 
> Use this value, if available, to set the OS-managed threshold limit.
> Users can still override it through sysfs if desired for testing or
> debug.
> 
> APEI is parsed after MCE is initialized. So reset the thresholding
> blocks later to pick up the threshold limit.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250825-wip-mca-updates-v5-20-865768a2eef8@amd.com
>      
>      v5->v6:
>      * No change.
>      
>      v4->v5:
>      * No change.
>      
>      v3->v4:
>      * New in v4.
> 
>   arch/x86/include/asm/mce.h          |  6 ++++++
>   arch/x86/kernel/acpi/apei.c         |  2 ++
>   arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
>   arch/x86/kernel/cpu/mce/internal.h  |  2 ++
>   arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
>   5 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 7d6588195d56..1cfbfff0be3f 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
>   /* Disable CMCI/polling for MCA bank claimed by firmware */
>   extern void mce_disable_bank(int bank);
>   
> +#ifdef CONFIG_X86_MCE_THRESHOLD
> +void mce_save_apei_thr_limit(u32 thr_limit);
> +#else
> +static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
> +#endif /* CONFIG_X86_MCE_THRESHOLD */
> +
>   /*
>    * Exception handler
>    */
> diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
> index 0916f00a992e..e21419e686eb 100644
> --- a/arch/x86/kernel/acpi/apei.c
> +++ b/arch/x86/kernel/acpi/apei.c
> @@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
>   	if (!cmc->enabled)
>   		return 0;
>   
> +	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
> +
>   	/*
>   	 * We expect HEST to provide a list of MC banks that report errors
>   	 * in firmware first mode. Otherwise, return non-zero value to
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index b895559e80ad..9b746080351f 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
>   	}
>   }
>   
> +/* Try to use the threshold limit reported through APEI. */
> +static u16 get_thr_limit(void)
> +{
> +	u32 thr_limit = mce_get_apei_thr_limit();
> +
> +	/* Fallback to old default if APEI limit is not available. */
> +	if (!thr_limit)
> +		return THRESHOLD_MAX;
> +
> +	return min(thr_limit, THRESHOLD_MAX);
> +}
> +
>   static void mce_threshold_block_init(struct threshold_block *b, int offset)
>   {
>   	struct thresh_restart tr = {
> @@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
>   		.lvt_off		= offset,
>   	};
>   
> -	b->threshold_limit		= THRESHOLD_MAX;
> +	b->threshold_limit		= get_thr_limit();
>   	threshold_restart_block(&tr);
>   };
>   
> @@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
>   	b->address		= address;
>   	b->interrupt_enable	= 0;
>   	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
> -	b->threshold_limit	= THRESHOLD_MAX;
> +	b->threshold_limit	= get_thr_limit();
>   
>   	if (b->interrupt_capable) {
>   		default_attrs[2] = &interrupt_enable.attr;
> @@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
>   
>   	list_add(&b->miscj, &tb->miscj);
>   
> +	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);

Why is this necessary? Shouldn't this patch consist of mainly 
s/THRESHOLD_MAX/get_thr_limit();


In allocate_threshold_block have already properly set threshold_limit. 
So this change really ensures threshold_restart_block is being called 
for the given block being initialized. Ignoring the changed threshold 
limit logic, why is this extra call necessary now and wasn't before?


> +
>   	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
>   	if (err)
>   		goto out_free;
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 9920ee5fb34c..a31cf984619c 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -67,6 +67,7 @@ void mce_track_storm(struct mce *mce);
>   void mce_inherit_storm(unsigned int bank);
>   bool mce_get_storm_mode(void);
>   void mce_set_storm_mode(bool storm);
> +u32  mce_get_apei_thr_limit(void);
>   #else
>   static inline void cmci_storm_begin(unsigned int bank) {}
>   static inline void cmci_storm_end(unsigned int bank) {}
> @@ -74,6 +75,7 @@ static inline void mce_track_storm(struct mce *mce) {}
>   static inline void mce_inherit_storm(unsigned int bank) {}
>   static inline bool mce_get_storm_mode(void) { return false; }
>   static inline void mce_set_storm_mode(bool storm) {}
> +static inline u32  mce_get_apei_thr_limit(void) { return 0; }
>   #endif
>   
>   /*
> diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
> index 45144598ec74..d00d5bf9959d 100644
> --- a/arch/x86/kernel/cpu/mce/threshold.c
> +++ b/arch/x86/kernel/cpu/mce/threshold.c
> @@ -13,6 +13,19 @@
>   
>   #include "internal.h"
>   
> +static u32 mce_apei_thr_limit;
> +
> +void mce_save_apei_thr_limit(u32 thr_limit)
> +{
> +	mce_apei_thr_limit = thr_limit;
> +	pr_info("HEST: Corrected error threshold limit = %u\n", thr_limit);
> +}
> +
> +u32 mce_get_apei_thr_limit(void)
> +{
> +	return mce_apei_thr_limit;
> +}
> +
>   static void default_threshold_interrupt(void)
>   {
>   	pr_err("Unexpected threshold interrupt at vector %x\n",
> 


