Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5390627F0ED
	for <lists+linux-edac@lfdr.de>; Wed, 30 Sep 2020 19:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3R4m (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 30 Sep 2020 13:56:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53872 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI3R4m (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 30 Sep 2020 13:56:42 -0400
Received: from zn.tnic (p200300ec2f092a00744358e5887c2da3.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:7443:58e5:887c:2da3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E90BB1EC02E6;
        Wed, 30 Sep 2020 19:56:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601488601;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZzIFbHMXP4Runkj3hT3iqTvEyIf7ACWWCkV96flgY78=;
        b=U6ouqzb6vToffA3qz+Vrl7lSfatxW03oHuMTFQuRAXtskKD9ksukJrYbEFKJZOJywEo2UF
        bS7YFOU/Ck1EYY5dAooC0JyArXIBQIPBSOPAbp18HAeaw+WkB9/z1dZkAhLLQwaQC8QTN1
        GNazPur+JPBaIZGW7u47rtTe4bjtXrw=
Date:   Wed, 30 Sep 2020 19:56:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     minyard@acm.org
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-edac@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        hidehiro.kawai.ez@hitachi.com, linfeilong@huawei.com,
        liuzhiqiang26@huawei.com
Subject: Re: [PATCH v2] x86: Fix MCE error handing when kdump is enabled
Message-ID: <20200930175633.GM6810@zn.tnic>
References: <20200929211644.31632-1-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929211644.31632-1-minyard@acm.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 29, 2020 at 04:16:44PM -0500, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> If kdump is enabled, the handling of shooting down CPUs does not use the
> RESET_VECTOR irq before trying to use NMIs to shoot down the CPUs.

So I've read that commit message like a bunch of times already and am
getting none the wiser about what the situation is, who's doing what and
what is this thing fixing.

It must be something about kdumping a kernel and an MCE happening at the
same time and we did something about this a while ago, see:

 5bc329503e81 ("x86/mce: Handle broadcasted MCE gracefully with kexec")

and that is simply letting CPUs which are not doing the kexec-ing
continue from the broadcasted MCE holding pattern so that kexec
finishes.

So please explain exactly what this problem is, who's doing what, when
does the MCE happen etc?

I've found this:

https://lkml.kernel.org/r/1600339070-570840-1-git-send-email-wubo40@huawei.com

and that sounds like the problem and I'm going to read that one in
detail if that is the issue we're talking about. But from skimming over
it, it sounds like the commit I mentioned above should take care of it.

Although I have no clue what this means:

"1) MCE appears on all CPUs, Currently all CPUs are in the NMI interrupt 
   context."

I think he means, all CPUs are in the #MC handler.

Also, looking at that mail, what kernel is Wu Bo using?

[ 4767.947960] BUG: unable to handle kernel paging request at ffff893e40000000
[ 4767.947962] PGD 13c001067 P4D 13c001067 PUD 0
[ 4767.947965] Oops: 0000 [#1] SMP PTI
[ 4767.947967] CPU: 0 PID: 0 Comm: swapper/0

There's no kernel version on this line above. Taint line is gone too. Why?

Judging by the "unable to handle kernel paging request" text, that must
be from before

  f28b11a2abd9 ("x86/fault: Reword initial BUG message for unhandled page faults")

which is 5.1. The commit above is in 5.1 but Wu Bo better try the latest
*upstream* kernel first. The stress being on *upstream*.

Also that kernel is in a guest - I take MCEs in guests not very
seriously.

So before we waste time, let's explain why we're doing all that exercise
first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
