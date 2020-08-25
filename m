Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0979F251F1E
	for <lists+linux-edac@lfdr.de>; Tue, 25 Aug 2020 20:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHYSeX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Aug 2020 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHYSeI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Aug 2020 14:34:08 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12529C061755;
        Tue, 25 Aug 2020 11:34:08 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c5a00d84f58c2ae3e6e5d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:5a00:d84f:58c2:ae3e:6e5d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89BBB1EC02E6;
        Tue, 25 Aug 2020 20:34:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598380446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fN7vONgRqJo+r0b+uDy2CQWm74Dp86pCAjGMuhbiocM=;
        b=NBko5bZkTXSv/bmBQXlYSgBe6LFcnA2UbGexIL2FFNgTCuDFkXsTclzrqTHOnx3izvCE0P
        g5s7MAX56sJ9jMCPCouTzyP7rUXOWWn4GgCQ/CNiHoJTQ11GcTi6ScEJO3lTuWkdWW/Xye
        Wk79DNxtsnWl5yIB/n/yYToNx+nJh5g=
Date:   Tue, 25 Aug 2020 20:34:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Smita.KoralahalliChannabasappa@amd.com" 
        <Smita.KoralahalliChannabasappa@amd.com>
Subject: Re: [PATCH] x86/mce: Increase maximum number of banks to 64
Message-ID: <20200825183402.GG12107@zn.tnic>
References: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
 <20200820171518.GB17271@zn.tnic>
 <20200820180054.GA2033274@yaz-nikka.amd.com>
 <6ecac9c40d7b4491b9a87c8927a4aca6@intel.com>
 <20200824151105.GA3478291@yaz-nikka.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824151105.GA3478291@yaz-nikka.amd.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Aug 24, 2020 at 10:11:05AM -0500, Yazen Ghannam wrote:
> Thanks. Yeah, they're identical:
>    text    data     bss     dec     hex filename
>    15710076        13519306        5398528 34627910        2106146   vmlinux-32banks
>    15710076        13519306        5398528 34627910        2106146   vmlinux-64banks

So I went crazy here and built allmodconfigs for hypothetical CPUs which
support up to 4K MCA banks:

   text    data     bss     dec     hex filename
24618040        27211906        35409988        87239934        5332cfe vmlinux-32banks
24618040        27211906        35409988        87239934        5332cfe vmlinux-64banks
24618040        27211906        35409988        87239934        5332cfe vmlinux-128banks

For the first three - up to 128 banks, the sizes don't change.

24618000        27216002        35401796        87235798        5331cd6 vmlinux-256banks

Somewhere after 128 banks, it grows the data section but by exactly 4K,
i.e., one more page:

27216002 - 27211906 = 4096

The last page is not full, of course.

27216002 % 4096 = 2178
27211906 % 4096 = 2178

24618000        27220098        35401796        87239894        5332cd6 vmlinux-512banks

The same happens here.

27220098 - 27216002 = 4096
27220098 % 4096 = 2178

And so on:

24618000        27228290        35393604        87239894        5332cd6 vmlinux-1024banks
24618000        27244674        35377220        87239894        5332cd6 vmlinux-2048banks
24618000        27277442        35344452        87239894        5332cd6 vmlinux-4Kbanks

So what I think happens is, the first 128 banks fit within the same
.data section page thus vmlinux doesn't increase.

I guess there might be a .config which could cause that data increase
when the 32->64 banks move won't fit in the last .data page. It depends
on where those ~2K you computed and I snipped, land.

But since most kernels are allmodconfig builds, I guess we should be
fine.

So yeah, I guess we can take this one after you summarize the findings
of this thread in v2's commit message. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
