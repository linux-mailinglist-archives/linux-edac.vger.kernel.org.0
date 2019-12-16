Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C567E1211D5
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2019 18:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfLPRho (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Dec 2019 12:37:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50146 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPRhn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Dec 2019 12:37:43 -0500
Received: from zn.tnic (p200300EC2F07BC00D0F2C92C76B3ABC9.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:bc00:d0f2:c92c:76b3:abc9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A405E1EC090E;
        Mon, 16 Dec 2019 18:37:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1576517862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIuQ4SBAYWTtmbd3i6y0A5cJd1GBpHw6PKo/pLo8a+4=;
        b=amZwGNh+x4wmCQD4hTMj7OhEe+SJh5f6ndvlCenqLGvcFKpR5mnpoJTtx6gHImXqhGceMR
        cS+Ll8bzg52kI7NC+nJQvdznmfq5VVDsi7R2Bcw5yI7+XuKWHBH9v6XltGHavvw1oZLChv
        gJesnWHvhRyeT6uevuc+GI1w9B/2RIU=
Date:   Mon, 16 Dec 2019 18:37:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH 4/6] x86/mce: Fix handling of optional message string
Message-ID: <20191216173737.GF17380@zn.tnic>
References: <20191210000733.17979-1-jschoenh@amazon.de>
 <20191210000733.17979-5-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191210000733.17979-5-jschoenh@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 10, 2019 at 01:07:31AM +0100, Jan H. Schönherr wrote:
> The function mce_severity() is not required to update its msg argument.
> In fact, mce_severity_amd() doesn't. Fix some code paths, that assume
> that it is always updated.
> 
> In particular, this avoids returning uninitialized data in
> mce_no_way_out(), which may be used later for printing.
> 
> Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 6afb9de251f2..b11a74e3fea9 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -809,10 +809,12 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
>  		if (quirk_no_way_out)
>  			quirk_no_way_out(i, m, regs);
>  
> +		tmp = NULL;
>  		m->bank = i;
>  		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
>  			mce_read_aux(m, i);
> -			*msg = tmp;
> +			if (tmp)
> +				*msg = tmp;
>  			return 1;
>  		}
>  	}
> @@ -1313,6 +1315,7 @@ void do_machine_check(struct pt_regs *regs, long error_code)
>  		 * make sure we have the right "msg".
>  		 */
>  		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
> +			msg = "Unknown";
>  			mce_severity(&m, cfg->tolerant, &msg, true);
>  			mce_panic("Local fatal machine check!", &m, msg);
>  		}
> -- 

Can we get rid of all that silliness of dealing with a possibly
uninitialized pointer in the callers and simply do at the beginning of
mce_panic():

	if (!msg)
		msg = "Unknown";

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
