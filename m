Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50DF2F2B2A
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 10:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390668AbhALJVb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 04:21:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390543AbhALJVb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 04:21:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AEE3A22DFB;
        Tue, 12 Jan 2021 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610443250;
        bh=AvDm3A0NwcBh8DpeHDJMysSFcCODqWM8mWVyrY9bvlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mokqjJx0zhVyqNLZaWiHL4Of+xS1j4KU5dL2TfshyVqjH980lIMXG19Yw6Ra021tV
         rAxTSpLX9Lh47bXxzjFZV9dH9er33YCd//tKv7EXy1jnqg2IDWB+UEkMsMvx/oqLC/
         zgao6yKTrsLJRg1b8LjgAUgRM3zODCbFqXSJsDA3lAe9Ww/Tl03MamZD/I+UZu/IDR
         EyjcZBN6QKsNqlg8r8vD433hCwoIEmYjn7pWGywwQb96ou03t5O0RiwxtyA79pH9T9
         15t5D3p49STYo3RAZUtNgiJXsTM8geOOutBKOGbqfHNmeMASp+dIxIAUEr+0RXVgJk
         A4NuVM265MXug==
Date:   Tue, 12 Jan 2021 10:20:45 +0100
From:   Robert Richter <rric@kernel.org>
To:     menglong8.dong@gmail.com
Cc:     khuong@os.amperecomputing.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: Re: [PATCH] edac: remove redundant error print in xgene_edac_probe
Message-ID: <X/1p7RgQQ+a+ndqZ@rric.localdomain>
References: <20210112084605.7110-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112084605.7110-1-dong.menglong@zte.com.cn>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 12.01.21 00:46:05, menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Coccinelle reports a redundant error print in xgene_edac_probe.
> As 'platform_get_irq' already prints the error message, error
> print here is redundant and can be removed.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> ---
>  drivers/edac/xgene_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index 1d2c27a00a4a..1d583f0ea4dc 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -1918,7 +1918,6 @@ static int xgene_edac_probe(struct platform_device *pdev)
>  		for (i = 0; i < 3; i++) {
>  			irq = platform_get_irq(pdev, i);
>  			if (irq < 0) {
> -				dev_err(&pdev->dev, "No IRQ resource\n");

Better call platform_get_irq_optional() instead. That would keep the
same error message patterns for all error paths of the probe function.

-Robert

>  				rc = -EINVAL;
>  				goto out_err;
>  			}
> -- 
> 2.17.1
> 
