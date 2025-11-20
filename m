Return-Path: <linux-edac+bounces-5489-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BAC7536F
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B6394F8122
	for <lists+linux-edac@lfdr.de>; Thu, 20 Nov 2025 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A063321C0;
	Thu, 20 Nov 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrSkporD"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A6E3644D4
	for <linux-edac@vger.kernel.org>; Thu, 20 Nov 2025 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653517; cv=none; b=k3M1bcRAagKERZi/7DKPtPI4/4aqyexRC/oB+xQuKpME9DcMTU0BoKoYo7GmFkLnOXPKzQN1kRKSZqy1yFR9ggKWEEMr8KEXzhdjNJGiCKNPXIJ0jNDgGdY2n3DLLNvaXPij68T7+hwZxk8ulpM/OiOUB8VxQN9EyDv9PFaCVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653517; c=relaxed/simple;
	bh=OTBHSDb8Rc8HpUsq1BO7u4HXCse22jOiexSRcrURie8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXujlJLHMr7dleXwQf/krL3ViayEeRiGATUUGsFjk+he9ZwDcFC/2lr0yIUQjxGwjBu+V10+Vb8ddJ5o2sJC1SpdrDtq5CRoxrXnRq0M8q3DNph4jFluGFHC8gxLbbvd8Al5Ozz+BeSVKTacZcdiLGsH8YA5QBiyH8GPBZ7o7kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrSkporD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b728a43e410so187244466b.1
        for <linux-edac@vger.kernel.org>; Thu, 20 Nov 2025 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763653511; x=1764258311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FMJ2IvKCYTO8R6nxvMUbY5OPaWFDAnkLuDX/Hx1uNj4=;
        b=WrSkporDKkwrGY70+5Qps4//FxPgQyoBYRUDN+0OD0I2pN67CovFEPtzIAkZPTqZZE
         UkCAvuZa6o1H9vWZZEm2HL84bPhqF6Np/umOvXXvdPhOJztz0zmw3ONs6/tbhGnVdELU
         mzXxs4XjF5ujVohBlGotKIxnvMyQUvE8GWXQXyptQC5B0hU6lFEKsM1Kh2FMqAPuJEG1
         rAYS5JCRLYDKQeBmH22hutZZ4gP8MV+FHMqA3YE6eIfNRXDpW+LNGj4G13khB0O224GN
         CIusckc5BZUykcE65B+s3BK2aFoBxAEViTztH40pIvEn56CxQcy0/mXUsjUofUWASJeT
         VT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763653511; x=1764258311;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMJ2IvKCYTO8R6nxvMUbY5OPaWFDAnkLuDX/Hx1uNj4=;
        b=BtIFtO4r7nsRZhHUPHAtFS4lNzjLyUMSpRlGoNIIc69eaguOqnkXosrDvynrXX9us5
         +LelGKE8MEpBKjcdWH5V8hEAl7vIVkJCDx9sPgdXifylaFDah0W24khF2B3XfMI36yvD
         4wz1sMB6bq2uQe8iRBv/bJqa3094fyr7zV0Oy8MOK/rfm5kDDVNAdf7JI18Cm2gv4hpo
         o0UtUYHYIUY9Tp+DQ4A+fpLUCpQlMch4Fbmag56VkPo6yEz8iAbiD3ZQ31x0rJGDA3q+
         tcJ2sPf4L+SFsTelo957WPcNZ6YX047777WvQfnkhNmDldUO36cTReNOvuV9aUrLnpPk
         QvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4YSSM/2DVqqsuetKE4voBOvQqiQklsdQNhTpQKzlodSBtDiY1OmfYw6meiCNFvDsU5X9gYe9vys7i@vger.kernel.org
X-Gm-Message-State: AOJu0YxNPX4vpu2NjZFm0wtlN3d2qw0lUFbUBug8pJ/AbjvdoYdO0bSl
	KtpUegJcwYDHg5dts3ziYNSmlhsAD5ErT6dwNDW+q0H79r5V+YDXSEetmHlDhX++kWE=
X-Gm-Gg: ASbGncuV89fXSE1iaFcUJu0x/wKyr4VIhR1LbmWTVnJUaIzlsw2C1i/73BV7+83Rpsk
	6k/eWD6C3y6FLUbCPfZj+0Da9L24tmqIByvv+Njf4I8o1lF+v8yzKzHvx3szCRSEzI3+KASqvt3
	AFiF2tPWJ99zw1jnoL1qd8qAuXaIruHT+DOl5/osXg1c0vUndDXZCzC52BOIc5uvjZVutK4y47g
	zc8GrvrtL7LpqnHUui942i1h/LglpRpn+8NsFybowc1BGrhUsbn2PtWboaQ6AJEIGKFwbeQlVhV
	Zs7Yq+/sWIbvdhz28p924n/8E3eolLY1ptlvR/+oeJLfnzjEHu5TSm7gDvvxorntb1LNL9fca0d
	C8tdSMBahUYnn8om+N4BINwtMFUC27XQwP/71lKPZvOOj1yZncaLuwabP8bgQR8LmKyQpkYfnHr
	wGymfHzHo/9f0e8N++atyEIzs0zUn4sjuBqkKq
X-Google-Smtp-Source: AGHT+IHMXQcmStydRvqbrcBEOehr3ctKTW4BIfbChvtttlmmnC/yJBCR39MxQLgUEpTrqVtANxeyRA==
X-Received: by 2002:a17:907:6d22:b0:b6d:505e:3da1 with SMTP id a640c23a62f3a-b7654cf9b90mr385876466b.7.1763653511335;
        Thu, 20 Nov 2025 07:45:11 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [85.187.216.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d56a88sm237607766b.23.2025.11.20.07.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 07:45:10 -0800 (PST)
Message-ID: <7f942b9f-ce85-4e02-9317-3aef1dccd1c9@suse.com>
Date: Thu, 20 Nov 2025 17:45:10 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Remove bitwise_xor_bits
To: Borislav Petkov <bp@alien8.de>
Cc: Yazen.Ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251113111125.823960-1-nik.borisov@suse.com>
 <20251118123352.GJaRxnsHRC6KcbQanQ@fat_crate.local>
 <edfc3212-dc28-43a5-9d9d-c838d253ea88@suse.com>
 <20251120154153.GBaR82wW8qjDQA8eoV@fat_crate.local>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20251120154153.GBaR82wW8qjDQA8eoV@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/20/25 17:41, Borislav Petkov wrote:
> On Tue, Nov 18, 2025 at 02:36:08PM +0200, Nikolay Borisov wrote:
>> Fair point, but bitwise xor is the lowest possible operation, I guess we
>> care about the higher-level effect, which is calculating parity.
> 
> ... in a function which "Calculate hash for each Bank bit."?
> 
> I don't think it matters either way. This is converting the DRAM addressing
> scheme into normalized addresses so as long as it is clear what happens
> there...
> 


So are you saying the patch should be dropped altogether or that the 
changelog should be reworded?  The way I see it, the parity for the 
given bank's col/row are calculated and this then is used into 
calculating the hash.

