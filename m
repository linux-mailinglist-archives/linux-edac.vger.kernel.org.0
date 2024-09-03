Return-Path: <linux-edac+bounces-1776-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4A9969652
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 09:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FC511C2300B
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 07:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD6E20010C;
	Tue,  3 Sep 2024 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RV7tkW9H"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AF1AB6C0;
	Tue,  3 Sep 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350338; cv=none; b=f0iUgmBYO82X3bz8S2E4k2bCg2wmZFUqAeY0FPydxPmqFR4nkWB6FNIDx8t+ClbxV5hjM+Pr9M8MtwXGJLcwXuPm4AFUtLUOk4BLDoH4b2b4PyqUmZ/fwvM7dFg4vT6hbdBtg3QgAfLW8qiIzgvb5Osrj7I4J6HJ57wDTsEauCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350338; c=relaxed/simple;
	bh=jMBF1eJfkRU7cRnclh+rfEYRcO0cRqD85aPEPxx1qoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPYJXzTb/Jn8BuO6bZGad6WEw2i34dO8oIwzgBvfhkRpB29cZqlh7iLQRM7Y4c9z+LYqZkd5UG46E87eR0+tkLM2Uw5LSwLi5/F6EnaEL82DkKFcTgFyJwbZzgbWUvNZrWaN7YBXzmiRxYcXWy8UIXxdsqXXUx2oheYYi58osyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RV7tkW9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D07C4CEC6;
	Tue,  3 Sep 2024 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725350337;
	bh=jMBF1eJfkRU7cRnclh+rfEYRcO0cRqD85aPEPxx1qoA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RV7tkW9HQoE1wYSK7zusNyEsAnvWl17yJ76l6NbfdP26mFWaR2gClX4GLjHROoxdL
	 osFLbvwjYR1WtVHn+Gha22gqzpEHZO+fZ3beNWuP17qhk+UPUPCm8bZBvKFALO2qy6
	 lR/eHr8OBIiK+dtiUY4vc0z589h5HpcUoWfpP+0sDh7685EKu22xdAQzZYPacLs/+P
	 sChQyHKRXAfrSY9BEmDYUyOaS+pFfBmi0HlXFe0ZFjK0Ru4tQsUBtWiDJWnsxTeAIf
	 ux42pjZXBiHxspK/M7v3T1DnSIkLjIp10A8HnXt4x4LkmsrXJrfh9MYMQFe8P3W2j6
	 04C7QMX6nT8eQ==
Message-ID: <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
Date: Tue, 3 Sep 2024 09:58:48 +0200
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
To: Zhao Qunqin <zhaoqunqin@loongson.cn>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
 <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
 <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2024 09:24, Zhao Qunqin wrote:
> 
> 在 2024/9/3 下午2:47, Krzysztof Kozlowski 写道:
>> On Tue, Sep 03, 2024 at 09:53:54AM +0800, Zhao Qunqin wrote:
>>> Report single bit errors (CE) only.
>>>
>>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>>> ---
>>>   MAINTAINERS                  |   1 +
>>>   arch/loongarch/Kconfig       |   1 +
>>>   drivers/edac/Kconfig         |   8 ++
>>>   drivers/edac/Makefile        |   1 +
>>>   drivers/edac/ls3a5000_edac.c | 187 +++++++++++++++++++++++++++++++++++
>>>   5 files changed, 198 insertions(+)
>>>   create mode 100644 drivers/edac/ls3a5000_edac.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 6cc8cfc8f..b43f82279 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>>>   L:	linux-edac@vger.kernel.org
>>>   S:	Maintained
>>>   F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
>>> +F:	drivers/edac/ls3a5000_edac.c
>>>   
>>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>> index 70f169210..348030c24 100644
>>> --- a/arch/loongarch/Kconfig
>>> +++ b/arch/loongarch/Kconfig
>>> @@ -182,6 +182,7 @@ config LOONGARCH
>>>   	select PCI_QUIRKS
>>>   	select PERF_USE_VMALLOC
>>>   	select RTC_LIB
>>> +	select EDAC_SUPPORT
>> I think you got here comment before. How did you address it?
> I just randomly found a spot, and I will put it at the end(next version 
> patch).

No, the comment was different. You must not select user-visible symbols.

>>
>>>   	select SPARSE_IRQ
>>>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>>>   	select SYSCTL_ARCH_UNALIGN_NO_WARN
>>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>>> index 16c8de505..2d10256f0 100644
>>> --- a/drivers/edac/Kconfig
>>> +++ b/drivers/edac/Kconfig
>>> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>>>   	  Support injecting both correctable and uncorrectable errors
>>>   	  for debugging purposes.
>>>   
>> ...
>>
>>   +
>>> +static int loongson_edac_probe(struct platform_device *pdev)
>>> +{
>>> +	struct resource *rs;
>>> +	struct mem_ctl_info *mci;
>>> +	struct edac_mc_layer layers[2];
>>> +	struct loongson_edac_pvt *pvt;
>>> +	u64 *vbase = NULL;
>>> +
>>> +	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +	/* not return if can not find resource or resource start equals NULL */
>> Why?
> 
> Because there are multiple memory controllers in the ls3x soc,
> 
> but the ECC function of some memory controllers cannot be used.

Then what does the driver do for such memory controllers? Your binding
is quite clear here that above code is just bogus. It is not possible to
have node without reg.

Please point us to your DTS and results of dtbs_check.

> 
> But in any case, a node must be created in /sys/devices/system/edac/mc/  
> through edac_mc_add_mc(mci).
> 
> Then if the ECC function of the memory controller cannot be used, set 
> start to NULL or do not pass mem resource,
> 
> which is equivalent to enumeration of memory controller, and the CE 
> count will always be zero.
> 
>>> +	if (rs && rs->start) {
>>> +		vbase = devm_ioremap_resource(&pdev->dev, rs);
>>> +		if (IS_ERR(vbase))
>>> +			return PTR_ERR(vbase);
>>> +	}


Best regards,
Krzysztof


