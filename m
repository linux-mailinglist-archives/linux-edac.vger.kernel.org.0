Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 518DB12FE8E
	for <lists+linux-edac@lfdr.de>; Fri,  3 Jan 2020 23:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgACWDh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 3 Jan 2020 17:03:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55506 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbgACWDh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 3 Jan 2020 17:03:37 -0500
Received: from zn.tnic (p200300EC2F00E700329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:e700:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7E2A71EC0A0E;
        Fri,  3 Jan 2020 23:03:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1578089015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPtBabqcLpHUTGg04+kMuWfsg7YS1k6qADzdYM5fMXk=;
        b=NZiv/ZNoDXRqTzjbEFde8fnUF2p1Vn55pp/Oaol93N07geQXRysUTF0ie0QHKBnXsWxiGe
        fV0eYC4W7khjYVKpMKeT8CRdeVb6PvARplduZpD5GLsbKxWbWzAwBTmEgOVd7ke84KYxK2
        QzBLNlIsfgiSCXy4sM9tW+JA4Mh4SDE=
Date:   Fri, 3 Jan 2020 23:03:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan =?utf-8?Q?H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 6/6] x86/mce: Dynamically register default MCE handler
Message-ID: <20200103220328.GF5099@zn.tnic>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-7-jschoenh@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103150722.20313-7-jschoenh@amazon.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 03, 2020 at 04:07:22PM +0100, Jan H. Schönherr wrote:
> On the other hand, I'm starting to question the whole logic to "only print
> the MCE if nothing else in the kernel has a handler registered". Is that
> really how it should be?

Yes, it should be this way: if there are no consumers, all error
information should go to dmesg so that it gets printed at least.

> For example, there are handlers that filter for a specific subset of
> MCEs. If one of those is registered, we're losing all information for
> MCEs that don't match.

Probably but I don't think there's an example of an actual system where
there are no other MCE consumers registered. Not if its users care about
RAS. This default fallback was added for the hypothetical case anyway.

> A possible solution to the latter would be to have a "handled" or "printed"
> flag within "struct mce" and print the MCE based on that in the default
> handler. What do you think?

Before we go and fix whatever, we need to define what exactly we're
fixing. Is there an actual system you're seeing this on or is this
something that would never happen in reality? Because if the latter, I
don't really care TBH. As in, there's more important stuff to take care
of first.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
