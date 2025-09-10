Return-Path: <linux-edac+bounces-4777-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 499EBB5195A
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 16:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7841C26E8F
	for <lists+linux-edac@lfdr.de>; Wed, 10 Sep 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26FC32BF48;
	Wed, 10 Sep 2025 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dabi62DS"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EF32A3F1
	for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514536; cv=none; b=mlu9Fl1EoLAX7a5R0NabF7BIufyxKDg2dpSBbPxOA/JTa7C4SInngUmL+wmgCboTCOtGT2J9/Jk1wnFt4pUSRa4rNOkTpleHCXhgsTvNf5S/LbPpdnFAT5un9ppzFrs32KxX/p+e5sEtJt4GSaXGiXopZCyB7SmZg/IIot9KBK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514536; c=relaxed/simple;
	bh=igV99EFzjMxCzaEKSmi2QrhFzFyAA6DsgJyTrvzNqfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgTQKzOe/DJMu4Jya4uotuG6OKiu+bYEhmj/oawH/ZpQpP91Zxqq5Z8gKgGcajmtm7Hn/6zI8oeXDKbpxX5oD9UFY9fzWzi5VdEJHp0AUyoxZo5/IvMMpinlNVnSemKKoEPfoC94CM1A7OV55jjB0KqIgjCPKEHTru3npmaIz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dabi62DS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso60656005e9.2
        for <linux-edac@vger.kernel.org>; Wed, 10 Sep 2025 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757514532; x=1758119332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dI+sh0uxlW6i9FKCK9xyQWvVSATlEgD+3cesKXaSpxg=;
        b=Dabi62DSyjABQTfu5cke7iRTQb86k6eabLsq8iAq9fncemacKo2Zu51JC6mRITVV7y
         RXOOXOmT0Dh7xYCZUF9yOMQOkGehgIG9go58tFFgYRRlfHOJGioRgrOItCRJkLb4tXgL
         oZpIyhNynkKMLh24p2IiAwMGTKM6l5wD9jWrcx3jEneJrTFJwq070/Cm9VOfmcFv0CF5
         v+ndVEd5dN+lK5rSd3e+u3fdAHFM03rb+T3d8r0bmxWzAhqgDDvRe0biZsWQ1LydaVrf
         Zojd9Fv8mUDk+UjTo6m9MTmtX9rqQXvSMFwH4Pz+YDWIXkbTgHb28stgHomlZ7m/CGrM
         pEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514532; x=1758119332;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI+sh0uxlW6i9FKCK9xyQWvVSATlEgD+3cesKXaSpxg=;
        b=JoFJ1cKkleCD8MAUNY8kj+L/YMh2y46jI0a4tyU8SfZkGrJv/gDIrcyqWZUcpuwbPD
         h6hpYK3gFOjB8naZ7spAmphTIVfAi85xMzHx6y5Cp/RZqVLEapUF5y533SvoKFsNwEQ8
         IYjbb8r12n38bEEQLJe4eMlta/a4Srooy7+EbUIxqjXorkI1WgcPsa72ZPnAGpw6p5Ei
         3Ewk4/WIcO8RfZpciwUiOpy+pgQiaXBUqH7hrApnSS4VTR4JtKW8PzKHRX1ZvNrQGWkN
         K1AjyzzKQZyRCdrMwcGo27D5Do1Nyt7QAsUxzadWIhRJIfRt4ZQ6es93VnVQT848AHvQ
         V1Ug==
X-Forwarded-Encrypted: i=1; AJvYcCWxpSid1fJmm2fpgqC4Wweo/Pd9P94WgJP8BOfjGjZEF57WJBTqV8j2PLIjinIR6PKFFBWIP6ZPXOgt@vger.kernel.org
X-Gm-Message-State: AOJu0YzgoIJfAHzweLURzuxWEk97i5JiDAj2fXmvpPQnTWhmHJSr/NHF
	oORUquBz1g8Q6Usgeq7JvbXbbIqzpoxyMsy/yaBhyp7lY+S20p+VYK6uP0zA7KgZWbS3wPMw0Em
	Bbqdm
X-Gm-Gg: ASbGncvRIzdHphSJLjK8rwC9sNO8FG1n7xerRpjg/RrTCsIWyk2paYYYeNtz/Yjf2VA
	adjLPx5mhRUjnggdLpZ6FT2lVX3Icy6rqhrImny3U6+sq/eHyh5yCuafXGLKk6VcRO2VDRW3cE/
	yd+L8w69neK/NFKPFKi+hzLREC9PLF1OWx/JvhMpSWGDhctpyzxON6RkV0SpTpVJZRLSaVwwN3E
	xlXMaICTsX0z6mlegj/WyJ1tanl4FpPuzNDZkY5oWHt+lWJX9v6fY7Jw0EtPHX1mEz0rY2PHGR5
	aNXqVXydLwnvqbblpUy9yJuH9BWMwidnqZCaNxc/pK7pV9N9VVVe7kompIB462Y7PiP0LrbFRhy
	NUNU77qDzw2a+/KEAucNF6ToaycD3wwTNhUXbQBvrtCRuhB2JJ+gaRSv2
X-Google-Smtp-Source: AGHT+IF1NgZuIvS3US+cPt/8imY0P83mqf1dizqnse4ruJPSBf8I7KUULXAxl7t6gNZN9w6I8llmHg==
X-Received: by 2002:a05:600c:4fcd:b0:45b:8822:d6c4 with SMTP id 5b1f17b1804b1-45dddee600dmr160334225e9.33.1757514531506;
        Wed, 10 Sep 2025 07:28:51 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9a65sm7537632f8f.17.2025.09.10.07.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 07:28:51 -0700 (PDT)
Message-ID: <861a0703-2adc-4e8c-86e5-c22192759e80@suse.com>
Date: Wed, 10 Sep 2025 17:28:43 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/15] x86/mce: Define BSP-only init
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com,
 Qiuxu Zhuo <qiuxu.zhuo@intel.com>, linux-acpi@vger.kernel.org
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
 <20250908-wip-mca-updates-v6-2-eef5d6c74b9c@amd.com>
 <98d80660-7140-43a2-b17c-07a0884996f8@suse.com>
 <20250910135323.GC11602@yaz-khff2.amd.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250910135323.GC11602@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10.09.25 г. 16:53 ч., Yazen Ghannam wrote:
> On Wed, Sep 10, 2025 at 02:47:16PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 9/8/25 18:40, Yazen Ghannam wrote:
>>> Currently, MCA initialization is executed identically on each CPU as
>>> they are brought online. However, a number of MCA initialization tasks
>>> only need to be done once.
>>>
>>> Define a function to collect all 'global' init tasks and call this from
>>> the BSP only. Start with CPU features.
>>>
>>> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
>>> Tested-by: Tony Luck <tony.luck@intel.com>
>>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>>> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
>>
>> <snip>
>>
>>> @@ -2240,6 +2233,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
>>>    }
>>>    #endif
>>> +void mca_bsp_init(struct cpuinfo_x86 *c)
>>> +{
>>> +	u64 cap;
>>> +
>>> +	if (!mce_available(c))
>>> +		return;
>>> +
>>> +	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
>>> +	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
>>> +	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
>>> +
>>> +	rdmsrq(MSR_IA32_MCG_CAP, cap);
>>> +
>>> +	/* Use accurate RIP reporting if available. */
>>> +	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
>>> +		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
>>> +
>>> +	if (cap & MCG_SER_P)
>>> +		mca_cfg.ser = 1;
>>> +}
>>> +
>>
>>
>> LGTM
>>
>> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> 
> Thanks Nikokay for the reviews.
> 
>>
>> nit: One question though for those CPUs which consist of P+E cores, is it
>> mandated that both types of cores will have identical MCE architecture, I
>> assume the x86 world will be a lot more unified than Arm's big.LITTLE ?
>>
> 
> I think technically no, they won't be mandated to be identical. We already
> have per-CPU feature bits, registers, etc. And in Scalable MCA there are
> also per-bank config bits.
> 
> However, this doesn't mean we will have different MCE features between
> CPUs in a system just yet. The architects do try to make things flexible
> and scalable just in case there is a need in the future.
> 
> We can code to the architectures and be *mostly* future-proof. But it's
> not guaranteed to be without bugs. And it's not guaranteed that every
> possible case will be used.
> 
> Do you have any concerns or see any issues with the code today in this
> area? Maybe you're thinking we should have per-CPU config for feature
> bits? If so, I agree but we don't have a real need today AFAIK.

Yes, for example in your current code you assume that whatever the value 
of MSR_IA32_MCG_CAP w.r.t MCG_EXT_P or MCG_SER_P it will be identical 
for all CPUs. That might be fine, but what if, in the future, we end up 
with machines where MCG_CAP will have different values for different 
CPU's/cores.

Or that in a system we can end up with cpu's which have different 
X86_FEATURE_SMCA value.

OTOH, you are right that when the time comes we can worry about this 
since there can possibly be infinite number of possible scenarios.

> 
> Maybe others can comment too.
> 
> Thanks,
> Yazen


