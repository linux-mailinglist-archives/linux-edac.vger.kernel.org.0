Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B7516EE63
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2020 19:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBYSwT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 13:52:19 -0500
Received: from mail.skyhub.de ([5.9.137.197]:57236 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgBYSwT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 13:52:19 -0500
Received: from zn.tnic (p200300EC2F07AB0030A629139D299034.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:ab00:30a6:2913:9d29:9034])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8E531EC0CD9;
        Tue, 25 Feb 2020 19:52:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582656736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n9C2V9/aZydusth37WA93xbi/LRpYRsdtulxt8mmBXE=;
        b=jQVflpTeQVE1EW0E5VwWqhbAvMZA+BkF85lmJe2f1oscptj/qaVXlci7mOTyFmGvwwvYcL
        X/NJGlj6bgj1ZQ1+eiV0fOMb0JQdDSK4DHC2Tvt7anmf9mshTzPmzEM33vffPd6xDhZfk4
        YaZ9oVnGlbk0a/dxhJOTqgdprrtEoH0=
Date:   Tue, 25 Feb 2020 19:52:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rrichter@marvell.com, robh+dt@kernel.org, frowand.list@gmail.com,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, barakw@amazon.com
Subject: Re: [PATCH v9 1/3] edac: Add support for Amazon's Annapurna Labs L1
 EDAC
Message-ID: <20200225185211.GB5457@zn.tnic>
References: <20200129195016.956-1-hhhawa@amazon.com>
 <20200129195016.956-2-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200129195016.956-2-hhhawa@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 29, 2020 at 09:50:14PM +0200, Hanna Hawa wrote:

> Adds support for Amazon's Annapurna Labs L1 EDAC driver to detect and
> report L1 errors.

You don't add support for a driver - you either add a driver or you add
support for HW...

> diff --git a/drivers/edac/al_l1_edac.c b/drivers/edac/al_l1_edac.c
> new file mode 100644
> index 000000000000..723b35b18f5b
> --- /dev/null
> +++ b/drivers/edac/al_l1_edac.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +
> +#include <asm/sysreg.h>
> +#include <linux/bitfield.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>

asm/ includes go after linux/ includes.

> +
> +#include "edac_device.h"
> +#include "edac_module.h"
> +
> +#define DRV_NAME				"al_l1_edac"
> +
> +/* Same bit assignments of CPUMERRSR_EL1 in ARM CA57/CA72 */
> +#define ARM_CA57_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> +#define ARM_CA57_CPUMERRSR_RAM_ID		GENMASK(30, 24)
> +#define  ARM_CA57_L1_I_TAG_RAM			0x00
> +#define  ARM_CA57_L1_I_DATA_RAM			0x01
> +#define  ARM_CA57_L1_D_TAG_RAM			0x08
> +#define  ARM_CA57_L1_D_DATA_RAM			0x09
> +#define  ARM_CA57_L2_TLB_RAM			0x18
> +#define ARM_CA57_CPUMERRSR_VALID		BIT(31)
> +#define ARM_CA57_CPUMERRSR_REPEAT		GENMASK_ULL(39, 32)
> +#define ARM_CA57_CPUMERRSR_OTHER		GENMASK_ULL(47, 40)
> +#define ARM_CA57_CPUMERRSR_FATAL		BIT_ULL(63)
> +
> +#define AL_L1_EDAC_MSG_MAX			256
> +
> +static void al_l1_edac_cpumerrsr_read_status(void *arg)

This is a static function so you don't really need a function prefix of
"al_l1_edac_". Use those chars to make its name more descriptive. Ditto
for the rest of the static functions in that file.

> +{
> +	struct edac_device_ctl_info *edac_dev = arg;
> +	int cpu, space, count;
> +	u32 ramid, repeat, other, fatal;
> +	u64 val;
> +	char msg[AL_L1_EDAC_MSG_MAX];
> +	char *p;
> +	spinlock_t *lock;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	val = read_sysreg_s(ARM_CA57_CPUMERRSR_EL1);
> +	if (!(FIELD_GET(ARM_CA57_CPUMERRSR_VALID, val)))
> +		return;
> +
> +	write_sysreg_s(0, ARM_CA57_CPUMERRSR_EL1);
> +
> +	cpu = smp_processor_id();
> +	ramid = FIELD_GET(ARM_CA57_CPUMERRSR_RAM_ID, val);
> +	repeat = FIELD_GET(ARM_CA57_CPUMERRSR_REPEAT, val);
> +	other = FIELD_GET(ARM_CA57_CPUMERRSR_OTHER, val);
> +	fatal = FIELD_GET(ARM_CA57_CPUMERRSR_FATAL, val);
> +
> +	space = sizeof(msg);
> +	p = msg;
> +	count = scnprintf(p, space, "CPU%d L1 %serror detected", cpu,
> +			  (fatal) ? "Fatal " : "");
> +	p += count;
> +	space -= count;
> +
> +	switch (ramid) {
> +	case ARM_CA57_L1_I_TAG_RAM:
> +		count = scnprintf(p, space, " RAMID='L1-I Tag RAM'");
> +		break;
> +	case ARM_CA57_L1_I_DATA_RAM:
> +		count = scnprintf(p, space, " RAMID='L1-I Data RAM'");
> +		break;
> +	case ARM_CA57_L1_D_TAG_RAM:
> +		count = scnprintf(p, space, " RAMID='L1-D Tag RAM'");
> +		break;
> +	case ARM_CA57_L1_D_DATA_RAM:
> +		count = scnprintf(p, space, " RAMID='L1-D Data RAM'");
> +		break;
> +	case ARM_CA57_L2_TLB_RAM:
> +		count = scnprintf(p, space, " RAMID='L2 TLB RAM'");
> +		break;
> +	default:
> +		count = scnprintf(p, space, " RAMID='unknown'");
> +		break;
> +	}
> +
> +	p += count;
> +	space -= count;
> +	count = scnprintf(p, space,
> +			  " repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)",
> +			  repeat, other, val);
> +
> +	lock = edac_dev->pvt_info;

That sure looks funky - why not use a proper private struct like the
rest of the drivers?

> +	spin_lock(lock);
> +	if (fatal)
> +		edac_device_handle_ue_count(edac_dev, repeat, 0, 0, msg);
> +	else
> +		edac_device_handle_ce_count(edac_dev, repeat, 0, 0, msg);
> +	spin_unlock(lock);
> +}
> +
> +static void al_l1_edac_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	on_each_cpu(al_l1_edac_cpumerrsr_read_status, edac_dev, 1);
> +}
> +
> +static int al_l1_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev;
> +	struct device *dev = &pdev->dev;
> +	spinlock_t *lock;
> +	int ret;
> +
> +	edac_dev = edac_device_alloc_ctl_info(sizeof(*lock), DRV_NAME, 1, "L",
> +					      1, 1, NULL, 0,
> +					      edac_device_alloc_index());
> +	if (!edac_dev)
> +		return -ENOMEM;
> +
> +	edac_dev->edac_check = al_l1_edac_check;
> +	edac_dev->dev = dev;
> +	edac_dev->mod_name = DRV_NAME;
> +	edac_dev->dev_name = dev_name(dev);
> +	edac_dev->ctl_name = "L1_cache";
> +	platform_set_drvdata(pdev, edac_dev);
> +	lock = edac_dev->pvt_info;
> +
> +	spin_lock_init(lock);
> +
> +	ret = edac_device_add_device(edac_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add L1 edac device (%d)\n", ret);
> +		edac_device_free_ctl_info(edac_dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int al_l1_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
> +
> +	edac_device_del_device(edac_dev->dev);
> +	edac_device_free_ctl_info(edac_dev);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id al_l1_edac_of_match[] = {
> +	/*
> +	 * "al,alpine-v2", and "amazon,al-alpine-v3" are machine compatible
> +	 * strings which have Cortex-A57/A72 configured with this support,
> +	 * and access to CPUMERRSR_EL1 register is enabled in firmware.
> +	 */
> +	{ .compatible = "al,alpine-v2" },

Err, checkpatch says:

WARNING: DT compatible string "al,alpine-v2" appears un-documented -- check ./Documentation/devicetree/bindings/
#236: FILE: drivers/edac/al_l1_edac.c:151:
+       { .compatible = "al,alpine-v2" },


Do you need a devicetree addition? I usually get such with the ARM EDAC
drivers...

> +	{ .compatible = "amazon,al-alpine-v3" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, al_l1_edac_of_match);
> +
> +static struct platform_driver al_l1_edac_driver = {
> +	.probe = al_l1_edac_probe,
> +	.remove = al_l1_edac_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +	},
> +};
> +
> +static struct platform_device *edac_l1_device;

Please move to the top of the file.

> +
> +static int __init al_l1_init(void)
> +{
> +	struct device_node *root;
> +	int ret;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root) {
> +		pr_debug("Can't find root node!\n");
> +		return 0;
> +	}
> +
> +	if (!of_match_node(al_l1_edac_of_match, root))
> +		return 0;
> +
> +	ret = platform_driver_register(&al_l1_edac_driver);
> +	if (ret) {
> +		pr_err("Failed to register %s (%d)\n", DRV_NAME, ret);
> +		return ret;
> +	}
> +
> +	edac_l1_device = platform_device_register_simple(DRV_NAME, -1, NULL, 0);
> +	if (IS_ERR(edac_l1_device)) {
> +		pr_err("Failed to register EDAC AL L1 platform device\n");

		platform_driver_unregister() ?

> +		return PTR_ERR(edac_l1_device);
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit al_l1_exit(void)
> +{
> +	platform_device_unregister(edac_l1_device);
> +	platform_driver_unregister(&al_l1_edac_driver);
> +}
> +
> +late_initcall(al_l1_init);

Why not module_init() ?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
