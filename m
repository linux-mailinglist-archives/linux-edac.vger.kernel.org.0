Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC179F5DD0
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfKIHcX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:32:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46254 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfKIHcX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8bLSNTzjuoFMu9WIRlNvvg4bEXkKwAKKUJYThERo2nk=; b=NCVtnpypExj6Vw0e5yFRpscjL
        JmEt7MHE5MyUS9rd1dDlByoboMDDSIP/gzqnrPxPF9h1A01Ja/KEkK8tVaV1hvJ4yVq7bdTbY9bBS
        D9CZUJUixc9E2o+TCvych9E1tiKy8WM3ukvvYPxO9d/qqjax+WvKKb7o7O6YeAZZY9fOGc3qUiQlq
        XGIFFyUH7+0oPeAVe9gSj1+MqqX0bBNeOLGkESQYV40re95O9jUnYpOmTwlAXFnUR1kYNZ9GDknmd
        04UQhGqgkR2evJeWJw6ZPL/lKCQHssnhFDisIoQ9vMlQWEzK9A48WcerYj03KOiUMkfDQGQKJd0zS
        V3DrA9S/g==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTLEE-0007oD-4z; Sat, 09 Nov 2019 07:32:14 +0000
Date:   Sat, 9 Nov 2019 08:32:10 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 20/20] EDAC, mc: Create new function edac_inc_csrow()
Message-ID: <20191109083210.69d36aa5@kernel.org>
In-Reply-To: <20191106093239.25517-21-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-21-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:46 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Have a separate function to count errors in csrow/channel. This better
> separates code and reduces the indentation level. No functional
> changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 93eac968678e..34b740036ffc 100644
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
> @@ -1214,22 +1234,12 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
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




Cheers,
Mauro
