Return-Path: <linux-edac+bounces-4710-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82BB3EB46
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 17:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5972C1822
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616F52DF132;
	Mon,  1 Sep 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z82cCnVQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CD82D5955
	for <linux-edac@vger.kernel.org>; Mon,  1 Sep 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741279; cv=none; b=T853ZdaQuTaMgBcYuE2T80AtKoorWOFgxk78apxGB1aWInru3jpsUXA5Nv95tTpCpK57sI533KPRRoujVaFZOzKl3hhebVNEVuTHLJtfoaimo8ODqvdDFam5Td5Sfzp8gKWEY8tGwRumgmYLacjr+QDeTznb3jFoQEW3EE2RqHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741279; c=relaxed/simple;
	bh=axNllwfDUkYTDCFBSCmvnLpLRzssBhfNZ58t/kYnHEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cy3HwSHqmoOQRYnL9R0LZmRwhN7VtXGJiTngLlgUiNn0kfGgnfSNeue0ETa0ZwIOorjdBRVGhRd4Uk2CAq0NSYvpWOLZWF5LoX8MAdZFhJ8+H2K/PVwJ4thvcN31US0vWD/1vJncK8LLGOSqrGH8UAsv3lyYFKVs2FodhJX1s/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z82cCnVQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7d485204so35618495e9.0
        for <linux-edac@vger.kernel.org>; Mon, 01 Sep 2025 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756741274; x=1757346074; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bm0pUtqqyLSDsF2Ey+fmrPZF+JfkcIIlkPgCIjpJRXo=;
        b=Z82cCnVQGccegHYVhHeLJmO7rY5rezT2aZH52OW3TBW9EOFVTb73VN99K1xbbgfPDm
         KIiTld39jDkk9r9x9nm5S9JH+7s/HBptzmODcfjShNZgQq0JCxI9ZUIosaEGgFZNHV8g
         6WTZcC6OxITGh17a2IYDyBcQybAyvTxYjboo6UVbEsBDYLuSqhdajhc/lmU6z8n91k7A
         8iq4GwSanuAqpp8eP/EJ43WwusaH8v8wRXzxEee9EYbpkET/Z2IGWk9lRz0+s48lrXJk
         Nm96O0QrxLMj3RBjKS4UBZAhyipE3C6JynDTRr1VF+VVJpi/SI/uUPtaKrLozaHEO8zm
         2GXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741274; x=1757346074;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bm0pUtqqyLSDsF2Ey+fmrPZF+JfkcIIlkPgCIjpJRXo=;
        b=Fl+XmfZyFsnIeet/BfZH4K1XtppczDthAAu9Z2Q39rkdtfrWC3VC7i0YO4qqALpMox
         uQV3fM9ln1JPlvoEyOHWOxJ1sP2L5+9rrq4EJnH2KC+m8JXPwmm9wTf/LrvzpREpL4OO
         iWQUx0KixZ5DfCoVmsO4ydQ7XElG35qHDaAArx96WH6jL+6E8N677581YXNqcliAbhUI
         56Ld2SKN9rVuNUUaXOgE/fEZvbGY9o1Qqal26/Fgsi27v9WER1nH6sHM4guwFW+AhE5K
         Uo7JrKGlcI1sJnfy9C1xLy+ohumRfJY+urvwUVlf22WtPi3qiA4CdAh+epkGm+pRmJ75
         e/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVn3qXWXOiejw2vpn3sWZIcr0+Nf+x1vIZfpdb2iSm2Yad3m0IWJaqlRTdvD3G2S4t1qbwgLOXQaGCF@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw22N0h0lQp8RpmGtN4d+m2UvmuZ6oSJq9qOjbEM2OK4h+uCMd
	CYZCDC/w3YaDKD/gVS4HYWnSwwfe62pXRcfilDVxfVt04f/NI4nqayiSlMl+tw2l87o=
X-Gm-Gg: ASbGncvhLcRVYZfIh0mAig+Pi/QWJTM72IRZDs1CZ9t8Y7BliuM/3j1PojDbUdEN5hI
	brgJ/Lo5LngRcIGncCvNW1bjjcjBNq3Nr/xpWftYBcTB3gS7RzugdN0ahxBhkWO7dB6BEeAuk9A
	md4Y7lPWB54fBdOTYAir8f+oOwsQI4u0xCW1FCw02I2dKTHuUBMQ4aTRTYjlVj71xDgInz8+UZM
	7I8YdAyQpp1XGW8CJP2Y17pP4W5AxsBSA/2Bo7sFYQ1QvCqA6uh7fyEkbsQIP1mPNXA8A6H1IrQ
	SPs6xzDJL8NttA5JXNKQZwct4HvX+/Vu8jvJMhKpb59cotlS/uomAEVOBegEjOYCn5OFrkHsRtD
	sz1n4pmCqNfQ2kyakp3FIFrWUf+3m7VcaYgcBdCreY2rofEwQstxlYHqhWyJZ/ZHd8V70xq8=
X-Google-Smtp-Source: AGHT+IGIQl5uv3T6xSUAchuV/QHFF6se7W+h+98dX15GDdNrxuH2lA6Y6X4R24Zy9hChiymRKhAn1g==
X-Received: by 2002:a05:600c:3543:b0:45b:8822:d6c2 with SMTP id 5b1f17b1804b1-45b88321d9emr53869155e9.12.1756741274125;
        Mon, 01 Sep 2025 08:41:14 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.143.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm500043f8f.23.2025.09.01.08.41.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:41:13 -0700 (PDT)
Message-ID: <49d90a98-f3fb-4df2-837f-53b109cfcd6d@suse.com>
Date: Mon, 1 Sep 2025 18:41:12 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/20] x86/mce/amd: Put list_head in threshold_bank
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-4-865768a2eef8@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250825-wip-mca-updates-v5-4-865768a2eef8@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/25 20:33, Yazen Ghannam wrote:
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
>      https://lore.kernel.org/r/20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com
>      
>      v4->v5:
>      * No change.
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
> index 580682af432d..54f02bda75aa 100644
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
> @@ -902,9 +903,9 @@ static void log_and_reset_block(struct threshold_block *block)
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
> @@ -918,16 +919,11 @@ static void amd_threshold_interrupt(void)
>   		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
>   			continue;

So the following diff can be applied ontop of this hunk to simplify the function even further:


diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5c4eb28c3ac9..b35e74292f58 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -932,7 +932,7 @@ static void amd_threshold_interrupt(void)
  {
         struct threshold_block *first_block = NULL, *block = NULL, *tmp = NULL;
         struct threshold_bank **bp = this_cpu_read(threshold_banks);
-       unsigned int bank, cpu = smp_processor_id();
+       unsigned int bank;
  
         /*
          * Validate that the threshold bank has been initialized already. The
@@ -943,7 +943,7 @@ static void amd_threshold_interrupt(void)
                 return;
  
         for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
-               if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
+               if (!(x86_this_cpu_test_bit(bank, bank_map)))
                         continue;
  
                 first_block = bp[bank]->blocks;


Will you integrate it (Boris) at merge time or should I send a patch now (or later) ?


<snip>

