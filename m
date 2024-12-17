Return-Path: <linux-edac+bounces-2730-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F999F40B7
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 03:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D87441883084
	for <lists+linux-edac@lfdr.de>; Tue, 17 Dec 2024 02:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BD13BAD5;
	Tue, 17 Dec 2024 02:26:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7D12F375;
	Tue, 17 Dec 2024 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402372; cv=none; b=bVlPGlenrt0fGhNf4uPiFfVKglyEgm0D/9cvMi6/+cm0n9jfL0rGEfrl6NqIMBkzp9WhXIDT3J2KJ2+Z92fXGk8vybVeOzkKJVHC2rQAsU7V/WrVym7gNakPi5vFaoP3hqMueRdDKiTJQnRkDqrbAEzMeucBkTOzRy9I3zWEntY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402372; c=relaxed/simple;
	bh=kdDaiTNEfIt7Rl9g4y1oqqYwy61EJNOPtOr3m3Q2zPU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hXXWQNg8LG9lldwC1pEzITiCk0BkjsoVNiG0cdbH/YdDrcqy0Gq4whM4djWnbqzyhZP1nBJtAgtapbxtCR/l7JgrAW4Ra631ypwPWrvPyveVVoqzY535VmBTNXa5HO/tWZfL3dOXKGXPkAnYa9R3U+LrTsYgnk7ps9HRN8iz7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxquE_4WBn555XAA--.43626S3;
	Tue, 17 Dec 2024 10:26:07 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxL+E74WBnCeyFAA--.16426S2;
	Tue, 17 Dec 2024 10:26:05 +0800 (CST)
Subject: Re: [PATCH V10 RESEND] EDAC: Add EDAC driver for loongson memory
 controller
To: Borislav Petkov <bp@alien8.de>
Cc: chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@xen0n.name, tony.luck@intel.com,
 james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
 loongarch@lists.linux.dev, xry111@xry111.site, Markus.Elfring@web.de,
 Jonathan.Cameron@huawei.com, Huacai Chen <chenhuacai@loongson.cn>
References: <20241216013351.15432-1-zhaoqunqin@loongson.cn>
 <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <2d4e5bd0-34dc-d781-3bd6-9eb7be2c1b17@loongson.cn>
Date: Tue, 17 Dec 2024 10:25:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241216115546.GHZ2AVQi9u5lABWboE@fat_crate.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxL+E74WBnCeyFAA--.16426S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCFW8Wry8uw43Kw4UJw4rtFc_yoW5Kw1kpr
	98CanFkr4jqr17Gw40qryqvF15Zrs2yr9Iy39xJa4YkwnIyr1xW395ta12krnakrn8tr1f
	Za45Grn7u3WDKFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
	U==


在 2024/12/16 下午7:55, Borislav Petkov 写道:
> On Mon, Dec 16, 2024 at 09:33:51AM +0800, Zhao Qunqin wrote:
>> +LOONGSON EDAC DRIVER
>> +M:	Zhao Qunqin <zhaoqunqin@loongson.cn>
>> +L:	linux-edac@vger.kernel.org
>> +S:	Maintained
>> +F:	drivers/edac/loongson_edac.c
> If you add yourself as a maintainer, I'd expect you to review and/or ack
> patches for your driver so that I can pick them up.
OK. I can review the patches for this driver.
>
>> +config EDAC_LOONGSON
>> +	tristate "Loongson Memory Controller"
>> +	depends on (LOONGARCH && ACPI) || COMPILE_TEST
> The COMPILE_TEST thing would mean that you'll make sure this driver always
> builds on other arches and it doesn't break randconfig builds of people. If it
> happens too often and no one is fixing it, I'll remove the COMPILE_TEST.
There have indeed been build errors on other arches. So i will remove it.
>> +	help
>> +	  Support for error detection and correction on the Loongson
>> +	  family memory controller. This driver reports single bit
>> +	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
>> +	  are compatible.
>>   
>>   endif # EDAC
>> +static int read_ecc(struct mem_ctl_info *mci)
>> +{
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +	u64 ecc;
>> +	int cs;
>> +
>> +	if (!pvt->ecc_base)
> When can that even happen? You're initializing it properly in pvt_init().
Will remove this check.
>> +		return pvt->last_ce_count;
>> +
>> +	ecc = readq(pvt->ecc_base + ECC_CS_COUNT_REG);
>> +	/* cs0 -- cs3 */
>> +	cs = ecc & 0xff;
>> +	cs += (ecc >> 8) & 0xff;
>> +	cs += (ecc >> 16) & 0xff;
>> +	cs += (ecc >> 24) & 0xff;
>> +
>> +	return cs;
>> +}
>> +
>> +static void edac_check(struct mem_ctl_info *mci)
>> +{
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +	int new, add;
>> +
>> +	new = read_ecc(mci);
>> +	add = new - pvt->last_ce_count;
>> +	pvt->last_ce_count = new;
> That last_ce_count is just silly. Kill it.

Then  I  can't calculate the error count added since the last check,  cause

what record in Loongson's ECC register is  the error count  from reset of

the memory controller.

>> +	if (add <= 0)
>> +		return;
>> +
>> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
>> +			     0, 0, 0, 0, 0, -1, "error", "");
>> +	edac_mc_printk(mci, KERN_INFO, "add: %d", add);
> "add"? What are you adding? Error count?
>
> No need.
Will remove this printk.
>> +static int edac_probe(struct platform_device *pdev)
>> +{
>> +	struct edac_mc_layer layers[2];
>> +	struct mem_ctl_info *mci;
>> +	void __iomem *vbase;
>> +	int ret;
>> +
>> +	vbase = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(vbase))
>> +		return PTR_ERR(vbase);
>> +
>> +	/* allocate a new MC control structure */
>> +	layers[0].type = EDAC_MC_LAYER_CHANNEL;
>> +	layers[0].size = 1;
>> +	layers[0].is_virt_csrow = false;
>> +	layers[1].type = EDAC_MC_LAYER_SLOT;
>> +	layers[1].size = 1;
>> +	layers[1].is_virt_csrow = true;
>> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
>> +			    sizeof(struct loongson_edac_pvt));
>> +	if (mci == NULL)
>> +		return -ENOMEM;
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
> Remove that obvious comment.

OK

Thanks for taking the time to review.

Best regards

>


