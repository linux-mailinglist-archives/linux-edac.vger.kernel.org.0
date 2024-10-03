Return-Path: <linux-edac+bounces-1960-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABA98F6FD
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 21:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01F2D282B0C
	for <lists+linux-edac@lfdr.de>; Thu,  3 Oct 2024 19:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A051ABED9;
	Thu,  3 Oct 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wle+WsjV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBFD1A7AF6
	for <linux-edac@vger.kernel.org>; Thu,  3 Oct 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983787; cv=none; b=FUPxsY8akGa15w/A+UITKmaf45XYbJZq1By5i43OWd+LQ87XuShWFPmkLpKwOey4fMf6h5Gznpgs460eyEh0jUrmdT3DbzR75ykfX5DQiWzkLYDIyT0fF0TPliWjyk1r8CJchaC7WbqHmIXIZ8vfke7xs0HnTaExCTF3Xce2HRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983787; c=relaxed/simple;
	bh=D7aETJPp/4LYnMzoSV8oLPYP8GD1T23jKxm2T/OKYCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jzgh6tuw2Z9aAGDZVY2OQ91rzkGweXmPAkofHbYTeW5dUm/VRo+LIYXRns6YPkKB5oY4neGGmE2RJd8IrC0ogqcMIxkoIBo2ubkngwBwkXYmnHeccNxrO2PCoO+xZn7+drVv6kAmFgmTTnQG+wVFtp1g5jJvPZuhiSkiaaL4Hw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wle+WsjV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cddc969daso1947855e9.1
        for <linux-edac@vger.kernel.org>; Thu, 03 Oct 2024 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727983783; x=1728588583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T7UrvI5Fkk+44il/XysRntO10uEYOYRnW9FgVarUVGs=;
        b=wle+WsjVYujZtyzcqiir0rugZheg6pH1ymwDTiuAtqtj/bsOItDBULvCPqHS26JH8C
         DD8HmTXh3v4jt0XV5A0eBY404tYnjK9mJd7PPOcDNK5DYx5l6VT/QrdOeUUoiOa6JPAP
         FRdNfuZQIKTUuzcRMpapWcptr3YKCA2NrVhZINXqKqjuqUsnylCZ5W2R/qAtG+a28suQ
         HwnJbNX2gcK9J1DAV1A/OKIIei7MXLYsn6FoV1GwNKkdSvfbMmI9JrsTNYXrDO04KmKG
         9DEA4Od9IWEAl9kXQPoxK9TeptRsdGUzcViHp/XHNxwSRBX28J3T+sT+DZ8Pu6zLtj2d
         neXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727983783; x=1728588583;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7UrvI5Fkk+44il/XysRntO10uEYOYRnW9FgVarUVGs=;
        b=e9h2gLJHtF/8MALCDRiqKw1OtU6jTpujQqKg9ed1dIwAHiIaGLqO+Li23gs34vMEzd
         MIxvVEB+tR3jpP7wE0BuHc9wM1pzMdkEQka7dyAFOkTPyacUJZvVZtNld7SUtvvvXsiH
         iqoqtusSF9nqY8F6h0ATZdGJNQhq0usohiQlE6mHxi92/OU+t64mNQuAzi2buH5xrm9J
         /A0Eka3UhNckuJDLzu4SPLdQ+2/TjdgWvHg8XWn7Hesz00vofBXkI85UfZpOh6PgnPc3
         oeXUpG7iZXFGpgRB62lWYq0HleVdxW2FR7Dr/Y0UzQB41XpSSgSagm3963AesEs08pBe
         qdGA==
X-Forwarded-Encrypted: i=1; AJvYcCWHcW1J/pcZ6KU3Z9bkcuGrFHMeM5KDuqFhF0U/VMx7XcMDLp5QKhUTS97sx93mry3ObNCdNQ/8lNdM@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbqfrrVFP+6Nb/iFXXp31nyytIHSAza8g0WY9bvwLvExon7NO
	IZxZGCL63g/jV+a0BTd0veQNXtJ6wCpJq/JgUPzx5od/FVT6EoTDBfeDxS4L8GM=
X-Google-Smtp-Source: AGHT+IEchPL6usDj9NEuF/JHyYPwezdupbMRzhwo6o14mcPVGjV8lwDrJxyiDlYqShHKviSeWv32pQ==
X-Received: by 2002:a05:600c:3b1a:b0:42c:b9c8:2ba9 with SMTP id 5b1f17b1804b1-42f85af0d24mr393255e9.6.1727983783124;
        Thu, 03 Oct 2024 12:29:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f85a5f56csm698455e9.1.2024.10.03.12.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:29:41 -0700 (PDT)
Message-ID: <a4e39207-fe4d-4242-9f32-c50910b9c319@linaro.org>
Date: Thu, 3 Oct 2024 21:29:40 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC: MAINTAINERS: move FSL DDR EDAC maintainer York Sun
 to Credits
To: Frank Li <Frank.li@nxp.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 James Morse <james.morse@arm.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 York Sun <york.sun@nxp.com>
References: <20241002105211.43276-1-krzysztof.kozlowski@linaro.org>
 <Zv1fsvP5b3a5Vz4l@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <Zv1fsvP5b3a5Vz4l@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 16:58, Frank Li wrote:
> On Wed, Oct 02, 2024 at 12:52:11PM +0200, Krzysztof Kozlowski wrote:
>> Last email from York Sun is from 2019, so move him to Credits, which
>> makes Freescale/NXP DDR EDAC driver orphaned.
>>
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Cc: York Sun <york.sun@nxp.com>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  CREDITS     | 4 ++++
>>  MAINTAINERS | 3 +--
>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/CREDITS b/CREDITS
>> index d439f5a1bc00..77b4760142f6 100644
>> --- a/CREDITS
>> +++ b/CREDITS
>> @@ -3795,6 +3795,10 @@ S: Department of Zoology, University of Washington
>>  S: Seattle, WA  98195-1800
>>  S: USA
>>
>> +N: York Sun
>> +E: york.sun@nxp.com
>> +D: Freescale DDR EDAC
>> +
>>  N: Eugene Surovegin
>>  E: ebs@ebshome.net
>>  W: https://kernel.ebshome.net/
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a77770cd96b8..b9e2824d7ebb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8130,9 +8130,8 @@ S:	Maintained
>>  F:	drivers/edac/e7xxx_edac.c
>>
>>  EDAC-FSL_DDR
>> -M:	York Sun <york.sun@nxp.com>
>>  L:	linux-edac@vger.kernel.org
>> -S:	Maintained
>> +S:	Orphaned
>>  F:	drivers/edac/fsl_ddr_edac.*
> 
> i.MX still use it,  I am volunteer to maintain this driver.
> Also please add imx@lists.linux.dev

Sure, thanks, I will send v2.

Best regards,
Krzysztof


