Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9317068A
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgBZRtc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Feb 2020 12:49:32 -0500
Received: from foss.arm.com ([217.140.110.172]:39834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbgBZRtb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Feb 2020 12:49:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 475F130E;
        Wed, 26 Feb 2020 09:49:31 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFC373F881;
        Wed, 26 Feb 2020 09:49:29 -0800 (PST)
Subject: Re: [PATCH 2/3] EDAC: synopsys: Reorganizing the output message for
 CE/UE
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        rrichter@marvell.com, michal.simek@xilinx.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
References: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
 <1582537357-10339-3-git-send-email-sherry.sun@nxp.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <39c63f4c-2e39-4478-1de1-b0b564a7f4e1@arm.com>
Date:   Wed, 26 Feb 2020 17:49:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582537357-10339-3-git-send-email-sherry.sun@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sherry,

On 24/02/2020 09:42, Sherry Sun wrote:
> The origin way which call sprintf() function two or three times to

(original? 'The current way' may be better)


> output message for CE/UE is incorrect, because it won't output all the
> message needed, instead it will only output the last message in
> sprintf().

Nice!


> So the simplest and most effective way to fix this problem
> is reorganizing all the output message needed for CE/UE into one
> sprintf() function.

This is a bug, but its in the middle of a series doing some cleanup, meaning the
maintainer can't easily pick it up in isolation. Could you post it separately?

'Reorganize' in the subject makes this sound like cleanup. Would "EDAC: synopsys: Fix back
to back snprintf() messages for CE/UE" be better?


Please add:
Fixes: b500b4a029d57 ("EDAC, synopsys: Add ECC support for ZynqMP DDR controller")

in the signed-off-by area so that stable trees pick this up.

and for what its worth:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks!

James



> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 7046b8929522..ef7e907c7956 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -485,20 +485,14 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
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
> -				 "DDR ECC error type:%s Row %d Bank %d ",
> -				  "CE", pinf->row, pinf->bank);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "BankGroup Number %d Block Number %d ",
> -				 pinf->bankgrpnr, pinf->blknr);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "Bit Position: %d Data: 0x%08x\n",
> +				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
> +				 "CE", pinf->row, pinf->bank,
> +				 pinf->bankgrpnr, pinf->blknr,
>  				 pinf->bitpos, pinf->data);
>  		}
>  
> @@ -515,10 +509,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
>  				"UE", pinf->row, pinf->bank, pinf->col);
>  		} else {
>  			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "DDR ECC error type :%s Row %d Bank %d ",
> -				 "UE", pinf->row, pinf->bank);
> -			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -				 "BankGroup Number %d Block Number %d",
> +				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
> +				 "UE", pinf->row, pinf->bank,
>  				 pinf->bankgrpnr, pinf->blknr);
>  		}
>  
> 

