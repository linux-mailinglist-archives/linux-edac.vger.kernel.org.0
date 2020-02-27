Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DC6172272
	for <lists+linux-edac@lfdr.de>; Thu, 27 Feb 2020 16:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgB0PoL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 27 Feb 2020 10:44:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46860 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbgB0PoL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 27 Feb 2020 10:44:11 -0500
Received: from zn.tnic (p200300EC2F0E0F009D97C1AC9E342137.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f00:9d97:c1ac:9e34:2137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1FF21EC0CDB;
        Thu, 27 Feb 2020 16:44:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582818249;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LevINb4patPPnz2zV7f1azNIu6xmQ62ZYofkI7mfbgI=;
        b=rEHJruPvNkluYhm19GFjRGyP3vfZ7Y5GRqyE20MNL1j+IG4bfq/LDIXTLJV9d/Xp6aNMnq
        EQ5sXqkNbo7INrFrcOp6JiH7s92yyHGfidIahtkBAESNIXhLqNsw/zz20mDj+/XQ67t+89
        AKy2DV56lHLroEJnrjZVo3TkKMjarn8=
Date:   Thu, 27 Feb 2020 16:44:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sherry Sun <sherry.sun@nxp.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     james.morse@arm.com, mchehab@kernel.org, tony.luck@intel.com,
        rrichter@marvell.com, michal.simek@xilinx.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
Subject: Re: [PATCH V2] EDAC: synopsys: Fix back to back snprintf() messages
 for CE/UE
Message-ID: <20200227154400.GA18629@zn.tnic>
References: <1582792452-32575-1-git-send-email-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1582792452-32575-1-git-send-email-sherry.sun@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Feb 27, 2020 at 04:34:12PM +0800, Sherry Sun wrote:
> The current way which call snprintf() function two or three times to
> output message for CE/UE is incorrect, because it won't output all the
> message needed, instead it will only output the last message in
> snprintf(). So the simplest and most effective way to fix this problem
> is combining all the snprintf() message needed for CE/UE into one
> snprintf() function.
> 
> Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
> Changes in V2:
> - Separated this patch from the original patchset.
> - Change the subject to be more concise and clear.
> 
> ---
>  drivers/edac/synopsys_edac.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 2d263382d797..880ffd833718 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -479,20 +479,14 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  		pinf = &p->ceinfo;
>  		if (!priv->p_data->quirks) {
>  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
> -				  "CE", pinf->row, pinf->bank, pinf->col);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "Bit Position: %d Data: 0x%08x\n",
> +				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
> +				 "CE", pinf->row, pinf->bank, pinf->col,
>  				 pinf->bitpos, pinf->data);
>  		} else {
>  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
> -				  "CE", pinf->row, pinf->bank, pinf->col);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "BankGroup Number %d Block Number %d ",
> -				 pinf->bankgrpnr, pinf->blknr);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "Bit Position: %d Data: 0x%08x\n",
> +				 "DDR ECC error type:%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> +				 "CE", pinf->row, pinf->bank, pinf->col,
> +				 pinf->bankgrpnr, pinf->blknr,
>  				 pinf->bitpos, pinf->data);
>  		}
>  
> @@ -509,10 +503,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  				"UE", pinf->row, pinf->bank, pinf->col);
>  		} else {
>  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> -				 "UE", pinf->row, pinf->bank, pinf->col);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "BankGroup Number %d Block Number %d",
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d BankGroup Number %d Block Number %d",
> +				 "UE", pinf->row, pinf->bank, pinf->col,
>  				 pinf->bankgrpnr, pinf->blknr);
>  		}
>  
> -- 

I'm wondering how Manish did not see this in testing? CCed.

Anyway, queueing for urgent.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
