Return-Path: <linux-edac+bounces-2922-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 186E8A12526
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 14:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71AB07A5E61
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DDB2416B8;
	Wed, 15 Jan 2025 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BgjcoSq7"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD124A7EF
	for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948544; cv=none; b=BvZpW7Y7KnqIdAHOfj5pVvwsSdkhsxUJEowZzfrZQWHzr57KigATnRHKvBvJ3eBivhCTWcmb3FFH+Kt/s92lhNgkaxwMJ+7kSv805nBc2HwPn1u8FhACzumSStRJlGLhOQIrWAT/jTM28BEm1KJ/qDBn9Awv0qwmtNscx7cjVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948544; c=relaxed/simple;
	bh=XGwLNhU6gC8zEKSc5+86Wqq2BWjmAQtzDA1W6OEKZbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghSRqP7OxEv7PkaeCMfMaNLlJvM5HOlJiJ7ZOhMeMDAL5vL3ueOODvvJnOjXDcijbp+Y1TnIb/CeH7bM3zi6HsicoLtV5zBxRO4dNRWr3Vwwxi1pvfeO7bnFyNjt5HMHyhscEcxdY0y/Jcojyv7jXi1rJff3Jd1x180LXszYJP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BgjcoSq7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso1387777666b.3
        for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2025 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736948539; x=1737553339; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Gw8etrQkiNuWT9BWkQsZYUSwDA88vMKAJS4wNvlJpU=;
        b=BgjcoSq7RmfmRmkWyPmj8fvvmwwdhcIzZ1NjjimP5thxT3BeDYeDYFQq8LVlB0xNtP
         Ub+YzaA1wDVQYlxSJG5XLIv2XlZ+Esa1r3qrD1YJGhNX/qJu9sM/5IlMjnZ4h8fQtlsX
         c7p3LqAcGnQWJ2OaLEjoNOGinkMNX/FWZ8XjuBfBJe/EvRW9tNy1b0iN3INJXwAm0ZfT
         Nq9YriDZs+aQe9ApU4iiItqNON5kse3mGXIHPvcltl/zyNPXRrL7NzDbLQM6MuXH1p4N
         IYc9yDTixNTYobzzW9Uv6mXatCp+xo3ulzaV66l/Plpp2qXXJKidnn+85Uh3Imvt+EwB
         TgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948539; x=1737553339;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Gw8etrQkiNuWT9BWkQsZYUSwDA88vMKAJS4wNvlJpU=;
        b=rRyDU+Lg0CivoZHsyp6q+uf+b4jdIpN3qcfxscuABP5fuBzPZbh6hNjdqZ80CWYOfc
         YCMZ5Z921Ehbfxc7xGWrWQxYrEoCan5Wl0xGrUlhbNxlX1zJkuQF2ne5VRmATT8mNLXm
         o23VAq/IfWYKU4XdklbenNq4qrelo/C7677UIGH984nVfmhLxEpjZhsGDvs/nd/siGnt
         UyHg9eVbGp6CzzWKjijfqZXoPiSz5tapvPcg/CAMIT/L8LXNlFUX9Se0Pftecy/ptyda
         Ze1e/gFrwHf9QaknWszqpiaC0Lwc41f6Low4ad1To40njgM0ACBwLLxylJ/vbb762aBQ
         JyLA==
X-Forwarded-Encrypted: i=1; AJvYcCVCzWWLZ0Hibuq2qkz9I0q46dT4ApyQ8JskYpxVbZQsnp+z2VJeTZyKcFI95uRDcWG2PRbkSn0YeOp1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7cbATt/fm8kHoQi95ssGzFwC2UtIVB0DfB58B6zmUGqHhbyn0
	/XoQBFuNqxvNq/MsKpB6AcaRPg5QECG2hMhmgQt6vXfhS0nE0BfkizZxN7+vEKk=
X-Gm-Gg: ASbGncuIV8oLjNL4+8WSH4pOeNwZ4Q0gVBMVDTPElps25OdWevvKZU3AF3uV6cRv+nK
	gNjZUMQjEVrsE8YLSODzPTIT+UPeT6MDN3ljt63KGDHsEs+P/shEtPeWTNBrpYHy+qXQ1k2XOrk
	P48prY+tyebMMg8X1tsTVO8XBsnpJ5oaEZ11/iMzpkSoOO1dwINzl9KFCAqomzhmNvsCe0xnQXv
	p20LjTz4sEBaYvIysBo1f9JDlvyAgRPCnttHXWEcbELabdrHiFICFoMK5uUQg==
X-Google-Smtp-Source: AGHT+IG7i+CNGHR9gmh+HC84gV5pHwEdta2xsYjUhmVtRBivP1oO6h85p3CMpQlznDJpMPcvgLl23w==
X-Received: by 2002:a17:907:1a50:b0:ab2:b5f1:5698 with SMTP id a640c23a62f3a-ab2b5f15abfmr1835161066b.38.1736948539294;
        Wed, 15 Jan 2025 05:42:19 -0800 (PST)
Received: from [192.168.0.20] ([212.21.159.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95647absm752658566b.118.2025.01.15.05.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 05:42:19 -0800 (PST)
Message-ID: <e9fb743e-89ac-4fd4-9b9b-2c8f42fe877a@suse.com>
Date: Wed, 15 Jan 2025 15:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/3] x86/mce: Make mce_notify_irq() static
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-3-nik.borisov@suse.com>
 <CY8PR11MB7134CAAE935E2C6941E496E689192@CY8PR11MB7134.namprd11.prod.outlook.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
In-Reply-To: <CY8PR11MB7134CAAE935E2C6941E496E689192@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.01.25 г. 15:37 ч., Zhuo, Qiuxu wrote:
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> [...]
>> Subject: [RESEND PATCH 2/3] x86/mce: Make mce_notify_irq() static
>>
>> It's no longer used outside of core.c so let's make it static. No functional
>> changes.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/include/asm/mce.h     |  2 --
>>   arch/x86/kernel/cpu/mce/core.c | 43 +++++++++++++++++-----------------
>>   2 files changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h index
>> eb2db07ef39c..6c77c03139f7 100644
>> --- a/arch/x86/include/asm/mce.h
>> +++ b/arch/x86/include/asm/mce.h
>> @@ -296,8 +296,6 @@ enum mcp_flags {
>>
>>   void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
>>
>> -bool mce_notify_irq(void);
>> -
>>   DECLARE_PER_CPU(struct mce, injectm);
>>
>>   /* Disable CMCI/polling for MCA bank claimed by firmware */ diff --git
>> a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c index
>> 23e5e7f7c554..89625ff79c3b 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -584,6 +584,28 @@ bool mce_is_correctable(struct mce *m)  }
>> EXPORT_SYMBOL_GPL(mce_is_correctable);
>>
>> +/*
>> + * Notify the user(s) about new machine check events.
>> + * Can be called from interrupt context, but not from machine check/NMI
>> + * context.
>> + */
>> +static int mce_notify_irq(void)
>> +{
>> +	/* Not more than two messages every minute */
>> +	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>> +
>> +	if (test_and_clear_bit(0, &mce_need_notify)) {
>> +		mce_work_trigger();
>> +
>> +		if (__ratelimit(&ratelimit))
>> +			pr_info(HW_ERR "Machine check events logged\n");
>> +
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 
> Did you mistakenly change the return value type to int?

It was int on master, where this patch originated from. Whereas on 
core/ras there's c845cb8dbd2e1a804babfd13648026c3a7cfbc0b which changes 
the function to bool. So I guess it's a rebase artifact, will fix it on 
next submission, but I will wait for more feedback.


