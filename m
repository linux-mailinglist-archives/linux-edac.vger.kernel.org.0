Return-Path: <linux-edac+bounces-4250-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F92AE8B0B
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 19:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D213B189A73A
	for <lists+linux-edac@lfdr.de>; Wed, 25 Jun 2025 17:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC26F1DD0F6;
	Wed, 25 Jun 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IIOWlfug"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E31459FA
	for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870351; cv=none; b=vDAQpZdGCKWvIFeZsn+hxYqBi8oCMiqlBVseYIk/yNgKRhkT1vnru9i7lH96NwVtJgNZ7nTMsCvuDoKZw2n5t6iqS5RNzVHuXM2x6Bt03T1NnJbGz/gYGBcmNpZoI268HX7+1NVrWwKvjFvxNzrfRANbSrGfXHJOI4Pxnr1+DZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870351; c=relaxed/simple;
	bh=vxVqKuyhKOTrPOEZ8Sksfy/GyYLbLbHSB9U6BYM/nWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhnQ0yRvl9Al9g1EGwYLEmxtzRY8OC+LSIC5GZC7AYE24tQwqtqP0ioU2Oqz+4+4U+NsY48Che6hAsRAFleCe3R3OG08s5yMkWrwCEGYlaKE96I+rgmbmxW8EhVsJGOV/Y/koxhfP1c7Hv3es2TbAgTnJ3gUP9u7OJLsHn664Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IIOWlfug; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a5257748e1so21510f8f.2
        for <linux-edac@vger.kernel.org>; Wed, 25 Jun 2025 09:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750870348; x=1751475148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BuQx+whEzhYiqRsKMpxFtR+g/DANNTkHVud3Hoan99A=;
        b=IIOWlfugh0dQOK7uOkmKuRvza80UzzSZiZLRvtaLFkenBelDN9I3oRlxpykkaksH8c
         6DLH5eXSc6PlBZRBdLHq3m1GQwWd9Ao8dHLtBPDVcf+7bqP09Krv/Xa56XSTN2dfmjFT
         P52PH4tz2/zhq0z05OiPeGoaO4fjbAe1KSvsnbSpho5QGY6eq1OFummwq07ptl5n64ob
         jdSnTwPuO1a+FwoNvq7JO4cXgHhuJnWbRxAAiMLpYuRQ1xqt/ecV6iOn8rB/XN05PDWZ
         L/I2D2xZUhoZXStrygVgVF4fLrf/Rd3qg798LA0ofibBd3QZ3vf5esym5bqedJuVrJ9i
         UCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870348; x=1751475148;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuQx+whEzhYiqRsKMpxFtR+g/DANNTkHVud3Hoan99A=;
        b=Xd3ThucFUBEQG47aJE+NOisPjMVOea5a2/QRF2maWLSwZD/J16/ca8D92/O4blAvHl
         OUFxgooQGZfqhj5wxQtWIrEjlNxQTTwjI1auaYbDpcKadCnojHi08bS2ZyTN+QmZrk1v
         jk4R9wOdGFDiAi+ZWoyROYL8+WT3oTC67P1546ngLLtbW0cE/ETJs89KxW0APC0U9PtG
         czJjGYN5kZKisdKPvafpvpO3acos3478OIs4DcOgf/c4YSgHb8iEAXIo2uNbGRZY84+p
         4SPfg64HrH2vCyFA3hrs/kDFsXaa+zQ5HguoFd1c67RSRhMEGYVQaCmQxRTwAug5za1H
         RPIw==
X-Forwarded-Encrypted: i=1; AJvYcCVkWtUSnmI7tY2DBS7UxHPK60pnRl4NG3wiT1f9zjAb/8VKK2q/sXuk3mAD67VbziOYM2bfy1dLUaki@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSRMwALDmhWDeBBrdxjvuk7kcQREKStrBoU6dPXm8jmQ70PzU
	42D3qVALn11xuLNXjwUtxgrGE1s2cfOrOA8FObCYdIV8YyVyXJVSRnmZI/xmgt6yVmY=
X-Gm-Gg: ASbGnctRSBZM1SGqvgXafaC/nwFsm8+Nztqj6uo9mgi5qDQDHgxdKV6lo8QuwD2A4oY
	Pv7NQ82RSCANBp4CuF11rfKT+YrtVrFh2VKituD9J7pEFVL/699fDy/vItLFpfuI1lU9UR4TPkj
	mhU6FiKqCvXh5mbZ2NkPsDjVPbu2VPlz9u4eGjBF1IVA9Im1UE5aMYlOF2xckarCY6p5e3V8V+b
	NjIX8wo77v0ESYcPBKL/hXdNTo+dGJobgwCcbXjXK/O5hLPHJFgMV1gyE5K2sbQ9XSjqEEsl/nG
	8IiPK8EYTsyU9UExdfNLc8l8IsQY+Nah9/gVNS5so14GvEZ+hwiMTRG4O32flo1C4YkaCXOdSXv
	E
X-Google-Smtp-Source: AGHT+IFeGwOAoax1AfZYO7qoKOk8kLvBs1ogWHo11zKXAb69vYbNyx/YqrqnxoZ5Wxl6ZV66P5yczQ==
X-Received: by 2002:a5d:5f49:0:b0:3a4:d4e5:498a with SMTP id ffacd0b85a97d-3a6ed66fc5amr2965346f8f.42.1750870347886;
        Wed, 25 Jun 2025 09:52:27 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e81106b8sm5168738f8f.91.2025.06.25.09.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 09:52:27 -0700 (PDT)
Message-ID: <68039ee2-5407-4bd4-9735-62674805eaad@suse.com>
Date: Wed, 25 Jun 2025 19:52:26 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/22] x86/mce/amd: Put list_head in threshold_bank
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 17:16, Yazen Ghannam wrote:
> The threshold_bank structure is a container for one or more
> threshold_block structures. Currently, the container has a single
> pointer to the 'first' threshold_block structure which then has a linked
> list of the remaining threshold_block structures.
> 
> This results in an extra level of indirection where the 'first' block is
> checked before iterating over the remaining blocks.
> 
> Remove the indirection by including the head of the block list in the
> threshold_bank structure which already acts as a container for all the
> bank's thresholding blocks.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250415-wip-mca-updates-v3-4-8ffd9eb4aa56@amd.com
>      
>      v3->v4:
>      * No change.
>      
>      v2->v3:
>      * Added tags from Qiuxu and Tony.
>      
>      v1->v2:
>      * New in v2.
> 
>   arch/x86/kernel/cpu/mce/amd.c | 43 ++++++++++++-------------------------------
>   1 file changed, 12 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 0ffbee329a8c..5d351ec863cd 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -241,7 +241,8 @@ struct threshold_block {
>   
>   struct threshold_bank {
>   	struct kobject		*kobj;
> -	struct threshold_block	*blocks;
> +	/* List of threshold blocks within this MCA bank. */
> +	struct list_head	miscj;
>   };
>   
>   static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
> @@ -900,9 +901,9 @@ static void log_and_reset_block(struct threshold_block *block)
>    */
>   static void amd_threshold_interrupt(void)
>   {
> -	struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
> -	struct threshold_bank **bp = this_cpu_read(threshold_banks);
> +	struct threshold_bank **bp = this_cpu_read(threshold_banks), *thr_bank;
>   	unsigned int bank, cpu = smp_processor_id();
> +	struct threshold_block *block, *tmp;
>   
>   	/*
>   	 * Validate that the threshold bank has been initialized already. The
> @@ -916,16 +917,11 @@ static void amd_threshold_interrupt(void)
>   		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
>   			continue;

<slight off topic>

nit: I wonder if instead of using per_cpu and manual bit testing can't a direct
call to x86_this_cpu_test_bit be a better solution. The assembly looks like:

[OLD]

xorl    %r14d, %r14d    # ivtmp.245
movq    %rax, 8(%rsp)   # cpu, %sfp
# arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
movq    $bank_map, %rax #, __ptr
movq    %rax, (%rsp)    # __ptr, %sfp
.L236:
movq    8(%rsp), %rax   # %sfp, cpu
# arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
movq    (%rsp), %rsi    # %sfp, __ptr
# arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
movq    __per_cpu_offset(,%rax,8), %rax # __per_cpu_offset[cpu_23], __per_cpu_offset[cpu_23]
# arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
movq    (%rax,%rsi), %rax
# arch/x86/kernel/cpu/mce/amd.c:917:        if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
btq %r14, %rax

[NEW]

xorl    %r15d, %r15d    # ivtmp.246
.L236:
# 917 "arch/x86/kernel/cpu/mce/amd.c" 1
btl %r15d, %gs:bank_map(%rip)   # ivtmp.246, *_9


That way you end up with a single btl (but I guess a version that uses btq should be added as well)
inside the loop rather than a bunch of instructions moving data around for per_cpu.

Alternatively, since this is running in interrupt context can't you use directly this_cpu_read(bank_map) and eliminate the smp_processor_id invocation?

</slight off topic>

>   

<snip>


