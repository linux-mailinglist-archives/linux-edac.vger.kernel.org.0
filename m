Return-Path: <linux-edac+bounces-1108-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2698CDAE9
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 21:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72B028112F
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB25284A21;
	Thu, 23 May 2024 19:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI8Ix6KB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E03629AB;
	Thu, 23 May 2024 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492769; cv=none; b=OFYHVkxnwlrFSSleGYn57uzErU7kA56yHnKTrIh9CCYYsr+1iqc76Lqy1NvNp9I9Xqz0ciBoRu//zytlHEt6fq1dZN4J/SUaorN5f5Z8DTK3od4nvPQK80xO2i6HFRmRfuFrEeLf/W9zhU15iJD5NnFURDyr2j8uFAGEvukwHRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492769; c=relaxed/simple;
	bh=4GOxqwSwAIEiFQo8otRI26MEmyqqZnsFcMuNXCQewRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FNXn1WgSQt0BayHsHJW6HLF6DtEvs6bnpGJ1QWi1XhWfaHnvQrjO7xZS2zTDB/Rqo2KMCBf/L9CNfln46+KhY9DWEnl1DHiFiuBzIV+W74+fa20lKv+ELhPEGMvSYcTweyw3tJqfJUe6hEw/o4d+7TP0TQ/enN1jOhCb69LSeik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI8Ix6KB; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f8ecafd661so130953b3a.3;
        Thu, 23 May 2024 12:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716492767; x=1717097567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BSMPg+JtmEvTAgJMEj6aatCAtPVZX62UHvRca6wD2Kg=;
        b=iI8Ix6KBU4uw+uZeaNr5DFbWuJghKO1AsFwr3wPL5BmqGSz/zW2mXCwQuFTVyIgRsB
         2EBKkk1uRjU+0QtrqEywitrm6TyfMQcc7z+pJMfQONDlB5WTB8yl9A/fdl58Fqsyzxjq
         3L3UgnXn+hTIaBnde2m0Th3QoBC6+uiwHcXaemU4uvMb38imj9F8WlQ3dnvOfdmPAQSM
         gxs+W7jxSWrpYaTIGg2MJlexMwOd+otJ/qQ70iEj0KWn+F1c3nvTOm+pAy8GtfDQl/oq
         bntprQGUF10r2SFE9ESIpw8o7jgjeJLKM1iz1q4a57D/n8bXLvh4sf/Zy6+mmAMZSZkR
         6S1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492767; x=1717097567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSMPg+JtmEvTAgJMEj6aatCAtPVZX62UHvRca6wD2Kg=;
        b=C5bPLjKyepaZSBOletuXs36EuuC8ZbvtaX+nA3Q+683s7AdZtyAl6YJa4vvO5G2Yt1
         I/XFX9ISMYNOz2JM2r8xv6768luWFVJld+GYgo80YPaAaMXAc650ZMoJm0imWrn3QBIQ
         ePUGFVGkxa7EKODRPNJKDumpnCrd0CvFAOjZz6s1yQWNkDl83jD0K0FprDGxMdX20NM+
         Rdy/N7Dy2nTHtSnlIaq+31Zi2ncWMBAIqHjIE575ngA3eHVe/qYGADEQElD5UKe+ch3J
         XUl9DJIVdlxSX/LZkH63ZSxUbhN1egOgmXb1mCXDXrKZoWteoppnXIOKlW6F7SjnltO9
         mUcw==
X-Forwarded-Encrypted: i=1; AJvYcCXjr7VaTRNxXPwB8zSQTNNa7ROnZuTakeXpR4YR6WUU/ge89eWrlFHRvXqh0VMbMcujLqAPBaYoOUp+gtkcd8IiROvJ1DxrjDYeUlCpPeRzsgtpsW04SF1P/C+Cq522RZv51CwJ4nOtHVOFck5nTQRxIxRilKZdYgHVLIvX5d59bsDzAuiL
X-Gm-Message-State: AOJu0Yzj+jwW17Rrf1xOjkuKv2i0Ocs0lNc9L0pXhxgtDCstdKBRn/qv
	/5IL1kRw99aGvVxsHP7iojeIcv/le1Y2ZnLnk/RPdm8sInKXYSOT+Mud9Q==
X-Google-Smtp-Source: AGHT+IEsc9w8u4r7TAhFz0RGNRWa656awiEPnloFIin0qsmMhcGBFEIYszrGdCA/9LYwVNDtREboZg==
X-Received: by 2002:a05:6a00:4088:b0:6f4:4441:a32b with SMTP id d2e1a72fcca58-6f8f40962bbmr141467b3a.26.1716492767283;
        Thu, 23 May 2024 12:32:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a6646bsm25102513b3a.15.2024.05.23.12.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:32:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e765d02-c7ef-48db-83b0-341362d71c70@roeck-us.net>
Date: Thu, 23 May 2024 12:32:45 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] hwmon: (k10temp) Rename _data variable
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-8-aa44c622de39@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240523-fix-smn-bad-read-v3-8-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 11:26, Yazen Ghannam wrote:
> ...to address the following warning:
> 
> drivers/hwmon/k10temp.c:273:47:
> warning: declaration shadows a variable in the global scope [-Wshadow]
> static umode_t k10temp_is_visible(const void *_data,
>                                                ^
> include/asm-generic/sections.h:36:13:
> note: previous declaration is here
> extern char _data[], _sdata[], _edata[];
> 
> No functional change is intended.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index a2d203304533..543526bac042 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -269,11 +269,11 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
>   	}
>   }
>   
> -static umode_t k10temp_is_visible(const void *_data,
> +static umode_t k10temp_is_visible(const void *drvdata,
>   				  enum hwmon_sensor_types type,
>   				  u32 attr, int channel)
>   {
> -	const struct k10temp_data *data = _data;
> +	const struct k10temp_data *data = drvdata;
>   	struct pci_dev *pdev = data->pdev;
>   	u32 reg;
>   
> 


