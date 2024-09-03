Return-Path: <linux-edac+bounces-1774-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C7969542
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C36E8B2318B
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 07:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6881D6C48;
	Tue,  3 Sep 2024 07:25:05 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127391CE70A;
	Tue,  3 Sep 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348305; cv=none; b=OE3TOpChIcV0CkoLu5bVm65SFtbEAfTC4snubur+XHJ2cNMHYtPZpuZkKZcjk3cwxZIpJhsyIsbOwrrra0Vpge3lPcGENUG3bIGz2JeS9P47h05r+wAQwe1/tm21L8e5pGq6DTfaNb08D6DhQisspk2hnZf5C+kMUkZPwEgv6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348305; c=relaxed/simple;
	bh=0Lk62AogqXYvQYO5OHvsDaoqs7VIQVuQ5SHSWCYbRSw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nU2EDyip6zddJjsVQYBMXS0VaNWo8df5CqPhaxOD0mwxHa3hJZVcueuqsXaDPbzDzweQSaBl9RJYcWcP3D9zjYBRXuTZi0RLbKw0OA7lzABetwKtzpEWo0rOuMFuH3WQ1N/oPlJao/JDNNbfdF44pmfXLtZy7Hs1+QJ3WG51hsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8BxmprLudZmofAoAA--.43065S3;
	Tue, 03 Sep 2024 15:24:59 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMCxncXKudZmJ6IEAA--.12539S2;
	Tue, 03 Sep 2024 15:24:58 +0800 (CST)
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
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <549969b7-26c4-a203-b5a0-2e89ab7e7d79@loongson.cn>
Date: Tue, 3 Sep 2024 15:24:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <jkdyayyjrzuhhfaueiessntfdof2m55xjxedkl3zp2jalf4sii@3fo65j64c6rv>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMCxncXKudZmJ6IEAA--.12539S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr1rtr48CFWkGF45GF45Jwc_yoW7WrWUpr
	nrAa13Cr18Kw13JwsaqrWUGF1Yvw1fJw13CrW3Aa4jk3sxAr95u34ktry2kFykCr1DGr48
	ZFyrC3ZFkFs8GFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUceOJUU
	UUU


在 2024/9/3 下午2:47, Krzysztof Kozlowski 写道:
> On Tue, Sep 03, 2024 at 09:53:54AM +0800, Zhao Qunqin wrote:
>> Report single bit errors (CE) only.
>>
>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>> ---
>>   MAINTAINERS                  |   1 +
>>   arch/loongarch/Kconfig       |   1 +
>>   drivers/edac/Kconfig         |   8 ++
>>   drivers/edac/Makefile        |   1 +
>>   drivers/edac/ls3a5000_edac.c | 187 +++++++++++++++++++++++++++++++++++
>>   5 files changed, 198 insertions(+)
>>   create mode 100644 drivers/edac/ls3a5000_edac.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6cc8cfc8f..b43f82279 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13242,6 +13242,7 @@ M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>>   L:	linux-edac@vger.kernel.org
>>   S:	Maintained
>>   F:	Documentation/devicetree/bindings/edac/loongson,ls3a5000-mc-edac.yaml
>> +F:	drivers/edac/ls3a5000_edac.c
>>   
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:	Sathya Prakash <sathya.prakash@broadcom.com>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 70f169210..348030c24 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -182,6 +182,7 @@ config LOONGARCH
>>   	select PCI_QUIRKS
>>   	select PERF_USE_VMALLOC
>>   	select RTC_LIB
>> +	select EDAC_SUPPORT
> I think you got here comment before. How did you address it?
I just randomly found a spot, and I will put it at the end(next version 
patch).
>
>>   	select SPARSE_IRQ
>>   	select SYSCTL_ARCH_UNALIGN_ALLOW
>>   	select SYSCTL_ARCH_UNALIGN_NO_WARN
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 16c8de505..2d10256f0 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -573,5 +573,13 @@ config EDAC_VERSAL
>>   	  Support injecting both correctable and uncorrectable errors
>>   	  for debugging purposes.
>>   
> ...
>
>   +
>> +static int loongson_edac_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *rs;
>> +	struct mem_ctl_info *mci;
>> +	struct edac_mc_layer layers[2];
>> +	struct loongson_edac_pvt *pvt;
>> +	u64 *vbase = NULL;
>> +
>> +	rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	/* not return if can not find resource or resource start equals NULL */
> Why?

Because there are multiple memory controllers in the ls3x soc,

but the ECC function of some memory controllers cannot be used.

But in any case, a node must be created in /sys/devices/system/edac/mc/  
through edac_mc_add_mc(mci).

Then if the ECC function of the memory controller cannot be used, set 
start to NULL or do not pass mem resource,

which is equivalent to enumeration of memory controller, and the CE 
count will always be zero.

>> +	if (rs && rs->start) {
>> +		vbase = devm_ioremap_resource(&pdev->dev, rs);
>> +		if (IS_ERR(vbase))
>> +			return PTR_ERR(vbase);
>> +	}
>> +
>> +	/* allocate a new MC control structure */
>> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
>> +	layers[0].size = 1;
>> +	layers[0].is_virt_csrow = false;
>> +	layers[1].type = EDAC_MC_LAYER_SLOT;
>> +	layers[1].size = 1;
>> +	layers[1].is_virt_csrow = true;
>> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
>> +	if (mci == NULL)
>> +		return -ENOMEM;
>> +
>> +	edac_dbg(0, "MC: mci = %p\n", mci);
> Nope, drop. You should never print pointers.
I will drop it in next version patch.
>> +
>> +	mci->mc_idx = edac_device_alloc_index();
>> +	mci->mtype_cap = MEM_FLAG_RDDR4;
>> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
>> +	mci->edac_cap = EDAC_FLAG_NONE;
>> +	mci->mod_name = "loongson_edac.c";
>> +	mci->ctl_name = "loongson_edac_ctl";
>> +	mci->dev_name = "loongson_edac_dev";
>> +	mci->ctl_page_to_phys = NULL;
>> +	mci->pdev = &pdev->dev;
>> +	mci->error_desc.grain = 8;
>> +	/* Set the function pointer to an actual operation function */
>> +	mci->edac_check = loongson_edac_check;
>> +
>> +	loongson_pvt_init(mci, vbase);
>> +	get_dimm_config(mci);
>> +
>> +	if (edac_mc_add_mc(mci)) {
>> +		edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
>> +		edac_mc_free(mci);
> That's still a success of probe? Weird a bit.

I will add return ret if (ret =edac_mc_add_mc(mci))  in next version patch.

>
>> +	}
>> +	edac_op_state = EDAC_OPSTATE_POLL;
>> +
>> +	return 0;
>> +}
>> +
>> +static void loongson_edac_remove(struct platform_device *pdev)
>> +{
>> +	struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
>> +
>> +	if (mci)
>> +		edac_mc_free(mci);
>> +}
>> +
>> +static const struct of_device_id loongson_edac_of_match[] = {
>> +	{ .compatible = "loongson,ls3a5000-mc-edac", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
>> +
>> +static struct platform_driver loongson_edac_driver = {
>> +	.probe		= loongson_edac_probe,
>> +	.remove		= loongson_edac_remove,
>> +	.driver		= {
>> +		.name	= "ls-mc-edac",
>> +		.of_match_table = loongson_edac_of_match,
>> +	},
>> +};
>> +
>> +module_platform_driver(loongson_edac_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Zhao Qunqin <zhaoqunqin@loongson.cn>\n");
> Drop \n.
I will drop it in next version patch.
>> +MODULE_DESCRIPTION("EDAC driver for loongson memory controller");
>> -- 
>> 2.43.0
>>
Best regards,

Zhao Qunqin.


