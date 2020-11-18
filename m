Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34EB2B83F3
	for <lists+linux-edac@lfdr.de>; Wed, 18 Nov 2020 19:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgKRShG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Nov 2020 13:37:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41792 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgKRShG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Nov 2020 13:37:06 -0500
Received: from zn.tnic (p200300ec2f0caf00cee835374c0b640d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:cee8:3537:4c0b:640d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D18821EC03CE;
        Wed, 18 Nov 2020 19:37:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605724624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Tv6NfihzUKUgm3a3PkS8PszKx5lZ5ynU2L5TjKaof78=;
        b=C2dt4rX/WiY8snqH+g+6DYyesgB7uIf3/dbtiTxX4wpVGn2zL2Q+kJaySkfJ6S+0WsGlxV
        cgECDyqGXiEzXUUHyNi5JuGzHRzAZapXK/6D6Zg4SR2C9nvW+FYIOp7mq0qaFOiPFNxtRC
        NoO7W5KVxywMNDuJvfOWtvG9IOsJ1Y0=
Date:   Wed, 18 Nov 2020 19:36:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Cc:     michal.simek@xilinx.com, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH] EDAC/synopsys: Fix wrong return value of mc_probe()
Message-ID: <20201118183658.GM7472@zn.tnic>
References: <20201116135810.3130845-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201116135810.3130845-1-zhangxiaoxu5@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Nov 16, 2020 at 08:58:10AM -0500, Zhang Xiaoxu wrote:
> If create the inject sysfs file failed, we should return
> the error, rather than 0. Otherwise, there maybe error
> pointer access.
> 
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> ---
>  drivers/edac/synopsys_edac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 12211dc040e8..7e7146b22c16 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -1344,7 +1344,8 @@ static int mc_probe(struct platform_device *pdev)
>  
>  #ifdef CONFIG_EDAC_DEBUG
>  	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
> -		if (edac_create_sysfs_attributes(mci)) {
> +		rc = edac_create_sysfs_attributes(mci);
> +		if (rc) {
>  			edac_printk(KERN_ERR, EDAC_MC,
>  					"Failed to create sysfs entries\n");
>  			goto free_edac_mc;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
