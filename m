Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B86042D690
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJNJ6N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 14 Oct 2021 05:58:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55592 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230199AbhJNJ6L (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 14 Oct 2021 05:58:11 -0400
Received: from zn.tnic (p200300ec2f0c7200b0e4a365e78c79f0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:7200:b0e4:a365:e78c:79f0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AA11E1EC047E;
        Thu, 14 Oct 2021 11:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634205365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sHLsxf9M5MPo/+/8DZe1zU1q55XpB0h23T1Q3btydec=;
        b=Fx0q3HQ8RHsk21xu1sFLMb/dxdKu/cl9qYuvjjMBGyFOFgWQLwHMAKjupb4WTNi5ilBvoz
        Q+kc52DN8lkpsyk2MHu12yhdRkzN5eJA6a9UHANFV66sXkd4DOFAFZ84SL5xKzGUhphAuH
        bDmC5+xQwaNIXva2X/i+HXtZZovbyAg=
Date:   Thu, 14 Oct 2021 11:56:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hans Potsch <hans.potsch@nokia.com>
Cc:     jlu@pengutronix.de, linux-edac@vger.kernel.org,
        harald.glock@nokia.com
Subject: Re: [PATCH] EDAC/armada-xp: Fix output of uncorrectable error counter
Message-ID: <YWf+tClabicEVQ4d@zn.tnic>
References: <AM8PR07MB81725DB8E29F93C960A0B1C8FEB09@AM8PR07MB8172.eurprd07.prod.outlook.com>
 <20211006121332.58788-1-hans.potsch@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211006121332.58788-1-hans.potsch@nokia.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 06, 2021 at 02:13:32PM +0200, Hans Potsch wrote:
> Incorrect parameter is passed to the edac_mc_handle_error() function.
> Therefore number of correctable errors is displayed as uncorrectable
> errors. Changed to correct parameter.
> 
> Signed-off-by: Hans Potsch <hans.potsch@nokia.com>
> ---
>  drivers/edac/armada_xp_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
> index e3e757513d1b..b1f46a974b9e 100644
> --- a/drivers/edac/armada_xp_edac.c
> +++ b/drivers/edac/armada_xp_edac.c
> @@ -178,7 +178,7 @@ static void axp_mc_check(struct mem_ctl_info *mci)
>  				     "details unavailable (multiple errors)");
>  	if (cnt_dbe)
>  		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> -				     cnt_sbe, /* error count */
> +				     cnt_dbe, /* error count */
>  				     0, 0, 0, /* pfn, offset, syndrome */
>  				     -1, -1, -1, /* top, mid, low layer */
>  				     mci->ctl_name,
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
