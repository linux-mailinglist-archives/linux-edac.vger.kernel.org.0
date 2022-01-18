Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604324929A6
	for <lists+linux-edac@lfdr.de>; Tue, 18 Jan 2022 16:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344910AbiARP21 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 18 Jan 2022 10:28:27 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiARP21 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 18 Jan 2022 10:28:27 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33D7A20B926E;
        Tue, 18 Jan 2022 07:28:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33D7A20B926E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642519706;
        bh=4Kxcr52+gHAbySx/ypcqz/aerBruEfVlDA6UU7MRmqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNo3lqJc3Fi043vZPmsF/n6MCeFaLJeFTsCY4AGA1bZ1ZkLUoffQShpUh6LKmgpwx
         Lu9rlX3AoiV6JE2vfKIFapbVi+QfDXMnXRN1IRkWpTZZdcx8/fiepGX6ZjxyUc0mDS
         5CevifvHgY5dnFd6H+Z4zn7IEr/r7OUC0EM1BWCQ=
Date:   Tue, 18 Jan 2022 09:28:16 -0600
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
Message-ID: <20220118152816.GA89184@sequoia>
References: <20220111163800.22362-1-tyhicks@linux.microsoft.com>
 <YeRkGvestiloCAUV@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeRkGvestiloCAUV@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022-01-16 19:29:46, Borislav Petkov wrote:
> On Tue, Jan 11, 2022 at 10:38:00AM -0600, Tyler Hicks wrote:
> > The dmc520 driver requires that at least one interrupt line, out of the ten
> > possible, is configured. The driver prints an error and returns -EINVAL
> > from its .probe function if there are no interrupt lines configured.
> > 
> > Don't print a KERN_ERR level message for each interrupt line that's
> > unconfigured as that can confuse users into thinking that there is an
> > error condition.
> > 
> > Before this change, the following KERN_ERR level messages would be
> > reported if only dram_ecc_errc and dram_ecc_errd were configured in the
> > device tree:
> > 
> >  dmc520 68000000.dmc: IRQ ram_ecc_errc not found
> >  dmc520 68000000.dmc: IRQ ram_ecc_errd not found
> >  dmc520 68000000.dmc: IRQ failed_access not found
> >  dmc520 68000000.dmc: IRQ failed_prog not found
> >  dmc520 68000000.dmc: IRQ link_err not
> >  dmc520 68000000.dmc: IRQ temperature_event not found
> >  dmc520 68000000.dmc: IRQ arch_fsm not found
> >  dmc520 68000000.dmc: IRQ phy_request not found
> > 
> > Fixes: 1088750d7839 ("EDAC: Add EDAC driver for DMC520")
> > Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> 
> Why stable? AFAICT, this is fixing only the spew of some error messages
> but the driver is still functional.

KERN_ERR messages trip log scanners and cause concern that the
kernel/hardware is not configured or working correctly. They also add a
little big of ongoing stress into kernel maintainer's lives, as we
prepare and test kernel updates, since they show up as red text in
journalctl output that we have to think about regularly. Multiple
KERN_ERR messages, 8 in this case, can also be considered a little worse
than a single error message.

I feel like this trivial fix is worth taking into stable rather than
suppressing these errors (mentally and in log scanners) for years.

Tyler

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
