Return-Path: <linux-edac+bounces-2924-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBDFA126C6
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 16:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03AE188A0BC
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2025 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59DF1448DC;
	Wed, 15 Jan 2025 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wc/+PO1q"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E97C14900B
	for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953335; cv=none; b=fDwJ+i/qUTrt2FyC57wrxTjnDXQWBeurL7MbxXJfv0SrXJqK/8+kfudsY/wv+m07NEKo1n7F402UYgi496umzPFt3yQJizA4OA6rB8yoD51IX4ZTQWv01+j9RZx/Od4gBDTXM6UvuwsKs/wpTxgE84DC7nKmIUdlQTvIjv1JHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953335; c=relaxed/simple;
	bh=fWe1DmIf/rUA4q9/7Bo+vw6TxUEJN2ralvVFtwgTqPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0955A49x43ywxSh8T3ihuq+G0Ag9q279agN/QDEfU044PsCAtDBAHpkfmddN43y3YMKAeE+KktgErT1m6Jm4zA2hxPPWFuU8zgXN6HuxVKVUBvETLHwK4R9thER8BEVO5maZjqrhVl9uQeyD/WR8ZaiyNnhFYYfg6WbJV9JC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wc/+PO1q; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so11460408a12.1
        for <linux-edac@vger.kernel.org>; Wed, 15 Jan 2025 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736953332; x=1737558132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wr3VTcbI+VvrHolaLupaAEzNtYD7r1o9IujuVJzdg/w=;
        b=Wc/+PO1qJI2Kvi1p7350Ru8DVJvbOxA+TAVGkroJ4G02I/jSxJVOSGAHqRzr+sLgBC
         7w5zSqnlFLCet0v86tMZT4kOFNs94ayrC3QACGB05Mj+OMHgNWb+6TofDWVVTvkj7OX+
         311ljresASiMNom28ialI0kAPH47LycHhSgb6lY+E2TRTULPOZdRgigqZi52/Q5TbQiW
         5b6/EYMlyJJS5feuTIMFkslM0Y40+iuSAt8+PcGymWjiUS8oyfFlvO2IVlxGruUfXIVs
         9SfMhVddZYphOryVqdftbvJ1OhaMjbld3Rqbi4xYaSGzosDBtnjgHpRWXAW6tQzGCYcL
         CZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736953332; x=1737558132;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr3VTcbI+VvrHolaLupaAEzNtYD7r1o9IujuVJzdg/w=;
        b=cAf75oMCZ/drJpOLHNLHcG7sQwF2p3Bpc2GSE9GtH8SCPO9bNwCqY89yzhVSZuwNxC
         DcnAeb5Xe2zra+v+i3C8l3GCNwurUojE4rmBmT2uYF7yd/GUBAVircmUXMhlcBH1yI+o
         ZQRU0fgKdHtDmoEwpH27pRs+1Uu4NMaj+0ZviuzuZulEKgsDb2allcPtMa0wwVWDd7df
         hHFmyLnxRdrufXd5pr+zKZndHNPaDnu8RITSxQTP5aBH0Q7Qeo3hJzkHk2hsT6oJs9yc
         QGmuD3nG/LsWm6w3JUvt70DrYWQ/IuEOFyuYzIa4Bt8DOt1hcabxP5N3NRooxdHQRrly
         TQdA==
X-Forwarded-Encrypted: i=1; AJvYcCVY0RVy8wXOiZJgBS8IU0C4fhR5muNMMyrCD3qSjsucmsKiNXx5m1Ik8R5aRnECqbHQsKS4DQqeylOv@vger.kernel.org
X-Gm-Message-State: AOJu0YzpG4uNwT/kfImoboMh5B+9kzuP3wWFxvXCAdT1D1D/w9lu/dqv
	kLoV9gdEkIiNFFdsJVU62qx2Eo6vgBrVdgSCEFd26SMjzx0V6Skj6QUnviEvsHM=
X-Gm-Gg: ASbGncuQXLdfCmn/Tcgz6jUNb/uQhJBeo5eD94T18Qfj/SzR6BJqBamI+kzb5OwdLfj
	1ipqT4+GSmliRYX8nLwZO/HiyyEHt+kPlVMGHgUfV2kW6o8a1YwCLmq2vrlV0StyzDuYjoWGio6
	IrFybgr2cjPRdn0e0Aoi154y2zxis+NL8JlkyYVEe+xvbju9oT5Iw/0N1J9qkitK6+65hhnpuZ3
	8QVYKyBiCfn9yaC4c13LYr0aNPjKEZXeXHCF8qpSjDHaBb3L0QNxlQwkYl5jw==
X-Google-Smtp-Source: AGHT+IHqlhGs7T+dMRvYzVElxj8Mj1/3/O1FkhC4R5g6hQsBXal1XoNT2GhhAzK4zkV36cnwKudbaQ==
X-Received: by 2002:a05:6402:5241:b0:5d0:f904:c23d with SMTP id 4fb4d7f45d1cf-5d972e6e094mr30699491a12.28.1736953330120;
        Wed, 15 Jan 2025 07:02:10 -0800 (PST)
Received: from [192.168.0.20] ([212.21.159.176])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9904a55f9sm7336529a12.81.2025.01.15.07.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 07:02:09 -0800 (PST)
Message-ID: <9eb0be50-c051-4e71-9d7a-4e609da1266f@suse.com>
Date: Wed, 15 Jan 2025 17:02:08 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bp@alien8.de" <bp@alien8.de>
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-4-nik.borisov@suse.com>
 <CY8PR11MB7134DEA89B78F45AA20C1C2E89192@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <CY8PR11MB7134DEA89B78F45AA20C1C2E89192@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15.01.25 г. 15:45 ч., Zhuo, Qiuxu wrote:
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> Sent: Wednesday, January 15, 2025 3:37 PM
>> To: linux-edac@vger.kernel.org
>> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; bp@alien8.de; Nikolay
>> Borisov <nik.borisov@suse.com>
>> Subject: [RESEND PATCH 3/3] x86/mce: Make mce_notify_irq() depend on
>> CONFIG_X86_MCELOG_LEGACY
>>
>> mce_notify_irq() really depends on the legacy mcelog being enabled as
>> otherwise mce_work_trigger() will never schedule the trigger work as
>> mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 89625ff79c3b..b21aa1494da0 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -591,6 +591,7 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
>>    */
>>   static int mce_notify_irq(void)
>>   {
>> +#ifdef CONFIG_X86_MCELOG_LEGACY
>>   	/* Not more than two messages every minute */
>>   	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
>>
>> @@ -602,7 +603,7 @@ static int mce_notify_irq(void)
>>
> 
> The message printed inside this function should not depend on
> CONFIG_X86_MCELOG_LEGACY.  User-space tools/scripts might look for this
> message to detect machine events. It is also useful for debugging purposes.

The thing is if MCELOG_LEGACY is turned off then mce_work_trigger is a 
noop, hence nothing is really logged which makes this message somewhat 
bogus. After all the early handler's job is to log to userspace, if we 
don't log anything no need to spam the kernel log.

> 
>     if (__ratelimit(&ratelimit))
>         pr_info(HW_ERR "Machine check events logged\n");
> 
>>   		return 1;
>>   	}
>> -
>> +#endif
>>   	return 0;
>>   }
>>
>> --
>> 2.43.0
>>
> 


