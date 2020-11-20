Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC55D2BB132
	for <lists+linux-edac@lfdr.de>; Fri, 20 Nov 2020 18:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgKTRHq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Nov 2020 12:07:46 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50186 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729976AbgKTRHq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Nov 2020 12:07:46 -0500
Received: from zn.tnic (p200300ec2f11ba0074b4ba83d21d5a9c.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:ba00:74b4:ba83:d21d:5a9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09FA01EC047E;
        Fri, 20 Nov 2020 18:07:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605892065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3KR92vuxYVBgK06PedGl/KeDJFbNpeGefSx2Yb7CWNQ=;
        b=geHBLt7iPjdg5zExWPyw89Os6akDxLqEyRiyOhnSw/sKpOqGQJkhhELIvem9t+ok/b8PBI
        Wtm8pOCwCDISigUS6AuowJxglb5MrIx8eVeifm013fH26lwsRGcOJN0SVs5tsxxcfXLXAr
        7xruRul0mZV7OBzYhQ60+FZI9M9c75c=
Date:   Fri, 20 Nov 2020 18:07:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH 1/4] x86/mce: do not overwrite no_way_out if mce_end()
 fails
Message-ID: <20201120170737.GD712@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-2-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118151552.1412-2-gabriele.paoloni@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 18, 2020 at 03:15:49PM +0000, Gabriele Paoloni wrote:
> Currently if mce_end() fails no_way_out is set equal to worst.
> worst is the worst severirty that was found in the MCA banks
		     ^^^^^^^^^

Please introduce a spellchecker into your patch creation workflow.

> associated to the current CPU; however at this point no_way_out
	     ^
	     with


> could be already set by mca_start() by looking at all severities

I think you mean "could have been already set" here

> of all CPUs that entered the MCE handler.
> if mce_end() fails we first check if no_way_out is already set and

Please use passive voice in your commit message: no "we" or "I", etc.

Also, pls start new sentences with a capital letter and end them with a
fullstop.

> if so we stick to it, otherwise we use the local worst value

So basically you're trying to say here that no_way_out might have been
already set and other CPUs could overwrite it and that should not
happen.

Is that what you mean?

> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 4102b866e7c0..b990892c6766 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1385,7 +1385,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	 */
>  	if (!lmce) {
>  		if (mce_end(order) < 0)
> -			no_way_out = worst >= MCE_PANIC_SEVERITY;
> +			no_way_out = no_way_out ? no_way_out : worst >= MCE_PANIC_SEVERITY;

I had to stare at this a bit to figure out what you're doing. So how
about simplifying this:

			if (!no_way_out)
				no_way_out = worst >= MCE_PANIC_SEVERITY;

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
