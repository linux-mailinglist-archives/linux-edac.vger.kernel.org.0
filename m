Return-Path: <linux-edac+bounces-1781-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7873B9699A7
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 11:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE752854DB
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E51F1A4E8B;
	Tue,  3 Sep 2024 09:59:54 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A819F42D;
	Tue,  3 Sep 2024 09:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725357594; cv=none; b=oRe4XMyVc1LFaiI3UDNtRqskyL3sHdSD+y4BDkDvVJar6OofjjOkoloJR3IESedKg2Em+m+3nwDqeWGkhOjA+XBzaqCv4dX2Xtgifw+7Pzm7ZvebXGu/CvxlWaStXKPPq2DTwglfWKinb8D649vjVTh8VorsA14JLESZ2fzuRXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725357594; c=relaxed/simple;
	bh=kpYh5Vbgr2QEdHEMAjI5GDUKDsowxzPMpAQCAPZxGKs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=GJsJTvujFIaHyBWlKnshSQ564orFXYFldTrPTm9f4Vo9+3xhyiU6kXnAX02AEmuAxW8dcNTwW0sGJ28QrSvLYchp81eYjfraO1m2k432/5NYXxxebaKeUEqtEALHy8LziSqx9Zw087DdpzyHBE/vDCxYX8R5whYO/x1EKlsRRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxaZoQ3tZmfRApAA--.43098S3;
	Tue, 03 Sep 2024 17:59:44 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMBxjcUO3tZmeMEEAA--.12849S2;
	Tue, 03 Sep 2024 17:59:43 +0800 (CST)
Subject: Re: [PATCH v2 2/2] Loongarch: EDAC driver for loongson memory
 controller
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 bp@alien8.de, tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
References: <20240903015354.9443-1-zhaoqunqin@loongson.cn>
 <20240903015354.9443-3-zhaoqunqin@loongson.cn>
 <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
 <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
 <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <cca91e87-ea98-5b16-0503-4d51fd524f24@loongson.cn>
Date: Tue, 3 Sep 2024 17:59:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <979d67cc-cbd2-408c-a8ca-a063030bcec2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMBxjcUO3tZmeMEEAA--.12849S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1DCr4Dur45ur1kCF48GrX_yoWrGF48pr
	n7Aa1fCr47Ka13Jrsav34jgFnIqwn7tr43Wrn3Ka4qgryqyFy3uFy8Xry29FyDur1kGrW8
	ZFyFka4akF45JacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4qg4DU
	UUU


在 2024/9/3 下午3:58, Krzysztof Kozlowski 写道:
> On 03/09/2024 09:24, Zhao Qunqin wrote:
>> 在 2024/9/3 下午2:47, Krzysztof Kozlowski 写道:
>>> On Tue, Sep 03, 2024 at 09:53:54AM +0800, Zhao Qunqin wrote:
>>>> Report single bit errors (CE) only.
>>>>
>>>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>>>> ---
>>>>    MAINTAINERS                  |   1 +
>>>>    arch/loongarch/Kconfig       |   1 +
>>>>    drivers/edac/Kconfig         |   8 ++
>>>>    drivers/edac/Makefile        |   1 +
>>>>    drivers/edac/ls3a5000_edac.c | 187 +++++++++++++++++++++++++++++++++++
>>>>    5 files changed, 198 insertions(+)
>>>>    create mode 100644 drivers/edac/ls3a5000_edac.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 6cc8cfc8f..b43f82279 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>>>>    L:	linux-edac@vger.kernel.org
>>>>    S:	Maintained
>>>>    F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
>>>> +F:	drivers/edac/ls3a5000_edac.c
>>>>    
>>>>    LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>>>    M:	Sathya Prakash <sathya.prakash@broadcom.com>
>>>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>>>> index 70f169210..348030c24 100644
>>>> --- a/arch/loongarch/Kconfig
>>>> +++ b/arch/loongarch/Kconfig
>>>> @@ -182,6 +182,7 @@ config LOONGARCH
>>>>    	select PCI_QUIRKS
>>>>    	select PERF_USE_VMALLOC
>>>>    	select RTC_LIB
>>>> +	select EDAC_SUPPORT
>>> I think you got here comment before. How did you address it?
>> I just randomly found a spot, and I will put it at the end(next version
>> patch).
> No, the comment was different. You must not select user-visible symbols.

Last version patch is:

@@ -182,6 +182,7 @@ config LOONGARCH
   	select PCI_QUIRKS
   	select PERF_USE_VMALLOC
   	select RTC_LIB
+	select EDAC_SUPPORT
+	select EDAC

I delet "select EDAC" in this version patch. Other arch's Kconfig has "select EDAC_SUPPORT", such as arch/x86/Kconfig and arch/arm64/Kconfig
.

>
>>>>    	select SPARSE_IRQ
>>>>    	select SYSCTL_ARCH_UNALIGN_ALLOW
>>>>    	select SYSCTL_ARCH_UNALIGN_NO_WARN
>>>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>>>> index 16c8de505..2d10256f0 100644
>>>> --- a/drivers/edac/Kconfig
>>>> +++ b/drivers/edac/Kconfig
>>>> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>>>>    	  Support injecting both correctable and uncorrectable errors
>>>>    	  for debugging purposes.
>>>>    
>>> ...
>>>
>>>    +
>>>> +static int loongson_edac_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct resource *rs;
>>>> +	struct mem_ctl_info *mci;
>>>> +	struct edac_mc_layer layers[2];
>>>> +	struct loongson_edac_pvt *pvt;
>>>> +	u64 *vbase = NULL;
>>>> +
>>>> +	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>>> +	/* not return if can not find resource or resource start equals NULL */
>>> Why?
>> Because there are multiple memory controllers in the ls3x soc,
>>
>> but the ECC function of some memory controllers cannot be used.
> Then what does the driver do for such memory controllers? Your binding
> is quite clear here that above code is just bogus. It is not possible to
> have node without reg.

I will rewrite the code above.

> Please point us to your DTS and results of dtbs_check.
>
>> But in any case, a node must be created in /sys/devices/system/edac/mc/
>> through edac_mc_add_mc(mci).
>>
>> Then if the ECC function of the memory controller cannot be used, set
>> start to NULL or do not pass mem resource,
>>
>> which is equivalent to enumeration of memory controller, and the CE
>> count will always be zero.
>>
>>>> +	if (rs && rs->start) {
>>>> +		vbase = devm_ioremap_resource(&pdev->dev, rs);
>>>> +		if (IS_ERR(vbase))
>>>> +			return PTR_ERR(vbase);
>>>> +	}
>
> Best regards,
> Krzysztof


