Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D6ED3DC9
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbfJKK4f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:56:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfJKK4f (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6PFef9FNs2cvQhskMlq+Tm+WVZZqlMFamwKzZ4ex8TI=; b=iWXodMFOPvrgKIzjTWXRK25xN
        PXsoEyb1Eh3+sn0J8h9DuXOQJKboGAUC2aGHfqAX71mpqdMSfn88Yypqhdd9XzvyeK+2WDuUSz9Fg
        b+1P7rpxB3XUKzi4e5nCDuCnZ0vBp5StzzRhLrmXBWTYveAD3/k3MecMKB0QTj3+HL3tid/eRwx7i
        J5GizMNjNs686k9KJfnUs0d2bTURjRV0CPLn5aYx6ouvR0o3HVgA/fjMUj2ZJKaVMkIK91Tvo0eyr
        1K98a6t78YADirYA6+yat4+7zBL0wg3V34lAqrZ92l0SCCcovigTJR9RnZXrr+y9cNWqa53n7WXw0
        ITIpEd3NQ==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsb1-0004c8-4w; Fri, 11 Oct 2019 10:56:31 +0000
Date:   Fri, 11 Oct 2019 07:56:26 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 13/19] EDAC, mc: Determine mci pointer from the error
 descriptor
Message-ID: <20191011075626.5d13372f@coco.lan>
In-Reply-To: <20191010202418.25098-14-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-14-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:31 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Each struct mci has its own error descriptor. Create a function
> error_desc_to_mci() to determine the corresponding mci from an error
> descriptor. This eases the parameter list of edac_raw_mc_handle_
> error() as the mci pointer do not need to be passed any longer.
> 
> While at it, reorder parameters of edac_raw_mc_handle_error().
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c   | 13 +++++++++----
>  drivers/edac/edac_mc.h   |  8 +++-----
>  drivers/edac/ghes_edac.c |  2 +-
>  3 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index ca206854b8ee..9e8c5716a8c0 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1040,10 +1040,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  	edac_inc_ue_error(mci, dimm, error_count);
>  }
>  
> -void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
> -			      struct dimm_info *dimm,
> -			      struct edac_raw_error_desc *e)
> +static struct mem_ctl_info *error_desc_to_mci(struct edac_raw_error_desc *e)
> +{
> +	return container_of(e, struct mem_ctl_info, error_desc);
> +}
> +
> +void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
> +			      struct dimm_info *dimm)
>  {
> +	struct mem_ctl_info *mci = error_desc_to_mci(e);
>  	char detail[80];
>  
>  	/* Memory type dependent details about the error */
> @@ -1243,6 +1248,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  
>  	dimm = edac_get_dimm(mci, top_layer, mid_layer, low_layer);
>  
> -	edac_raw_mc_handle_error(mci, dimm, e);
> +	edac_raw_mc_handle_error(e, dimm);
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_handle_error);
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index a8f1b5b5e873..3b01d5d9d7bc 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -212,17 +212,15 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
>   * edac_raw_mc_handle_error() - Reports a memory event to userspace without
>   *	doing anything to discover the error location.
>   *
> - * @mci:		a struct mem_ctl_info pointer
> - * @dimm:		a struct dimm_info pointer
>   * @e:			error description
> + * @dimm:		a struct dimm_info pointer
>   *
>   * This raw function is used internally by edac_mc_handle_error(). It should
>   * only be called directly when the hardware error come directly from BIOS,
>   * like in the case of APEI GHES driver.
>   */
> -void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
> -			      struct dimm_info *dimm,
> -			      struct edac_raw_error_desc *e);
> +void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
> +			      struct dimm_info *dimm);
>  
>  /**
>   * edac_mc_handle_error() - Reports a memory event to userspace.
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 1db1c012bed9..8078d4ec9631 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -439,7 +439,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	dimm = edac_get_dimm_by_index(mci, e->top_layer);
>  
> -	edac_raw_mc_handle_error(mci, dimm, e);
> +	edac_raw_mc_handle_error(e, dimm);
>  
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  }



Thanks,
Mauro
