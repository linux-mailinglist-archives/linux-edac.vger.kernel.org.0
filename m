Return-Path: <linux-edac+bounces-4830-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489DFB840D0
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 12:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93F831C281FE
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587652FC03B;
	Thu, 18 Sep 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gP9HAlIz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DE28FA9A
	for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758190864; cv=none; b=cepVeSwLzx0bahsTsx5qqmBmC9zRvADKGFO/dMFRcz9ZYgEqjKrXrckSfmbswHWjfXULRYyznt7Is/09tuF731KG+XahIC6J5v5zDlWByH76k65gYllaMpIPjGspele0/zgUe0F3xVeMK9kPzjZt9zvks7HfmWhQR0b8PK9LDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758190864; c=relaxed/simple;
	bh=lcbZuTlRYeYw/+6+qtA8Zj+ABLvsvhjoXWyh7W0PIeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFGjq+ntkarVxChVz8lom3KvVTROH8bpLY/Us4Xwbe6NdF+p8k1QfGaUbCs+hgKue+WvGg4nP0oy3/KdsYRXIZ5xFhMjMwgP81Ily4D5kl/sODibdK4zY6vdmKZ54+aNcyLZk52T3jA+UTPY5gN9HAZjlw2nORUYBU4c+gjG3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gP9HAlIz; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62f28b8e12cso1443196a12.1
        for <linux-edac@vger.kernel.org>; Thu, 18 Sep 2025 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758190860; x=1758795660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QRDX73CGJx/uFk65r/M++y1ESGZoLC/18154y9sBkyQ=;
        b=gP9HAlIzZ0O+NFXtxQ4IpfNNIVQIVKkryhTQcuFybJgWqgykNlPduGpqteJPzkYleb
         zyj8gwG2TEITgKMitfGgdFg2bsYVyfzS8DiCQ2UNF7Pi6tK/aAnFLaIVPnbT/je66//8
         KhxTsD9BDCmSlzY+t+V8gcpiLJQu+mmS5b47jGt2qRRhizEeKLwP9cbj9OFYFsM0jhUq
         0SLMWMdhJu4lddfKrcXToILlz1OTIL5RuundElWq65LzDCnLSnr9WrUjyXQicUtlfyY3
         t3dgOOpzwM/WG6IrPaWf0GVkykcW51NN1B4IeDJqh2OtZbgXEVFLb0kEB7MF6zdPU7Bj
         /xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758190860; x=1758795660;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRDX73CGJx/uFk65r/M++y1ESGZoLC/18154y9sBkyQ=;
        b=bQuqfFntzZTklY3jYYRJnO3hwPuoNt+OgUVO19Quk9UxQqAJBoUpqfGrBD4SkvgA3r
         8VJoPgjdKIN7Vq94c5KP4JG003fGOp2lysg5wTIklGc6h1DcbArswCyIGlraUSA0e7t4
         IlpqMDOZa9q5dgYprNKRHgexlHBR8FpmYRe34I6iW2FA1zAbqFPLtTMrn8DxqTpF36jh
         /5V38yVaqrEy3cjsTcuRPlt5crivLzpeuG1m51+Ond715S65ejErP+qw6tp9mX5L+OXq
         tKSaIgcjB2nqK2l7rB9GCyAuRBaNCgeNCBKz24AJv2hh663J+I3wyfdjw/YcqvgPdnD7
         3kyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqoKuHXck30bc0SL+j+18KGUzzySDLLF9lV60nNLlOSO1OyqWqILa4WLCf8n6aFS1rdCbYN/FpssVC@vger.kernel.org
X-Gm-Message-State: AOJu0YzX56PsOAKmjM7MfCnOweYlqc29e3GQAvl0+Sl3GGYM0ShS7PRu
	X13ikx5MaM3PhcjSfpwD0aAijeJFoD4odAH66ZEgVfc8HI20Jhg6TJ4uHJaVzH++bQE=
X-Gm-Gg: ASbGncuKWVcmw62J2aS2es3Yat0f6Q/u6+NaptBzrRlzonDtl2XK/iYq1J6YhvVFSmM
	yrK6G+Xb9l2lHU8l9pJLS0YTHn69uXyzC+ADZHWLt6NfO01cJgbjiNp5GmIWEtcqppYZI6lF4Bq
	1s6DJQJEE1aW4Xvl8kD3hRpKFPgbhrFPmaVSopOAQbyQhKSfLflrU+MwQQLhfewiTTG/0GsWdHb
	fUsJTxWWNTtTMzbKz77/enoVQj8rjvYP/9v03PgtXHxqCTHBqWeW5lWAuVneqaXXPXg1wMmxVD/
	jFxSYYiimzBhdDZAS1Rmn7CnLo/yAneQ5f8259D+cnoyl0ZSm+AG18Uhh+WLgZX3xnWbAL0KRKD
	WHpCPY6Nv8ziADXPb7wcEMRNxf7qHhPxzvHKfslPovsoHsjNXGnsxbZ1TW+33po4APVJ0iJbHiK
	XOaQ==
X-Google-Smtp-Source: AGHT+IHZMQ2x56m1ACsAJOzzucWoM9GC1r3aRL6fpTCvD4pffVAwszK8RFTaPLUkaniu91C/lt6qfQ==
X-Received: by 2002:a17:907:7ea8:b0:afc:a190:848a with SMTP id a640c23a62f3a-b1bc27793b9mr605349566b.60.1758190860179;
        Thu, 18 Sep 2025 03:21:00 -0700 (PDT)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd14d5f56sm166369466b.74.2025.09.18.03.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 03:20:59 -0700 (PDT)
Message-ID: <5ba955fe-2b96-429e-b2e8-5e1bf19d8e8e@suse.com>
Date: Thu, 18 Sep 2025 13:20:58 +0300
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spurious mce Hardware Error messages in next-20250912
To: Yazen Ghannam <yazen.ghannam@amd.com>, Bert Karwatzki <spasswolf@web.de>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org,
 rafael@kernel.org, qiuxu.zhuo@intel.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20250915010010.3547-1-spasswolf@web.de>
 <20250915175531.GB869676@yaz-khff2.amd.com>
 <45d4081d93bbd50e1a23a112e3caca86ce979217.camel@web.de>
 <426097525d5f9e88a3f7e96ce93f24ca27459f90.camel@web.de>
 <20250916091055.GAaMkpn72GrFnsueCF@fat_crate.local>
 <20250916140744.GA1054485@yaz-khff2.amd.com>
 <9488e4bf935aa1e50179019419dfee93d306ded9.camel@web.de>
 <be9e2759c1c474364e78ef291c33bc0506942669.camel@web.de>
 <20250917144148.GA1313380@yaz-khff2.amd.com>
 <6e1eda7dd55f6fa30405edf7b0f75695cf55b237.camel@web.de>
 <20250917192652.GA1610597@yaz-khff2.amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250917192652.GA1610597@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/17/25 22:26, Yazen Ghannam wrote:
<snip>


> Right, so it seems we have bogus data logged in these registers. And
> this is unrelated to the recent patches.
> 
> We have some combination of bits set in MCA_DESTAT registers. The
> deferred error interrupt hasn't fired (at least from the latest
> example).
> 
> There does seem to be some combination of bits that are always set and
> others flip between examples.
> 
> I'll highlight this to our hardware folks. But I don't think there's
> much we can do other than filter these out somehow.
> 
> I can add two checks to the patch to make it more like the current
> behavior.
> 
> 1) Check for 'Deferred' status bit when logging from the MCA_DESTAT.
> This was in the debug patch I shared.

According to AMD APM 9.3.3.4:

"If the error being logged is a deferred error, then the error will be 
logged to MCA_DESTAT."

So this means that when Valid is set in DESTAT then the error MUST BE 
deferred. I.e I think it's in valid to have valid && !deferred in 
DESTAT, no ?

Additionally nowhere in the APM is ti mentioned what's the default value 
of MCA_CONFIG.LogDeferredEn so as it stands you are now working with the 
assumption that it's 1 and DESTAT is always a redundant copy of STATUS.

Btw looking at the output that Bert has provided it seems that indeed 
MCA_CONFIG.LogDeferredEn is 0 by default:

"
LogDeferredEn—Bit 34. Enable logging of deferred errors in MCA_STATUS. 
0=Log deferred errors only in MCA_DESTAT and MCA_DEADDR. 1=Log deferred 
errors in MCA_STATUS and MCA_ADDR in addition to MCA_DESTAT and 
MCA_DEADDR. This bit does not affect logging of deferred errors in 
MCA_SYND or MCA_MISCx.
"


I think the polling code is slightly broken now for AMD. The order of 
operation per poll cycle should be:

1. Check MCA_STATUS -> report if there is anything, clear it the bank
2. (In the same cycle) -> Check DEFERRED and report if there is 
anything, clear the deferred.


> 2) Only check MCA_DESTAT when we are notified by the deferred error
> interrupt.
> 
> Technically, both of these shouldn't be necessary based on the
> architecture.
> 
> So there's a third option: add this error signature to our filter_mce()
> function.
 > > As I write this out, I feel more inclined to option #3. I think it 
would
> be better to stick to the architecture. We may get error reports like
> this. But that may be preferable so that any potential hardware issues
> can be investigated sooner. If there's a real problem, better to get it
> fixed in future products rather than implicitly mask it by our code
> flow.
> 
> Any thoughts from others?
> 
> Thanks,
> Yazen


