Return-Path: <linux-edac+bounces-1889-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86ADD97C53A
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 09:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DE01F220D8
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E98194C73;
	Thu, 19 Sep 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PanegqTf"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AB2194C65;
	Thu, 19 Sep 2024 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726732104; cv=none; b=pkwghPTB9t43Mu0B6Ni7XGPHbNJuNZVem/Uqju4ooPdwo8qEXKZyRx6U7qKNc49xDs1SawZywGf+PJplyWWeuIc52IbudBYHmJmbWEOhi0WkOuiEmTUdB30chMk8exq8mfSrbylZSCExHLS/CU8L1TXIS0zooULfj16rgI51cuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726732104; c=relaxed/simple;
	bh=qeY+WWX8JFRwUacovT08cHFgDHIwenb512jaT880aEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9kIgJ9pw2UV6ul3J+Uh0YieV8eX6xhKrz5AsFwnfRevPJ0THYDnOrf+4NK7aI991GPZMhzgF/mhbbTCqBm2XevmQWlOb1eo3mgIcnsYNnYNC78QWQSSgJjzg9HF1UNETn/wDOipr2ZRvjBLupJb3tvJ98MYvR6mqIkPGUEEfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PanegqTf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb58d810eso10153575e9.0;
        Thu, 19 Sep 2024 00:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726732100; x=1727336900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cxRcEhBQUnIo+eMpirZAH9+jtMgloRBOhsaQP5kQMPY=;
        b=PanegqTfXLMYmfQBp1rpY0R0Lz8kTQYYbIly5nMWPm9MAOq7LhAz+Z25Ris4+wspDi
         P3tbiFLjGJsnAGSXhGKOCoQ0jYXfZOaWJ21IWFF5zfFy8Q22IpAmcwWDvnjBbJtDK3nK
         tE6YeXbwhjdnt8I+xxvwdWXCBFsKdrkWQdu/PvqbLcCPxhLgY68w5m6zjxtQL5uPcSq5
         Ep3zGx9yPoER4aRZEbd/3Tago3CivsvFJD3vxQanEIoE3guh7utdnWbFwtK9CgQh18PM
         Rv7fhf0HDncJtTcOqBx8gFhXpDhNhLVQNqbJXM9NciXYpR66yZbzb6wskKWIamAXLvz9
         1m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726732100; x=1727336900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cxRcEhBQUnIo+eMpirZAH9+jtMgloRBOhsaQP5kQMPY=;
        b=ApA5eHx0sRKNX0ow7XrQay47WccLvHIzNoyMg6kJ5y47TMUeKuv5dtNqRKfupALib3
         RSu4mM2CKUmYkHoM1WIhWmux6gi+5WapX2Yb7OXyhTY9KjkOcSphQAwZcuWsL2jmL/3W
         xGB2k/JAEW1xxSb8mjYAJUenMwnEkZCqGhhrEr8naregZMc/EothjOhbtVScwaJVV52x
         0Fr06Aes4DTegwbBbUtbSWPACdvKuYU7zcgnSYhCwZfYZJTXeKWXu0zzFFyMAaw9M2+s
         K/MXV/vYw1Y0WD4aGYx7x0AFv/M/ca7zNvRaTGDJxa1tu/6clTngunOA8OSUpYuptlEt
         wrDA==
X-Forwarded-Encrypted: i=1; AJvYcCVNfG/VQ0LxWExhfcQJFvP4AJzabPwz+cgC6sZhfb5FSI6IEQ3uo/H15sRyHwOTzIo2fKSkTcC8uWps@vger.kernel.org, AJvYcCWCvzjWVFx6Cs3UU3HYvjZ2Jj2CfzxAOdWzmfnLJcHulzXnA2x6rNf8RmxesPrmh9RKR9EDDSgx1d2viabc@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhGBp5klqxzG7U5akZ48zUKgFa1pejhi8Lor5rBF2PUT40dS1
	VDUW1HufeM3/pCaDBFnTDxvw9eFiPkeQDs7I7BCmoo0Xaq8+ELmg
X-Google-Smtp-Source: AGHT+IHIMEKJz/YGEH6p+9jooZXp4rGSdrrKrknBunEn4zZfQo6EhnWSg4ufU1J5Z6/S05bGTmNBng==
X-Received: by 2002:a05:600c:1c9d:b0:42c:b377:3f55 with SMTP id 5b1f17b1804b1-42e743f263bmr12487065e9.3.1726732099768;
        Thu, 19 Sep 2024 00:48:19 -0700 (PDT)
Received: from [192.168.0.101] (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e754091desm14894825e9.8.2024.09.19.00.48.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 00:48:18 -0700 (PDT)
Message-ID: <351a69eb-bdad-46ff-aa8b-ad156de10249@gmail.com>
Date: Thu, 19 Sep 2024 08:48:16 +0100
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] EDAC, pnd2: Make read-only const array intlv static
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240912131730.588673-1-colin.i.king@gmail.com>
 <CY8PR11MB7134F6951DFF67FDED364FB889632@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <CY8PR11MB7134F6951DFF67FDED364FB889632@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/09/2024 08:19, Zhuo, Qiuxu wrote:
>> From: Colin Ian King <colin.i.king@gmail.com>
>> [...]
>> Subject: [PATCH][next] EDAC, pnd2: Make read-only const array intlv static
>>
>> Don't populate the const read-only array intlv on the stack at run time, instead
>> make it static.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   drivers/edac/pnd2_edac.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c index
>> f93f2f2b1cf2..af14c8a3279f 100644
>> --- a/drivers/edac/pnd2_edac.c
>> +++ b/drivers/edac/pnd2_edac.c
>> @@ -372,7 +372,7 @@ static int gen_asym_mask(struct
>> b_cr_slice_channel_hash *p,
>>   			 struct b_cr_asym_mem_region1_mchbar *as1,
>>   			 struct b_cr_asym_2way_mem_region_mchbar
>> *as2way)  {
>> -	const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
>> +	static const int intlv[] = { 0x5, 0xA, 0x3, 0xC };
>>   	int mask = 0;
>>
>>   	if (as2way->asym_2way_interleave_enable)
>> @@ -489,7 +489,7 @@ static int dnv_get_registers(void)
>>    */
>>   static int get_registers(void)
>>   {
>> -	const int intlv[] = { 10, 11, 12, 12 };
>> +	static const int intlv[] = { 10, 11, 12, 12 };
>>
> 
> I didn't see the why and the benefits of these changes.
> Could you elaborate more?

The non-const construct will generate code to put the array on the stack 
and this occurs on each call, so there is a small amount of extra object 
code overhead to do this at run time. Making it static will put the data
into a data section so there is run-time penalty. So this change 
potentially shrinks the object code and run time overhead a very small 
amount.

Colin


