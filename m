Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECB2492EC5
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jan 2022 20:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348936AbiARTyF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Jan 2022 14:54:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38134 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239127AbiARTyD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Jan 2022 14:54:03 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id E090220B9270;
        Tue, 18 Jan 2022 11:54:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E090220B9270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642535643;
        bh=Xn5G5Yd/mU4xY8lEVK+Cw7n0ukjhmtZgBlV9vzEdU1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ovMugNtO1bmmEfzaaqP8cekHKQ4j7E6niSRX837RD6RjBQJmIuZrcutgsUzol3LtF
         JUwPniVWKh23AEHc706FCri2kjY1rARbzN/Dr16cAr4+Enqj7BWHWr/8WmttrN79oG
         NqRgdAFxcVQjGDknK7ziC2V2x6t1KQ53vdNZmaVc=
Date:   Tue, 18 Jan 2022 13:54:01 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lei Wang <lewan@microsoft.com>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sinan Kaya <okaya@kernel.org>,
        Shiping Ji <shiping.linux@gmail.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/dmc520: Don't print an error for each unconfigured
 interrupt line
Message-ID: <20220118195401.GB89184@sequoia>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
 <20220118152816.GA89184@sequoia>
 <Yeb4sK+ZmSHjWPWL@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yeb4sK+ZmSHjWPWL@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022-01-18 18:28:16, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 09:28:16AM -0600, Tyler Hicks wrote:
> > KERN_ERR messages trip log scanners and cause concern that the
> > kernel/hardware is not configured or working correctly. They also add a
> > little big of ongoing stress into kernel maintainer's lives, as we
> > prepare and test kernel updates, since they show up as red text in
> > journalctl output that we have to think about regularly. Multiple
> > KERN_ERR messages, 8 in this case, can also be considered a little worse
> > than a single error message.
> 
> It sounds to me like you wanna read
> 
> Documentation/process/stable-kernel-rules.rst
> 
> first.

I'm familiar with it and the sort of commits that flow into stable.

> > I feel like this trivial fix is worth taking into stable rather than
> > suppressing these errors (mentally and in log scanners) for years.
> 
> Years? 

Yes, years. v5.10 is supported through 2026.

> In any case, sorry, no, I don't consider this stable material.

The bar varies by subsystem maintainer but this wouldn't be the first
logging fix that made it into a stable branch. From the linux-5.10.y
branch of linux-stable:

 ddb13ddacc60 scsi: pm80xx: Fix misleading log statement in pm8001_mpi_get_nvmd_resp()
 526261c1b706 amd/display: downgrade validation failure log level
 9a3f52f73c04 bnxt_en: Improve logging of error recovery settings information.
 5f7bda9ba8d7 leds: lm3697: Don't spam logs when probe is deferred
 8b195380cd07 staging: fbtft: Don't spam logs when probe is deferred
 ...

But you do the hard work of maintaining the subsystem tree so you get to
call the shots about where fixes are routed. :) Thanks for applying the
change!

Tyler

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
