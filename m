Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A0F2803AB
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 18:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgJAQQz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 12:16:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35640 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732026AbgJAQQz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 1 Oct 2020 12:16:55 -0400
Received: from zn.tnic (p200300ec2f089d001daab592cfa658ec.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:1daa:b592:cfa6:58ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C15031EC04D6;
        Thu,  1 Oct 2020 18:16:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601569013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Z3eWdyOgq8BnbcTgC0zzQ1rYiMP5bzJljYw3eqh0BE0=;
        b=bq+AiB/GR+yJuTotMI3Vf+Do3/Py/CuaEWx9m0iydwShtlVaoBHBPF0U/XYCzUYNsXrxO1
        gxpSj0eefQkP8XZt/L4cSoBLbadrjqg+G9dhdyQ4UcXxXlKJAF1IAFAU6xE8a1uTa3fElX
        rnrrvUphCd01w5q4/h5AZtpt2t4PzZk=
Date:   Thu, 1 Oct 2020 18:16:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Corey Minyard <minyard@acm.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20201001161645.GD17683@zn.tnic>
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
 <20200930184906.GZ3674@minyard.net>
 <20201001113318.GC17683@zn.tnic>
 <20201001134449.GB3674@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201001134449.GB3674@minyard.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 01, 2020 at 08:44:49AM -0500, Corey Minyard wrote:
> I don't understand the last sentence.  You don't want to do IRQ
> servicing when you are going to kdump.  That's going to change the state
> of the kernel and you may lose information, and it may interfere with
> the kdump process.

I misspoke: what I meant was, what mce_check_crashing_cpu() does - free
the CPU from the #MC handler so that it can do whatever it is supposed
to do under kdump.

> That's why (well, one of many reasons why) kdump goes straight to NMI
> shootdown.

Right.

> Also, it's still unclear to me how kdump would get the register
> information for the CPUs that enter wait_for_panic().

Yes, you said that already.

> I was thinking about this some yesterday.  It seems to me that enabling
> IRQS in an MCE handler is just a bad idea, but it's really a bad idea
> for kdump.

I don't think this code ever thought about kdump.

> I think you could just remove the irq enable in wait_for_panic() and
> call run_crash_ipi_callback() from the loop there without messing
> with irqs.  In the non-kdump case, it waits a second for the
> RESET_VECTOR to happen in native_stop_other_cpus() then it uses an NMI
> shootdown.  So it will delay for a second in the normal panic case.
> The kdump case uses nmi_shootdown_cpus(), which doesn't do the
> RESET_VECTOR stop.

Well, I don't think the MCE code should know anything about kdump. What
it should do in the kdump case - i.e., when crashing_cpu != -1, is
simply call mce_check_crashing_cpu() in wait_for_panic(). In that case,
the only thing it should do is get out of the #MC handler so that it can
get the shootdown NMI.

For all other cases, it should do what wait_for_panic() has been doing
so far.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
