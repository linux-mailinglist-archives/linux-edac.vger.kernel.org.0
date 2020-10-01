Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9E27FE77
	for <lists+linux-edac@lfdr.de>; Thu,  1 Oct 2020 13:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbgJALd2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 1 Oct 2020 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbgJALd2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 1 Oct 2020 07:33:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216C7C0613D0
        for <linux-edac@vger.kernel.org>; Thu,  1 Oct 2020 04:33:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f089d0086f50977b536c1c2.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:9d00:86f5:977:b536:c1c2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9D261EC047F;
        Thu,  1 Oct 2020 13:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601552006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8CRd+yr1XtH/F+plPSOjaWbAYrwAhBrbjfUWb42l+Qg=;
        b=HJJ+vaGxk0M5N7jK41iqkdgn+I2tYJZuhbBAnl7+wBGKaelFjr9uDu5O+d7iOo4I2GHi0b
        /lfrzjIu5Zs0KgaCb7g++r24tcOBx3M6xvrcGI/jh5BcsfuRNMbBeynGQpiUq+YuEoW/Jk
        9YHNkqFCp5Ey+KHovOhH332mICAXO0Y=
Date:   Thu, 1 Oct 2020 13:33:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Corey Minyard <minyard@acm.org>, "Luck, Tony" <tony.luck@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20201001113318.GC17683@zn.tnic>
References: <20200929211644.31632-1-minyard@acm.org>
 <20200930175633.GM6810@zn.tnic>
 <20200930184906.GZ3674@minyard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930184906.GZ3674@minyard.net>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 30, 2020 at 01:49:06PM -0500, Corey Minyard wrote:
> That is the original post for this, yes.
> 
> Wu, what kernel version are you using?  Can you try to reproduce on the
> current mainstream kernel?  I just assumed it was current.
> 
> The description isn't that great, no.  I'll try again.
> 
> The problem is that while waiting in wait_for_panic() in the mce code,
> interrupts are enabled.  In the kdump case, there is nothing that will
> wake them up, so they will sit there in the loop until they time out.
> 
> In the mean time, the cpu handling the panic calls some IPMI code that
> stores panic information in the IPMI event log.  Since interrupts are
> enabled on the CPUs in wait_for_panic(), those CPUs are handling
> interrupts from the IPMI hardware.  They will not, however, handle
> the NMI IPI that gets sent from the panic() code for kdump.
> 
> The IPMI code has disabled locks to avoid a deadlock if the exception
> happens while in IPMI code.  So the panic-handling part of IPMI and the
> IPMI interrupt handling are both running at the same time, messing each
> other up.
> 
> It seems, in general, like a bad idea to have interrupts enabled on some
> CPUs while running through the panic() code and after the new kdump
> kernel has started.  There are other issues that might come from this.
> 
> I'm also not quite sure how kdump register information for the CPUs
> in wait_for_panic() gets put into the kernel coredump if you don't do
> something like my patch.
> 

Ok, thanks for taking the time, this makes a lot more sense to me.

Now, from looking at the code, I'm thinking that we should simply "let
go" the other CPUs just like we do in mce_check_crashing_cpu(), if
kdump is starting. Instead of spinning with IRQs enabled.

Simply run mce_check_crashing_cpu() at wait_for_panic() entry, just like
exc_machine_check_kernel() does now. The logic being, if we're going
to wait for panic but we're starting the kdump kernel anyway, then we
better let the CPUs go so that they can do all kinds of IRQ servicing
etc and don't interfere.

*If* we don't kdump, we timeout the usual way.

Tony, how does that logic sound?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
