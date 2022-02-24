Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E574C2F28
	for <lists+linux-edac@lfdr.de>; Thu, 24 Feb 2022 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiBXPOi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 24 Feb 2022 10:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbiBXPOh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 24 Feb 2022 10:14:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5243E20A950;
        Thu, 24 Feb 2022 07:14:07 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D63B71EC0528;
        Thu, 24 Feb 2022 16:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1645715642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nSq5oYXo1UEvyHJYxYxFKGBXBtBsPoV2+wY1jf02ac4=;
        b=h/WDBZg1kLW1wZiyrreLLv3am4Xhxws3c3qT9/EYQmDXy5LN0d09fkrZKnTJ3rl/KzXr1Z
        9YkaCUAgmGjFiEY6Bs5yDLCoz5N0/JK33pvK9ZtbAYKtq/ntgVJ83Aoi6k9idFe/hZ6BnT
        DSn6dEBIPL95eNvLo3Y588IpplhemCk=
Date:   Thu, 24 Feb 2022 16:14:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 1/2] x86/mce: Remove old CMCI storm mitigation code
Message-ID: <YhegvWKq913TEd0M@zn.tnic>
References: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220217141609.119453-2-Smita.KoralahalliChannabasappa@amd.com>
 <Yg6FqR2cMZDwdBdi@agluck-desk3.sc.intel.com>
 <Yg6HeKIn0FCRDk22@agluck-desk3.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yg6HeKIn0FCRDk22@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 17, 2022 at 09:35:52AM -0800, Luck, Tony wrote:
> When a "storm" of CMCI is detected this code mitigates by
> disabling CMCI interrupt signalling from all of the banks
> owned by the CPU that saw the storm.
> 
> There are problems with this approach:
> 
> 1) It is very coarse grained. In all liklihood only one of the

Unknown word [liklihood] in commit message.
Suggestions: ['likelihood', 'livelihood']

> banks was geenrating the interrupts, but CMCI is disabled for all.

Unknown word [geenrating] in commit message.
Suggestions: ['generating', 'penetrating', 'germinating', 'entreating', 'ingratiating']

Do I need to give you the whole spiel about using a spellchecker?

:)

> This means Linux may delay seeing and processing errors logged
> from other banks.
> 
> 2) Although CMCI stands for Corrected Machine Check Interrupt, it
> is also used to signal when an uncorrected error is logged. This
> is a problem because these errors should be handled in a timely
> manner.
> 
> Delete all this code in preparation for a finer grained solution.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c     |  20 +---
>  arch/x86/kernel/cpu/mce/intel.c    | 145 -----------------------------
>  arch/x86/kernel/cpu/mce/internal.h |   6 --
>  3 files changed, 1 insertion(+), 170 deletions(-)

Yah, can't complain about diffstats like that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
