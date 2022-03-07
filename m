Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA4A4D001A
	for <lists+linux-edac@lfdr.de>; Mon,  7 Mar 2022 14:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiCGNcT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 7 Mar 2022 08:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242881AbiCGNcS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 7 Mar 2022 08:32:18 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E68A6DC;
        Mon,  7 Mar 2022 05:31:24 -0800 (PST)
Received: from nazgul.tnic (nat0.nue.suse.com [IPv6:2001:67c:2178:4000::1111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 014F71EC0537;
        Mon,  7 Mar 2022 14:31:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646659879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GpGI0D4rD+Njmm+Q0184SgW1CbMNN6ew2JNcrhmR7Qo=;
        b=cYMMGvCr2WaSqdw9nHWCfXg02fvlat1g6Cw1dlTHtTS6pvmi3qgNblwGhUKTg1BG1WacfG
        hKx88JPixa97PIS0C5q17k5IfTC0sue0nsvvOZIAO8s3zchJqEENNoOslj5WDbIkGJIHed
        1Ui9fDiX/uFv7wOB9lUAUPl7BnJbUfM=
Date:   Mon, 7 Mar 2022 14:31:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 2/2] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <YiYJGKGmgUx9gAXv@nazgul.tnic>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <Yg6Hst4Ocg7UNNG9@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg6Hst4Ocg7UNNG9@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 17, 2022 at 09:36:50AM -0800, Luck, Tony wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4f9abb66520d..1f3e7c074182 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -714,6 +714,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		barrier();
>  		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
>  
> +		mce_intel_storm_tracker(i, m.status);

Why is this called before the VALID bit check?

Because you want to still run the tracker on each polling - not only
when it sees a valid error?

> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index cee9d989f791..2ed5634ec277 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -47,8 +47,48 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
>   */
>  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>  
> +/*
> + * CMCI storm tracking state
> + */

Those could use some comments explaining what is tracking what:

> +static DEFINE_PER_CPU(int, stormy_bank_count);
> +static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
> +static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);

AFAICT, this says whether a bank is in storm mode?

> +static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);

This looks like it collects the jiffies when the bank was looked at in
the storm tracker.

> +static int cmci_threshold[MAX_NR_BANKS];
> +
>  #define CMCI_THRESHOLD		1
>  
> +/*
> + * High threshold to limit CMCI rate during storms. Max supported is
> + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> + * signature when some asks "Why am I not seeing all corrected errors?"
> + */
> +#define CMCI_STORM_THRESHOLD	0x7FED

Why is a "threshold" in hex?

> +
> +/*
> + * How many errors within the history buffer mark the start of a storm
> + */
> +#define STORM_BEGIN	5

That looks like a STORM_BEGIN_THRESHOLD to me.

> +
> +/*
> + * How many polls of machine check bank without an error before declaring
> + * the storm is over
> + */
> +#define STORM_END	30

Similarly:

STORM_END_POLL_THRESHOLD

> +
> +/*
> + * If there is no poll data for a bank for this amount of time, just
> + * discard the history.
> + */
> +#define STORM_INTERVAL (1 * HZ)

That looks unused.

> +static void cmci_storm_begin(int bank)
> +{
> +	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	this_cpu_write(bank_storm[bank], true);
> +	if (this_cpu_inc_return(stormy_bank_count) == 1)

s/ == 1//

> +		mce_timer_kick(true);
> +}
> +
> +static void cmci_storm_end(int bank)
> +{
> +	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	this_cpu_write(bank_history[bank], 0ull);
> +	this_cpu_write(bank_storm[bank], false);
> +	if (this_cpu_dec_return(stormy_bank_count) == 0)

	if (!...

> +		mce_timer_kick(false);
> +}
> +
> +void mce_intel_storm_tracker(int bank, u64 status)

Function name needs a verb.

> +{
> +	unsigned long now = jiffies, delta;
> +	unsigned int shift;
> +	u64 history;
> +
> +	delta = now - this_cpu_read(bank_time_stamp[bank]);
> +	shift = this_cpu_read(bank_storm[bank]) ? 1 : (delta + HZBITS) / HZBITS;

Do

	shift = 1;

on function entry to simplify this assignment.

Also, I'm having trouble with this shift calculation. The laptop here has
HZ=250. Let's say delta is 2000 jiffies.

So if this bank wasn't in storm mode, I'd have

shift = (2000 + (250 / 64)) / (250 / 64) = 513

...

Aaaha, so only when the diff is < 250 in my case, i.e., it polls the
same bank within a second, only then it would shift the history. I.e.,
what you mean with that "The 64 bit width corresponds to about one
second."

> +	history = (shift < 64) ? this_cpu_read(bank_history[bank]) << shift : 0;
> +	this_cpu_write(bank_time_stamp[bank], now);
> +
> +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
> +		history |= 1;
> +	this_cpu_write(bank_history[bank], history);
> +
> +	if (this_cpu_read(bank_storm[bank])) {
> +		if (history & GENMASK_ULL(STORM_END - 1, 0))
> +			return;

Aha, under STORM_END polls you don't declare the storm as being over.

> +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> +		cmci_set_threshold(bank, cmci_threshold[bank]);
> +		cmci_storm_end(bank);
> +	} else {
> +		if (hweight64(history) < STORM_BEGIN)
> +			return;

Aha, so you need STORM_BEGIN errors within the last second to cause the
storm polling. Ok I guess.

So all in all I can't find anything eeewy in this - it would need to
have a lot more documentation, though, as this is not the most trivial
thing to stare at.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
