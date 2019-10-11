Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3D4D3DAB
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfJKKtD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:49:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57982 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKtD (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KpxDWPvz35a9kdqfFQphvMNey2YNc/+UfxTnv1nH9vc=; b=uVjSIh28fX7Nc49ea8x4QcaIh
        2C2QtuT3kFValZ1SvZzLVM3CZ7jDU/uqdmBC2MxGtEBhhXlHO+tKCgFpUpokBqYCeuU6TYxoadmcU
        G52awsBZNCqhvz07y+WMuHUAJCr0jtfbRwSJVagfJW5v7tT8uiLMSuv7s7g5sj6iH7y6tuPbXYuFz
        eJ+Ihdha+2nbc7U2m+5nOUDoQllJz7CbpBRpLUXjb1TSYaVBQzHba1QESt0xvGLs+/1Ibj9yZkqWq
        r5iKJK/dHK6dflOCdqNe3xZ8Yy/OoPcHEtLynXvJ/SzxD6gquTPV5sY6uy9YvXXPJDvJO5Llx3KPC
        FHGqKAxog==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsTj-0000PI-7l; Fri, 11 Oct 2019 10:48:59 +0000
Date:   Fri, 11 Oct 2019 07:48:55 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/19] EDAC, mc: Rework edac_raw_mc_handle_error() to
 use struct dimm_info
Message-ID: <20191011074855.30bd7e72@coco.lan>
In-Reply-To: <20191010202418.25098-11-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-11-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:24 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The error handling functions have the pos[] array argument for
> determing the dimm handle. Rework those functions to use the dimm
> handle directly.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  drivers/edac/edac_mc.c   | 28 +++++++++++++---------------
>  drivers/edac/edac_mc.h   |  2 ++
>  drivers/edac/ghes_edac.c |  6 +++++-
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 6d880cf4d599..cdfb383f7a35 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -925,11 +925,9 @@ const char *edac_layer_name[] = {
>  EXPORT_SYMBOL_GPL(edac_layer_name);
>  
>  static void edac_inc_ce_error(struct mem_ctl_info *mci,
> -			      const int pos[EDAC_MAX_LAYERS],
> +			      struct dimm_info *dimm,
>  			      const u16 count)
>  {
> -	struct dimm_info *dimm = edac_get_dimm(mci, pos[0], pos[1], pos[2]);
> -
>  	mci->ce_mc += count;
>  
>  	if (dimm)
> @@ -939,11 +937,9 @@ static void edac_inc_ce_error(struct mem_ctl_info *mci,
>  }
>  
>  static void edac_inc_ue_error(struct mem_ctl_info *mci,
> -				    const int pos[EDAC_MAX_LAYERS],
> -				    const u16 count)
> +			      struct dimm_info *dimm,
> +			      const u16 count)
>  {
> -	struct dimm_info *dimm = edac_get_dimm(mci, pos[0], pos[1], pos[2]);
> -
>  	mci->ue_mc += count;
>  
>  	if (dimm)
> @@ -953,8 +949,8 @@ static void edac_inc_ue_error(struct mem_ctl_info *mci,
>  }
>  
>  static void edac_ce_error(struct mem_ctl_info *mci,
> +			  struct dimm_info *dimm,
>  			  const u16 error_count,
> -			  const int pos[EDAC_MAX_LAYERS],
>  			  const char *msg,
>  			  const char *location,
>  			  const char *label,
> @@ -982,7 +978,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
>  				       error_count, msg, msg_aux, label,
>  				       location, detail);
>  	}
> -	edac_inc_ce_error(mci, pos, error_count);
> +	edac_inc_ce_error(mci, dimm, error_count);
>  
>  	if (mci->scrub_mode == SCRUB_SW_SRC) {
>  		/*
> @@ -1006,8 +1002,8 @@ static void edac_ce_error(struct mem_ctl_info *mci,
>  }
>  
>  static void edac_ue_error(struct mem_ctl_info *mci,
> +			  struct dimm_info *dimm,
>  			  const u16 error_count,
> -			  const int pos[EDAC_MAX_LAYERS],
>  			  const char *msg,
>  			  const char *location,
>  			  const char *label,
> @@ -1041,15 +1037,15 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  			      msg, msg_aux, label, location, detail);
>  	}
>  
> -	edac_inc_ue_error(mci, pos, error_count);
> +	edac_inc_ue_error(mci, dimm, error_count);
>  }
>  
>  void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  			      struct mem_ctl_info *mci,
> +			      struct dimm_info *dimm,
>  			      struct edac_raw_error_desc *e)
>  {
>  	char detail[80];
> -	int pos[EDAC_MAX_LAYERS] = { e->top_layer, e->mid_layer, e->low_layer };
>  
>  	/* Memory type dependent details about the error */
>  	if (type == HW_EVENT_ERR_CORRECTED) {
> @@ -1057,7 +1053,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
>  			e->page_frame_number, e->offset_in_page,
>  			e->grain, e->syndrome);
> -		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
> +		edac_ce_error(mci, dimm, e->error_count, e->msg, e->location,
>  			      e->label, detail, e->other_detail,
>  			      e->page_frame_number, e->offset_in_page, e->grain);
>  	} else {
> @@ -1065,7 +1061,7 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  			"page:0x%lx offset:0x%lx grain:%ld",
>  			e->page_frame_number, e->offset_in_page, e->grain);
>  
> -		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
> +		edac_ue_error(mci, dimm, e->error_count, e->msg, e->location,
>  			      e->label, detail, e->other_detail);
>  	}
>  
> @@ -1245,6 +1241,8 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
>  			       grain_bits, e->syndrome, e->other_detail);
>  
> -	edac_raw_mc_handle_error(type, mci, e);
> +	dimm = edac_get_dimm(mci, top_layer, mid_layer, low_layer);
> +
> +	edac_raw_mc_handle_error(type, mci, dimm, e);
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_handle_error);
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 02aac5c61d00..2c3e2fbcedc4 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -214,6 +214,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
>   *
>   * @type:		severity of the error (CE/UE/Fatal)
>   * @mci:		a struct mem_ctl_info pointer
> + * @dimm:		a struct dimm_info pointer
>   * @e:			error description
>   *
>   * This raw function is used internally by edac_mc_handle_error(). It should
> @@ -222,6 +223,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
>   */
>  void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  			      struct mem_ctl_info *mci,
> +			      struct dimm_info *dimm,
>  			      struct edac_raw_error_desc *e);
>  
>  /**
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index e0b90c6d7d63..4f5721cf4380 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -193,6 +193,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  
>  void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  {
> +	struct dimm_info *dimm;
>  	enum hw_event_mc_err_type type;
>  	struct edac_raw_error_desc *e;
>  	struct mem_ctl_info *mci;
> @@ -437,7 +438,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
>  		       grain_bits, e->syndrome, pvt->detail_location);
>  
> -	edac_raw_mc_handle_error(type, mci, e);
> +	dimm = edac_get_dimm_by_index(mci, e->top_layer);
> +
> +	edac_raw_mc_handle_error(type, mci, dimm, e);
> +
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  }
>  



Thanks,
Mauro
