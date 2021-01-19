Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB792FB9D8
	for <lists+linux-edac@lfdr.de>; Tue, 19 Jan 2021 15:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbhASOhZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Jan 2021 09:37:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54008 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387543AbhASJc5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Jan 2021 04:32:57 -0500
Received: from zn.tnic (p200300ec2f0bca00060d4a1f80a80a6a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:60d:4a1f:80a8:a6a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4540A1EC059F;
        Tue, 19 Jan 2021 10:32:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611048725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=C4TkBqWq+vmw2+Loapcennvk02Pn9BQkzA2VOF0MEKQ=;
        b=sdcQagCDDbS4it4pL1Ib0a7pFn0CoPoQ/cNA772sxWYSWQ5ZR8rQevIbExxTfPhipNZvUn
        xvUNdg4hVMasvItADKQbCmYRXbRhRys5XOjLqlQOqhOsmIb/RWPTqh7iYSc4sDjviQZZMH
        A08hnAL8E9T3L0PtZE6f7VUcW+b5PuI=
Date:   Tue, 19 Jan 2021 10:32:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     menglong8.dong@gmail.com
Cc:     rric@kernel.org, khuong@os.amperecomputing.com, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH v2] edac: remove redundant error print in xgene_edac_probe
Message-ID: <20210119093200.GB27433@zn.tnic>
References: <20210112103540.7818-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112103540.7818-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 02:35:40AM -0800, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Coccinelle reports a redundant error print in xgene_edac_probe.
> As 'platform_get_irq' already prints the error message, error
> print here is redundant.
> 
> Fix it by using 'platform_get_irq_optional' in place of
> 'platform_get_irq', as Robert suggested.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
> v2:
> - use 'platform_get_irq_optional' instead of 'platform_get_irq'
> ---
>  drivers/edac/xgene_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index 1d2c27a00a4a..2ccd1db5e98f 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -1916,7 +1916,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
>  		int i;
>  
>  		for (i = 0; i < 3; i++) {
> -			irq = platform_get_irq(pdev, i);
> +			irq = platform_get_irq_optional(pdev, i);
>  			if (irq < 0) {
>  				dev_err(&pdev->dev, "No IRQ resource\n");
>  				rc = -EINVAL;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
