Return-Path: <linux-edac+bounces-1107-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576568CDAE6
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 21:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D667A1F23AAE
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5C083CDD;
	Thu, 23 May 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+m7hL3N"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B429AB;
	Thu, 23 May 2024 19:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716492717; cv=none; b=I05EjEj+dHhrEdmGCmp8QPw6Skn2r7i++KHiWE5Ov0kqvKBoNVqYjuccCIFhlulAgue650QCnBHhAUtyvdmVkOj69PIECKrWUnxWOzvpNMa7CFHqBow6ROdmzn/xH4nPG5gGKY/Opk2sdaY2u0Ns3XO5VPMVDGfG/AmpI31duHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716492717; c=relaxed/simple;
	bh=aXYDXIn/ENB6oZKwNZ1Jq36Ex2Cl3fIqV674B6i/STM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De9zzVrrdXXg89UWGKyv6HVg2bavNPkeStDkyoYpVTfn9rcjV6+kO/hJJE/2VqCfe31tK8dlw4ZC8N79A4a8K6/TpX8h49zrLDrsapYbJXBIxMMua2Dqbr/kz6auEWsibtEdITflnfB/CdN35MBvZzmPLUjnr2AFLFdqyBHg3wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+m7hL3N; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b513017so242555ad.1;
        Thu, 23 May 2024 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716492715; x=1717097515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ercL6wWo4kFiMX1hwzNAewQSqM8Z99TOJrvmuHqRN8E=;
        b=E+m7hL3NQ/vKxrczE3+KqphPfiZKh5yMaowhR70JuNENdKf/C6p7NQBlU/C4Z84Zvi
         4Y4ZITN34nvEfwQWNrSHKGWysjplga20aUjbaSb0sNC/dgIO+nK7C9d6hZVSIfD2eB9G
         NMZNLsAkMOF8cfQIOide0TN63PVSY0kEWY2ptqZfet0YwvdgU47n91jac+DqHxSqOgRZ
         aZioNmU2UV4k6h6CtPzMI4s9hqtsq3mhhkkA3wVzet7Y4hbWA6t4+4ES/MsbkyzPRnf8
         fKYoWOQTUtS3kTn1nIIl8n2wiraQIhGhQMOwQcQhkhVbhz29DUfDu2CH677c4QkjxP29
         t9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716492715; x=1717097515;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ercL6wWo4kFiMX1hwzNAewQSqM8Z99TOJrvmuHqRN8E=;
        b=vllEsOlpsWHxkKY4KRhlmD7/7lKqQtLusERoIAK3jJ98eNQ5KQDz/vuwRmsRODsmeY
         a+yhZVQBLTiO3H35rTASTrLClcNpzpTv6bTZDXv4DMdwsMYAuR/JpSnm9299+1F6d4vv
         KDwVntDVIey/34dSTnJqx7RV3ld87/buODr4gtotak10AtpRocIUfYmuD5b9btQ838im
         tOU3blcmIyOsxXnat7bXkLeYRXL5jVElBTi98KBPvU3QVwB8MwynUxLq73eC3/bdRYoY
         r+IToGkZxk/md0z/1Cc78irIEWgUUBiduXvMpcr9/zsytDwXdt4zZhl6wV5VFcxBg7eK
         puCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8E2BywsHLBvpEwDR9CYivwNLJy5ZdatEBfu5a5z8i9HnlHm677Uduj6mEe9QplXBTx+GwSvZcIiddZ4ED5KSufDmKdT3ANwRKJrY/2D5z0LcOuA8yqCb+RF2KMPpH0AsW6Mjp/LDpWS/OPP6AIiPDczVU/rfE1DYWXGtWWYzX4TVhsWQD
X-Gm-Message-State: AOJu0YzDaO/1C3nSboDMkFhpEbJHtiA8/mgIHi2DDzkESGGv4VAcZDRK
	Y9Ynvt7XUuHUZEFYz227Z+I62JDu26MO34N8bQ0JPT4AfqdRjO2h
X-Google-Smtp-Source: AGHT+IHzj6nVNQNhgjPaU0bHbQ9GIYWP1dZ8yY3ol7Im5Z2GzF6t4GYmkVlNSPS/18YzfhJyoil4nQ==
X-Received: by 2002:a17:902:d504:b0:1ea:9596:11eb with SMTP id d9443c01a7336-1f4498e22a7mr2695745ad.60.1716492715219;
        Thu, 23 May 2024 12:31:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b1b1d13sm260115155ad.0.2024.05.23.12.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 12:31:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <93f90092-b757-4bf9-9f43-34801d92c345@roeck-us.net>
Date: Thu, 23 May 2024 12:31:52 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] hwmon: (k10temp) Remove unused HAVE_TDIE() macro
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
 <20240523-fix-smn-bad-read-v3-7-aa44c622de39@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240523-fix-smn-bad-read-v3-7-aa44c622de39@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 11:26, Yazen Ghannam wrote:
> ...to address the following warning:
> 
> drivers/hwmon/k10temp.c:104:9:
> warning: macro is not used [-Wunused-macros]
> 
> No functional change is intended.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/hwmon/k10temp.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
> index 6deb272c7cef..a2d203304533 100644
> --- a/drivers/hwmon/k10temp.c
> +++ b/drivers/hwmon/k10temp.c
> @@ -101,7 +101,6 @@ struct k10temp_data {
>   #define TCCD_BIT(x)	((x) + 2)
>   
>   #define HAVE_TEMP(d, channel)	((d)->show_temp & BIT(channel))
> -#define HAVE_TDIE(d)		HAVE_TEMP(d, TDIE_BIT)
>   
>   struct tctl_offset {
>   	u8 model;
> 


