Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42F76F58
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2019 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfGZQtg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Jul 2019 12:49:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387437AbfGZQtg (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 26 Jul 2019 12:49:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 003E3337;
        Fri, 26 Jul 2019 09:49:35 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E05B3F71F;
        Fri, 26 Jul 2019 09:49:32 -0700 (PDT)
Subject: Re: [PATCH v3 2/4] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        Jonathan.Cameron@huawei.com, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <1563197049-12679-1-git-send-email-hhhawa@amazon.com>
 <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a2dc6760-50e2-6e98-5b61-002836d92dd2@arm.com>
Date:   Fri, 26 Jul 2019 17:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1563197049-12679-3-git-send-email-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hanna,

On 15/07/2019 14:24, Hanna Hawa wrote:
> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
> report L1 errors.

> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
> new file mode 100644
> index 0000000..70510ea
> --- /dev/null
> +++ b/drivers/edac/al_l1_edac.c
> @@ -0,0 +1,156 @@

> +#include <linux/bitfield.h>

You need <linux/smp.h> for on-each_cpu().

> +#include "edac_device.h"
> +#include "edac_module.h"

You need <asm/sysreg.h> for the sys_reg() macro. The ARCH_ALPINE dependency doesn't stop
this from being built on 32bit arm, where this sys_reg() won't work/exist.

[...]

> +static void al_l1_edac_cpumerrsr(void *arg)
> +{
> +	struct edac_device_ctl_info *edac_dev = arg;
> +	int cpu, i;
> +	u32 ramid, repeat, other, fatal;
> +	u64 val = read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
> +	char msg[AL_L1_EDAC_MSG_MAX];
> +	int space, count;
> +	char *p;
> +	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
> +		return;
> +	space = sizeof(msg);
> +	p = msg;
> +	count = snprintf(p, space, "CPU%d L1 %serror detected", cpu,
> +			 (fatal) ? "Fatal " : "");
> +	p += count;
> +	space -= count;

snprintf() will return the number of characters it would have generated, even if that is
more than space. If this happen, space becomes negative, p points outside msg[] and msg[]
isn't NULL terminated...

It looks like you want scnprintf(), which returns the number of characters written to buf
instead. (I don't see how 256 characters would be printed by this code)


> +	switch (ramid) {
> +	case ARM_CA57_L1_I_TAG_RAM:
> +		count = snprintf(p, space, " RAMID='L1-I Tag RAM'");
> +		break;
> +	case ARM_CA57_L1_I_DATA_RAM:
> +		count = snprintf(p, space, " RAMID='L1-I Data RAM'");
> +		break;
> +	case ARM_CA57_L1_D_TAG_RAM:
> +		count = snprintf(p, space, " RAMID='L1-D Tag RAM'");
> +		break;
> +	case ARM_CA57_L1_D_DATA_RAM:
> +		count = snprintf(p, space, " RAMID='L1-D Data RAM'");
> +		break;
> +	case ARM_CA57_L2_TLB_RAM:
> +		count = snprintf(p, space, " RAMID='L2 TLB RAM'");
> +		break;
> +	default:
> +		count = snprintf(p, space, " RAMID='unknown'");
> +		break;
> +	}
> +
> +	p += count;
> +	space -= count;
> +	count = snprintf(p, space,
> +			 " repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)",
> +			 repeat, other, val);
> +
> +	for (i = 0; i < repeat; i++) {
> +		if (fatal)
> +			edac_device_handle_ue(edac_dev, 0, 0, msg);
> +		else
> +			edac_device_handle_ce(edac_dev, 0, 0, msg);
> +	}
> +
> +	write_sysreg_s(0, ARM_CA57_CPUMERRSR_EL1);

Writing 0 just after you've read the value would minimise the window where repeat could
have increased behind your back, or another error was counted as other, when it could have
been reported more accurately.


> +}


> +static int al_l1_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	edac_dev = edac_device_alloc_ctl_info(0, (char *)dev_name(dev), 1, "L",
> +					      1, 1, NULL, 0,
> +					      edac_device_alloc_index());
> +	if (IS_ERR(edac_dev))

edac_device_alloc_ctl_info() returns NULL, or dev_ctl, which comes from kzalloc(). I think
you need to check for NULL here, IS_ERR() only catches the -errno range. (there is an
IS_ERR_OR_NULL() if you really needed both)


> +		return -ENOMEM;


With the header-includes and edac_device_alloc_ctl_info() NULL check:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
