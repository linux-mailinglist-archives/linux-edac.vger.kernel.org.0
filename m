Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64C073B6E6
	for <lists+linux-edac@lfdr.de>; Fri, 23 Jun 2023 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFWMJ1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Jun 2023 08:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFWMJ0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Jun 2023 08:09:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375FC1724;
        Fri, 23 Jun 2023 05:09:24 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F5B11EC041E;
        Fri, 23 Jun 2023 14:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687522162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M/dFIGeObXNSK0+1Vrh8UN2vBkMfuX0DSniP7oF6zVc=;
        b=XtcQ9jj1rD6NHncvrJ+irOwTz/ZgbAvLGDyUpvlFEQiizWAoPdfaHG5lE+LS1DWZJXyp2r
        euaiWfItr5qx77dcps0kn2hELb+gxH48FilIsIcnLpELOYiKWcP6208FFENCy3UA+NO2Ha
        bUv1n/kc5ocL148c64ItZRBAXsWyG+0=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DFGmczbKggKd; Fri, 23 Jun 2023 12:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687522158; bh=M/dFIGeObXNSK0+1Vrh8UN2vBkMfuX0DSniP7oF6zVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdrTBOkliNkjURxqsJdzGgczP38MWSAa37VDidfRhAx66Fg8z9FcZX7Q8DcYH80XG
         bCRXJx2fjcMfvgCOPz1CiWUQAWTMW/QRzwnXYzHjB27O1xijwQopICr0lSiY5PNDAY
         Gi/aGj4H/VsvWMW7Y5jbKIvO9rjIoWN9iXs/VqEjmHmIV4RWZCo3v9gz3l98DJ/aHE
         iR48lFziRd9OiP0zzwlIX13chBZo+bnMMcaqPQDTrvO9xFG9w1EJ3QayA77+8weRD+
         XuiyC7y8amYRsLM0/YfSWJIM/rQK/u250MD8bcJXFkfS/DclcCNXMV+etzMt/KVMO9
         mszJCYABngkZBk2/6CxhXKY4lJvsbY/Qf3cEQrvc3EomPhUBVxch0ePCqHVCysoHwG
         VLO6vQIdsh/KUQ5V1VY/gLOVs//FyUV34atwcN4i4nSYGiLBMeejRyBuhFBMjP6pOX
         10zlTyEbH+9VDHxiXaz9aIkmV3CwXdixvW0n1Gd/Am/VF1ZtdklSZVEmavc9YrWbnf
         tEfLLdtj7b5BeKVcxu31HjdXXe0DJ3E5KA0rdW62raY8MO3/LWcef99d0xZMCwDAmx
         sfUBIFcN3LNs7R0nh0SgcV7RRfm9xAgdOflsJdZjxNrjfSK8ts9MbQdP09BocEAJrX
         YvTSRZ5zS/lGO8uyJMm0eLbY=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 411D940E01D0;
        Fri, 23 Jun 2023 12:09:10 +0000 (UTC)
Date:   Fri, 23 Jun 2023 14:09:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v6 2/4] x86/mce: Add per-bank CMCI storm mitigation
Message-ID: <20230623120904.GAZJWLYMP0XxIr5k7s@fat_crate.local>
References: <20230411173841.70491-1-tony.luck@intel.com>
 <20230616182744.17632-1-tony.luck@intel.com>
 <20230616182744.17632-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230616182744.17632-3-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 16, 2023 at 11:27:42AM -0700, Tony Luck wrote:
> -void mce_timer_kick(unsigned long interval);
> +void mce_timer_kick(bool storm);
> +void mce_handle_storm(int bank, bool on);
> +void cmci_storm_begin(int bank);
> +void cmci_storm_end(int bank);
> +
> +/**

Yeah, let's not add kernel-doc comments about structs in internal.h
which are no one's business outside of MCA.

> + * struct mca_storm_desc - CMCI storm tracking data
> + * @stormy_bank_count: count of MC banks in storm state
> + * @bank_history: bitmask tracking of corrected errors seen in each bank
> + * @bank_storm: determines whether the bank is in storm mode
> + * @bank_time_stamp: last time (in jiffies) that each bank was polled
> + */
> +struct mca_storm_desc {
> +	int		stormy_bank_count;
> +	u64		bank_history[MAX_NR_BANKS];
> +	bool		bank_storm[MAX_NR_BANKS];
> +	unsigned long	bank_time_stamp[MAX_NR_BANKS];
> +};
> +DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);

Would that make the members organization even better:

struct storm_bank {
	u64 history;
	u64 timestamp;
	bool storm;
};

struct mca_storm_desc {
	struct storm_bank banks[MAX_NR_BANKS];
	unsigned int	  bank_count;
};

?

From the previous mail:

> storm_poll_mode is a regular per-cpu variable that indicates a CPU is in
> poll mode because one or more of the banks it owns has gone over the
> storm threshold.

It is still a per-CPU var which can be part of the storm descriptor, no?

> bank_storm - is a per-cpu per-bank indicator that a particular bank
> on a particular CPU is in storm mode.

Ok, so the above can be extended to:

struct mca_storm_desc {
        struct storm_bank banks[MAX_NR_BANKS];
        unsigned int      bank_count;
	bool		  poll_mode;
};

?

> +/*
> + * How many polls of machine check bank without an error before declaring
> + * the storm is over
> + */
> +#define STORM_END_POLL_THRESHOLD	30

So what's stopping you from doing

/*
 * How many polls of machine check bank without an error before declaring
 * the storm is over. Since it is tracked in the struct
 * storm_bank.history member as a bitmask, the mask is 30 bits [0 ... 29]
 */
#define STORM_END_POLL_THRESHOLD	29

?

And you've also explained it in text too so that it is perfectly clear
what the intent is.

>  #ifdef CONFIG_ACPI_APEI
>  int apei_write_mce(struct mce *m);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index e7936be84204..cd9d9ea5bb0a 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -607,6 +607,83 @@ static struct notifier_block mce_default_nb = {
>  	.priority	= MCE_PRIO_LOWEST,
>  };
>  
> +DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
> +
> +void cmci_storm_begin(int bank)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	__set_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	storm->bank_storm[bank] = true;
> +
> +	/*
> +	 * If this is the first bank on this CPU to enter storm mode
> +	 * start polling
> +	 */
> +	if (++storm->stormy_bank_count == 1)

	if (++storm->stormy_bank_count)

> +		mce_timer_kick(true);
> +}
> +
> +void cmci_storm_end(int bank)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	storm->bank_history[bank] = 0ull;
> +	storm->bank_storm[bank] = false;
> +
> +	/* If no banks left in storm mode, stop polling */
> +	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
> +		mce_timer_kick(false);
> +}
> +
> +void track_cmci_storm(int bank, u64 status)

This is still not called cmci_track_storm() ;-\

And looking at the AMD side of things, there's a track_cmci_storm() in
amd_threshold_interrupt() which doesn't make any sense whatsoever.

Or at least this was my initial reaction because why would the AMD side
call a "CMCI" specific function. So they're prefixed with "cmci_" but
they don't really have anything to do with the Intel CMCI feature - it
is a storm handling code.

Which means, since those are used by both, the confusing "cmci" should
not be in the names.

And which also means, those should be static and private to mce/core.c.
But I'll see what functionality the rest of the patches need and how it
all should be split/exported properly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
