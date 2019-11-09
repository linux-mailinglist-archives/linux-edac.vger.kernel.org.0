Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DDDF5DCE
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKIHax (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:30:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKIHaw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iwJzasVWWLkRtmciIZR9kiPc8ha+YPAPXMvnHOGcBIo=; b=O8+s1SgC+k/gsF6OKlmsvgdst
        p+ugle+CjAH93UdOZ3RPjLcvctCd9QYMZK4FY70PSkMEdXl1Z4fD7/1TAArs2ModhkbXc4U2H4AWe
        k2OZQKNXBJTHaxzlb3OIl4AA9osKWWLXmW84LXULg3DmY7aK5p3D1Ovg/JgZNoXAjtXoPvvIM01Qz
        fDvcmo+4AlD8PWO+HNo7TednTIhuTmLKOwD6xYp9rZTejIVmAqm48cUsswLRnLDwGizi7WXTNdXHJ
        2X7jlrhLeRjYuCp07EkXtZd83jIfc2ECcZZ4ZuPD9CuF8auqVQIFOqutxEJM/tQ05FWCAKcFZNlV6
        w+AQDBTHg==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTLCr-0007ei-50; Sat, 09 Nov 2019 07:30:49 +0000
Date:   Sat, 9 Nov 2019 08:30:45 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 18/20] EDAC: Store error type in struct
 edac_raw_error_desc
Message-ID: <20191109083045.0fec2064@kernel.org>
In-Reply-To: <20191106093239.25517-19-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-19-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:41 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Store the error type in struct edac_raw_error_desc. This makes the
> type parameter of edac_raw_mc_handle_error() obsolete.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  drivers/edac/edac_mc.c   | 10 +++++-----
>  drivers/edac/edac_mc.h   |  4 +---
>  drivers/edac/ghes_edac.c | 11 +++++------
>  include/linux/edac.h     |  1 +
>  4 files changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index e4a11218009b..7b4f5e98dfe8 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1040,8 +1040,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  	edac_inc_ue_error(mci, dimm, error_count);
>  }
>  
> -void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
> -			      struct mem_ctl_info *mci,
> +void edac_raw_mc_handle_error(struct mem_ctl_info *mci,
>  			      struct dimm_info *dimm,
>  			      struct edac_raw_error_desc *e)
>  {
> @@ -1056,14 +1055,14 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  
>  	/* Report the error via the trace interface */
>  	if (IS_ENABLED(CONFIG_RAS))
> -		trace_mc_event(type, e->msg, e->label, e->error_count,
> +		trace_mc_event(e->type, e->msg, e->label, e->error_count,
>  			       mci->mc_idx, e->top_layer, e->mid_layer,
>  			       e->low_layer,
>  			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
>  			       grain_bits, e->syndrome, e->other_detail);
>  
>  	/* Memory type dependent details about the error */
> -	if (type == HW_EVENT_ERR_CORRECTED) {
> +	if (e->type == HW_EVENT_ERR_CORRECTED) {
>  		snprintf(detail, sizeof(detail),
>  			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
>  			e->page_frame_number, e->offset_in_page,
> @@ -1109,6 +1108,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	/* Fills the error report buffer */
>  	memset(e, 0, sizeof (*e));
>  	e->error_count = error_count;
> +	e->type = type;
>  	e->top_layer = top_layer;
>  	e->mid_layer = mid_layer;
>  	e->low_layer = low_layer;
> @@ -1242,6 +1242,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
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
> index 6eebaf28e31c..7d325d70d6d3 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -202,7 +202,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  {
>  	struct dimm_info *dimm;
> -	enum hw_event_mc_err_type type;
>  	struct edac_raw_error_desc *e;
>  	struct mem_ctl_info *mci;
>  	struct ghes_edac_pvt *pvt;
> @@ -241,17 +240,17 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
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
> @@ -442,7 +441,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	dimm = edac_get_dimm_by_index(mci, e->top_layer);
>  
> -	edac_raw_mc_handle_error(type, mci, dimm, e);
> +	edac_raw_mc_handle_error(mci, dimm, e);
>  
>  unlock:
>  	spin_unlock_irqrestore(&ghes_lock, flags);
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




Cheers,
Mauro
