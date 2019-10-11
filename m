Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18C2D3DF6
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfJKLIh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:08:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46370 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbfJKLIh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 07:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JdlAz1c3xJbnUsZPJsKSq2/6IjokW6klgJgxwldSumo=; b=ZMm1uq20dA+f7muVhKSi1QI8r
        sGYMElo+fFm4UkXJAWslhL028hc1eFwlPh+1Fn0r0xYkQKvCmvfvzKBRlNbn657HkVi5bLLU7nA4u
        nyHlbJD0vGjYv/XMJcoRgyDYj9o40xYnCOF//0TCFeiTJ5+5vNyftmKRS/STyjCx7T/8E6a8nz7pS
        23k3PtE/Wz2gKeQSr8ujQJa6AE5CyP0JDY8sxuP2mDH0ScnjKyvMph8PenSF00i6uv3ao2iSxoISr
        ztWS50p7Ervy2GX+O8/hA8l/SQiApVu2BUDld7d8+LArR0mvlE0lGbsm9UUzz3Hw3VWOinPRwvUIT
        OrOrfGX0A==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsmc-0001Ol-Ab; Fri, 11 Oct 2019 11:08:30 +0000
Date:   Fri, 11 Oct 2019 08:08:25 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/19] EDAC, mc: Create new function edac_inc_csrow()
Message-ID: <20191011080825.74932496@coco.lan>
In-Reply-To: <20191010202418.25098-15-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-15-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:33 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Have a separate function to count errors in csrow/channel. This better
> separates code and reduces the indentation level. No functional
> changes.

This one assumes patch 06/19, with I'm not sure if it is correct.

> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 9e8c5716a8c0..3779204c0e21 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1045,6 +1045,26 @@ static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *e)
>  	return container_of(e, struct mem_ctl_info, error_desc);
>  }
>  
> +static void edac_inc_csrow(struct edac_raw_error_desc *e, int row, int chan)
> +{
> +	struct mem_ctl_info *mci = error_desc_to_mci(e);
> +	u16 count = e->error_count;
> +	enum hw_event_mc_err_type type = e->type;
> +
> +	if (row < 0)
> +		return;
> +
> +	edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> +
> +	if (type == HW_EVENT_ERR_CORRECTED) {
> +		mci->csrows[row]->ce_count += count;
> +		if (chan >= 0)
> +			mci->csrows[row]->channels[chan]->ce_count += count;
> +	} else {
> +		mci->csrows[row]->ue_count += count;
> +	}
> +}
> +
>  void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
>  			      struct dimm_info *dimm)
>  {
> @@ -1201,22 +1221,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			chan = -2;
>  	}
>  
> -	if (any_memory) {
> +	if (any_memory)
>  		strcpy(e->label, "any memory");
> -	} else {
> -		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> -		if (p == e->label)
> -			strcpy(e->label, "unknown memory");
> -		if (type == HW_EVENT_ERR_CORRECTED) {
> -			if (row >= 0) {
> -				mci->csrows[row]->ce_count += error_count;
> -				if (chan >= 0)
> -					mci->csrows[row]->channels[chan]->ce_count += error_count;
> -			}
> -		} else
> -			if (row >= 0)
> -				mci->csrows[row]->ue_count += error_count;
> -	}
> +	else if (!*e->label)
> +		strcpy(e->label, "unknown memory");
> +
> +	edac_inc_csrow(e, row, chan);
>  
>  	/* Fill the RAM location data */
>  	p = e->location;



Thanks,
Mauro
