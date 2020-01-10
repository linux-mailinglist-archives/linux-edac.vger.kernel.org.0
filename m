Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4E136A39
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgAJJuO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jan 2020 04:50:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:33464 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgAJJuO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Jan 2020 04:50:14 -0500
Received: from zn.tnic (p200300EC2F0ACA0024F85FB92EE88C9E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:ca00:24f8:5fb9:2ee8:8c9e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B03FC1EC0CAD;
        Fri, 10 Jan 2020 10:50:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578649811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIT8Yx3kSe9Z9owbe2rOIZDAMgeLxHz7eh5yqOrcB8c=;
        b=qUUU0WfgA+wqfA4yZuR/kqZ2+GUNSzj06F1JaEfPdEfkhMx5cVJv/fsNKW9A2z1Z3/M+Vq
        C8E/7L2aeciYr41PhPYN0Fq44RdRUcTs6ssmFdJd5i9LEI9azk3zLu2Jbe9y+iSIBgrgfk
        Y4EL+MxBXyNBWYa++tVpZpdRuxFix90=
Date:   Fri, 10 Jan 2020 10:50:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 1/6] x86/mce: Take action on UCNA/Deferred errors again
Message-ID: <20200110095004.GD19453@zn.tnic>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-2-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103150722.20313-2-jschoenh@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 03, 2020 at 04:07:17PM +0100, Jan H. Schönherr wrote:
> Commit fa92c5869426 ("x86, mce: Support memory error recovery for both
> UCNA and Deferred error in machine_check_poll") added handling of UCNA
> and Deferred errors by adding them to the ring for SRAO errors.
> 
> Later, commit fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action
> Optional errors") switched storage from the SRAO ring to the unified
> pool that is still in use today. In order to only act on the intended
> errors, a filter for MCE_AO_SEVERITY is used -- effectively removing
> handling of UCNA/Deferred errors again.
> 
> Extend the severity filter to include UCNA/Deferred errors again.
> Also, generalize the naming of the notifier from SRAO to UC to capture
> the extended scope.
> 
> Note, that this change may cause a message like the following to appear,
> as the same address may be reported as SRAO and as UCNA:
> 
>  Memory failure: 0x5fe3284: already hardware poisoned
> 
> Technically, this is a return to previous behavior.
> 
> Fixes: fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>

Tony, ACK?

Also, do you want it in stable@ so that it gets backported?

> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 8994fe7751a4..16134ce587fd 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -156,10 +156,8 @@ void mce_log(struct mce *m)
>  }
>  EXPORT_SYMBOL_GPL(mce_log);
>  
> -static struct notifier_block mce_srao_nb;
> -
>  /*
> - * We run the default notifier if we have only the SRAO, the first and the
> + * We run the default notifier if we have only the UC, the first and the
>   * default notifier registered. I.e., the mandatory NUM_DEFAULT_NOTIFIERS
>   * notifiers registered on the chain.
>   */
> @@ -580,26 +578,29 @@ static struct notifier_block first_nb = {
>  	.priority	= MCE_PRIO_FIRST,
>  };
>  
> -static int srao_decode_notifier(struct notifier_block *nb, unsigned long val,
> -				void *data)
> +static int uc_decode_notifier(struct notifier_block *nb, unsigned long val,
> +			      void *data)
>  {
>  	struct mce *mce = (struct mce *)data;
>  	unsigned long pfn;
>  
> -	if (!mce)
> +	if (!mce || !mce_usable_address(mce))
>  		return NOTIFY_DONE;
>  
> -	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
> -		pfn = mce->addr >> PAGE_SHIFT;
> -		if (!memory_failure(pfn, 0))
> -			set_mce_nospec(pfn);
> -	}
> +	if (mce->severity != MCE_AO_SEVERITY &&
> +	    mce->severity != MCE_DEFERRED_SEVERITY)
> +		return NOTIFY_DONE;
> +
> +	pfn = mce->addr >> PAGE_SHIFT;
> +	if (!memory_failure(pfn, 0))
> +		set_mce_nospec(pfn);

I'm wondering if in the memory_failure error() case, we should hand it
down to the remaining notifiers.

Which also begs the question in light of this clumsy notifier counting:

How about we have the default notifier *unconditionally* print the MCE?
I.e., if the error has reached it, it would print it. If not and some
other notifier consumed it, it will get handled differently.

This way we won't need any special counting of notifiers and special
reg/unreg of notifiers etc.

IOW, the logic would be:

If something consumes the error, then it doesn't get printed. Notifier
does NOTIFY_STOP.

If nothing consumes it or something looks at it and decides that it
should still get printed, then the last catch-all notifier callback does
that.

Thoughts?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
