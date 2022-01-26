Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225E349D1FB
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiAZSqL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 13:46:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiAZSqL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 13:46:11 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD05C06161C;
        Wed, 26 Jan 2022 10:46:10 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87EA81EC053F;
        Wed, 26 Jan 2022 19:46:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643222765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QHoPLG69qOcnOcG4+SmdqeMupwE5W4oefihpmsVWEe0=;
        b=QjOpLqwwBSEX6kR47KO5PFM9UoiaXg6rJ4xLP4Rxn/TvxRQA1BH+pNg0aEwMwzfHx5J/YH
        8kFhg3p99sJSpxB//vsXL1yOpHWtFv/KXFWRGrokzuijMSBBi6exT/1nVXiudEEVymTgo1
        nk66aHb4AmX3hIfGdrpIEZppGIk/yAY=
Date:   Wed, 26 Jan 2022 19:46:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eliav Farber <farbere@amazon.com>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 2/4] EDAC: Remove unnecessary cast to char* in
 edac_align_ptr() function
Message-ID: <YfGW6n59lDRiS3di@zn.tnic>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-3-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113100622.12783-3-farbere@amazon.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 13, 2022 at 10:06:20AM +0000, Eliav Farber wrote:
> Amend commit 7391c6dcab30 ("drivers/edac: mod edac_align_ptr function")
> and change all return path to use void* instead of char* according
> to the new signature.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
>  drivers/edac/edac_mc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 61d72bd96754..8b9b86a7720a 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -263,12 +263,12 @@ void *edac_align_ptr(void **p, unsigned size, int n_elems)
>  	else if (size > sizeof(char))
>  		align = sizeof(short);
>  	else
> -		return (char *)ptr;
> +		return ptr;
>  
>  	r = (unsigned long)ptr % align;
>  
>  	if (r == 0)
> -		return (char *)ptr;
> +		return ptr;
>  
>  	*p += align - r;
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
