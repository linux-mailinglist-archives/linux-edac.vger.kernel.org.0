Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22BD3D25
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfJKKRT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:17:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKRT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cv/KAWwMfr+7BghJTGUGWukKHt7xg9UrE7eOCgXB8Lc=; b=MnaEbUBjI73soKTwbAzHNRrvZ
        Uw9waepT+B3yTernjqev5rqW69WB1wwZzLBjbAXRuuErEmUWtUNfg7TyHsHh4LvhZQsZzP5RF3ZEX
        yQLEib/Fctcw+R3S9toaUMNspcDPerEcxsZxVbozmzD4hlMY91cYc8BNZdogb+WK0I9qPAbm4mtEq
        LNJESqgixdSX37mnXUDQc2ZSbVoXy07mCWO+HNUv6n+8ORNPV3KXSzQA1e2ZWPcmSs7whjE91PQlc
        y5C3NRFKvzwSnVGtzowCBxsC/O30KS75kHz6el9ZIvGzrb6MNtrGs9QY224N+lMUecY6+AhuSY8P1
        NtqCC0hyw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrz1-0003C5-LJ; Fri, 11 Oct 2019 10:17:15 +0000
Date:   Fri, 11 Oct 2019 07:17:11 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/19] EDAC, mc: Reduce indentation level in
 edac_mc_handle_error()
Message-ID: <20191011071711.7e15a4cb@coco.lan>
In-Reply-To: <20191010202418.25098-6-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-6-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:14 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Reduce the indentation level in edac_mc_handle_error() a bit by using
> continue. No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 59 +++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index f2cbca77bc50..45b02bb31964 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1171,37 +1171,38 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  		 * channel/memory controller/...  may be affected.
>  		 * Also, don't show errors for empty DIMM slots.
>  		 */
> -		if (e->enable_per_layer_report && dimm->nr_pages) {
> -			if (n_labels >= EDAC_MAX_LABELS) {
> -				e->enable_per_layer_report = false;
> -				break;
> -			}
> -			n_labels++;
> -			if (p != e->label) {
> -				strcpy(p, OTHER_LABEL);
> -				p += strlen(OTHER_LABEL);
> -			}
> -			strcpy(p, dimm->label);
> -			p += strlen(p);
> -			*p = '\0';
> +		if (!e->enable_per_layer_report || !dimm->nr_pages)
> +			continue;
>  
> -			/*
> -			 * get csrow/channel of the DIMM, in order to allow
> -			 * incrementing the compat API counters
> -			 */
> -			edac_dbg(4, "%s csrows map: (%d,%d)\n",
> -				 mci->csbased ? "rank" : "dimm",
> -				 dimm->csrow, dimm->cschannel);
> -			if (row == -1)
> -				row = dimm->csrow;
> -			else if (row >= 0 && row != dimm->csrow)
> -				row = -2;
> -
> -			if (chan == -1)
> -				chan = dimm->cschannel;
> -			else if (chan >= 0 && chan != dimm->cschannel)
> -				chan = -2;
> +		if (n_labels >= EDAC_MAX_LABELS) {
> +			e->enable_per_layer_report = false;
> +			break;
> +		}
> +		n_labels++;
> +		if (p != e->label) {
> +			strcpy(p, OTHER_LABEL);
> +			p += strlen(OTHER_LABEL);
>  		}
> +		strcpy(p, dimm->label);
> +		p += strlen(p);
> +		*p = '\0';
> +
> +		/*
> +		 * get csrow/channel of the DIMM, in order to allow
> +		 * incrementing the compat API counters
> +		 */
> +		edac_dbg(4, "%s csrows map: (%d,%d)\n",
> +			mci->csbased ? "rank" : "dimm",
> +			dimm->csrow, dimm->cschannel);
> +		if (row == -1)
> +			row = dimm->csrow;
> +		else if (row >= 0 && row != dimm->csrow)
> +			row = -2;
> +
> +		if (chan == -1)
> +			chan = dimm->cschannel;
> +		else if (chan >= 0 && chan != dimm->cschannel)
> +			chan = -2;
>  	}
>  
>  	if (!e->enable_per_layer_report) {



Thanks,
Mauro
