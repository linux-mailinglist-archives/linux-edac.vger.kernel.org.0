Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC91813816A
	for <lists+linux-edac@lfdr.de>; Sat, 11 Jan 2020 14:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgAKNRx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 11 Jan 2020 08:17:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54812 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgAKNRw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 11 Jan 2020 08:17:52 -0500
Received: from zn.tnic (p200300EC2F1E140059EC870F21D98201.dip0.t-ipconnect.de [IPv6:2003:ec:2f1e:1400:59ec:870f:21d9:8201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63A801EC085F;
        Sat, 11 Jan 2020 14:17:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578748671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cL/qt2mO3HDc5ZV1IIYpqPif5FcLQqmGpbntiAxlo2s=;
        b=pFLTkCMGIYbC+kyfnU7Hlx4UfGj0TRfPYkL2psiEEEgrliU6UuJmMnAcI/+zPCM78D47BY
        MtroX5YBKjnnzgPganINGUEs2/ObrJQDCjvrQEHiU4TQs/An1f1g3RRjIfgE8QYTAjLXZb
        VeYTl3zt69A0rx5CpUsGTeHO0Pbpawc=
Date:   Sat, 11 Jan 2020 14:17:44 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 1/6] x86/mce: Take action on UCNA/Deferred errors again
Message-ID: <20200111131744.GC23583@zn.tnic>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-2-jschoenh@amazon.de>
 <20200110095004.GD19453@zn.tnic>
 <20200110184533.GB20511@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200110184533.GB20511@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 10, 2020 at 10:45:33AM -0800, Luck, Tony wrote:
> I totally agree that counting notifiers is clumsy. Also less than
> ideal is the concept that any notifier on the chain can declare:
>   "I fixed it"
> and prevent any other notifiers from even seeing it. Well the concept
> is good, but it is overused.

But why can't we use it?

Don't get me wrong: I'm simply following my KISS approach to do the
simplest scheme required. So, do you see a use case where the whole
error handling chain would need more sophisticated handling?

> I think we may do better with a field in the "struct mce" that is being
> passed to each where notifiers can wiggle some bits (semantics to be
> defined later) which can tell subsequent notifiers what sort of actions
> have been taken.
> E.g. the SRAO/UCNA notifier can say "I took this page offline"
> the dev_mcelog one can say "I think I handed to a process that has /dev/mcelog open"
> EDAC drivers can say "I decoded the address and printed something"
> CEC can say: "I silently counted this corrected error", or "error exceeded
> threshold and I took the page offline".
> 
> The default notifier can print to console if nobody set a bit to say
> that the error had been somehow logged.

That idea is good and I'll gladly take patches for it so if you wanna do
it...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
