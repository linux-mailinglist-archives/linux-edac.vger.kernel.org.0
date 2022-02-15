Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76D4B6C19
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiBOMef (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 07:34:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiBOMeb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 07:34:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC6F107DAF;
        Tue, 15 Feb 2022 04:34:21 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50B4D1EC047C;
        Tue, 15 Feb 2022 13:34:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644928455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lCbNnh9HCKpg3aL7PIsd0OZwD3X8Vj7X1aVtSzLSyls=;
        b=o8dPL5DVKZw2ahnzd/bFXaWTnc/KzdXK9d191bFEO4WbPw5NBggUWW0Q0vuQbbye/ZNlWP
        EWhBGk9GPLSD3XENcL/iWt4eFS5wT8J4QMMSKXsA4JCfhbgm3eTgRBgzZfY9qsiKwjgIKn
        w0v6wvmYFugw3EY5VQIqbwWkGVHzAKg=
Date:   Tue, 15 Feb 2022 13:34:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Farber, Eliav" <farbere@amazon.com>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 1/4] EDAC: Fix calculation of returned address and next
 offset in edac_align_ptr()
Message-ID: <YgudxpqAlyQ5UqlF@zn.tnic>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-2-farbere@amazon.com>
 <YfALFy7LGGIOS2Fv@zn.tnic>
 <9bd8f3c5-2281-8235-9eac-d2c371245a54@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bd8f3c5-2281-8235-9eac-d2c371245a54@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 27, 2022 at 11:58:58AM +0200, Farber, Eliav wrote:
> One of the fields in our private-data structure is 'struct notifier_block'
> which has a next field of type 'struct notifier_block __rcu *'.

Just to make sure I understand you correctly: you're talking about some
internal version of al_mc_edac - not what's upstream?

> The size of our private-data structure is greater than 8, and it comes after
> 'struct edac_mc_layer' which has a size that is not zero modulo eight, and
> also ends at an address that is not zero modulo eight.
> Because of the bug in edac_align_ptr(), our private-data structure which
> should have been aligned to 8 wasn't (it was aligned to 4), so
> notifier_block was also not aligned to 8, and finally next wasn't aligned
> to 8.

Ok, I think I see what's going on. So this:

8447c4d15e35 ("edac: Do alignment logic properly in edac_align_ptr()")

changed that remainder computation thing and it was supposed to do what
your patch does. Hell, even the commit message says so:

"The logic was checking the sizeof the structure being allocated to
determine whether an alignment fixup was required. This isn't right;
what we actually care about is the alignment of the actual pointer
that's about to be returned."

So if we really do care about the alignment of the actual pointer we're
about to return, then yes, we should check ptr - not p.

Lemme add that newly discovered info to your patch and queue it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
