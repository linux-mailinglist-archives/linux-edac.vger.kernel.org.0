Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D92ECFF5
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 13:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbhAGMhT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 07:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbhAGMhS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 Jan 2021 07:37:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244C8C0612F4
        for <linux-edac@vger.kernel.org>; Thu,  7 Jan 2021 04:36:38 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kxUWq-0006uW-IH; Thu, 07 Jan 2021 13:36:36 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kxUWm-0001Qr-Dl; Thu, 07 Jan 2021 13:36:32 +0100
Date:   Thu, 7 Jan 2021 13:36:32 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>, kernel@pengutronix.de,
        Borislav Petkov <bp@alien8.de>, York Sun <york.sun@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20210107123632.GX19063@pengutronix.de>
References: <20210107103819.13552-1-s.hauer@pengutronix.de>
 <20210107103819.13552-2-s.hauer@pengutronix.de>
 <20210107111520.GA7523@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107111520.GA7523@C02TD0UTHF1T.local>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:26:06 up 36 days, 53 min, 73 users,  load average: 0.20, 0.09,
 0.08
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 07, 2021 at 11:15:20AM +0000, Mark Rutland wrote:
> Hi Sascha,
> 
> On Thu, Jan 07, 2021 at 11:38:19AM +0100, Sascha Hauer wrote:
> > The Cortex A53 and A57 cores have error detection capabilities for the
> > L1/L2 Caches, this patch adds a driver for them.
> > 
> > Unfortunately there is no robust way to inject errors into the caches,
> > so this driver doesn't contain any code to actually test it. It has
> > been tested though with code taken from an older version of this driver
> > found here: https://lkml.org/lkml/2018/3/14/1203. For reasons stated
> > in this thread the error injection code is not suitable for mainline,
> > so it is removed from the driver.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/edac/Kconfig              |   6 +
> >  drivers/edac/Makefile             |   1 +
> >  drivers/edac/cortex_arm64_l1_l2.c | 218 ++++++++++++++++++++++++++++++
> >  3 files changed, 225 insertions(+)
> >  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
> 
> [...]
> 
> > +#define SYS_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> > +#define SYS_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)
> 
> Just to note -- these registers are IMPLEMENTATION DEFINED, and so may
> be trapped by a hypervisor or messed around with arbitrarily by FW.
> 
> > +static void read_errors(void *data)
> > +{
> > +	struct merrsr *merrsr = data;
> > +
> > +	merrsr->cpumerr = read_sysreg_s(SYS_CPUMERRSR_EL1);
> > +	write_sysreg_s(0, SYS_CPUMERRSR_EL1);
> > +	merrsr->l2merr = read_sysreg_s(SYS_L2MERRSR_EL1);
> > +	write_sysreg_s(0, SYS_L2MERRSR_EL1);
> > +}
> 
> ... and so here the MRS instructions may behave as UNDEFINED in some
> cases. Foer example, KVM would trap these via HCR_EL2.TIDCP, and emulate
> these as UNDEFINED.
> 
> > +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> > +	{ .compatible = "arm,cortex-a53" },
> > +	{ .compatible = "arm,cortex-a57" },
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
> 
> ... and so it's not safe to probe this based on the CPU compatible
> string alone. If we really need to support this, it will need its own
> binding (to describe that the reigsters are safe to access and behave in
> a useful way).

Rob objected to adding dedicated nodes to attach the driver to. That
leaves adding a property like "edac-enabled" or similar to the CPU nodes
when edac is desired. Would that be ok?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
