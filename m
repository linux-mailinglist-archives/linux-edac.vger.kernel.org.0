Return-Path: <linux-edac+bounces-2735-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E029F60AE
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 10:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328267A2BD8
	for <lists+linux-edac@lfdr.de>; Wed, 18 Dec 2024 09:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0E21917E9;
	Wed, 18 Dec 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ScmZRtqk"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F8187862
	for <linux-edac@vger.kernel.org>; Wed, 18 Dec 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734512661; cv=none; b=qw3cPDnuUmODr4Of68rRLdP2sWpDMrGu+rqGsyzTtJtlLDEYZSyXJlPBeJIY58QDfuUlk/wkJUVUvLmPzmzUmxXRv8Cny8UjHTQS3LYSbVXJng92B7P5wOf3/AXEeRMSvdccdlJQb6xwXooCMIc4EkIWoubPBqvvE4Hh3oixqKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734512661; c=relaxed/simple;
	bh=3gXU73qcbmEkygM0ywI47bgUMZJ+Z0Z9RX32JwkAYRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXBDE7LVJEV1OBFlAIl4m8rEtjMG7oRiPTylQYfz8XN1XfGxW0kkL1X51klq+KazLSr2qSsNAeriurzcsZfJ+UT40jLM3Mf3FaOnKTGXNH3t9+7Kgawl20q3UIbMb0Gg+YSN7KMsbXYVjaHj5fg63fHkMJ18KxoNHxX7+aPY8aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ScmZRtqk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361f796586so68097045e9.3
        for <linux-edac@vger.kernel.org>; Wed, 18 Dec 2024 01:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734512657; x=1735117457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BeTnhogaiVSEtaoJL1Fjor5c0RTC5Gjutd2kCpNXW4U=;
        b=ScmZRtqkY51kg7qwkErDMfwM/AYUN/QwoddCoAQ/GF5o8yD+UFMnjZd2ngyhJZy7QY
         ddvnXUp7/PA0AswVvlpuWnscqH4IGZE0lkA60qbiXe4oxo5+DN5lcvchDImCKlno0MYr
         MmujbJZG/y2rAkYDc8LcRD70oaOZx+1ENTOmMsgbGkVw/8UGcW8wrHH47QFCbIgGGvKJ
         4K2DMEyJOqI+MMm7NMOAgR5rtn17MJAYwObF0u3m4B+bcmSpGVVLlWLkQUT6pqRIOZ96
         kDT953B3VU0yZmRMp8ls0qIEmWoAsETex3jwT+I1FWmpy7w0BwJgxlGxy1OPTBIuLgxo
         BlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734512657; x=1735117457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BeTnhogaiVSEtaoJL1Fjor5c0RTC5Gjutd2kCpNXW4U=;
        b=jjp2s79VY+54LfQV7PFRqReFjDy73cXccc2mKZCh00kxg6hxXoEciZ3SroRsPQOVjv
         njZLwsC7ZPN8tDOUXC/o+tXbmZGdj7kxwPuU4mMiPxJwKUOhQ2kTUWyd2Xj2AByMKxQg
         OJ3RJKUT1EyAmP4PvKBZJ+HWrlf/fk/4MalaS/X445N8U6j5yg9wcfiKTpkXcpN2LcvR
         YDgtlpjAUdUbRF39HIxy7bVGfZA1pIDNZZRcJUyJmwfRVX6jFzvBe3XWkF2zXNBLa8VG
         bTSZfNfw9wisl4myN8ROB2K2WHEL1R74tU3H7jdz2YtNdWscA+SunMrnkf0EOuTmdxhf
         AJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7iU+1UloIc4I0Nysttkt1beK/6lo/lpy/598TY3XVqvMLuhWU9HhGvhtJv9LiEhW6Eja2tr/TktMm@vger.kernel.org
X-Gm-Message-State: AOJu0YzoxcxyiFHP/RgW9VdFNuewY306L0ArpFfPMYJ2h3YEoi55vAFF
	etl2WathaMQCoOvELt9zki+etN/f5qdEjPdhDT9ggZCVKRD9mhOr6xRT2FnHvUw=
X-Gm-Gg: ASbGnct1URoRFpqP0b7JgekHSyt4HZjn9emJXhDFlayWYqy1/bv2fekXkieBlfxsDJi
	fFfOgEadtgt5lZoAaBU0PJPsTxi4mnRXFvelTeKN0wVP6hFiCu6ZXvOsukm+v2tXRU1WcHAodZF
	vTjEc+W8n3nPV3NFjWUsIjAFoddQTIGi2DmqwrGD8SHGdG4UwCao38+UC9Kpco/pcabj/iQ3FnY
	SuE8wYoKS9bFFPhbkDGPbIcJnI1WPgUxn34VTr5HUWoUZ+JINTokdi2X/mbqT2X9Yao0PCguYYs
	KxZ1DGzr
X-Google-Smtp-Source: AGHT+IHKkUpAqF3ohsXOFa0CkcX8+OH/Vt+BfoQPXs0wlRktNNw/o1TPMKRVpTn0T1AqyJBgIxEy8w==
X-Received: by 2002:a5d:59ae:0:b0:385:df73:2f42 with SMTP id ffacd0b85a97d-388e4d93f16mr1564729f8f.32.1734512656574;
        Wed, 18 Dec 2024 01:04:16 -0800 (PST)
Received: from [192.168.0.20] (nborisov.ddns.nbis.net. [109.121.139.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8060592sm13245030f8f.98.2024.12.18.01.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 01:04:16 -0800 (PST)
Message-ID: <31e87668-afc7-41a2-8cfe-1de609e6f2ce@suse.com>
Date: Wed, 18 Dec 2024 11:04:15 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mce/: Make cmci_supported() return bool
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@suse.de>, "Luck, Tony" <tony.luck@intel.com>
Cc: "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20241217145117.155990-1-nik.borisov@suse.com>
 <CY8PR11MB7134CD07F072C6F3EE6C4EA589052@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Language: en-US
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <CY8PR11MB7134CD07F072C6F3EE6C4EA589052@CY8PR11MB7134.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18.12.24 г. 3:21 ч., Zhuo, Qiuxu wrote:
> +Boris & Tony,
> 
>> From: Nikolay Borisov <nik.borisov@suse.com>
>> Sent: Tuesday, December 17, 2024 10:51 PM
>> To: dave.hansen@linux.intel.com
>> Cc: x86@kernel.org; linux-edac@vger.kernel.org; Nikolay Borisov
>> <nik.borisov@suse.com>
>> Subject: [PATCH] x86/mce/: Make cmci_supported() return bool
>>
>> It's the last function in this file which is not returning bool when it should.
>> Rectify this, no functional changes.
>>
>> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
>> ---
>>   arch/x86/kernel/cpu/mce/intel.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
>> index b3cd2c61b11d..db0436e9c891 100644
>> --- a/arch/x86/kernel/cpu/mce/intel.c
>> +++ b/arch/x86/kernel/cpu/mce/intel.c
> 
> Hi Nikolay,
> 
> I've included this change in the following link, which you've reviewed before 😊
> 
>    https://lore.kernel.org/all/20241212140103.66964-2-qiuxu.zhuo@intel.com/

Indeed,

Disregard this then :)


> 
> Thanks!
> -Qiuxu


