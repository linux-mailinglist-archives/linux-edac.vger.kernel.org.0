Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E17230BC7C
	for <lists+linux-edac@lfdr.de>; Tue,  2 Feb 2021 12:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhBBLCR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Feb 2021 06:02:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhBBLCM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 2 Feb 2021 06:02:12 -0500
Received: from zn.tnic (p200300ec2f0e1f00bc090c6ff424f9e7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:1f00:bc09:c6f:f424:f9e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 150701EC04C2;
        Tue,  2 Feb 2021 12:01:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612263690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9gCNYvkuN/kvIgv8aLGPw+TzBmvD3HmEHDLnSe+f7Yw=;
        b=gYxiZ/z/RYAxYW5HBh7279NrZqyUrTWmKlgcQjEKiMfn496skmrFLs3C4TIe8uAzzNtKfu
        AtLoHp/7vfDOFEyAPrgTHQdUsSBcwmLxBFEFF3cdiJZLkgFQRvPWCpQcH56SaxWnzihtDU
        RwtFe8FnvWSI82sLa2TOIFj9vw4ZQFQ=
Date:   Tue, 2 Feb 2021 12:01:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210202110126.GB18075@zn.tnic>
References: <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
 <20210128175735.GB2120@zn.tnic>
 <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210201185812.GA54867@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 01, 2021 at 10:58:12AM -0800, Luck, Tony wrote:
> On Thu, Jan 28, 2021 at 06:57:35PM +0100, Borislav Petkov wrote:
> > Crazy idea: if you still can reproduce on -rc3, you could bisect: i.e.,
> > if you apply the patch on -rc3 and it explodes and if you apply the same
> > patch on -rc5 and it works, then that could be a start... Yeah, don't
> > have a better idea here. :-\
> 
> I tried reporoducing (applied the original patch I posted back to -rc3) and
> the same issue stubbornly refused to show up again.
> 
> But I did hit something with the same signature (overflow bit set in
> bank 1) while running my futex test (which has two processes mapping
> the poison page).  This time I *do* understand what happened.  The test
> failed when the two processes were running on the two hyperhtreads of
> the same core. Seeing overflow in this case is understandable because
> bank 1 MSRs on my test machine are shared between the HT threads. When
> I run the test again using taskset(1) to only allowing running on
> thread 0 of each core, it keeps going for hunderds of iterations.
> 
> I'm not sure I can stitch together how this overflow also happened for
> my single process test. Maybe a migration from one HT thread to the
> other at an awkward moment?

Sounds plausible.

And the much more important question is, what is the code supposed to
do when that overflow *actually* happens in real life? Because IINM,
an overflow condition on the same page would mean killing the task to
contain the error and not killing the machine...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
