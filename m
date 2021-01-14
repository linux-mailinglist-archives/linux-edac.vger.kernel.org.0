Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3592F6BFE
	for <lists+linux-edac@lfdr.de>; Thu, 14 Jan 2021 21:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbhANUXB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Jan 2021 15:23:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbhANUXB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Jan 2021 15:23:01 -0500
Received: from zn.tnic (p200300ec2f1aa9006cfc9535ea796179.dip0.t-ipconnect.de [IPv6:2003:ec:2f1a:a900:6cfc:9535:ea79:6179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 34CD61EC0253;
        Thu, 14 Jan 2021 21:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610655740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B98lkJB1V5RYsjEAJLeZgjNYUBdiqyknXyQisAXWnig=;
        b=aq9KFkfNTOWE8yJKkb4oMKx5lEZa+qRKShQukNmCJcDGpvA5J80gNQZKR/DqOxYcko5H8T
        WUCO77i9S5HqeSJfphu4sGCL8MO6TvY/qSN6DtYSBDF9OqWaSHi6RhHJ77KfkAFo1yjJ77
        nH/v/v1J6oo+CEcS5Ffn8ptFQc+ngGg=
Date:   Thu, 14 Jan 2021 21:22:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210114202213.GI12284@zn.tnic>
References: <20210108222251.14391-1-tony.luck@intel.com>
 <20210111214452.1826-1-tony.luck@intel.com>
 <20210111214452.1826-2-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210111214452.1826-2-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jan 11, 2021 at 01:44:50PM -0800, Tony Luck wrote:
> @@ -1431,8 +1433,11 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  				mce_panic("Failed kernel mode recovery", &m, msg);
>  		}
>  
> -		if (m.kflags & MCE_IN_KERNEL_COPYIN)
> +		if (m.kflags & MCE_IN_KERNEL_COPYIN) {
> +			if (current->mce_busy)
> +				mce_panic("Multiple copyin", &m, msg);

So this: we're currently busy handling the first MCE, why do we must
panic?

Can we simply ignore all follow-up MCEs to that page?

I.e., the page will get poisoned eventually and that poisoning is
currently executing so all following MCEs are simply nothing new and we
can ignore them.

It's not like we're going to corrupt more data - we already are
"corrupting" whole 4K.

Am I making sense?

Because if we do this, we won't have to pay attention to any get_user()
callers and whatnot - we simply ignore and the solution is simple and
you won't have to touch any get_user() callers...

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
