Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CC92C0DA9
	for <lists+linux-edac@lfdr.de>; Mon, 23 Nov 2020 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbgKWO1y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Nov 2020 09:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbgKWO1x (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Nov 2020 09:27:53 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CEFC0613CF;
        Mon, 23 Nov 2020 06:27:53 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bbc0057986d054fc332b4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bc00:5798:6d05:4fc3:32b4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C848F1EC0489;
        Mon, 23 Nov 2020 15:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606141671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YVlMkzHFiusX04YsfOyqGo4uwcFrGk13RNaV6hMxiVY=;
        b=IbGNT6Z75IQwf/JbHcLWZ7w/bK5OJCWv9Ab0+boxbhWEf1Q+Ec/CPC6eWqOr745J7SLTRn
        7Ac8hG8Ni3z/FmiHrk5+6i01xwnNhHgIooe//M/ixS7An08Vz13gABUMKgv9BCvGoAfWvY
        P4+8fJtpQgmH+FJFKEDzDsEHHHP02/o=
Date:   Mon, 23 Nov 2020 15:27:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Gabriele Paoloni <gabriele.paoloni@intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, hpa@zytor.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech
Subject: Re: [PATCH 2/4] x86/mce: move the mce_panic() call and kill_it
 assignments at the right places
Message-ID: <20201123142746.GC15044@zn.tnic>
References: <20201118151552.1412-1-gabriele.paoloni@intel.com>
 <20201118151552.1412-3-gabriele.paoloni@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118151552.1412-3-gabriele.paoloni@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 18, 2020 at 03:15:50PM +0000, Gabriele Paoloni wrote:
> Right now for local MCEs we panic(),if needed, right after lmce is
> set. For global MCEs mce_reign() takes care of calling mce_panic().
> Hence this patch:
> - improves readibility by moving the conditional evaluation of
> tolerant up to when kill_it is set first
> - moves the mce_panic() call up into the statement where mce_end()
> fails

Pls avoid using "this patch does this and that" in the commit message
but say directly what it does:

- Improve readability ...

- Move mce_panic()...

and so on.

> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index b990892c6766..e025ff04438f 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1350,8 +1350,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	 * severity is MCE_AR_SEVERITY we have other options.
>  	 */
>  	if (!(m.mcgstatus & MCG_STATUS_RIPV))
> -		kill_it = 1;
> -
> +		kill_it = (cfg->tolerant == 3) ? 0 : 1;

So you just set kill_it using cfg->tolerant...

>  	/*
>  	 * Check if this MCE is signaled to only this logical processor,
>  	 * on Intel, Zhaoxin only.
> @@ -1384,8 +1383,15 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  	 * When there's any problem use only local no_way_out state.
>  	 */
>  	if (!lmce) {
> -		if (mce_end(order) < 0)
> +		if (mce_end(order) < 0) {
>  			no_way_out = no_way_out ? no_way_out : worst >= MCE_PANIC_SEVERITY;
> +			/*
> +			 * mce_reign() has probably failed hence evaluate if we need
> +			 * to panic
> +			 */
> +			if (no_way_out && mca_cfg.tolerant < 3)

... but here you're testing cfg->tolerant again.

why not

			if (no_way_out && kill_it)

?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
