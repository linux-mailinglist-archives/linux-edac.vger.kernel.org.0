Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C86492FE2
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jan 2022 22:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349546AbiARVEi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Jan 2022 16:04:38 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46952 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245732AbiARVEd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 18 Jan 2022 16:04:33 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C19A1EC0441;
        Tue, 18 Jan 2022 22:04:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642539867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Bw9CAaU00kCn0djSnCEevWP1zGjAgVuyLrAZN+WrYxI=;
        b=cvsNU6Gklq7aV/Y6B6yyKCRI2fGLVWzjX2FclBHdkH3xWJM9nNiXsJbSYUbSzLvouK6rnd
        E7TQ0nYp4egHTP5bzSRnyXa5lDU3mh77UrRckbX7cIii/WfHnNWa+3tdoUS+yVA6DFK8tR
        Hy4BsFQOZxvrFLk8yxQLPBKJrPqisTA=
Date:   Tue, 18 Jan 2022 22:04:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Lei Wang <lewan@microsoft.com>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <YecrXidqecoYI/xg@zn.tnic>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220118195401.GB89184@sequoia>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 18, 2022 at 01:54:01PM -0600, Tyler Hicks wrote:
> On 2022-01-18 18:28:16, Borislav Petkov wrote:
> > On Tue, Jan 18, 2022 at 09:28:16AM -0600, Tyler Hicks wrote:
> > > KERN_ERR messages trip log scanners and cause concern that the
> > > kernel/hardware is not configured or working correctly. They also add a
> > > little big of ongoing stress into kernel maintainer's lives, as we
> > > prepare and test kernel updates, since they show up as red text in
> > > journalctl output that we have to think about regularly. Multiple
> > > KERN_ERR messages, 8 in this case, can also be considered a little worse
> > > than a single error message.
> > 
> > It sounds to me like you wanna read
> > 
> > Documentation/process/stable-kernel-rules.rst
> > 
> > first.
> 
> I'm familiar with it and the sort of commits that flow into stable.
> 
> > > I feel like this trivial fix is worth taking into stable rather than
> > > suppressing these errors (mentally and in log scanners) for years.
> > 
> > Years? 
> 
> Yes, years. v5.10 is supported through 2026.
> 
> > In any case, sorry, no, I don't consider this stable material.
> 
> The bar varies by subsystem maintainer but this wouldn't be the first
> logging fix that made it into a stable branch. From the linux-5.10.y
> branch of linux-stable:
> 
>  ddb13ddacc60 scsi: pm80xx: Fix misleading log statement in pm8001_mpi_get_nvmd_resp()
>  526261c1b706 amd/display: downgrade validation failure log level
>  9a3f52f73c04 bnxt_en: Improve logging of error recovery settings information.
>  5f7bda9ba8d7 leds: lm3697: Don't spam logs when probe is deferred
>  8b195380cd07 staging: fbtft: Don't spam logs when probe is deferred
>  ...

Well, lemme add the stable folks for comment then - they might have had
their reasons.

( Or Sasha's AI went nuts. Which I've witnessed a bunch of times
already.)

If I look at the stable-kernel-rules.rst file, the only rule that
*maybe*, *probably* applies here is

"- It must fix a real bug that bothers people"

But this one is formulated so broadly so that it makes me wanna ignore
it. Because *anything* can bother people - even spelling mistakes but
then a later rule says no spelling fixes.

Don't get me wrong - I don't mind having the stable tag where really
needed. But here it is questionable. And we have those stable rules for
a reason - if we start bending them and ignoring them then we might
just as well backport everything that applies and have parallel kernel
streams where the version means nothing. Basically a distro kernel. :-P

So let's see what the stable folks say first.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
