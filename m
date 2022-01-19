Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71991493703
	for <lists+linux-edac@lfdr.de>; Wed, 19 Jan 2022 10:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351949AbiASJR6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 19 Jan 2022 04:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351412AbiASJR6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 19 Jan 2022 04:17:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA4C061574;
        Wed, 19 Jan 2022 01:17:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F6BDB8190C;
        Wed, 19 Jan 2022 09:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6D4C004E1;
        Wed, 19 Jan 2022 09:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642583875;
        bh=Tz7UWHlD4kYNxsRbKagjhbgKk/X3za8NyODCl6AjJYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mXkyB+9bPfPAOtELgVgZo1hEvyM9x6iLVZDpObhg5r3dF1RwnYT3ncyjKtej8wqMA
         /SfQXpNCE3+D4d9TQ66YpwlltnqSy3OyVkD7G3WNgBKY4yxr3c049lFAeNG5QGP9k7
         S647hWLaCBp+c+jAwYdS+4lXy3EnussCTNhIdJc0=
Date:   Wed, 19 Jan 2022 10:17:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Sasha Levin <sashal@kernel.org>, Lei Wang <lewan@microsoft.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <YefXQHXNlsxk8yUc@kroah.com>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
 <20220118195401.GB89184@sequoia>
 <YecrXidqecoYI/xg@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YecrXidqecoYI/xg@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 18, 2022 at 10:04:30PM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 01:54:01PM -0600, Tyler Hicks wrote:
> > On 2022-01-18 18:28:16, Borislav Petkov wrote:
> > > On Tue, Jan 18, 2022 at 09:28:16AM -0600, Tyler Hicks wrote:
> > > > KERN_ERR messages trip log scanners and cause concern that the
> > > > kernel/hardware is not configured or working correctly. They also add a
> > > > little big of ongoing stress into kernel maintainer's lives, as we
> > > > prepare and test kernel updates, since they show up as red text in
> > > > journalctl output that we have to think about regularly. Multiple
> > > > KERN_ERR messages, 8 in this case, can also be considered a little worse
> > > > than a single error message.
> > > 
> > > It sounds to me like you wanna read
> > > 
> > > Documentation/process/stable-kernel-rules.rst
> > > 
> > > first.
> > 
> > I'm familiar with it and the sort of commits that flow into stable.
> > 
> > > > I feel like this trivial fix is worth taking into stable rather than
> > > > suppressing these errors (mentally and in log scanners) for years.
> > > 
> > > Years? 
> > 
> > Yes, years. v5.10 is supported through 2026.
> > 
> > > In any case, sorry, no, I don't consider this stable material.
> > 
> > The bar varies by subsystem maintainer but this wouldn't be the first
> > logging fix that made it into a stable branch. From the linux-5.10.y
> > branch of linux-stable:
> > 
> >  ddb13ddacc60 scsi: pm80xx: Fix misleading log statement in pm8001_mpi_get_nvmd_resp()
> >  526261c1b706 amd/display: downgrade validation failure log level
> >  9a3f52f73c04 bnxt_en: Improve logging of error recovery settings information.
> >  5f7bda9ba8d7 leds: lm3697: Don't spam logs when probe is deferred
> >  8b195380cd07 staging: fbtft: Don't spam logs when probe is deferred
> >  ...
> 
> Well, lemme add the stable folks for comment then - they might have had
> their reasons.
> 
> ( Or Sasha's AI went nuts. Which I've witnessed a bunch of times
> already.)
> 
> If I look at the stable-kernel-rules.rst file, the only rule that
> *maybe*, *probably* applies here is
> 
> "- It must fix a real bug that bothers people"
> 
> But this one is formulated so broadly so that it makes me wanna ignore
> it. Because *anything* can bother people - even spelling mistakes but
> then a later rule says no spelling fixes.
> 
> Don't get me wrong - I don't mind having the stable tag where really
> needed. But here it is questionable. And we have those stable rules for
> a reason - if we start bending them and ignoring them then we might
> just as well backport everything that applies and have parallel kernel
> streams where the version means nothing. Basically a distro kernel. :-P
> 
> So let's see what the stable folks say first.

I will be glad to take these types of patches if the subsystem
maintainer thinks it will help things out, or if they are tired of
getting emails about the misleading messages.  In this case, I don't
think either of those things is relevant, so I don't see why the patch
should be backported.

For this specific change, I do NOT think it should be backported at all,
mostly for the reason that people are still arguing over the whole
platform_get_*_optional() mess that we currently have.  Let's not go and
backport anything right now to stable trees until we have all of that
sorted out, as it looks like it all might be changing again.  See:
	https://lore.kernel.org/r/20220110195449.12448-1-s.shtylyov@omp.ru
for all of the gory details and the 300+ emails written on the topic so
far.

Tyler, feel free to jump in to that thread if you want, it's a mess...

thanks,

greg k-h
