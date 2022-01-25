Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F5649B69D
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jan 2022 15:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239021AbiAYOkF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Jan 2022 09:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388418AbiAYOhW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 25 Jan 2022 09:37:22 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395CAC061751;
        Tue, 25 Jan 2022 06:37:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37D821EC0304;
        Tue, 25 Jan 2022 15:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643121436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FmNennP2E1Srxpp/fcleOZgmfWGnml38KdonbDFAk9g=;
        b=EY5D4y8OnsmgsbSTWnFGOQ3FPGX5qVZzzYXSqqnGcAnVCeoU+QY5snRdZyUseMJPoVqQ+V
        TQV00VRxFTHqSTsGWYfdLn5zs73ZKvxsHv5zVprxoI0iSWuSB6j0oaVzlqmot4AmhD2bUV
        eDemfqtQpBw2PQ+5we9APSh7B0yQ0w4=
Date:   Tue, 25 Jan 2022 15:37:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eliav Farber <farbere@amazon.com>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 1/4] EDAC: Fix calculation of returned address and next
 offset in edac_align_ptr()
Message-ID: <YfALFy7LGGIOS2Fv@zn.tnic>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-2-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113100622.12783-2-farbere@amazon.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 13, 2022 at 10:06:19AM +0000, Eliav Farber wrote:
> Do alignment logic properly and use 'ptr' for calculating the remainder
> of the alignment.
> 
> This became an issue because 'struct edac_mc_layer' has a size that is
> not zero modulo eight, and the next offset that was prepared for the
> private-data was unaligned, causing an alignment exception.

How exactly did this "become an issue"?

I'm asking because I have been hearing about weird bugs with that
pointer alignment contraption and have never managed to reproduce them
myself or hear a proper explanation from people.

And that thing is an abomination, frankly, and I'd like to get rid of it
but maybe some other time...

So, please explain more verbosely, a specific example or how I could
reproduce it, would be even better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
