Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E57A28CC57
	for <lists+linux-edac@lfdr.de>; Tue, 13 Oct 2020 13:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgJMLNw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Oct 2020 07:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgJMLNv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Oct 2020 07:13:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C93C0613D0
        for <linux-edac@vger.kernel.org>; Tue, 13 Oct 2020 04:13:51 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSIFY-00051D-H9; Tue, 13 Oct 2020 13:13:48 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kSIFW-0006XA-Gc; Tue, 13 Oct 2020 13:13:46 +0200
Date:   Tue, 13 Oct 2020 13:13:46 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53
 and A57
Message-ID: <20201013111346.GG11648@pengutronix.de>
References: <20200813075721.27981-1-s.hauer@pengutronix.de>
 <20200813075721.27981-2-s.hauer@pengutronix.de>
 <20200826084135.GA22390@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826084135.GA22390@zn.tnic>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:51:59 up 236 days, 18:22, 151 users,  load average: 0.09, 0.13,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

Sorry for the long delay, your mail was buried in my inbox.

On Wed, Aug 26, 2020 at 10:41:35AM +0200, Borislav Petkov wrote:
> On Thu, Aug 13, 2020 at 09:57:20AM +0200, Sascha Hauer wrote:
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
> >  .../bindings/edac/arm,cortex-a5x-edac.yaml    |  32 +++
> >  drivers/edac/Kconfig                          |   6 +
> >  drivers/edac/Makefile                         |   1 +
> >  drivers/edac/cortex_arm64_l1_l2.c             | 208 ++++++++++++++++++
> >  4 files changed, 247 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/edac/arm,cortex-a5x-edac.yaml
> >  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
> 
> Just nitpicks below. James'd need to look at this too before it goes
> anywhere.
> 
> Checkpatch is trying to tell me something here:
> 
> WARNING: DT compatible string "arm,cortex-a53-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
> #296: FILE: drivers/edac/cortex_arm64_l1_l2.c:190:
> +       { .compatible = "arm,cortex-a53-edac" },
> 
> WARNING: DT compatible string "arm,cortex-a57-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
> #297: FILE: drivers/edac/cortex_arm64_l1_l2.c:191:
> +       { .compatible = "arm,cortex-a57-edac" },
> 
> for 2/2 too:
> 
> WARNING: DT compatible string "arm,cortex-a53-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
> #39: FILE: arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi:842:
> +               compatible = "arm,cortex-a53-edac";
> 
> WARNING: DT compatible string "arm,cortex-a57-edac" appears un-documented -- check ./Documentation/devicetree/bindings/
> #56: FILE: arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi:805:
> +               compatible = "arm,cortex-a57-edac";
> 
> 
> False positive or valid?

Have you run checkpatch on a tree with this patch applied? If not, then
yes, it's undocumented as the docs are added with this patch.

> 
> ...
> 
> > +static void read_errors(void *data)
> > +{
> > +	u64 cpumerr, l2merr;
> > +	int cpu = smp_processor_id();
> > +	char msg[MESSAGE_SIZE];
> > +	struct edac_device_ctl_info *edac_ctl = data;
> 
> Please sort function local variables declaration in a reverse christmas
> tree order:
> 
> 	<type A> longest_variable_name;
> 	<type B> shorter_var_name;
> 	<type C> even_shorter;
> 	<type D> i;

I never heard of such a requirement. How is the length defined? Is it
only the length of the variable name or is it the length of the name
including the type? Including the array braces [] or not? What if a
variable shall be initialized with the value of an earlier declared
variable, do I have to make up variable names with a suitable length in
that case?  What if shorter_var_name and even_shorter are of same type,
can I still write them in a single line? Finally, Is this documented
somewhere?

I hope that was a joke from you that I didn't understand.

> 
> Check your other functions too pls.
> 
> > +	/* cpumerrsr_el1 */
> > +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (cpumerr));
> > +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (0));
> > +
> > +	if (cpumerr & CPUMERRSR_EL1_VALID) {
> > +		const char *str;
> > +		int fatal = (cpumerr & CPUMERRSR_EL1_FATAL) != 0;
> 
> Don't need "!= 0" and fatal can be bool.

Ok.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
