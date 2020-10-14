Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D9728E1DE
	for <lists+linux-edac@lfdr.de>; Wed, 14 Oct 2020 16:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388860AbgJNOEn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Oct 2020 10:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388859AbgJNOEn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 14 Oct 2020 10:04:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0EC061755
        for <linux-edac@vger.kernel.org>; Wed, 14 Oct 2020 07:04:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kShOI-0001Ik-Lb; Wed, 14 Oct 2020 16:04:30 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kShOH-0004SM-4F; Wed, 14 Oct 2020 16:04:29 +0200
Date:   Wed, 14 Oct 2020 16:04:29 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Add L1 and L2 error detection for A53 and A57
Message-ID: <20201014140429.GE13710@pengutronix.de>
References: <20201013125033.4749-1-s.hauer@pengutronix.de>
 <20201014132511.GA1517487@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014132511.GA1517487@bogus>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:54:31 up 237 days, 21:25, 150 users,  load average: 0.21, 0.34,
 0.32
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 14, 2020 at 08:25:11AM -0500, Rob Herring wrote:
> On Tue, Oct 13, 2020 at 02:50:30PM +0200, Sascha Hauer wrote:
> > This driver is based on an earlier version from York Sun which can
> > be found here: https://lkml.org/lkml/2018/3/14/1203.
> > 
> > At that time the conclusion was that this driver is not suitable for
> > mainline as it used IMPLEMENTATION DEFINED CPU registers and also
> > NXP specific SMC calls. All this was used for the error injection only,
> > for error reporting it is not needed.
> 
> Have you looked at Amazon's version:
> http://lore.kernel.org/r/20200510151310.17372-2-hhhawa@amazon.com

No, I was not aware of that driver. It's basically the same driver, but
limited to a single SoC. Looks like at least some things are better in
that driver, read_sysreg_s(ARM_CA57_L2MERRSR_EL1) reads better than my
open coded variant.

> 
> Which is an A57 EDAC driver. Looks like it never got upstream though, 
> but it's not clear why.
> 
> You'll note that it doesn't have a virtual DT node either.

Testing the SoC type in an initcall looks odd to me. Wouldn't a
dedicated node be preferred?

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
