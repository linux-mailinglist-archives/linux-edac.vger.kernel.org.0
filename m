Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C952ECE7C
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 12:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbhAGLQQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 06:16:16 -0500
Received: from foss.arm.com ([217.140.110.172]:58016 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbhAGLQP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Jan 2021 06:16:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C091FB;
        Thu,  7 Jan 2021 03:15:30 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.34.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACF913F719;
        Thu,  7 Jan 2021 03:15:27 -0800 (PST)
Date:   Thu, 7 Jan 2021 11:15:20 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>, kernel@pengutronix.de,
        Borislav Petkov <bp@alien8.de>, York Sun <york.sun@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20210107111520.GA7523@C02TD0UTHF1T.local>
References: <20210107103819.13552-1-s.hauer@pengutronix.de>
 <20210107103819.13552-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107103819.13552-2-s.hauer@pengutronix.de>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sascha,

On Thu, Jan 07, 2021 at 11:38:19AM +0100, Sascha Hauer wrote:
> The Cortex A53 and A57 cores have error detection capabilities for the
> L1/L2 Caches, this patch adds a driver for them.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version of this driver
> found here: https://lkml.org/lkml/2018/3/14/1203. For reasons stated
> in this thread the error injection code is not suitable for mainline,
> so it is removed from the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/edac/Kconfig              |   6 +
>  drivers/edac/Makefile             |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c | 218 ++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c

[...]

> +#define SYS_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> +#define SYS_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)

Just to note -- these registers are IMPLEMENTATION DEFINED, and so may
be trapped by a hypervisor or messed around with arbitrarily by FW.

> +static void read_errors(void *data)
> +{
> +	struct merrsr *merrsr = data;
> +
> +	merrsr->cpumerr = read_sysreg_s(SYS_CPUMERRSR_EL1);
> +	write_sysreg_s(0, SYS_CPUMERRSR_EL1);
> +	merrsr->l2merr = read_sysreg_s(SYS_L2MERRSR_EL1);
> +	write_sysreg_s(0, SYS_L2MERRSR_EL1);
> +}

... and so here the MRS instructions may behave as UNDEFINED in some
cases. Foer example, KVM would trap these via HCR_EL2.TIDCP, and emulate
these as UNDEFINED.

> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a53" },
> +	{ .compatible = "arm,cortex-a57" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);

... and so it's not safe to probe this based on the CPU compatible
string alone. If we really need to support this, it will need its own
binding (to describe that the reigsters are safe to access and behave in
a useful way).

Thanks,
Mark.
