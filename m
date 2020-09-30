Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F7427F195
	for <lists+linux-edac@lfdr.de>; Wed, 30 Sep 2020 20:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3StL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Sep 2020 14:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3StL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 30 Sep 2020 14:49:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A29C061755
        for <linux-edac@vger.kernel.org>; Wed, 30 Sep 2020 11:49:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i17so2821521oig.10
        for <linux-edac@vger.kernel.org>; Wed, 30 Sep 2020 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3RdZr/4qIioeSla8PBH3eQVinVLfaBTVWGoyOB+C2Wc=;
        b=WJwP7Ow4qVtOKZVMS1UOfUP9DfhDnELqQZPFC1TfTXDT9rHInd3RZikfUVz1iDDA+h
         fbP90m8kaKqBydS0wjycG4aCGU3G7xSrTSdGhubfxHqFgapXPr6u0VSm6iK+W2N1w3mE
         OckfSSM5S849wTcU883AOL0MCSfnSWu3K6zhuqficnp25I9wFuBS5tXA+AE02Po8kWSc
         9b4kdfALOIV+cVO4lFCNpCKqueusa4gLRDWlXUJVw7n8tcQqC6qBBgoJ3iFu8C/+PIa9
         hSUOYG80McEnB6Y3Y++TWv+uqkpRGgqXbMBgMikflB2OppRu46Tj4Xz4IpZtVGnFglG+
         hhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=3RdZr/4qIioeSla8PBH3eQVinVLfaBTVWGoyOB+C2Wc=;
        b=ATuR6WcOkrfq+d9p7e/4RyBrmyk0fbBQObDSvlYCpXtzjv815pD/IYFiFaDZCKpH0p
         NXN4/88qcAp8cwMOFuu13cubh8U4u3lRefth+p6zAoHoxM7yLq4RFJNeqWdH35aQn33B
         L4OmYH6Vk+vl6NVsz2JVJ7Fj9RLPJdIpcvzn2SkmcvWqJ56kWVbzDh+U7mXhkbM+Nqnl
         Gewos+WE0vX3w0bLIPtlDIjZEUMvcXC6ghf5FOXWuRGQQYD6OO++dmsl5Vqe/LOmJFb9
         n190l1r+79AwF45n0AIclw0KFxTmEMwMMTXgngjqBZB1AInrTkfyx71El96NK41Ps82F
         L3/g==
X-Gm-Message-State: AOAM530gKcaFVNH/FY925OYrUCCEiqshkjptmK9UPkl0vJ5Rz6r30jxe
        zsd4rCOfK+pjcGTz42/LTeN+t+HFLCoAkPk=
X-Google-Smtp-Source: ABdhPJwIDPRECdMfRjIa5zgEpgbpLOJxmX4dfxr4lYwnsVKCBueqyycb76lMbhVyymTikWVp2nBPwA==
X-Received: by 2002:aca:c50b:: with SMTP id v11mr2100327oif.76.1601491750730;
        Wed, 30 Sep 2020 11:49:10 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n186sm616293oob.11.2020.09.30.11.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 11:49:09 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:39:f0c4:8e9f:b46b])
        by serve.minyard.net (Postfix) with ESMTPSA id 136A518003E;
        Wed, 30 Sep 2020 18:49:08 +0000 (UTC)
Date:   Wed, 30 Sep 2020 13:49:06 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20200930184906.GZ3674@minyard.net>
Reply-To: minyard@acm.org
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930175633.GM6810@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 30, 2020 at 07:56:33PM +0200, Borislav Petkov wrote:
> On Tue, Sep 29, 2020 at 04:16:44PM -0500, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > If kdump is enabled, the handling of shooting down CPUs does not use the
> > RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.
> 
> So I've read that commit message like a bunch of times already and am
> getting none the wiser about what the situation is, who's doing what and
> what is this thing fixing.
> 
> It must be something about kdumping a kernel and an MCE happening at the
> same time and we did something about this a while ago, see:
> 
>  5bc329503e81 ("x86/mce: Handle broadcasted MCE gracefully with kexec")
> 
> and that is simply letting CPUs which are not doing the kexec-ing
> continue from the broadcasted MCE holding pattern so that kexec
> finishes.
> 
> So please explain exactly what this problem is, who's doing what, when
> does the MCE happen etc?
> 
> I've found this:
> 
> https://lkml.kernel.org/r/1600339070-570840-1-git-send-email-wubo40@huawei.com
> 
> and that sounds like the problem and I'm going to read that one in
> detail if that is the issue we're talking about. But from skimming over
> it, it sounds like the commit I mentioned above should take care of it.

That is the original post for this, yes.

Wu, what kernel version are you using?  Can you try to reproduce on the
current mainstream kernel?  I just assumed it was current.

The description isn't that great, no.  I'll try again.

The problem is that while waiting in wait_for_panic() in the mce code,
interrupts are enabled.  In the kdump case, there is nothing that will
wake them up, so they will sit there in the loop until they time out.

In the mean time, the cpu handling the panic calls some IPMI code that
stores panic information in the IPMI event log.  Since interrupts are
enabled on the CPUs in wait_for_panic(), those CPUs are handling
interrupts from the IPMI hardware.  They will not, however, handle
the NMI IPI that gets sent from the panic() code for kdump.

The IPMI code has disabled locks to avoid a deadlock if the exception
happens while in IPMI code.  So the panic-handling part of IPMI and the
IPMI interrupt handling are both running at the same time, messing each
other up.

It seems, in general, like a bad idea to have interrupts enabled on some
CPUs while running through the panic() code and after the new kdump
kernel has started.  There are other issues that might come from this.

I'm also not quite sure how kdump register information for the CPUs
in wait_for_panic() gets put into the kernel coredump if you don't do
something like my patch.

Thanks,

-corey

> 
> Although I have no clue what this means:
> 
> "1) MCE appears on all CPUs, Currently all CPUs are in the NMI interrupt 
>    context."
> 
> I think he means, all CPUs are in the #MC handler.
> 
> Also, looking at that mail, what kernel is Wu Bo using?
> 
> [ 4767.947960] BUG: unable to handle kernel paging request at ffff893e40000000
> [ 4767.947962] PGD 13c001067 P4D 13c001067 PUD 0
> [ 4767.947965] Oops: 0000 [#1] SMP PTI
> [ 4767.947967] CPU: 0 PID: 0 Comm: swapper/0
> 
> There's no kernel version on this line above. Taint line is gone too. Why?
> 
> Judging by the "unable to handle kernel paging request" text, that must
> be from before
> 
>   f28b11a2abd9 ("x86/fault: Reword initial BUG message for unhandled page faults")
> 
> which is 5.1. The commit above is in 5.1 but Wu Bo better try the latest
> *upstream* kernel first. The stress being on *upstream*.
> 
> Also that kernel is in a guest - I take MCEs in guests not very
> seriously.
> 
> So before we waste time, let's explain why we're doing all that exercise
> first.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
