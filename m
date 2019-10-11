Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965DDD3DC0
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfJKKy0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:54:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33102 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfJKKy0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fJx1GyploDJueI6zRxILnt9V2dKVq76fxDUt12UHdOc=; b=V671/vaKIxzppWHM+32aF2dkb
        Z1oc3hxcXKoJcbxsUGXA1HVrKtRUhu6KPXC8PEPeBhcWIu+o8WGVf0cDZLP+M7ckJsLv77hegW5o9
        YxNs8agAuxZp80f9EoMv5r9Qw54OIVuyW+aTZWyrVfJ+a626FvKniqk2lPRy7hjMqZURELr5RfIRM
        6Ze+C5SYeHBNinGNM2J4mY5Ir6jKnhioMwPg1HFGvrNlsnLDTVPh+v8okcC/Akp6opNlsIFOS6VMD
        yXvD8wGFBdU/gS8iRyvwCZJ8a+R4Sc5C1z4HcQTpasXVOWuz5JiR+qcl7EVEr9rs9T1E2Oq85ebBQ
        0VXr/bJeQ==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsYx-00037i-9X; Fri, 11 Oct 2019 10:54:23 +0000
Date:   Fri, 11 Oct 2019 07:54:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/19] EDAC: Store error type in struct
 edac_raw_error_desc
Message-ID: <20191011075412.03458c3e@coco.lan>
In-Reply-To: <20191010202418.25098-13-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-13-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:29 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Store the error type in struct edac_raw_error_desc. This makes the
> type parameter of edac_raw_mc_handle_error() obsolete.

I don't see much gain on this change, but whatever works best for
ghes.

> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c   |  8 ++++----
>  drivers/edac/edac_mc.h   |  4 +---
>  drivers/edac/ghes_edac.c | 13 ++++++-------
>  include/linux/edac.h     |  1 +
>  4 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index cdfb383f7a35..ca206854b8ee 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1040,15 +1040,14 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  	edac_inc_ue_error(mci, dimm, error_count);
>  }
>  
> -void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
> -			      struct mem_ctl_info *mci,
> +void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
>  			      struct dimm_info *dimm,
>  			      struct edac_raw_error_desc *e)
>  {
>  	char detail[80];
>  
>  	/* Memory type dependent details about the error */
> -	if (type == HW_EVENT_ERR_CORRECTED) {
> +	if (e->type == HW_EVENT_ERR_CORRECTED) {
>  		snprintf(detail, sizeof(detail),
>  			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
>  			e->page_frame_number, e->offset_in_page,
> @@ -1095,6 +1094,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	/* Fills the error report buffer */
>  	memset(e, 0, sizeof (*e));
>  	e->error_count = error_count;
> +	e->type = type;
>  	e->top_layer = top_layer;
>  	e->mid_layer = mid_layer;
>  	e->low_layer = low_layer;
> @@ -1243,6 +1243,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  
>  	dimm = edac_get_dimm(mci, top_layer, mid_layer, low_layer);
>  
> -	edac_raw_mc_handle_error(type, mci, dimm, e);
> +	edac_raw_mc_handle_error(mci, dimm, e);
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_handle_error);
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 2c3e2fbcedc4..a8f1b5b5e873 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -212,7 +212,6 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
>   * edac_raw_mc_handle_error() - Reports a memory event to userspace without
>   *	doing anything to discover the error location.
>   *
> - * @type:		severity of the error (CE/UE/Fatal)
>   * @mci:		a struct mem_ctl_info pointer
>   * @dimm:		a struct dimm_info pointer
>   * @e:			error description
> @@ -221,8 +220,7 @@ extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
>   * only be called directly when the hardware error come directly from BIOS,
>   * like in the case of APEI GHES driver.
>   */
> -void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
> -			      struct mem_ctl_info *mci,
> +void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
>  			      struct dimm_info *dimm,
>  			      struct edac_raw_error_desc *e);
>  
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 4f5721cf4380..1db1c012bed9 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -194,7 +194,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  {
>  	struct dimm_info *dimm;
> -	enum hw_event_mc_err_type type;
>  	struct edac_raw_error_desc *e;
>  	struct mem_ctl_info *mci;
>  	struct ghes_edac_pvt *pvt = ghes_pvt;
> @@ -232,17 +231,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	switch (sev) {
>  	case GHES_SEV_CORRECTED:
> -		type = HW_EVENT_ERR_CORRECTED;
> +		e->type = HW_EVENT_ERR_CORRECTED;
>  		break;
>  	case GHES_SEV_RECOVERABLE:
> -		type = HW_EVENT_ERR_UNCORRECTED;
> +		e->type = HW_EVENT_ERR_UNCORRECTED;
>  		break;
>  	case GHES_SEV_PANIC:
> -		type = HW_EVENT_ERR_FATAL;
> +		e->type = HW_EVENT_ERR_FATAL;
>  		break;
>  	default:
>  	case GHES_SEV_NO:
> -		type = HW_EVENT_ERR_INFO;
> +		e->type = HW_EVENT_ERR_INFO;
>  	}
>  
>  	edac_dbg(1, "error validation_bits: 0x%08llx\n",
> @@ -433,14 +432,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	grain_bits = fls_long(e->grain);
>  	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
>  		 "APEI location: %s %s", e->location, e->other_detail);
> -	trace_mc_event(type, e->msg, e->label, e->error_count,
> +	trace_mc_event(e->type, e->msg, e->label, e->error_count,
>  		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
>  		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
>  		       grain_bits, e->syndrome, pvt->detail_location);
>  
>  	dimm = edac_get_dimm_by_index(mci, e->top_layer);
>  
> -	edac_raw_mc_handle_error(type, mci, dimm, e);
> +	edac_raw_mc_handle_error(mci, dimm, e);
>  
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  }
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 4d9673954856..587c53b87fdf 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -463,6 +463,7 @@ struct edac_raw_error_desc {
>  	long grain;
>  
>  	u16 error_count;
> +	enum hw_event_mc_err_type type;
>  	int top_layer;
>  	int mid_layer;
>  	int low_layer;



Thanks,
Mauro
