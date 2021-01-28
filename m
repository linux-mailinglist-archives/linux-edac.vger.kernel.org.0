Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED20307D3A
	for <lists+linux-edac@lfdr.de>; Thu, 28 Jan 2021 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhA1R7l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Jan 2021 12:59:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:47428 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229593AbhA1R63 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Jan 2021 12:58:29 -0500
Received: from zn.tnic (p200300ec2f0a4b00db608beaaba2adee.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:4b00:db60:8bea:aba2:adee])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9486D1EC058C;
        Thu, 28 Jan 2021 18:57:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611856661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T/dOLZHqyfSXT8UHCHdkk516q/7r513CDtEdL9VJMe0=;
        b=JVi7ocDa2q2IATomaId3fpoiN/LDhxvbpNFODzgUofJsUdv9XlHFcEs2yeCpx2aVfSnBT6
        kYv3Ge/CN1jzCfqg4JiD295LveLTvw/HA+3dytSHBOA7eVQQ+2UhIVJPZKreVrvGSFqbPU
        Eqn3p/nu89ZAnYf7vFUSR3thif+aylg=
Date:   Thu, 28 Jan 2021 18:57:35 +0100
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
Message-ID: <20210128175735.GB2120@zn.tnic>
References: <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
 <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 26, 2021 at 02:36:05PM -0800, Luck, Tony wrote:
> In some cases Linux might context switch to something else. Perhaps
> this task even gets picked up by another CPU to run the task work
> queued functions.  But I imagine that the context switch should act
> as a barrier ... shouldn't it?

I'm given to understand that the #MC from user is likely to schedule and
a context switch has a barrier character.

> After a few cycles of the test injection to user mode, I saw an
> overflow in the machine check bank. As if it hadn't been cleared
> from the previous iteration ...

This sounds weird. As if something else is happening which we haven't
thought of yet...

> When the tests were failing, code was on top of v5.11-rc3. Latest
> experiments moved to -rc5.  There's just a tracing fix from
> PeterZ between rc3 and rc5 to mce/core.c:
> 
> 737495361d44 ("x86/mce: Remove explicit/superfluous tracing")
> 
> which doesn't appear to be a candidate for the problems I saw.

Doesn't look like it.

> This is the bit that changed during my detour using atomic_t mce_count.
> I added the local variable to capture value from atomic_inc_return(), then
> used it later, instead of a bunch of atomic_read() calls.
> 
> I kept it this way because "if (count == 1)" is marginally easier to read
> than "if (current->mce_count++ == 0)"

Right.

So still no explanation why it would fail before. ;-\

Crazy idea: if you still can reproduce on -rc3, you could bisect: i.e.,
if you apply the patch on -rc3 and it explodes and if you apply the same
patch on -rc5 and it works, then that could be a start... Yeah, don't
have a better idea here. :-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
