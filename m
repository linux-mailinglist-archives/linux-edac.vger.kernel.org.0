Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A204572EA32
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjFMRqO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFMRqN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 13:46:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1EE6;
        Tue, 13 Jun 2023 10:46:12 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB05D1EC0501;
        Tue, 13 Jun 2023 19:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686678370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LWlHFe9nJlKqdUvnuqyzsMA1rnJcw+tnScqqI8D68Os=;
        b=S9IYp7r/EjBmBONAYEjmfIF2DIG9kX9uDgtsCK0F+hsZCba1IW5mnxvjtrlFWqekUwiDJV
        7pdw5ETe1hsq6km5kiD/ZQAGEzdSz+dOwZR4SXzovlPV7PBJj0FTC3rvHO3u5Q6V2JXkDM
        JLQDH95WPYHnhtdcZUga5zQObw8jZ98=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a_ZbYUs7shpD; Tue, 13 Jun 2023 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1686678366; bh=LWlHFe9nJlKqdUvnuqyzsMA1rnJcw+tnScqqI8D68Os=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NijJ/2E3rBi9qsK2j2nMzs74AT2r93nvVkLzHiHxhh4SfHxTDnME2anPvOuk5mQ2n
         UljsDOrpjWkFbi4FRKc9WnjRtt55YfZyryCTb+DG8Dr8Ht7dB7DyGGp9lE377Cb671
         feKQrdGfVBpefef9DlsTluO7BSX6oC4gMOHwTcBItM0FRZPGMkOX3vVsJi1agaVWfw
         hu7zr+RDEyKQaDhrKCc4ESyLUUhigWr+up4ft526rbndNcVQ5hKPSrNjEQq9fqBnrs
         4D5VRaO1+PtAQ7riegnE8160aRwcbFqmAcS5QJq92UrunyyuXankGhr9aPrCFWHbze
         I9oJywEKv1xpHoWPafcCBsC0QTKAem5hQditkaGEdbtdWZreB8WGgQ3Uwwt4+LG2b/
         pN1wYyno+nrj6URTT2n0eYdC/CqKu6V3MFC2PMyZWll4TMwmT4Yo3w19olWBlnjIJQ
         C1KsnBMRuM7XLZpB1BatLgFWOhRCJg3koZeqYsdeb+NvjUbf6povYU53u22FDO4e2b
         IJuYMpABArOa29jx+/DPqbG8s9/d+3R57oqQ+Ax8b9rCSdBJz5q6tL2Au3jsETqovC
         53Yum5BaW7IWXugMuMQzHRMelA4e99p1n6BY4kvUQG0ZwPBXAqrQm8VehPS8/zDovi
         yM031q2vIpye1Duauay6/7Es=
Received: from zn.tnic (p200300EA971Dc5F7329C23FFfEa6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971d:c5f7:329c:23ff:fea6:a903])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3835140E01D0;
        Tue, 13 Jun 2023 17:45:58 +0000 (UTC)
Date:   Tue, 13 Jun 2023 19:45:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v5 2/5] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20230613174553.GDZIirUaTo6Kd8gq4W@fat_crate.local>
References: <20230403210716.347773-1-tony.luck@intel.com>
 <20230411173841.70491-1-tony.luck@intel.com>
 <20230411173841.70491-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230411173841.70491-3-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Apr 11, 2023 at 10:38:38AM -0700, Tony Luck wrote:
> @@ -1587,6 +1589,7 @@ static unsigned long check_interval = INITIAL_CHECK_INTERVAL;
>  
>  static DEFINE_PER_CPU(unsigned long, mce_next_interval); /* in jiffies */
>  static DEFINE_PER_CPU(struct timer_list, mce_timer);
> +static DEFINE_PER_CPU(bool, storm_poll_mode);

See comment below about putting all those storm-related vars in a struct.

Also, there's another bool - bank_storm - which looks like it does the
same.

>  static void __start_timer(struct timer_list *t, unsigned long interval)
>  {
> @@ -1622,22 +1625,29 @@ static void mce_timer_fn(struct timer_list *t)
>  	else
>  		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
>  
> -	__this_cpu_write(mce_next_interval, iv);
> -	__start_timer(t, iv);
> +	if (__this_cpu_read(storm_poll_mode)) {
> +		__start_timer(t, HZ);
> +	} else {
> +		__this_cpu_write(mce_next_interval, iv);
> +		__start_timer(t, iv);
> +	}
>  }
>  
>  /*
> - * Ensure that the timer is firing in @interval from now.
> + * When a storm starts on any bank on this CPU, switch to polling
> + * once per second. When the storm ends, revert to the default
> + * polling interval.
>   */
> -void mce_timer_kick(unsigned long interval)
> +void mce_timer_kick(bool storm)
>  {
>  	struct timer_list *t = this_cpu_ptr(&mce_timer);
> -	unsigned long iv = __this_cpu_read(mce_next_interval);
>  
> -	__start_timer(t, interval);
> +	__this_cpu_write(storm_poll_mode, storm);
>  
> -	if (interval < iv)
> -		__this_cpu_write(mce_next_interval, interval);
> +	if (storm)
> +		__start_timer(t, HZ);
> +	else
> +		__this_cpu_write(mce_next_interval, check_interval * HZ);

This looks very familiar to what mce_timer_fn() above does. Add
a helper.

>  /* Must not be called in IRQ context where del_timer_sync() can deadlock */
> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index 052bf2708391..4106877de028 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -47,8 +47,40 @@ static DEFINE_PER_CPU(mce_banks_t, mce_banks_owned);
>   */
>  static DEFINE_RAW_SPINLOCK(cmci_discover_lock);
>  
> +/*
> + * CMCI storm tracking state
> + *	stormy_bank_count: per-cpu count of MC banks in storm state
> + *	bank_history: bitmask tracking of corrected errors seen in each bank

	bank_storm: determines whether the bank is in storm mode

> + *	bank_time_stamp: last time (in jiffies) that each bank was polled
> + *	cmci_threshold: MCi_CTL2 threshold for each bank when there is no storm
> + */
> +static DEFINE_PER_CPU(int, stormy_bank_count);
> +static DEFINE_PER_CPU(u64 [MAX_NR_BANKS], bank_history);
> +static DEFINE_PER_CPU(bool [MAX_NR_BANKS], bank_storm);
> +static DEFINE_PER_CPU(unsigned long [MAX_NR_BANKS], bank_time_stamp);

All those are begging to be a

struct mca_storm_desc {

	....

};

or so, so that they don't "dangle" randomly all over the place and one
doesn't know what they belong to.

Every time you then do storm management, you get the percpu pointer and
do

	storm_desc->bank_history[bank] ...
	storm_desc->bank_count
	...

and so on.

> +static int cmci_threshold[MAX_NR_BANKS];

Why do we have to save per-bank thresholds instead of writing a default
non-storm value into all? Why are they each special?

> +
> +/* Linux non-storm CMCI threshold (may be overridden by BIOS */

Missing ")".

>  #define CMCI_THRESHOLD		1
>  
> +/*
> + * High threshold to limit CMCI rate during storms. Max supported is
> + * 0x7FFF. Use this slightly smaller value so it has a distinctive
> + * signature when some asks "Why am I not seeing all corrected errors?"
> + */
> +#define CMCI_STORM_THRESHOLD	32749

Why if you can simply clear CMCI_EN and disable CMCI for this bank while
the storm goes on?

And reenable it when it subsides?

> +void track_cmci_storm(int bank, u64 status)

cmci_track_storm

> +{
> +	unsigned long now = jiffies, delta;
> +	unsigned int shift = 1;
> +	u64 history;
> +
> +	/*
> +	 * When a bank is in storm mode it is polled once per second and
> +	 * the history mask will record about the last minute of poll results.
> +	 * If it is not in storm mode, then the bank is only checked when
> +	 * there is a CMCI interrupt. Check how long it has been since
> +	 * this bank was last checked, and adjust the amount of "shift"
> +	 * to apply to history.
> +	 */
> +	if (!this_cpu_read(bank_storm[bank])) {
> +		delta = now - this_cpu_read(bank_time_stamp[bank]);
> +		shift = (delta + HZ) / HZ;
> +	}
> +
> +	/* If has been a long time since the last poll, clear history */
> +	if (shift >= 64)
> +		history = 0;
> +	else
> +		history = this_cpu_read(bank_history[bank]) << shift;

<---- newline here.

> +	this_cpu_write(bank_time_stamp[bank], now);
> +
> +	/* History keeps track of corrected errors. VAL=1 && UC=0 */
> +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)
> +		history |= 1;

Ditto.

> +	this_cpu_write(bank_history[bank], history);
> +
> +	if (this_cpu_read(bank_storm[bank])) {

You just read bank_storm and now you're reading it again. Just do
a struct pls.

> +		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD - 1, 0))

"- 1" because you start from 0? So define the STORM_END_POLL_THRESHOLD
thing above as (30 - 1) and explain why.

> +			return;

<---- newline here.

> +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> +		cmci_set_threshold(bank, cmci_threshold[bank]);
> +		cmci_storm_end(bank);
> +	} else {
> +		if (hweight64(history) < STORM_BEGIN_THRESHOLD)

How am I to understand this? Is that the "5 in this RFC code for ease of
testing" thing from the commit message?

> +			return;

<---- newline here.

> +		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> +		cmci_set_threshold(bank, CMCI_STORM_THRESHOLD);
> +		cmci_storm_begin(bank);
> +	}
> +}
> +
>  /*
>   * The interrupt handler. This is called on every event.
>   * Just call the poller directly to log any events.
> @@ -147,6 +266,9 @@ static void cmci_discover(int banks)
>  			continue;
>  		}
>  
> +		if ((val & MCI_CTL2_CMCI_THRESHOLD_MASK) == CMCI_STORM_THRESHOLD)

This is silly: you have at least two per-cpu bools which record which
banks are in storm mode. Why don't you query them?

> +			goto storm;
> +
>  		if (!mca_cfg.bios_cmci_threshold) {
>  			val &= ~MCI_CTL2_CMCI_THRESHOLD_MASK;
>  			val |= CMCI_THRESHOLD;
> @@ -159,7 +281,7 @@ static void cmci_discover(int banks)
>  			bios_zero_thresh = 1;
>  			val |= CMCI_THRESHOLD;
>  		}
> -
> +storm:

That piece from here on wants to be a separate helper - that function is
becoming huge and unwieldy, doing a bunch of things.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
