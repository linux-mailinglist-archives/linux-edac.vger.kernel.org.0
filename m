Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825084D081D
	for <lists+linux-edac@lfdr.de>; Mon,  7 Mar 2022 21:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiCGUFg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Mar 2022 15:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbiCGUFf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Mar 2022 15:05:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C68710ED;
        Mon,  7 Mar 2022 12:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646683480; x=1678219480;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCspBBZZJuTW58iCt27emX56f2pFoXaQE2eIGa1lhbY=;
  b=BzZau6t6A6ZDGmGKx+TE1J9z8h7ibN01VrO1DJ37TDhJ/FImsOezgtPR
   hv7XdqQABXKW9sutAK+nWCHA6VePMRt3NdF3PXxshiQWlylWSy1te9Xl3
   ISFkjUrVBJL5uD6vsL9QEHEI/Jhoso59u/0DPpgBH+1o7dGO9Yz8HeOzS
   zsw148jjZB4RnrP9aiR7j07KzBYxWU1hUvHMuCMlTp1LIAWr5fYc81mAC
   vID4YKXtGIf8oEJJ0lKi7XoLOCq6vZZ2/QEg3MnoSckHPyTDMolhihxBV
   j/jauCk4V5SMURlSAyrD84w8Winfi5SnLMDtZoYSMm45LNNZCnOCNmjH4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="340925983"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="340925983"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:04:37 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="711239141"
Received: from agluck-desk3.sc.intel.com ([172.25.222.60])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:04:35 -0800
Date:   Mon, 7 Mar 2022 12:04:34 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 2/2] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <YiZlUgbYtd2DUTOQ@agluck-desk3.sc.intel.com>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <Yg6Hst4Ocg7UNNG9@agluck-desk3.sc.intel.com>
 <YiYJGKGmgUx9gAXv@nazgul.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYJGKGmgUx9gAXv@nazgul.tnic>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Mar 07, 2022 at 02:31:21PM +0100, Borislav Petkov wrote:

> So all in all I can't find anything eeewy in this - it would need to
> have a lot more documentation, though, as this is not the most trivial
> thing to stare at.

Thanks for the review. I'll see about re-naming things and adding comments
to make this easier to read.

> >  		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
> >  
> > +		mce_intel_storm_tracker(i, m.status);
> 
> Why is this called before the VALID bit check?
> 
> Because you want to still run the tracker on each polling - not only
> when it sees a valid error?

Yes. The tracker cares both about polls that find errors, and polls
that don't. Storm detection is triggered with some threshold of positive
scans, even if they are mixed in with some negative ones. End of storm
is determined by a number of consecutive negative polls.

> > diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> > index cee9d989f791..2ed5634ec277 100644
> > --- a/arch/x86/kernel/cpu/mce/intel.c
> > +++ b/arch/x86/kernel/cpu/mce/intel.c
> > @@ -47,8 +47,48 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
> >   */
> >  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
> >  
> > +/*
> > + * CMCI storm tracking state
> > + */
> 
> Those could use some comments explaining what is tracking what:
> 
> > +static DEFINE_PER_CPU(int, stormy_bank_count);

This one is a count of how many banks on this CPU are in storm mode.

> > +static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);

Bitmask history of the most recent 64 polls for each bank.

> > +static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
> 
> AFAICT, this says whether a bank is in storm mode?

Yes.

> > +static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);
> 
> This looks like it collects the jiffies when the bank was looked at in
> the storm tracker.

Yes.

> > +static int cmci_threshold[MAX_NR_BANKS];
> > +
> >  #define CMCI_THRESHOLD		1
> >  
> > +/*
> > + * High threshold to limit CMCI rate during storms. Max supported is
> > + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> > + * signature when some asks "Why am I not seeing all corrected errors?"
> > + */
> > +#define CMCI_STORM_THRESHOLD	0x7FED
> 
> Why is a "threshold" in hex?

For debugging ... I was using rdmsr tool to read the MCi_CTL2 machine
check bank MSRs. It could be defined in decimal.

> > +
> > +/*
> > + * How many errors within the history buffer mark the start of a storm
> > + */
> > +#define STORM_BEGIN	5
> 
> That looks like a STORM_BEGIN_THRESHOLD to me.

Yes.

> > +
> > +/*
> > + * How many polls of machine check bank without an error before declaring
> > + * the storm is over
> > + */
> > +#define STORM_END	30
> 
> Similarly:
> 
> STORM_END_POLL_THRESHOLD

Ditto yes.

> > +
> > +/*
> > + * If there is no poll data for a bank for this amount of time, just
> > + * discard the history.
> > + */
> > +#define STORM_INTERVAL (1 * HZ)
> 
> That looks unused.

It was at one point a replacement for CMCI_STORM_INTERVAL deleted
in patch 0001. But I must have dropped the place it was used. Will
delete.

> > +static void cmci_storm_begin(int bank)
> > +{
> > +	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> > +	this_cpu_write(bank_storm[bank], true);
> > +	if (this_cpu_inc_return(stormy_bank_count) == 1)
> 
> s/ == 1//

Not sure about this. The stormy_bank_count variable keeps
track of how many banks on this CPU are in storm mode. So
the transition from zero to one is significant. Need to start
polling. But for 1->2, 2->3 etc. nothing needs to happen. The
CPU is already polling.

> > +		mce_timer_kick(true);
> > +}
> > +
> > +static void cmci_storm_end(int bank)
> > +{
> > +	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> > +	this_cpu_write(bank_history[bank], 0ull);
> > +	this_cpu_write(bank_storm[bank], false);
> > +	if (this_cpu_dec_return(stormy_bank_count) == 0)
> 
> 	if (!...

OK.

> > +		mce_timer_kick(false);
> > +}
> > +
> > +void mce_intel_storm_tracker(int bank, u64 status)
> 
> Function name needs a verb.

How about: track_cmci_storm(int bank, u64 status) ?

> > +{
> > +	unsigned long now = jiffies, delta;
> > +	unsigned int shift;
> > +	u64 history;
> > +
> > +	delta = now - this_cpu_read(bank_time_stamp[bank]);
> > +	shift = this_cpu_read(bank_storm[bank]) ? 1 : (delta + HZBITS) / HZBITS;
> 
> Do
> 
> 	shift = 1;
> 
> on function entry to simplify this assignment.


Yes. That will be easier to read.

> Also, I'm having trouble with this shift calculation. The laptop here has
> HZ=250. Let's say delta is 2000 jiffies.
> 
> So if this bank wasn't in storm mode, I'd have
> 
> shift = (2000 + (250 / 64)) / (250 / 64) = 513
> 
> ...
> 
> Aaaha, so only when the diff is < 250 in my case, i.e., it polls the
> same bank within a second, only then it would shift the history. I.e.,
> what you mean with that "The 64 bit width corresponds to about one
> second."

Yes, you got it ... but I'll add a comment so code readers don't have
to redo that deduction every time.

> > +	history = (shift < 64) ? this_cpu_read(bank_history[bank]) << shift : 0;
> > +	this_cpu_write(bank_time_stamp[bank], now);
> > +
> > +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
> > +		history |= 1;
> > +	this_cpu_write(bank_history[bank], history);
> > +
> > +	if (this_cpu_read(bank_storm[bank])) {
> > +		if (history & GENMASK_ULL(STORM_END - 1, 0))
> > +			return;
> 
> Aha, under STORM_END polls you don't declare the storm as being over.
> 
> > +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> > +		cmci_set_threshold(bank, cmci_threshold[bank]);
> > +		cmci_storm_end(bank);
> > +	} else {
> > +		if (hweight64(history) < STORM_BEGIN)
> > +			return;
> 
> Aha, so you need STORM_BEGIN errors within the last second to cause the
> storm polling. Ok I guess.

Agreed. This needs comments to explain what is going on.

> So all in all I can't find anything eeewy in this - it would need to
> have a lot more documentation, though, as this is not the most trivial
> thing to stare at.

Thanks again for the review.

-Tony
