Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 842C634F1B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFDRi4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 13:38:56 -0400
Received: from foss.arm.com ([217.140.101.70]:48806 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfFDRi4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 13:38:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E9BE80D;
        Tue,  4 Jun 2019 10:38:56 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84D033F5AF;
        Tue,  4 Jun 2019 10:38:54 -0700 (PDT)
Date:   Tue, 4 Jun 2019 18:38:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     thor.thayer@linux.intel.com, bp@alien8.de, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] EDAC/altera: Warm Reset option for Stratix10 peripheral
 DBE
Message-ID: <20190604173848.GA28613@e107155-lin>
References: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
 <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 04, 2019 at 06:23:15PM +0100, James Morse wrote:
> Hi Thor,
>
> (CC: +Mark, Lorenzo and Sudeep for PSCI.
> How should SYSTEM_RESET2 be used for a vendor-specific reset?
>

Initially it was indented to be used by passing command line argument
"reboot=w" or "reboot=warm" as specified in kernel document[1]

However it was enhanced and enabled specifically for panic by
Commit b287a25a7148 ("panic/reboot: allow specifying reboot_mode for panic only")

IIUC you can now pass "reboot=panic_warm" to just set reboot_mode to
WARM when there's a panic. SYSTEM_RESET2 gets called whenever reboot_mode
is set to WARM/SOFT

> The original patch is:
> lore.kernel.org/r/1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com
> )
>
> On 03/06/2019 21:37, thor.thayer@linux.intel.com wrote:
> > From: Thor Thayer <thor.thayer@linux.intel.com>
> >
> > The Stratix10 peripheral FIFO memories can recover from double
> > bit errors with a warm reset instead of a cold reset.
> > Add the option of a warm reset for peripheral (USB, Ethernet)
> > memories.
> >
> > CPU memories such as SDRAM and OCRAM require a cold reset for
> > DBEs.
> > Filter on whether the error is a SDRAM/OCRAM or a peripheral
> > FIFO memory to determine which reset to use when the warm
> > reset option is configured.
>
> ... so you want to make different SMC calls on each CPU after panic()?
>
>
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index 8816f74a22b4..179601f14b48 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -2036,6 +2036,19 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
> >  /* panic routine issues reboot on non-zero panic_timeout */
> >  extern int panic_timeout;
> >
> > +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
> > +/* EL3 SMC call to setup CPUs for warm reset */
> > +void panic_smp_self_stop(void)
> > +{
> > +	struct arm_smccc_res result;
> > +
> > +	__cpu_disable();
> > +	cpu_relax();
> > +	arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, S10_WARM_RESET_WFI_FLAG,
> > +		      S10_WARM_RESET_WFI_FLAG, 0, 0, 0, 0, 0, &result);

Please use SYSTEM_RESET2 or let us know why it can't be used to understand
the requirement better. There are options to use vendor extentions with
the SYSTEM_RESET2 PSCI command if you really have to. However the mainline
supports only architectural warm reset.

--
Regards,
Sudeep

[1] Documentation/admin-guide/kernel-parameters.txt
