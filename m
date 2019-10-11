Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9981D3E5C
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 13:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfJKLXb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 07:23:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33936 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLXb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 07:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dsaS+us45ZwRJKtxMVnmPBirfa55ePd+K+QsxKfNims=; b=M+9x6KXTQEC5pNJJj0PEEnCT/
        eNIz6yP2H1CP+41JaDqT7OsU2Eb1V2OH3aHcm2ad+cq5Ngpm7/86a1NUu8PKg+DXifsJR1+tSJ3Ka
        d38fDJxg26jGxYsLkTAeSjb8UkdHAprao45qOZbKQkT6hgd12Y7XX/bjcvsU86qdu8oB+iT/n6HpM
        6VGEWRnj5PEpb4fD8O+X8NMc34cm37//Lnh5Kl6ruvgKxmPO6uCEXyVcfxffW+d9aFUmmqCrRw82p
        5Cgbo+c/cTsKjiZ+WTga6mpQpZv6Ey5ozpnNF90+SVugIhn553oC4RM/oq4JzlFG5qhLpLo0Ejxx4
        jbhuYH0Ww==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIt16-00009Y-1q; Fri, 11 Oct 2019 11:23:28 +0000
Date:   Fri, 11 Oct 2019 08:23:24 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/19] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
Message-ID: <20191011082324.4289a2d2@coco.lan>
In-Reply-To: <20191010202418.25098-19-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-19-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:40 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The code in ghes_edac.c and edac_mc.c for grain_bits calculation and
> calling trace_mc_event() is now the same. Move it to a single location
> in edac_raw_mc_handle_error().
> 
> The only difference is the missing IS_ENABLED(CONFIG_RAS) switch, but
> this is needed for ghes too.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c   | 30 +++++++++++++++---------------
>  drivers/edac/ghes_edac.c | 13 -------------
>  2 files changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 3779204c0e21..e6c6e40dc760 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -1070,6 +1070,21 @@ void edac_raw_mc_handle_error(struct edac_raw_error_desc *e,
>  {
>  	struct mem_ctl_info *mci = error_desc_to_mci(e);
>  	char detail[80];
> +	u8 grain_bits;
> +
> +	/* Sanity-check driver-supplied grain value. */
> +	if (WARN_ON_ONCE(!e->grain))
> +		e->grain = 1;
> +
> +	grain_bits = fls_long(e->grain - 1);
> +
> +	/* Report the error via the trace interface */
> +	if (IS_ENABLED(CONFIG_RAS))
> +		trace_mc_event(e->type, e->msg, e->label, e->error_count,
> +			       mci->mc_idx, e->top_layer, e->mid_layer,
> +			       e->low_layer,
> +			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> +			       grain_bits, e->syndrome, e->other_detail);
>  
>  	/* Memory type dependent details about the error */
>  	if (e->type == HW_EVENT_ERR_CORRECTED) {
> @@ -1110,7 +1125,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	int row = -1, chan = -1;
>  	int pos[EDAC_MAX_LAYERS] = { top_layer, mid_layer, low_layer };
>  	int i, n_labels = 0;
> -	u8 grain_bits;
>  	struct edac_raw_error_desc *e = &mci->error_desc;
>  	bool any_memory = true;
>  
> @@ -1242,20 +1256,6 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	if (p > e->location)
>  		*(p - 1) = '\0';
>  
> -	/* Sanity-check driver-supplied grain value. */
> -	if (WARN_ON_ONCE(!e->grain))
> -		e->grain = 1;
> -
> -	grain_bits = fls_long(e->grain - 1);
> -
> -	/* Report the error via the trace interface */
> -	if (IS_ENABLED(CONFIG_RAS))
> -		trace_mc_event(type, e->msg, e->label, e->error_count,
> -			       mci->mc_idx, e->top_layer, e->mid_layer,
> -			       e->low_layer,
> -			       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> -			       grain_bits, e->syndrome, e->other_detail);
> -
>  	dimm = edac_get_dimm(mci, top_layer, mid_layer, low_layer);
>  
>  	edac_raw_mc_handle_error(e, dimm);
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 8d9d3c4dbebb..17d5b22fe000 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -198,7 +198,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	struct ghes_edac_pvt *pvt = ghes_pvt;
>  	unsigned long flags;
>  	char *p;
> -	u8 grain_bits;
>  
>  	if (!pvt)
>  		return;
> @@ -430,18 +429,6 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	if (p > pvt->other_detail)
>  		*(p - 1) = '\0';
>  
> -	/* Sanity-check driver-supplied grain value. */
> -	if (WARN_ON_ONCE(!e->grain))
> -		e->grain = 1;
> -
> -	grain_bits = fls_long(e->grain - 1);
> -
> -	/* Generate the trace event */
> -	trace_mc_event(e->type, e->msg, e->label, e->error_count,
> -		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
> -		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> -		       grain_bits, e->syndrome, e->other_detail);
> -
>  	dimm = edac_get_dimm_by_index(mci, e->top_layer);
>  
>  	edac_raw_mc_handle_error(e, dimm);



Thanks,
Mauro
