Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F803611499
	for <lists+linux-edac@lfdr.de>; Fri, 28 Oct 2022 16:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ1ObO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Oct 2022 10:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiJ1ObN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Oct 2022 10:31:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158CB194233;
        Fri, 28 Oct 2022 07:31:13 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e7ce329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e7ce:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2BF21EC026E;
        Fri, 28 Oct 2022 16:31:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666967471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XRoCyNRuJ43vkRm4DOj6nGnh/K/4b+27L1YT+luEkEo=;
        b=ZPcppmyi/j3XBzUPjiDK2yC13+JTKvFuz6ZSVq4lFMoT3qP0mx1v6ODzwA4Bicfki/Q4kC
        Tnqc3YAJfdwnMhc4fSwc5rn64488Zwvy0YkkahvphJz9Dr19A6uHNtmlqadIsTS2AV6QCS
        WNPpDYyRX4Sy7v7rb3BxxBTvisiTsV4=
Date:   Fri, 28 Oct 2022 16:31:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Make Mauro reviewer
Message-ID: <Y1vnr11yG5b0nyA8@zn.tnic>
References: <20220926180343.23346-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220926180343.23346-1-bp@alien8.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 26, 2022 at 08:03:43PM +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Mauro hasn't really been maintaining EDAC for a long while now. Make him
> a reviewer instead.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9d7f64dc0efe..935b42c7f52f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7314,9 +7314,9 @@ F:	drivers/edac/thunderx_edac*
>  
>  EDAC-CORE
>  M:	Borislav Petkov <bp@alien8.de>
> -M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  M:	Tony Luck <tony.luck@intel.com>
>  R:	James Morse <james.morse@arm.com>
> +R:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  R:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
> -- 

Queued.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
