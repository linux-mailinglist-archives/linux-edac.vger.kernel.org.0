Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767FF613B97
	for <lists+linux-edac@lfdr.de>; Mon, 31 Oct 2022 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJaQow (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Oct 2022 12:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJaQov (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 Oct 2022 12:44:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B843360FE;
        Mon, 31 Oct 2022 09:44:50 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7cf329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7cf:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1EEB11EC0391;
        Mon, 31 Oct 2022 17:44:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667234689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7wmDNEFHKG8uskSGWw9dqDy6mNpU/vVuiAiPzGtPboU=;
        b=asD9pX3Sgpb3MLnzSUrkDc/6lAJV+QTraPR1tqM0PYv4SA9+8SJRljINApDH0E0j6aspdE
        chqiXFe3OQC39AcC0cZ+rAIdhYTfElIucRifTon61REBj3Y4GVh7k5bw8UpitlBMrGNSs5
        sLhicnh8O+nL0r5ZgHqmCeRqGQQ9qc0=
Date:   Mon, 31 Oct 2022 17:44:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/mce: Dump the stack for recoverable machine
 checks in kernel context
Message-ID: <Y1/7ewEgVZ56KlJp@zn.tnic>
References: <20220922195136.54575-1-tony.luck@intel.com>
 <20220922195136.54575-3-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922195136.54575-3-tony.luck@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 22, 2022 at 12:51:36PM -0700, Tony Luck wrote:
> @@ -254,6 +255,9 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>  			wait_for_panic();
>  		barrier();
>  
> +		if (final->severity == MCE_PANIC_STACKDUMP_SEVERITY)
> +			show_stack(NULL, NULL, KERN_DEFAULT);

So this is kinda weird, IMO:

1. If the error has raised a MCE, then we will dump stack anyway.

2. If the error is the result of consuming poison or some other deferred
type which doesn't raise an exception immediately, then we have missed
it because we don't have the stack at the time the error got detected by
the hardware.

3. If all you wanna do is avoid useless stack traces, you can simply
ignore them. :)

IOW, it will dump stack in the cases we're interested in and it will
dump stack in a couple of other PANIC cases. So? We simply ignore the
latter.

But I don't see the point of adding code just so that we can suppress
the uninteresting ones...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
