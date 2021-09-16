Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995DD40D693
	for <lists+linux-edac@lfdr.de>; Thu, 16 Sep 2021 11:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbhIPJtV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Sep 2021 05:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhIPJtU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 16 Sep 2021 05:49:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0019CC061574
        for <linux-edac@vger.kernel.org>; Thu, 16 Sep 2021 02:47:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f11c600b77f9e345fbfb487.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:c600:b77f:9e34:5fbf:b487])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A9C1EC02DD;
        Thu, 16 Sep 2021 11:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631785674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hOOP7cyJJdufYBs6Ml4jmD1a5MjrNNfFRNS7LbCvVYU=;
        b=AHRRrI4zjeUGikwxq728PwH9tbpdKZc8j5F+hDI5jOI+dV77TzOtAzlaVaRKo3+pnFvaYF
        cT4XMQaXvfCQ6WcnfGQD9c7jHAKxDMgQB5yrlWsXmWNmJLAn7ufzSA7pGhEI8hH7KHCaiY
        jEk2mS3rMHl/z5SlXJdyTqtzhrnqyUg=
Date:   Thu, 16 Sep 2021 11:47:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org,
        michal.simek@xilinx.com, git@xilinx.com
Subject: Re: [PATCH 2/2] edac: synopsys: Fix the issue in reporting of the
 error count
Message-ID: <YUMSxK0rWEGRxR/4@zn.tnic>
References: <20210818072315.15149-1-shubhrajyoti.datta@xilinx.com>
 <20210818072315.15149-2-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818072315.15149-2-shubhrajyoti.datta@xilinx.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Aug 18, 2021 at 12:53:15PM +0530, Shubhrajyoti Datta wrote:
> Currently we are reading the error count from status register which

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

> is not correct, this patch fixes the issue by reading the count from

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> error count register(ERRCNT). Currently we are not reporting the
> errors cumulatively.
> Also send the cumulative errors to the edac_mc_handle_error.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7d08627e738b..38c03bdc2393 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -163,6 +163,11 @@
>  #define ECC_STAT_CECNT_SHIFT		8
>  #define ECC_STAT_BITNUM_MASK		0x7F
>  
> +/* ECC error count register definitions */
> +#define ECC_ERRCNT_UECNT_MASK		0xFFFF0000
> +#define ECC_ERRCNT_UECNT_SHIFT		16
> +#define ECC_ERRCNT_CECNT_MASK		0xFFFF
> +
>  /* DDR QOS Interrupt register definitions */
>  #define DDR_QOS_IRQ_STAT_OFST		0x20200
>  #define DDR_QOSUE_MASK			0x4
> @@ -418,14 +423,16 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
>  	base = priv->baseaddr;
>  	p = &priv->stat;
>  
> +	regval = readl(base + ECC_ERRCNT_OFST);
> +	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
> +	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
> +	if (!p->ce_cnt)
> +		goto ue_err;
> +
>  	regval = readl(base + ECC_STAT_OFST);
>  	if (!regval)
>  		return 1;
>  
> -	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
> -	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
> -	if (!p->ce_cnt)
> -		goto ue_err;
>  
>  	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
>  

That change looks correct.

> @@ -491,7 +498,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  		}
>  
>  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> -				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
> +				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
>  				     priv->message, "");
>  	}
>  
> @@ -509,7 +516,7 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  		}
>  
>  		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> -				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
> +				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
>  				     priv->message, "");
>  	}
>  

That one doesn't. AFIACT, handle_error() is supposed to deal with the
current errors logged which ->get_error_info() has done by putting the
counts into priv->stat which gets passed in.

The cumilative errors are dumped a little bit further down - grep for
"Total error count". Those are debug statements, though.

Also, edac_mc_handle_error() gets the *current* error counts which got
logged by the current ECC interrupt - not the cumulative!

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
