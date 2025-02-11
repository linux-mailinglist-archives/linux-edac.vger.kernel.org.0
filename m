Return-Path: <linux-edac+bounces-3020-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A767CA30644
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 09:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223911881E5A
	for <lists+linux-edac@lfdr.de>; Tue, 11 Feb 2025 08:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E21EF085;
	Tue, 11 Feb 2025 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NRGg5crm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106851E7C28
	for <linux-edac@vger.kernel.org>; Tue, 11 Feb 2025 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263776; cv=none; b=cz5f/Jx3ue6C76b5ti2jI1qn1YJOKnTB6wF+Qfe+2BU4gOngKec0wV9lfT+W+HEv9HUtFduQdhvjSiVR14cqa23pf7UgaO3bRaKE1f6Ws7rctA+XlSwbAkJMG0/2629Rs932/oITwgVy4JCYIOS0HBcBV4USryFODwdvoLnFpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263776; c=relaxed/simple;
	bh=9mKyJMqRC5jyuweKXjyNCG6BcFdmTfgVIZoSwMXjCmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gQrOQ6McQtqb3hz5nv7lJhtLL4f7w78SB0G26ComE71BLaMJxBc1stujKKgM0tYauBFRXSkP628tXcP0HuKmAcOJ6ti8DsjSW4NsMgnx10gHP8bkmFNrwHIrzwA8iAnVdKGHEdEUVK4b0iflLR/CdgppvumMqAFt2u7gCLNMyHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NRGg5crm; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de727f7f05so3460058a12.1
        for <linux-edac@vger.kernel.org>; Tue, 11 Feb 2025 00:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739263772; x=1739868572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OB5t4gfhkfMF/UDGzHAHHgwNX5rrFSgr5XYXaS4lgQA=;
        b=NRGg5crml94IzwhBVa11d0pu1mGb5iG72IOuxvfdqjhUFmS08gbYYfxzFTLYDEqY4Z
         47FcZeL2PCOzA9+IVwiddkEQR72LqxlHJp/95ZhoKGYdshASNaT5fYusneDJ1e+P2is9
         8oJKFwGFTumBgAvEm4hW+tK23FfdnVeS6dDrplvrGQ9xawU9MU0NsYr4qZ3mpOrnUw7Q
         A6wK+1DZ9pCTDC1GO6+GcaVfyARdd9WCyKeZyvlYX+eTRP0/chI4lOrdjfFe/t14zgnL
         gxHpdw1NN2YrrwDZifpluqug5ugNnlVVkodSfZHI7TFdct/+srrRgk1DjsIdLh5aPNx2
         DniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263772; x=1739868572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OB5t4gfhkfMF/UDGzHAHHgwNX5rrFSgr5XYXaS4lgQA=;
        b=Vtv+ngJ25y2OFr8Aw7erOwtIl9Dtn/ac89t4o5nTChDOJrZzBmJYQbEUbGCJz6MHM2
         /SqFPD3l/Fpp/A0b6AIBYcgzlOtK+5Vimqkt8D3w3SDAH+PIASRMU67PNOLrAYat8I3D
         4o7jQuTUemXfZpnbmIA4DV25Y3Xs4IARsAV0PyrWnQTR55bHdKt/qP3FEQb11Y9jtX1k
         tMyDec7Tf8x9XDn4krPSxYAUsXA6UqxP9UuqSKa/bJqN0WXY0PWBZp5qUhFQQ75LfXc8
         soLsYQ+xPTROpaAdcTOZHB9ijOMWP69F5sOup4HLNXUqgHXu4hT5/EZDoQ2RGmpPfDSX
         TK9w==
X-Forwarded-Encrypted: i=1; AJvYcCUUQ9rjl1pGxy6iOUMiqkaepc7+QdpZW8x14gvgM3iMK52/BOa2B7LZVEBYCETf9yXAAjm3SYHm0dqb@vger.kernel.org
X-Gm-Message-State: AOJu0YwtiH0Krk6IBDEl+m/PYwRpIKixfUudPZ3uOXbsCfEslvY4BrXM
	fq4YJz8YZ0bhEg12HNKpCZfNqNGankQupvlDsWBWWS8BRG/YfHGoj7iGIi805EO1OQyBi24f7G+
	+
X-Gm-Gg: ASbGncvO+7vGF+aBU7iuSHHYVrKbeHPruvQnBNfl4+RO0yn3Z0jXwfqt16T1HBuAgsR
	xsLx55w4qY0CJ0/aBgcvjjDxscL6Rv3B9Oxe/4cG1htbZbrVt9hocCLUcBQr7lwHljSVYx90Zl4
	kuOxTEUcEKog1HwVkxfnZH0LXd7g+XNETV+yY6Emhc8tjxwrBnlZ8Bo5k0PfE6ch4+YiiP37Nb3
	C13TXliN2MkihokrTHU76ueZSiUCqg+Au6tsgS6li6CtJSkbDEvbucgJQaLg/w8s1CL0NRJKG3S
	peqU9eH5NdZpEM/6DRcEvGHOcssx11urvAchgRSD8Vo=
X-Google-Smtp-Source: AGHT+IFXrQtW3i12aCdYpAoofw5wR7Ns57GQoGt9IWwgAVMx27O4JHyPf4yKdquh38GeHqubCO+n0w==
X-Received: by 2002:a17:907:1b27:b0:aa6:8cbc:8d15 with SMTP id a640c23a62f3a-ab789ac0169mr1832842966b.14.1739263772357;
        Tue, 11 Feb 2025 00:49:32 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.142.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7d101ed7dsm217170166b.106.2025.02.11.00.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 00:49:32 -0800 (PST)
Message-ID: <1ab8afe8-761f-416c-8584-dcf15972e363@suse.com>
Date: Tue, 11 Feb 2025 10:49:31 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
 <CY8PR11MB713403A5AC3B0699B56A552F89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <CY8PR11MB713403A5AC3B0699B56A552F89FD2@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11.02.25 г. 9:03 ч., Zhuo, Qiuxu wrote:
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> [...]
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
> 
> Why make mce_notify_irq() return an int?


Pff... because I based my patches off master and not tip, which has it 
as bool...
> 
>> [...]
>> -/*
>> - * Notify the user(s) about new machine check events.
>> - * Can be called from interrupt context, but not from machine check/NMI
>> - * context.
>> - */
>> -bool mce_notify_irq(void)
>> [...]


