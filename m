Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14F96951C5
	for <lists+linux-edac@lfdr.de>; Mon, 13 Feb 2023 21:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjBMUXz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Feb 2023 15:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBMUXy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Feb 2023 15:23:54 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED07C7;
        Mon, 13 Feb 2023 12:23:53 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 838D51EC085F;
        Mon, 13 Feb 2023 21:23:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676319832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ypnjjDOlMKByHgBsDifeVXqH+dpUSWT2PgTiP8mY28M=;
        b=BdQq8my2qWo+RBmR+VNG7M84d0yrDFOs/29uvzeFwDaPP5+qcs/bt9HLH9J3+h6M4U4A9N
        MaSg9jKN6SvYu9O0uATtA93kfd2UaP11FWh5qnmMy6SHuxAfWxYxaKkt6VJ24tRtiLAh9o
        7rAtKYL4BTgb3hHgnn5l64sDEvJ6aYs=
Date:   Mon, 13 Feb 2023 21:23:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     Tom Rix <trix@redhat.com>, Nathan Chancellor <nathan@kernel.org>,
        tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: remove unneeded call to
 reserve_mc_sibling_devs()
Message-ID: <Y+qcU2M5gchfzbky@zn.tnic>
References: <20230213191510.2237360-1-trix@redhat.com>
 <Y+qZthCMRL1m0p4B@yaz-fattaah>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+qZthCMRL1m0p4B@yaz-fattaah>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 13, 2023 at 08:12:38PM +0000, Yazen Ghannam wrote:
> These errors are encountered when extra warnings are enabled, correct?

It says so in the warning which one it is: -Werror,-Wsometimes-uninitialized

Don't know if we enable that one for clang with W= or Nathan adds
additional switches.

> I think the following patch would resolve this issue. This is part of a set
> that isn't fully applied.
> https://lore.kernel.org/linux-edac/20230127170419.1824692-12-yazen.ghannam@amd.com/
> 
> Boris,
> Do you think one of these patches should be applied or just hold off until the
> entire original set is applied?

I still wanted to go through the rest but I'm not sure I'll have time
for it before the merge window. So unless this is breaking some silly
testing scenario, I'd say I'll leave things as they are.

Once I take yours, that silly false positive will go away and we can
forget about it.

> As for myself, I'll start including builds with extra warnings enabled
> for each patch in my workflow. Currently I do a regular build for each
> patch and a build with extra warnings for the entire set.

Dunno, I'd say with false positives we have bigger fish to fry...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
