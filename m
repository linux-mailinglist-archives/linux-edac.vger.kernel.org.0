Return-Path: <linux-edac+bounces-3951-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E9AABD388
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 11:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE7148A5BA5
	for <lists+linux-edac@lfdr.de>; Tue, 20 May 2025 09:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E65B267F73;
	Tue, 20 May 2025 09:35:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439B614F9FB;
	Tue, 20 May 2025 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733714; cv=none; b=gTzDxX7NDs9qM3fLc8etOYJHOG+1pWAonb7WdVp4SXtLShIp+1IWb2nJAJkM7dm0SlsyMrDEdn3mZgvPd6SI0SXvqKdpFd8LTCcgZgdQb1IxdTbin974P1APySp6uHiEHo2eTBw7qd/Pi+Dq74O/0HYmWDx+Vcc5VW6s0mZVsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733714; c=relaxed/simple;
	bh=gssOtqDrZ64agWfHP7AcIQ+UH4O/S9b4BiWUSZ1bCEg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2EWibzRCvgGTUnTq5G76NyQ/4hRI5yvHI9ufzqOwiAthSjMUbtEhCsSosDdLXW/TNqISjaV5pmIdUH9z2aLEuyTZ3eFOXui8WT77OC20Yc6C8e/cDk1cBecGe0tckFo+W6bRxV5k4LCfD1ns8hDeMawSuLk3GZKfEiQzUOOu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b1qBY0g2wz6GDB4;
	Tue, 20 May 2025 17:34:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EA10E1402FF;
	Tue, 20 May 2025 17:35:02 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 May
 2025 11:35:01 +0200
Date: Tue, 20 May 2025 10:35:00 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
CC: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, James Morse <james.morse@arm.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tyler Hicks
	<code@tyhicks.com>, Marc Zyngier <maz@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
Message-ID: <20250520103500.00003905@huawei.com>
In-Reply-To: <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
	<1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 17:06:11 -0700
Vijay Balakrishna <vijayb@linux.microsoft.com> wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The Cortex A72 cores have error detection capabilities for
> the L1/L2 Caches, this patch adds a driver for them. The selected errors
> to detect/report are by reading CPU/L2 memory error syndrome registers.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version [1] of this
> driver.  For reasons stated in thread [1], the error injection code is
> not suitable for mainline, so it is removed from the driver.
> 
> [1] https://lore.kernel.org/all/1521073067-24348-1-git-send-email-york.sun@nxp.com/#t
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Co-developed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Hi.

Some issues with release of device_nodes in the of parsing code.

Jonathan

> diff --git a/drivers/edac/edac_a72.c b/drivers/edac/edac_a72.c
> new file mode 100644
> index 000000000000..13acd7e7cef0
> --- /dev/null
> +++ b/drivers/edac/edac_a72.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A72 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * Based on Code from:
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + *
Trivial but this blank line adds nothing useful
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <asm/smp_plat.h>
> +

> +
> +static void cortex_arm64_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
> +
> +	edac_device_del_device(edac_ctl->dev);

Maybe worth thinking about about devm_ versions of the functions these
are undoing though not for this patch set.


> +	edac_device_free_ctl_info(edac_ctl);
> +}
> +
> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a72" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
> +
> +static struct platform_driver cortex_arm64_edac_driver = {
> +	.probe = cortex_arm64_edac_probe,
> +	.remove = cortex_arm64_edac_remove,
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +};
> +
> +static int __init cortex_arm64_edac_driver_init(void)
> +{
> +	struct device_node *np;
> +	int cpu;
> +	struct platform_device *pdev;
> +	int err;

Might as well have

	int err, cpu;

> +
> +	for_each_possible_cpu(cpu) {
> +		np = of_get_cpu_node(cpu, NULL);

		np = of_cpu_device_node_get(cpu);
is probably appropriate here.  See docs for of_get_cpu_node - that is
only meant for initial setup of the device_node to cpu logical
id mapping.  It uses an extra walk in the wrong direction.


> +
> +		if (!np) {
> +			pr_warn("failed to find device node for cpu %d\n", cpu);
> +			continue;
> +		}
> +		if (!of_match_node(cortex_arm64_edac_of_match, np))
> +			continue;

You are holding the reference to the node which should have been released.
If Borislav doesn't mind them in edac, use __free magic to handle this.
		struct device_node *np __free(device_node) = 
			of_cpu_device_node_get(cpu);

and don't manually release the node at all.  It will be released on scope
exit (so each iteration of the loop).  This is safe for !np test as well.

> +		if (!of_property_read_bool(np, "edac-enabled"))
> +			continue;
> +		cpumask_set_cpu(cpu, &compat_mask);
> +		of_node_put(np);
> +	}
> +
> +	if (cpumask_empty(&compat_mask))
> +		return 0;
> +
> +	err = platform_driver_register(&cortex_arm64_edac_driver);
> +	if (err)
> +		return err;
> +
> +	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register cortex arm64 edac device\n");
> +		platform_driver_unregister(&cortex_arm64_edac_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +

> +static void __exit cortex_arm64_edac_driver_exit(void)
> +{
> +		platform_driver_unregister(&cortex_arm64_edac_driver);

Looks like a bonus tab.

> +}
> +
> +module_init(cortex_arm64_edac_driver_init);
> +module_exit(cortex_arm64_edac_driver_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("Cortex A72 L1 and L2 cache EDAC driver");


