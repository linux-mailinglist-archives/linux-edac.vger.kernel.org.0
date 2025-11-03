Return-Path: <linux-edac+bounces-5293-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E008EC2B965
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 13:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2915D188E0B6
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811FF21D3F0;
	Mon,  3 Nov 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4rMtue2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4J4QuAm"
X-Original-To: linux-edac@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9278F2F
	for <linux-edac@vger.kernel.org>; Mon,  3 Nov 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172166; cv=none; b=nVgPy43n8BSmoSZN0r+ynZryVujehQXHognGm6pBSPYaPhzDSPqwEwAL7xTflKQKj9jYKUqC21D+DPo0KeTNd8FgEq/HIM8PqyGfHvj9wUdbd1ifXUUJXyI7J2d10nuBBtRe9ddPoL6HHxskH3B3bkEeOXqNK0b6FFaYbE0R+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172166; c=relaxed/simple;
	bh=/nhHmYY4DwG4OUbjbLLRvwUDlHogICBXhctaOEpPmEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFXZGuf3UAV5YXrtfumEcHHmKN2OU/4QO14nNWk9EiIGUcDeINQ0wX0681k5rH93GALLvT47w46LDvJVWExbCxnEpdTE3fhT9mvhxqDRokBpyEgQqrM12Yva5Ks08ozSuWgGqgcoglsY7ncmAVz6Jw96RiI/qsi177BoVqeMePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4rMtue2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4J4QuAm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762172163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
	b=a4rMtue284uW/gLTziL0EVrN3BkKQutAtAKn1QKE9sXcl8ONNM8PL1kuDZIf4M2V86DODy
	paWlcbIQLayRgp1ZtjVHIo6Xp5VFB8jIdoQva9yWazsN1Lob5uEJici8J6Rsi7E/xGOinm
	GXUGxBVE9khDn4eWmb0Z7uIU0Lo0tlg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-fxYFxci9M1Ka5gs8JLC-VA-1; Mon, 03 Nov 2025 07:16:02 -0500
X-MC-Unique: fxYFxci9M1Ka5gs8JLC-VA-1
X-Mimecast-MFC-AGG-ID: fxYFxci9M1Ka5gs8JLC-VA_1762172161
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475ddd57999so43234045e9.1
        for <linux-edac@vger.kernel.org>; Mon, 03 Nov 2025 04:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762172161; x=1762776961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
        b=D4J4QuAmWePBBLZcO03T1c+2ecsmNJeSI0fGcBINLqWCcPro3Xub4wxmP2Be2pK8kW
         Tmt/G3jus9w5woY7GphnZIwE0mya9uRHd6qt2UeTP/RaunZCvdis//H8yNk1POOOrNlc
         +s7cIMMDDkZfJfdV9WDZ+VxxB66/gJ+jY4jXgNVWdy3AD0pvA7C+EXGfkEJ2bu/JhguB
         MSlernLwoeG4gOeMLgBp92vPFb44AAD32rE1OPwGLK6ILS3NIp6o68c1J7lF5XNxNQaN
         4yOBVvmGE8Fw8dDFT+Vj003p8HMM9HZqPZRj4sc9WuAD+YQB56102BrS+FusDUL9QcXf
         kJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172161; x=1762776961;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WsMXCh+iFFtzPSIRTCb9422M4w3M6JOwaIkWBJ3l9zg=;
        b=ZYffCg2YXMiLj3H1LGEo1suvR3nQSmWuH+Nv8cU8VuoQq3HpCQEtHW4MTx7RuXWYvO
         Rnk5L65VVOl8JqL5OxKbPhCZ8uwVavU/85nOmxnp0EXEIPIRD33WDO+BGC1FciVba+Pz
         cnSvweO8ohHrqUQsgWF7/Ufuiqgfc0biiHRw+GA4EZejudCy09bBn7DrUKL/cH0QeF7g
         QJCPLiEtDnj0CGjZpLSd/5qd2SBWPnTkJDUnilSx60UkDXGOCmTlKhuInzrb5m8/DJ+P
         1ROt8hh6hRRCHR/XvoCuG5s09ZuMfXnqUU5L91dSyTIIcTtNqFJRxirKmod+UK3DzhFn
         10kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk9tt2E+B5as0EMeiUiQVfl5DRSNTHDkcMoUufwLXsNoJDLlIIeY2JpHhj0GEJc5zjDRAUKEs5MHYP@vger.kernel.org
X-Gm-Message-State: AOJu0YzKOIssm/Z5RTBt6TG4Qkx0v8HLu2Juw+P7Ztw1r37ShLaRB1J5
	9lZ6Uaqh3nazE/HSR6wUfvVyv/GoU8Pc61oO9eAeVgkw/u6m2oQT+svm2A5ontA7H2xhHwQ4Upe
	PMie3QBdH0MllY+In9jAXz2PZaxEoDqYILr0Nsggw7ULefaStAk9xUtr2o7eHl20=
X-Gm-Gg: ASbGncujD777Vume8BhddQROUc7A8XfDVkkhcTcxM73f+oCji3X23PvutyjuNFCd9Hg
	WeIyT8Axzjseh2mvbC0hj+03qHLLy9OSIOwi0hz/xkHskzBc/FeWXOMCtfAyke4FJ8Ddh1yORhD
	w4zquGlek+unb2XX81oeMKrXY1GFMrHKegejZ5SrHDhn73FVmOULYUEgB3lLL9I0MCavYx4uQsC
	TRwcU5Nw4dByrUeZO+lJl2ZPRu+LiuAIeta71ttZma1oiYW6dkaXWd50lVfceA5njc9tMuV7a3Z
	sX/ITeN/aco0T+RCXeYK6ertcCGHxLlOyR0+JHFGveGhjMQBfb1xSDEUNP9al9WRdHswgjOSrxX
	2mh8QnsWOGyXxvVjihZYNeXPyCDzRpITGfXqFCQvzUkZZs4Xi1FrGqcQKim1MAgUA9iMctPPT/M
	btyyQ56C+MxXeJ3xELZV+v/Z2iFis=
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429bd6ece4bmr12949809f8f.61.1762172161222;
        Mon, 03 Nov 2025 04:16:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJz3FBKsr18wkuyol1fzdxNXOP0NzjA4OuIx2R32uJMWanPs2oQny9N+V7osFONlxQu55C5Q==
X-Received: by 2002:a5d:64e8:0:b0:429:8a40:e995 with SMTP id ffacd0b85a97d-429bd6ece4bmr12949761f8f.61.1762172160704;
        Mon, 03 Nov 2025 04:16:00 -0800 (PST)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13eaee6sm19776225f8f.33.2025.11.03.04.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:16:00 -0800 (PST)
Message-ID: <341ff738-255f-41c7-8b23-48aac4cf51e3@redhat.com>
Date: Mon, 3 Nov 2025 13:15:58 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/memory-failure: remove the selection of RAS
To: Xie Yuanbin <xieyuanbin1@huawei.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
 luto@kernel.org, peterz@infradead.org, tony.luck@intel.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-edac@vger.kernel.org, will@kernel.org, liaohua4@huawei.com,
 lilinjie8@huawei.com
References: <20251103033536.52234-1-xieyuanbin1@huawei.com>
 <20251103033536.52234-2-xieyuanbin1@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251103033536.52234-2-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.11.25 04:35, Xie Yuanbin wrote:
> The commit 97f0b13452198290799f ("tracing: add trace event for
> memory-failure") introduces the selection of RAS in memory-failure.
> This commit is just a tracing feature; in reality, there is no dependency
> between memory-failure and RAS. RAS increases the size of the bzImage
> image by 8k, which is very valuable for embedded devices.
> 
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>   mm/Kconfig          | 1 -
>   mm/memory-failure.c | 2 ++
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index a5a90b169435..c3a8e0ba1ac1 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -738,11 +738,10 @@ config ARCH_SUPPORTS_MEMORY_FAILURE
>   
>   config MEMORY_FAILURE
>   	depends on MMU
>   	depends on ARCH_SUPPORTS_MEMORY_FAILURE
>   	bool "Enable recovery from hardware memory errors"
> -	select RAS
>   	help
>   	  Enables code to recover from some memory failures on systems
>   	  with MCA recovery. This allows a system to continue running
>   	  even when some of its memory has uncorrected errors. This requires
>   	  special hardware support and typically ECC memory.
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index f698df156bf8..baf2bd79b2fb 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1276,11 +1276,13 @@ static void update_per_node_mf_stats(unsigned long pfn,
>    * setting PG_dirty outside page lock. See also comment above set_page_dirty().
>    */
>   static int action_result(unsigned long pfn, enum mf_action_page_type type,
>   			 enum mf_result result)
>   {
> +#ifdef CONFIG_RAS
>   	trace_memory_failure_event(pfn, type, result);
> +#endif
>   
>   	if (type != MF_MSG_ALREADY_POISONED) {
>   		num_poisoned_pages_inc(pfn);
>   		update_per_node_mf_stats(pfn, result);
>   	}

I rather wonder whether the memory-tracing code should live in a 
memory-failure.h instead.

-- 
Cheers

David / dhildenb


