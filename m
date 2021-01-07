Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BD52ECACD
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 08:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAGHII (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 02:08:08 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59320 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbhAGHIH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 7 Jan 2021 02:08:07 -0500
Received: from zn.tnic (p200300ec2f0e340040aa7c2c4e2416a1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3400:40aa:7c2c:4e24:16a1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AC701EC0249;
        Thu,  7 Jan 2021 08:07:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610003246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KGFgHoScXK7gB6fZQoDz8zCs6uUeA+Ptsmqs8FOCUSM=;
        b=XAlB6YxFl3hMIWbrMLDgTPBh+P8vAOdOBCQL6FPsxbviydKlnstDQ5ZuT8GD1/I/QrP5sy
        E39IkG2lhmx+5hqJV+g6UktV6JJ0RzYwfKHFDX+iEI+NtJtOZK9HIuh0m30bitnm02r8+5
        d36WzkMrMLJWGohHXGwwSeEs7r1Ve4g=
Date:   Thu, 7 Jan 2021 08:07:24 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-edac@vger.kernel.org, tony.luck@intel.com,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        kernel-team@fb.com
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210107070724.GC14697@zn.tnic>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <20210106183244.GA24607@zn.tnic>
 <20210106191353.GA2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210106191353.GA2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 11:13:53AM -0800, Paul E. McKenney wrote:
> Not yet, it isn't!  Well, except in -rcu.  ;-)

Of course it is - saying "This commit" in this commit's commit message
is very much a tautology. :-)

> You are suggesting dropping mce_missing_cpus and just doing this?
> 
> if (!cpumask_andnot(&mce_present_cpus, cpu_online_mask, &mce_present_cpus))

Yes.

And pls don't call it "holdout CPUs" and change the order so that it is
more user-friendly (yap, you don't need __func__ either):

[   78.946153] mce: Not all CPUs (24-47,120-143) entered the broadcast exception handler.
[   78.946153] Kernel panic - not syncing: Timeout: MCA synchronization.

or so.

And that's fine if it appears twice as long as it is the same info - the
MCA code is one complex mess so you can probably guess why I'd like to
have new stuff added to it be as simplistic as possible.

> I was worried (perhaps unnecessarily) about the possibility of CPUs
> checking in during the printout operation, which would set rather than
> clear the bit.  But perhaps the possible false positives that Tony points
> out make this race not worth worrying about.
> 
> Thoughts?

Yah, apparently, it is not going to be a precise report as you wanted it
to be but at least it'll tell you which *sockets* you can rule out, if
not cores.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
