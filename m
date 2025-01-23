Return-Path: <linux-edac+bounces-2946-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D26A1A77A
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 17:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8C4188C8DB
	for <lists+linux-edac@lfdr.de>; Thu, 23 Jan 2025 16:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DB3212FB4;
	Thu, 23 Jan 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q5V1w2GO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A623CB
	for <linux-edac@vger.kernel.org>; Thu, 23 Jan 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648067; cv=none; b=BTZcPbW6mhv+EvjC1k4pdRfjHHQN6m8qhYczRo1x78Cx71Aa12uijvN+zGnJlqXMuM+xYYu1J/Np89Gg3P7qF5TRs/6ga4jW1/8+ZMedZ/ATPeaLu/sUl7q2XJiXIU9f6pS2onUDUk9iBsUgUDo8KiIpFPz8T3Sljybs644xa0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648067; c=relaxed/simple;
	bh=1kUo76AdbdInNUYiaAbGGk6BEc0K5sUJ9fGGb2RLCDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t29HVTFUCjaYJDNCxWRGokWmxIlYiQUq15p4sEM+iphQ1zVpldF12wuvhL/MoJ7TYYcVohbCfN9TGFcvbMsUloO4qfCVlgZkbTbubJwqsfjR6hxkcu291EXo5Ovhg45TjtkA7240os+nd52pcUhOar7KCNxD0ZjFQ0zb4QhcWRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q5V1w2GO; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf60d85238so192652666b.0
        for <linux-edac@vger.kernel.org>; Thu, 23 Jan 2025 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737648062; x=1738252862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xh3+8eFQABhtF13QI7U7fE3d8Hf8FSiqNKcHdOqMxak=;
        b=Q5V1w2GO91aKFkTRgXxEWP+GB4iwf2pnUDvpeTlE9I7zzVN7RP78R9ZbQEvgd8aSnG
         Y1kOZb/6XBOBEiDlsAKAN9GzeMk6i9Dpk1wNyQt35i19hKfZF7Q/oPqv7pe0bn2CO+Ug
         bB236QfAv+ivslVo6AQ6GW0J+1tlZ4vDJr2YUzBKpov0RnMxkZmDpINGKvcEgQb5JI72
         svnBdkNvoRTvct7HKZevU7yCb7DxS3cRttSrd1C0iH90nuGp4txp+Lo0TAbhLXJ80alV
         ARMSahUJAGx00wZWkXy6qdnr0n4TWXHCoSREwScf1CZhgTIiupA+OOcpfWCELBAg0QP+
         KhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737648062; x=1738252862;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xh3+8eFQABhtF13QI7U7fE3d8Hf8FSiqNKcHdOqMxak=;
        b=cgDp+RBdD03WHZkPBZCcxU1LK7Om3MlgvUeGC2c9LCjiwMcagHdvrl0w3kzzJ3MRob
         iKt4Y3BjTIzlY2KCni9QWShVLRdS6FESEJeyfsNzhFvWpYbpIDRiUTEq7sEJ4y7mq4qh
         GEba5lgYI0G2/82vzzCuFd+UKx6jol9ckPNpJgVe8Mncg6ChwXFcarbbHE/AAF1pqwUf
         Q9PEWP5d45zfy6Lparu+qbAdCsUwW3vSrySRPf/Sd7ooLzNqlCV+L+Z1iKLdHa2/3XaD
         UK32wxqzKCOF9m5UcxGWqM5iHiE2L3ao9SnW8nnAbJZeyh+YuGbioCCahMxKOT0WA7KS
         OdwQ==
X-Gm-Message-State: AOJu0YzujDG0fYVVXV7KUagZMLwOvKqihNJ5yGb8yn4QGMnFYKAR+9Bf
	cdgyZENXG6kJMG8f3HfP/9KiY+Cdg3Ge+xmjAkln/LPrKcbgj1sqE9KWkVIAg4A=
X-Gm-Gg: ASbGncsQ+Cgt2qWBP7sDHpZdumGiIYU/xKN4Ke2IDBoIPZ4DPGj6d69AWTbyrPFjXxC
	OoRpPkMIVUa3u0twQurrhd7xXBiObRzOKuMI4OIT7/dtNUeoXyhuP9j1nw2aQcxX4/vWCDAzd7a
	F9cTgSXxYBpweF+7QRjL9BFXrdUz+1E68CTIiIVPQr8GCscKiU3a7yv1tgHvVl92d/jmXetKcYo
	5vkGNDwpCRMF3OLJXjfTiUulMtq9UPQ+s2Zagzz6aUULivzyVb5yn0y0WUAMdYwV0fCBd0dAakv
	4C+MEi2NnQ==
X-Google-Smtp-Source: AGHT+IFHEnqCVvZ4lgttQ4MJzcAW1C2/hsGPw7wH4081/1BgH39bZ2tm2jus/cyF3UabeFRY00xy6Q==
X-Received: by 2002:a17:907:7da1:b0:ab2:c1da:b725 with SMTP id a640c23a62f3a-ab38b298c5bmr2677492466b.30.1737648061540;
        Thu, 23 Jan 2025 08:01:01 -0800 (PST)
Received: from [192.168.0.20] ([212.21.159.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384c5c47bsm1095940266b.16.2025.01.23.08.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 08:01:01 -0800 (PST)
Message-ID: <0f0ca15c-7d6e-4274-ae4c-20f55340aad6@suse.com>
Date: Thu, 23 Jan 2025 18:00:59 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 1/3] x86/mce/inject: Remova call to
 mce_notify_irq()
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 bp@alien8.de
References: <20250114163722.34850-1-nik.borisov@suse.com>
 <20250115073640.77099-1-nik.borisov@suse.com>
 <20250115073640.77099-2-nik.borisov@suse.com>
 <20250122182438.GA464145@yaz-khff2.amd.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <20250122182438.GA464145@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22.01.25 г. 20:24 ч., Yazen Ghannam wrote:
> On Wed, Jan 15, 2025 at 09:36:38AM +0200, Nikolay Borisov wrote:
> 
> Hi Nikolay,
> 
> There is a typo in the $SUBJECT.
> 
>> The call is actually a noop because when the MCE is raised the early
>> notifier is the only call site that correctly calls mce_notify_irq()
>> because it also sets mce_need_notify. So let's just remove this call,
>> which allows to unexport mce_notify_irq.
>>
> 
> The commit message should be in passive and imperative voice.
> 
> "So let's just remove this..." -> "Remove this..."
> 
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/kernel/cpu/mce/core.c   | 1 -
>>   arch/x86/kernel/cpu/mce/inject.c | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 0dc00c9894c7..23e5e7f7c554 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -1793,7 +1793,6 @@ bool mce_notify_irq(void)
>>   	}
>>   	return false;
>>   }
>> -EXPORT_SYMBOL_GPL(mce_notify_irq);
>>
>>   static void __mcheck_cpu_mce_banks_init(void)
>>   {
>> diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
>> index 313fe682db33..06e3cf7229ce 100644
>> --- a/arch/x86/kernel/cpu/mce/inject.c
>> +++ b/arch/x86/kernel/cpu/mce/inject.c
>> @@ -229,7 +229,6 @@ static int raise_local(void)
>>   	} else if (m->status) {
>>   		pr_info("Starting machine check poll CPU %d\n", cpu);
>>   		raise_poll(m);
>> -		mce_notify_irq();
> 
> With this change, there are no users of mce_notify_irq() outside of
> mce/core.c. So you could go further and make the function static to
> core.c.
> 
> In other words, you could squash the second patch into this one.

Thanks, I've incorporated those in V2 that I sent.

> 
> Thanks,
> Yazen


