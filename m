Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA8DF3606DA
	for <lists+linux-edac@lfdr.de>; Thu, 15 Apr 2021 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhDOKPh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Apr 2021 06:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhDOKPh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Apr 2021 06:15:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAC6C061574
        for <linux-edac@vger.kernel.org>; Thu, 15 Apr 2021 03:15:14 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lWz1k-00021v-J3; Thu, 15 Apr 2021 12:15:12 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1lWz1h-0004Ec-54; Thu, 15 Apr 2021 12:15:09 +0200
Date:   Thu, 15 Apr 2021 12:15:09 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20210415101509.GD19819@pengutronix.de>
References: <20210401110615.15326-1-s.hauer@pengutronix.de>
 <20210401110615.15326-2-s.hauer@pengutronix.de>
 <87czvdf1a7.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czvdf1a7.wl-maz@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:47:36 up 56 days, 13:11, 104 users,  load average: 0.38, 0.49,
 0.33
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Marc,

Thanks for the input.

On Fri, Apr 02, 2021 at 11:06:56AM +0100, Marc Zyngier wrote:
> > +config EDAC_CORTEX_ARM64_L1_L2
> > +	tristate "ARM Cortex A57/A53"
> > +	depends on ARM64
> > +	help
> > +	  Support for L1/L2 cache error detection on ARM Cortex A57 and A53.
> 
> I went through the TRMs for a few other Cortex-A cores, and this
> feature looks more common than this comment suggests. At least A35 and
> A72 implement something similar (if not strictly identical), probably
> owing to their ancestry.

Ok, I'll add these to the description.

> > +		}
> > +
> > +		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
> > +			 str, fatal ? "fatal" : "correctable", cpu);
> > +
> > +		if (fatal)
> > +			edac_device_handle_ue(edac_ctl, cpu, 0, msg);
> > +		else
> > +			edac_device_handle_ce(edac_ctl, cpu, 0, msg);
> > +	}
> > +
> > +	if (l2merr & L2MERRSR_EL1_VALID) {
> > +		bool fatal = l2merr & L2MERRSR_EL1_FATAL;
> > +
> > +		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d",
> > +			 fatal ? "fatal" : "correctable", cpu);
> 
> The shared nature of the L2 makes the CPU it has been detected on
> pretty much irrelevant. What you really want here is the CPUID+Way
> that is in the register data.

You are right. For the next round I added some more code to decode the
CPUID/Way field. What's still missing then is information which L2
cache has errors in case there is more than one. I wonder if we should
add get_cpu_cacheinfo(cpu)->id to the message or if there's more to it.

> 
> > +		if (fatal)
> > +			edac_device_handle_ue(edac_ctl, cpu, 1, msg);
> > +		else
> > +			edac_device_handle_ce(edac_ctl, cpu, 1, msg);
> > +	}
> > +}
> > +
> > +static void read_errors(void *data)
> > +{
> > +	struct merrsr *merrsr = data;
> > +
> > +	merrsr->cpumerr = read_sysreg_s(SYS_CPUMERRSR_EL1);
> > +	write_sysreg_s(0, SYS_CPUMERRSR_EL1);
> > +	merrsr->l2merr = read_sysreg_s(SYS_L2MERRSR_EL1);
> > +	write_sysreg_s(0, SYS_L2MERRSR_EL1);
> 
> If an error happens between read and write, you lose it. That's not
> great. You could improve things by only writing 0 if you have found an
> error. You probably also need an isb after the write if you want it to
> take effect in a timely manner.

Ok, will change.

> 
> I'm also not sure of how valuable it is to probe for L2 errors on each
> CPU, given that it is shared with up to 3 other cores. You probably
> want to use the cache topology information for this.

I have no idea how l2merr is implemented. When there is only one
register for all CPUs sharing the same L2 cache then it shouldn't
do any harm to read it more than once. The expensive part is
probably to schedule a function on all CPUs, and we have to do that
anyway to read the L1 cache errors.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
