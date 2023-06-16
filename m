Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C297337FB
	for <lists+linux-edac@lfdr.de>; Fri, 16 Jun 2023 20:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjFPSPx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Jun 2023 14:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjFPSPx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Jun 2023 14:15:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63291359F;
        Fri, 16 Jun 2023 11:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686939351; x=1718475351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cI48v1ZuhHOhlpUOPrw4B4na1RnMU3QCPml2U1pns8c=;
  b=Engtz8DfOQqMpM1FPytyrmhbAGyZ85dKgwK+Kbn9Ju5mOvuegYx7XPZl
   Q0+Ynkfqpf+fMPQebQEDqxwODVRQdZHj0ryutc1ZYxxqfveqss9O03v6I
   qyTjQkJE9Mz6Xk3JvZkS+d6INbavtW0HHEAOrV9p7cc7p9618sKQ2dKJB
   dURAvtKDRumddxUfbLEH8IJ91TcHbXDdh80yVP7zN33LGHv24MIfxeybI
   L9vtcjG5v+x7bBxfknvWvSSvt70et/r95u9f97Rt+UqbPDQB+ttAfvazc
   gkAV+1GscNq8ruxMtLE6NmqsHywuL9zeBrgj4Fm9CGNeblwqVp6UVNm4e
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362693888"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="362693888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:15:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="742749860"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="742749860"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:15:48 -0700
Date:   Fri, 16 Jun 2023 11:15:46 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v5 2/5] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <ZIym0ql90nXH7u83@agluck-desk3>
References: <20230403210716.347773-1-tony.luck@intel.com>
 <20230411173841.70491-1-tony.luck@intel.com>
 <20230411173841.70491-3-tony.luck@intel.com>
 <20230613174553.GDZIirUaTo6Kd8gq4W@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613174553.GDZIirUaTo6Kd8gq4W@fat_crate.local>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jun 13, 2023 at 07:45:53PM +0200, Borislav Petkov wrote:
> On Tue, Apr 11, 2023 at 10:38:38AM -0700, Tony Luck wrote:
> > @@ -1587,6 +1589,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
> >  
> >  static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
> >  static DEFINE_PER_CPU(struct timer_list, mce_timer);
> > +static DEFINE_PER_CPU(bool, storm_poll_mode);
> 
> See comment below about putting all those storm-related vars in a struct.

Done. Looks much better without the forest ot this_cpu*() operators.  Thanks.

> Also, there's another bool - bank_storm - which looks like it does the
> same.

storm_poll_mode is a regular per-cpu variable that indicates a CPU is in
poll mode because one or more of the banks it owns has gone over the
storm threshold.

bank_storm - is a per-cpu per-bank indicator that a particular bank
on a particular CPU is in storm mode.

> 
> >  static void __start_timer(struct timer_list *t, unsigned long interval)
> >  {
> > @@ -1622,22 +1625,29 @@ static void mce_timer_fn(struct timer_list *t)
> >  	else
> >  		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
> >  
> > -	__this_cpu_write(mce_next_interval, iv);
> > -	__start_timer(t, iv);
> > +	if (__this_cpu_read(storm_poll_mode)) {
> > +		__start_timer(t, HZ);
> > +	} else {
> > +		__this_cpu_write(mce_next_interval, iv);
> > +		__start_timer(t, iv);
> > +	}
> >  }
> >  
> >  /*
> > - * Ensure that the timer is firing in @interval from now.
> > + * When a storm starts on any bank on this CPU, switch to polling
> > + * once per second. When the storm ends, revert to the default
> > + * polling interval.
> >   */
> > -void mce_timer_kick(unsigned long interval)
> > +void mce_timer_kick(bool storm)
> >  {
> >  	struct timer_list *t = this_cpu_ptr(&mce_timer);
> > -	unsigned long iv = __this_cpu_read(mce_next_interval);
> >  
> > -	__start_timer(t, interval);
> > +	__this_cpu_write(storm_poll_mode, storm);
> >  
> > -	if (interval < iv)
> > -		__this_cpu_write(mce_next_interval, interval);
> > +	if (storm)
> > +		__start_timer(t, HZ);
> > +	else
> > +		__this_cpu_write(mce_next_interval, check_interval * HZ);
> 
> This looks very familiar to what mce_timer_fn() above does. Add
> a helper.

Looking at the final versions of these functions with patches applied,
I'm not seeing the similarities.

> >  /* Must not be called in IRQ context where del_timer_sync() can deadlock */
> > diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> > index 052bf2708391..4106877de028 100644
> > --- a/arch/x86/kernel/cpu/mce/intel.c
> > +++ b/arch/x86/kernel/cpu/mce/intel.c
> > @@ -47,8 +47,40 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
> >   */
> >  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
> >  
> > +/*
> > + * CMCI storm tracking state
> > + *	stormy_bank_count: per-cpu count of MC banks in storm state
> > + *	bank_history: bitmask tracking of corrected errors seen in each bank
> 
> 	bank_storm: determines whether the bank is in storm mode

Good catch. Added.

> 
> > + *	bank_time_stamp: last time (in jiffies) that each bank was polled
> > + *	cmci_threshold: MCi_CTL2 threshold for each bank when there is no storm
> > + */
> > +static DEFINE_PER_CPU(int, stormy_bank_count);
> > +static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
> > +static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
> > +static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
> 
> All those are begging to be a
> 
> struct mca_storm_desc {
> 
> 	....
> 
> };
> 
> or so, so that they don't "dangle" randomly all over the place and one
> doesn't know what they belong to.
> 
> Every time you then do storm management, you get the percpu pointer and
> do
> 
> 	storm_desc->bank_history[bank] ...
> 	storm_desc->bank_count
> 	...
> 
> and so on.

Yup. Done.

> > +static int cmci_threshold[MAX_NR_BANKS];
> 
> Why do we have to save per-bank thresholds instead of writing a default
> non-storm value into all? Why are they each special?

Because we have an option to use thresholds set by BIOS.

> > +
> > +/* Linux non-storm CMCI threshold (may be overridden by BIOS */
> 
> Missing ")".

Fixed.

> >  #define CMCI_THRESHOLD		1
> >  
> > +/*
> > + * High threshold to limit CMCI rate during storms. Max supported is
> > + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> > + * signature when some asks "Why am I not seeing all corrected errors?"
> > + */
> > +#define CMCI_STORM_THRESHOLD	32749
> 
> Why if you can simply clear CMCI_EN and disable CMCI for this bank while
> the storm goes on?
>
> And reenable it when it subsides?

Because Intel reports both corrected and uncorrected errors in the same
bank and signals both with CMCI (that first "C" stands for "Corrected",
so this is now a misleading name). I want Linux to get notification of
uncorrected errors in a timely fashion, so CMCI has to stay enabled.

AMD doesn't have this problem, Smita's patch disables CMCI as you
suggest.

> 
> > +void track_cmci_storm(int bank, u64 status)
> 
> cmci_track_storm

Updated.

> > +{
> > +	unsigned long now = jiffies, delta;
> > +	unsigned int shift = 1;
> > +	u64 history;
> > +
> > +	/*
> > +	 * When a bank is in storm mode it is polled once per second and
> > +	 * the history mask will record about the last minute of poll results.
> > +	 * If it is not in storm mode, then the bank is only checked when
> > +	 * there is a CMCI interrupt. Check how long it has been since
> > +	 * this bank was last checked, and adjust the amount of "shift"
> > +	 * to apply to history.
> > +	 */
> > +	if (!this_cpu_read(bank_storm[bank])) {
> > +		delta = now - this_cpu_read(bank_time_stamp[bank]);
> > +		shift = (delta + HZ) / HZ;
> > +	}
> > +
> > +	/* If has been a long time since the last poll, clear history */
> > +	if (shift >= 64)
> > +		history = 0;
> > +	else
> > +		history = this_cpu_read(bank_history[bank]) << shift;
> 
> <---- newline here.

Added

> > +	this_cpu_write(bank_time_stamp[bank], now);
> > +
> > +	/* History keeps track of corrected errors. VAL=1 && UC=0 */
> > +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
> > +		history |= 1;
> 
> Ditto.

Ditto.

> > +	this_cpu_write(bank_history[bank], history);
> > +
> > +	if (this_cpu_read(bank_storm[bank])) {
> 
> You just read bank_storm and now you're reading it again. Just do
> a struct pls.
> 
> > +		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))
> 
> "- 1" because you start from 0? So define the STORM_END_POLL_THRESHOLD
> thing above as (30 - 1) and explain why.

Because the low bit in a bitmap is named 0. I want to check if any of
the low 30 bits are set, so I need a bitmask with bits {29..0}

> > +			return;
> 
> <---- newline here.

Added.

> > +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> > +		cmci_set_threshold(bank, cmci_threshold[bank]);
> > +		cmci_storm_end(bank);
> > +	} else {
> > +		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
> 
> How am I to understand this? Is that the "5 in this RFC code for ease of
> testing" thing from the commit message?

Yes. I've fixed up the commit message to remove the "ease of testing". 5
seems (to me) to be a reasonable value. But it's  #define so easy to
change if anyone has data to support a better choice.

> > +			return;
> 
> <---- newline here.

Added.

> > +		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> > +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> > +		cmci_storm_begin(bank);
> > +	}
> > +}
> > +
> >  /*
> >   * The interrupt handler. This is called on every event.
> >   * Just call the poller directly to log any events.
> > @@ -147,6 +266,9 @@ static void cmci_discover(int banks)
> >  			continue;
> >  		}
> >  
> > +		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)
> 
> This is silly: you have at least two per-cpu bools which record which
> banks are in storm mode. Why don't you query them?

This is the case where a CPU is taken offline while a storm is in
progress for one of its banks. So the bool would tell us the storm
was in progress if we knew which CPU was the previous owner of this
bank. But there's no way to know that. Which banks are shared by
which CPUs isn't enumerated anywhere. So the old CPU went offline
with a storm active, the new CPU picking up ownership of this bank
must carry on managing the storm.

> > +			goto storm;
> > +
> >  		if (!mca_cfg.bios_cmci_threshold) {
> >  			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
> >  			val |= CMCI_THRESHOLD;
> > @@ -159,7 +281,7 @@ static void cmci_discover(int banks)
> >  			bios_zero_thresh = 1;
> >  			val |= CMCI_THRESHOLD;
> >  		}
> > -
> > +storm:
> 
> That piece from here on wants to be a separate helper - that function is
> becoming huge and unwieldy, doing a bunch of things.

Agreed. I pulled out three helpers. The result looks (IMHO) far more
readable.
> 
> Thx.

Thanks for the detailed review. Will post new version later today.

-Tony
