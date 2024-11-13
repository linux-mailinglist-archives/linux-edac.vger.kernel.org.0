Return-Path: <linux-edac+bounces-2521-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73589C6A2A
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 08:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDEE2844E8
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 07:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C718595F;
	Wed, 13 Nov 2024 07:48:15 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D562217B425;
	Wed, 13 Nov 2024 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731484095; cv=none; b=rXwXlXO5krsaKS22FYIN1uEoxLr8+hrzSZsPXDxOKSCPTUMSez1BFbdO2FIGGhfLx85455d8rTW/BmfVJn+NwB/XcY0KV1agXpvgd6uyrUUUIWN9ImsWCPUgwmJJjk3yfsqjBWCtRp84Al7lvDEIsA3u9p3iIY2cuNsa0Iv4LAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731484095; c=relaxed/simple;
	bh=7Fw5eYBXt+T0n1p9UpFjgR3ZqLHr1zZO4vAZavIofDM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FNK9gY1X9YOolYcw1ccBmXvWV+87929exI5aw1bgfqOKPg1BTV+uX0OkwYzAKdqMsEtsmB5Hz69b/i1/9gNDc9PuNyNvHckcfKtTwtNW11I1ziHoHQmya84SULAhE222Lnloj4xRhLXBnYJ7yOsZF02c/G0ly9DdmpKED+rh25U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxQK22WTRnXZ48AA--.15233S3;
	Wed, 13 Nov 2024 15:48:06 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxecGxWTRnpb1TAA--.5587S2;
	Wed, 13 Nov 2024 15:48:02 +0800 (CST)
Subject: Re: [PATCH V8] EDAC: Add EDAC driver for loongson memory controller
To: Huacai Chen <chenhuacai@kernel.org>
Cc: kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com,
 james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, xry111@xry111.site, Markus.Elfring@web.de,
 krzk@kernel.org
References: <20241113032326.14267-1-zhaoqunqin@loongson.cn>
 <CAAhV-H6+c8sJySdz0QuXWQ_XzXjLZ1WTnN7CimBf-c7U-5JzUQ@mail.gmail.com>
From: Zhao Qunqin <zhaoqunqin@loongson.cn>
Message-ID: <e2a5d0e5-0c17-9475-452d-798838346ef1@loongson.cn>
Date: Wed, 13 Nov 2024 15:46:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H6+c8sJySdz0QuXWQ_XzXjLZ1WTnN7CimBf-c7U-5JzUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxecGxWTRnpb1TAA--.5587S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3WFyrXF1kZw1xAryUJw17XFc_yoW7Xr15pF
	4kCan3Cr1xtr43ArZavry7WF15X393KFy2gF47ta4q93srAry8ZFy0grW2vFWDZr48GrW0
	vFyrGw43CFs8GacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUU
	UUU


在 2024/11/13 下午12:14, Huacai Chen 写道:
> Hi, Qunqin
>
> On Wed, Nov 13, 2024 at 11:23 AM Zhao Qunqin <zhaoqunqin@loongson.cn> wrote:
>> Add ECC support for Loongson SoC DDR controller. This
>> driver reports single bit errors (CE) only.
>>
>> Only ACPI firmware is supported.
> Fair enough, if there is only ACPI firmware support EDAC, we don't
> need to bother FDT.
OK
>> Signed-off-by: Zhao Qunqin <zhaoqunqin@loongson.cn>
>> ---
>> Changes in v8:
>>          - Used readl() instead of readq()
>>          - Used acpi_device_id instead of of_device_id, then removed
>>            dt-bindings
>>
>> Changes in v7:
>>          - Fixed sparse's "incorrect type in assignment"
>>          - Cleaned up coding style
>>
>> Changes in v6:
>>          - Changed the Kconfig name to CONFIG_EDAC_LOONGSON
>>
>> Changes in v5:
>>          - Dropepd the loongson_ prefix from all static functions.
>>          - Aligned function arguments on the opening brace.
>>          - Dropepd useless comments and useless wrapper. Dropped side
>>            comments.
>>          - Reordered variable declarations.
>>
>> Changes in v4:
>>          - None
>>
>> Changes in v3:
>>          - Addressed review comments raised by Krzysztof and Huacai
>>
>> Changes in v2:
>>          - Addressed review comments raised by Krzysztof
>>
>>   MAINTAINERS                  |   6 ++
>>   arch/loongarch/Kconfig       |   1 +
>>   drivers/edac/Kconfig         |   8 ++
>>   drivers/edac/Makefile        |   1 +
>>   drivers/edac/loongson_edac.c | 155 +++++++++++++++++++++++++++++++++++
>>   5 files changed, 171 insertions(+)
>>   create mode 100644 drivers/edac/loongson_edac.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index e9659a5a7..b36a45051 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13397,6 +13397,12 @@ S:     Maintained
>>   F:     Documentation/devicetree/bindings/thermal/loongson,ls2k-thermal.yaml
>>   F:     drivers/thermal/loongson2_thermal.c
>>
>> +LOONGSON EDAC DRIVER
>> +M:     Zhao Qunqin <zhaoqunqin@loongson.cn>
>> +L:     linux-edac@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/edac/loongson_edac.c
>> +
>>   LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
>>   M:     Sathya Prakash <sathya.prakash@broadcom.com>
>>   M:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index bb35c34f8..10b9ba587 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -185,6 +185,7 @@ config LOONGARCH
>>          select PCI_MSI_ARCH_FALLBACKS
>>          select PCI_QUIRKS
>>          select PERF_USE_VMALLOC
>> +       select EDAC_SUPPORT
> Please use alpha-betical order, which means "select EDAC_SUPPORT"
> should be before "select EFI".
>
Will fix
>>          select RTC_LIB
>>          select SPARSE_IRQ
>>          select SYSCTL_ARCH_UNALIGN_ALLOW
>> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
>> index 81af6c344..4dce2b92a 100644
>> --- a/drivers/edac/Kconfig
>> +++ b/drivers/edac/Kconfig
>> @@ -564,5 +564,13 @@ config EDAC_VERSAL
>>            Support injecting both correctable and uncorrectable errors
>>            for debugging purposes.
>>
>> +config EDAC_LOONGSON
>> +       tristate "Loongson Memory Controller"
>> +       depends on (LOONGARCH && ACPI) || COMPILE_TEST
>> +       help
>> +         Support for error detection and correction on the Loongson
>> +         family memory controller. This driver reports single bit
>> +         errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
>> +         are compatible.
>>
>>   endif # EDAC
>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>> index faf310eec..f8bdbc895 100644
>> --- a/drivers/edac/Makefile
>> +++ b/drivers/edac/Makefile
>> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_DMC520)             += dmc520_edac.o
>>   obj-$(CONFIG_EDAC_NPCM)                        += npcm_edac.o
>>   obj-$(CONFIG_EDAC_ZYNQMP)              += zynqmp_edac.o
>>   obj-$(CONFIG_EDAC_VERSAL)              += versal_edac.o
>> +obj-$(CONFIG_EDAC_LOONGSON)            += loongson_edac.o
>> diff --git a/drivers/edac/loongson_edac.c b/drivers/edac/loongson_edac.c
>> new file mode 100644
>> index 000000000..340722db1
>> --- /dev/null
>> +++ b/drivers/edac/loongson_edac.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2024 Loongson Technology Corporation Limited.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/edac.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
> Use alpha-betical order too, which means exchange module.h and init.h.
Will fix
>> +#include <linux/platform_device.h>
>> +#include "edac_module.h"
>> +
>> +#define ECC_CS_COUNT_REG       0x18
>> +
>> +struct loongson_edac_pvt {
>> +       void __iomem *ecc_base;
>> +       int last_ce_count;
>> +};
>> +
>> +static int read_ecc(struct mem_ctl_info *mci)
>> +{
>> +       struct loongson_edac_pvt *pvt = mci->pvt_info;
>> +       u32 ecc;
>> +       int cs;
>> +
>> +       if (!pvt->ecc_base)
>> +               return pvt->last_ce_count;
>> +
>> +       ecc = readl(pvt->ecc_base + ECC_CS_COUNT_REG);
> If the register is actually 64bit, it is better to use readq, and add
> "depends on 64BIT" after config EDAC_LOONGSON.

It seems that including "<linux/io-64-nonatomic-lo-hi.h>" this  file and 
directly using reqdq()  is a better option.

Best regards


