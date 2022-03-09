Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074F54D38F4
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 19:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiCISic (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiCISib (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 13:38:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36727A;
        Wed,  9 Mar 2022 10:37:31 -0800 (PST)
Received: from zn.tnic (p200300ea971938593bb3add11194ca93.dip0.t-ipconnect.de [IPv6:2003:ea:9719:3859:3bb3:add1:1194:ca93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D70D1EC0432;
        Wed,  9 Mar 2022 19:37:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1646851046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NbclMBw5QgYO4EIbhlHNLwEU/FaXIJ/dtETOluRZQ/M=;
        b=gqNRnZWWGiT4Cf+H0DruhMlPYfLR35Jsxy0TL4mC84aSeoG5fDpmSFUiZAkMJ+wmB8PXN2
        FuCgUJa4Cx6hkh9LApMb7gniYNGbzOzoz0d8/12NOvQ6GgZ/v8uzTHULSfXVgc79GkPui1
        3d2VxB1S9LTTkmpL+pxkSVVxJrQ0emA=
Date:   Wed, 9 Mar 2022 19:37:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, yazen.ghannam@amd.com,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        bilbao@vt.edu
Subject: Re: [PATCH] x86/mce: Cover grading of AMD machine error checks
Message-ID: <Yijz7dA1U0AMcYPZ@zn.tnic>
References: <20220309174107.6113-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309174107.6113-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Definitely a step in the right direction.

Now...

On Wed, Mar 09, 2022 at 11:41:07AM -0600, Carlos Bilbao wrote:
> AMD's severity grading covers very few machine errors. In the graded cases
> there are no user-readable messages, complicating debugging of critical
> hardware errors.

That's too generic. What is the actual use case here you're spending all
this time for?

> Fix the above issues extending the current grading logic for AMD with cases
> not previously considered and their corresponding messages.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  arch/x86/include/asm/mce.h         |   6 +
>  arch/x86/kernel/cpu/mce/severity.c | 232 +++++++++++++++++++++++++----
>  2 files changed, 205 insertions(+), 33 deletions(-)

Now, looking at the whole thing, AFAICT all you're interested in is
getting some strings out from those error types. But but, we already
have something like that. That's even mentioned in the patch:

> +	 * Default return values. The poll handler catches these and passes
> +	 * responsibility of decoding them to EDAC

So there's a big fat module mce_amd.c which does convert MCEs to
strings. So why can't that be used and extended instead of adding more
strings to more places in the kernel?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
