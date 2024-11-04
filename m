Return-Path: <linux-edac+bounces-2435-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E45C9BC057
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 22:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EF781C21F27
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 21:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303731FCF41;
	Mon,  4 Nov 2024 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LWArabD+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251571AC435
	for <linux-edac@vger.kernel.org>; Mon,  4 Nov 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757122; cv=none; b=AsHlcNKfRthjfbL8g4icLacba0XImd0sYmK+CcbMHt/b8P7wTU4Mw6iPTC+tMrBsADUYP1C8nLM+gAaTPsQCECNZuofVuNZlKaIPvsMbW78AywSZheuB8uk+H6HaQ87qoiuBtfrUbr1kcrnViOyNh2TAKPAzxsxxbzFwuQh/eHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757122; c=relaxed/simple;
	bh=UsiBc1g53sq+K0xqyImn41o5l2118hJKKKhUPiwFY6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FM1ybla3odZY/2DH588RxubSRHgE4iWUF/pqgUiFe1v7pWawR6ECddz+SSOCDVeLMwVDHTgaOl+L1B0YittsRaPqA9tqAkIhCWzxudAkWU5gMC7rkhqjoLi88TgvCoeSlyDHAI+MirGOnNHK6V+nLp5jITFLYreVzedjSGYSoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LWArabD+; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab21c26e5so192379839f.1
        for <linux-edac@vger.kernel.org>; Mon, 04 Nov 2024 13:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730757118; x=1731361918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3V3t06tAcIBFTGvKOZbL8ly+O9NdFQ2GFTEgezZueso=;
        b=LWArabD+pj1ezYDQ3NOeq2dOl2b6KA5J4o8y5SoXh6p+5IXjeZ/yCp7kHVzyIbkS90
         xSEyXCJmcgR1hc5qyn+r9BPjyp/1H9bRwohoxeRRH7DbmaUnCoCZk2ikZGbBN2G77rQ9
         /rMQBEjPvNizRYq5JoxrYup6HYX3kU6iNKGu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757118; x=1731361918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3V3t06tAcIBFTGvKOZbL8ly+O9NdFQ2GFTEgezZueso=;
        b=akYr2BUZCGvdCdXGmO09GQDMpYbrO8xAvvRAo6UXhc/F6xYaFlDiUrZFWrOReGCBin
         LnADMBf53zZzY6NRFMZuNeJ9zIx9MLHoNgfQkYTr3HRwlo/TSUVtbIIWPFn8SSj7PCPP
         9BDeU4IXKl5L455bBYQi6VxUGj11NJWGl9e9rFVmtUIyRrzK/NZOHAAD7XxD28qZyvHm
         4YuqJU/ECc/JeOZTVfRaSfZXuMtFkAXlTH710fnP50phzs9SA45oUVpiLeOpmA6912zv
         qO9xDSCCyKgA9u9hndTAWbKkOBxSVd1Zac5Q382hv6uoxjnROE2Npi3hMNHA9jwhpUtT
         1Hlw==
X-Gm-Message-State: AOJu0YwL68c7dwm5SxDiPTushWcQnW092nwB2u5n4AZ52LEZD/LEUJZP
	RdB0MA3+34CtvfrbsVKEZ7KK8zqIqWDUtbTZGnEiz7UoiTLBAe6Jgwl3b921VLg=
X-Google-Smtp-Source: AGHT+IFP9aXJEqHwR2wuVf4JYtqpech/vN7YFiF50djAXb6OhhwndHvwXMCJsUuSMdtnvOdMXSCUGw==
X-Received: by 2002:a05:6e02:1528:b0:3a2:7651:9846 with SMTP id e9e14a558f8ab-3a4ed295a05mr365210515ab.13.1730757118227;
        Mon, 04 Nov 2024 13:51:58 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6a97b009csm25308285ab.4.2024.11.04.13.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:51:57 -0800 (PST)
Message-ID: <3c347f99-485c-453d-9b9a-9924abf1e868@linuxfoundation.org>
Date: Mon, 4 Nov 2024 14:51:56 -0700
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
To: Karan Sanghavi <karansanghvi98@gmail.com>,
 Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
 Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241104-coverity1593397signextension-v1-1-4cfae6532140@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/24 11:34, Karan Sanghavi wrote:
> Explicit cast pc to u32 to avoid sign extension while left shift
> 
> Issue reported by coverity with CID: 1593397
> 
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
> Coverity  Link:
> https://scan7.scan.coverity.com/#/project-view/51975/11354?selectedIssue=1593397

Please include the coverity message instead of this link so
reviewers without coverity accounts can see the report.

> ---
>   drivers/ras/amd/atl/umc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
> index dc8aa12f63c8..916c867faaf8 100644
> --- a/drivers/ras/amd/atl/umc.c
> +++ b/drivers/ras/amd/atl/umc.c
> @@ -293,7 +293,7 @@ static unsigned long convert_dram_to_norm_addr_mi300(unsigned long addr)
>   	}
>   
>   	/* PC bit */
> -	addr |= pc << bit_shifts.pc;
> +	addr |= (u32)pc << bit_shifts.pc;

How did you determine this is the right fix and how did
test this change?

>   
>   	/* SID bits */
>   	for (i = 0; i < NUM_SID_BITS; i++) {
> 
> ---
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
> change-id: 20241104-coverity1593397signextension-78c9b2c21d51
> 
> Best regards,

thanks,
-- Shuah

