Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8634B78BE
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 21:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbiBOQzX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 11:55:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiBOQzX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 11:55:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721BC117C80;
        Tue, 15 Feb 2022 08:55:12 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EBADA1EC0535;
        Tue, 15 Feb 2022 17:55:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644944107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=85FEUlBIu7c8gw8c7k99bQj9pHdSOqXZ6/sStTCcMr8=;
        b=j47rsTlv5hjzO1Nkmit+xbe+OARRqvueOA4vw2ObjxKLl9G3hWsA/V75a64FJWY+h6HeQ0
        tRJtp76UF+2FdvW1EZIGUOfhTiN2V/SqBrQH0IJ1+d9djKNnMvpwv2C7fuczr0+n5+p7H2
        QGzBCxmUbzJfYm5std+ESynQIDydzFQ=
Date:   Tue, 15 Feb 2022 17:55:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eliav Farber <farbere@amazon.com>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 3/4] EDAC: Refactor edac_align_ptr() to use
 u8/u16/u32/u64 data types
Message-ID: <Ygva6E2Xrurr8hkE@zn.tnic>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-4-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113100622.12783-4-farbere@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 13, 2022 at 10:06:21AM +0000, Eliav Farber wrote:
> Prefer well defined size variables, that are same in size across all
> systems.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/edac/edac_mc.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 8b9b86a7720a..3367bf997b73 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -250,18 +250,13 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
>  	 * 'size'.  Adjust 'p' so that its alignment is at least as
>  	 * stringent as what the compiler would provide for X and return
>  	 * the aligned result.
> -	 * Here we assume that the alignment of a "long long" is the most
> -	 * stringent alignment that the compiler will ever provide by default.
> -	 * As far as I know, this is a reasonable assumption.
>  	 */
> -	if (size > sizeof(long))
> -		align = sizeof(long long);
> -	else if (size > sizeof(int))
> -		align = sizeof(long);
> -	else if (size > sizeof(short))
> -		align = sizeof(int);
> -	else if (size > sizeof(char))
> -		align = sizeof(short);
> +	if (size > sizeof(u32))
> +		align = sizeof(u64);
> +	else if (size > sizeof(u16))
> +		align = sizeof(u32);
> +	else if (size > sizeof(u8))
> +		align = sizeof(u16);
>  	else
>  		return ptr;

This is just silly. I think you should simply align on 8 and kill all
that bla.

This whole pointer alignment, then picking out the actual pointers of
the embedded struct members is just a bunch of unneeded complexity. I'd
like to get rid of it completely one day...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
