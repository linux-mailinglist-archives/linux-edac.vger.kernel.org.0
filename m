Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10D5280062
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732020AbgJANoz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 09:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732018AbgJANoz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Oct 2020 09:44:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1FC0613D0
        for <linux-edac@vger.kernel.org>; Thu,  1 Oct 2020 06:44:53 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z26so5579356oih.12
        for <linux-edac@vger.kernel.org>; Thu, 01 Oct 2020 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWvqgGg9x3rndGKnsfey2hSakWzbUWX2bFMpFGno/eM=;
        b=gAEPPBInHJISG4I+BCO5QQFbsKJk7rIZom+O5pYBUNY8QQwZdZph3bDbS0IQPSHL1e
         jMdpTSKL/sGudXpQ8EHyPVGXt+hY7aaxb+zksuroEOBMBb2ZawfCLlM8h0ejrnSQzne9
         Updyu4hE/GuF1nngfEzsnHDyxD2VTUoCArUebobNxNe99ReUR0CXBVnkpqDKB5FUMush
         MFYsv6wuktwwwKc+ghTdIXgoGYVEuvhzlqKca1ID65M/REo0EJsgMgh38lyFtFNLGoMe
         /DkOnlnTmXsf3DiCBUr6dvG9ewKaODwgOoOFhpb6y0/Hgb2hTJuQ82JbOzoUfJ+gKvU+
         sRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=sWvqgGg9x3rndGKnsfey2hSakWzbUWX2bFMpFGno/eM=;
        b=hc8NcAw/wxAMczLxgIL7egs+Yp2rOuV31QGmW+9DhYdrurPn/G+wOjOaGqmQcFGL9d
         qUw9iNWeYq5dvehzKZMr+zVYlukycR0/QHh7+y2VsARjmJA3n+zIBEGdvuzDEpLfeesI
         rTNCqm5/81Z0Y2Qi1FNgrAF0SpkUBDtojkDSM9e8H2GcvbkKLb92fq58/N0J6cwSwwCz
         rtBXFGyFkOgixQNBt93DV+WTiSHsYOqSgCF7DjWC/mUBxtRJTzmJUmL/AauKJwMwgl6j
         n5zr8EHpYEUXMBWgdQzwGBDVXHa4oKFMm34CBXIzc3LDfbQBLxuy5vLB+C9px3BzzvhU
         q0Sg==
X-Gm-Message-State: AOAM532LJXH8i/tEEVXdp/NY8qotwrbpyt2zPc0gBhkr/vYDHj0CL1KU
        5fZ38lbuNkfLVJFy+maJlA==
X-Google-Smtp-Source: ABdhPJznzfGcnX0AceTCoCw42ooYga4lvJpQjAv1YSUnKSBpgeFNH/O0VC50amR73IxhiSS11qpANA==
X-Received: by 2002:aca:b144:: with SMTP id a65mr30196oif.53.1601559892736;
        Thu, 01 Oct 2020 06:44:52 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id h14sm1191725otr.21.2020.10.01.06.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 06:44:51 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:119c:a18f:647:7f4c])
        by serve.minyard.net (Postfix) with ESMTPSA id A43C4180056;
        Thu,  1 Oct 2020 13:44:50 +0000 (UTC)
Date:   Thu, 1 Oct 2020 08:44:49 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20201001134449.GB3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
 <20200930184906.GZ3674@minyard.net>
 <20201001113318.GC17683@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001113318.GC17683@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 01, 2020 at 01:33:18PM +0200, Borislav Petkov wrote:
> On Wed, Sep 30, 2020 at 01:49:06PM -0500, Corey Minyard wrote:
> > That is the original post for this, yes.
> > 
> > Wu, what kernel version are you using?  Can you try to reproduce on the
> > current mainstream kernel?  I just assumed it was current.
> > 
> > The description isn't that great, no.  I'll try again.
> > 
> > The problem is that while waiting in wait_for_panic() in the mce code,
> > interrupts are enabled.  In the kdump case, there is nothing that will
> > wake them up, so they will sit there in the loop until they time out.
> > 
> > In the mean time, the cpu handling the panic calls some IPMI code that
> > stores panic information in the IPMI event log.  Since interrupts are
> > enabled on the CPUs in wait_for_panic(), those CPUs are handling
> > interrupts from the IPMI hardware.  They will not, however, handle
> > the NMI IPI that gets sent from the panic() code for kdump.
> > 
> > The IPMI code has disabled locks to avoid a deadlock if the exception
> > happens while in IPMI code.  So the panic-handling part of IPMI and the
> > IPMI interrupt handling are both running at the same time, messing each
> > other up.
> > 
> > It seems, in general, like a bad idea to have interrupts enabled on some
> > CPUs while running through the panic() code and after the new kdump
> > kernel has started.  There are other issues that might come from this.
> > 
> > I'm also not quite sure how kdump register information for the CPUs
> > in wait_for_panic() gets put into the kernel coredump if you don't do
> > something like my patch.
> > 
> 
> Ok, thanks for taking the time, this makes a lot more sense to me.
> 
> Now, from looking at the code, I'm thinking that we should simply "let
> go" the other CPUs just like we do in mce_check_crashing_cpu(), if
> kdump is starting. Instead of spinning with IRQs enabled.
> 
> Simply run mce_check_crashing_cpu() at wait_for_panic() entry, just like
> exc_machine_check_kernel() does now. The logic being, if we're going
> to wait for panic but we're starting the kdump kernel anyway, then we
> better let the CPUs go so that they can do all kinds of IRQ servicing
> etc and don't interfere.

I don't understand the last sentence.  You don't want to do IRQ
servicing when you are going to kdump.  That's going to change the state
of the kernel and you may lose information, and it may interfere with
the kdump process.

That's why (well, one of many reasons why) kdump goes straight to NMI
shootdown.

Also, it's still unclear to me how kdump would get the register
information for the CPUs that enter wait_for_panic().

> 
> *If* we don't kdump, we timeout the usual way.

I was thinking about this some yesterday.  It seems to me that enabling
IRQS in an MCE handler is just a bad idea, but it's really a bad idea
for kdump.

I think you could just remove the irq enable in wait_for_panic() and
call run_crash_ipi_callback() from the loop there without messing
with irqs.  In the non-kdump case, it waits a second for the
RESET_VECTOR to happen in native_stop_other_cpus() then it uses an NMI
shootdown.  So it will delay for a second in the normal panic case.
The kdump case uses nmi_shootdown_cpus(), which doesn't do the
RESET_VECTOR stop.

-corey

> 
> Tony, how does that logic sound?
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
