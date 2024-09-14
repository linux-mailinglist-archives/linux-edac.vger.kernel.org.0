Return-Path: <linux-edac+bounces-1873-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16860978CBC
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 04:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331401C25530
	for <lists+linux-edac@lfdr.de>; Sat, 14 Sep 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBF3168DC;
	Sat, 14 Sep 2024 02:18:55 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4FC13D;
	Sat, 14 Sep 2024 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280335; cv=none; b=N7jBFW3tyYeBfVEoHYsOFBVN/aqmyEIu6AJ0bmYPZZzNiLos75CwY8j+Wn/oxo1XsqtKjEZbwJLZuw0eygNGTWw2s4nfk9/aHSBFuGRxsZgDco0G0vCWQ9phpaG5bywuPYV1Lt17ZOP5k9J7miibsHRd9Ql6dvrWgCRG0rJ/Rqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280335; c=relaxed/simple;
	bh=ZTEcpdbnmUfr1X64bF3TIuqOhdRmJceHg9z2xV2RnJU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mcnVvLjISWwa+NqnAqwXqZr8jWyAh65m/8j3Y/pyqVramlOyDqXw0M3W3gCxgbfvCRtvi8Ujg+SSTIV4PH71BfJ3qALkXuYeqfqCeQX85SL1f58NPCwOCLj2fLLj0S19f8Z174t7j9gx8S5YSKM2zpIXwwTc1M1uzRCGz2CqxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Ax6+mJ8uRm7pwHAA--.17457S3;
	Sat, 14 Sep 2024 10:18:49 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front2 (Coremail) with SMTP id qciowMBxOsaI8uRmhrYHAA--.34198S2;
	Sat, 14 Sep 2024 10:18:48 +0800 (CST)
Subject: Re: [PATCH v4 2/2] Loongarch: EDAC driver for loongson memory
 controller
To: Borislav Petkov <bp@alien8.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 chenhuacai@kernel.org, linux-edac@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@xen0n.name,
 tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
 rric@kernel.org, loongarch@lists.linux.dev
References: <20240909032124.18819-1-zhaoqunqin@loongson.cn>
 <20240909032124.18819-3-zhaoqunqin@loongson.cn>
 <20240913101137.GHZuQP2WzlkvJ5gG2F@fat_crate.local>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <2ca97c7c-2fd4-3ce5-9e8c-426c418ebcf5@loongson.cn>
Date: Sat, 14 Sep 2024 10:18:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240913101137.GHZuQP2WzlkvJ5gG2F@fat_crate.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qciowMBxOsaI8uRmhrYHAA--.34198S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF15GrW3ZrWxJryxtryruFX_yoWrWry8pF
	15C3WqyFs8tryUK34vvwn8ZF9avrZ3tF12yrW3t343Aa4qywn3ur9agF129r1kAr1jkr12
	va4UKrZ3uFn0kFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWU
	AwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcTKZDUUUU


在 2024/9/13 下午6:11, Borislav Petkov 写道:
> On Mon, Sep 09, 2024 at 11:21:24AM +0800, Zhao Qunqin wrote:
>> Subject: Re: [PATCH v4 2/2] Loongarch: EDAC driver for loongson memory controller
> 			EDAC/loongson: Add EDAC driver ...
>
>> Reports single bit errors (CE) only.
>>
>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>> ---
> ...
>
>> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
>> new file mode 100644
>> index 000000000..b89d6e0e7
>> --- /dev/null
>> +++ b/drivers/edac/loongson_edac.c
>> @@ -0,0 +1,182 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
>> + */
>> +
>> +#include <linux/edac.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "edac_module.h"
>> +
>> +enum ecc_index {
>> +	ECC_SET = 0,
>> +	ECC_RESERVED,
>> +	ECC_COUNT,
>> +	ECC_CS_COUNT,
>> +	ECC_CODE,
>> +	ECC_ADDR,
>> +	ECC_DATA0,
>> +	ECC_DATA1,
>> +	ECC_DATA2,
>> +	ECC_DATA3,
>> +};
>> +
>> +struct loongson_edac_pvt {
>> +	u64 *ecc_base;
>> +	int last_ce_count;
>> +};
>> +
>> +static void loongson_update_ce_count(struct mem_ctl_info *mci,
> Drop the loongson_ prefix from all static functions.
>
> Also, align function arguments on the opening brace.
>
>> +					int chan,
>> +					int new)
>> +{
>> +	int add;
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
> The EDAC tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
>
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
>
> The above is faster to parse than the reverse ordering::
>
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
>
> And even more so than random ordering::
>
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;
>
>> +
>> +	add = new - pvt->last_ce_count;
>> +
>> +	/* Store the new value */
> Drop all those obvious comments.
>
>> +	pvt->last_ce_count = new;
>> +
>> +	/* device resume or any other exceptions*/
> No clue what that means.

The CE value of the memory controller should only increase,

but it will return to its initial value when resuming from S3 or S4 
sleep state,

then the new ce count may be smaller than the last ce count.

>
> Also,  the check goes right under the assignment.
>
>> +	if (add < 0)
>> +		return;
>> +
>> +	/*updated the edac core */
> Useless comment.
>
>> +	if (add != 0) {
> 	if (!add)
> 		return;
>
> and now you can save yourself an indentation level:
>
> 	edac_mc_...(
>
>> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, add,
>> +					0, 0, 0,
>> +					chan, 0, -1, "error", "");
>> +		edac_mc_printk(mci, KERN_INFO, "add: %d", add);
>> +	}
>> +}
>> +
>> +static int loongson_read_ecc(struct mem_ctl_info *mci)
>> +{
>> +	u64 ecc;
>> +	int cs = 0;
>> +	struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +
>> +	if (!pvt->ecc_base)
>> +		return pvt->last_ce_count;
>> +
>> +	ecc = pvt->ecc_base[ECC_CS_COUNT];
>> +	cs += ecc & 0xff;		// cs0
>> +	cs += (ecc >> 8) & 0xff;	// cs1
>> +	cs += (ecc >> 16) & 0xff;	// cs2
>> +	cs += (ecc >> 24) & 0xff;	// cs3
> No side comments pls - put them over the line.
>
>> +
>> +	return cs;
>> +}
>> +
>> +static void loongson_edac_check(struct mem_ctl_info *mci)
>> +{
>> +	loongson_update_ce_count(mci, 0, loongson_read_ecc(mci));
> Drop this silly wrapper.
>
>> +}
>> +
>> +static int get_dimm_config(struct mem_ctl_info *mci)
>> +{
>> +	u32 size, npages;
>> +	struct dimm_info *dimm;
>> +
>> +	/* size not used */
>> +	size = -1;
>> +	npages = MiB_TO_PAGES(size);
>> +
>> +	dimm = edac_get_dimm(mci, 0, 0, 0);
>> +	dimm->nr_pages = npages;
>> +	snprintf(dimm->label, sizeof(dimm->label),
>> +			"MC#%uChannel#%u_DIMM#%u",
>> +			mci->mc_idx, 0, 0);
> Align arguments on the opening brace.
>
>> +	dimm->grain = 8;
>> +
>> +	return 0;
>> +}

Will address above comments. Thanks for taking the time to review.

Best regards,

Zhao Qunqin.

>
>


