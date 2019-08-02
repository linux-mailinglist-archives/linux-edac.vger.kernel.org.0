Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A017FF32
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbfHBREt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 13:04:49 -0400
Received: from foss.arm.com ([217.140.110.172]:55210 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbfHBREt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 13:04:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A9D2344;
        Fri,  2 Aug 2019 10:04:48 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 983793F575;
        Fri,  2 Aug 2019 10:04:47 -0700 (PDT)
Subject: Re: [PATCH v2 03/24] EDAC, ghes: Remove pvt->detail_location string
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-4-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <abbab8fd-d87e-d37d-b077-9f43474beaf8@arm.com>
Date:   Fri, 2 Aug 2019 18:04:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190624150758.6695-4-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 24/06/2019 16:08, Robert Richter wrote:
> The detail_location[] string in struct ghes_edac_pvt is complete
> useless and data is just copied around. Put everything into
> e->other_detail from the beginning.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index d095d98d6a8d..049de73c3bad 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -21,8 +21,7 @@ struct ghes_edac_pvt {
>  	struct mem_ctl_info *mci;
>  
>  	/* Buffers for the error handling routine */
> -	char detail_location[240];
> -	char other_detail[160];
> +	char other_detail[400];
>  	char msg[80];
>  };
>  
> @@ -224,13 +223,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	e->error_count = 1;
>  	e->grain = 1;
>  	strcpy(e->label, "unknown label");
> -	e->msg = pvt->msg;
> -	e->other_detail = pvt->other_detail;
>  	e->top_layer = -1;
>  	e->mid_layer = -1;
>  	e->low_layer = -1;
> -	*pvt->other_detail = '\0';
> +	e->msg = pvt->msg;
> +	e->other_detail = pvt->other_detail;
> +
>  	*pvt->msg = '\0';
> +	*pvt->other_detail = '\0';
>  
>  	switch (sev) {
>  	case GHES_SEV_CORRECTED:
> @@ -361,6 +361,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* All other fields are mapped on e->other_detail */
>  	p = pvt->other_detail;
> +	p += snprintf(p, sizeof(pvt->other_detail),
> +		"APEI location: %s ", e->location);
>  	if (mem_err->validation_bits & CPER_MEM_VALID_ERROR_STATUS) {
>  		u64 status = mem_err->error_status;
>  
> @@ -443,12 +445,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	grain_bits = fls_long(e->grain - 1);
>  
>  	/* Generate the trace event */
> -	snprintf(pvt->detail_location, sizeof(pvt->detail_location),
> -		 "APEI location: %s %s", e->location, e->other_detail);
>  	trace_mc_event(type, e->msg, e->label, e->error_count,
>  		       mci->mc_idx, e->top_layer, e->mid_layer, e->low_layer,
>  		       (e->page_frame_number << PAGE_SHIFT) | e->offset_in_page,
> -		       grain_bits, e->syndrome, pvt->detail_location);
> +		       grain_bits, e->syndrome, e->other_detail);
>  
>  	edac_raw_mc_handle_error(type, mci, e);
>  	spin_unlock_irqrestore(&ghes_lock, flags);

After a game of spot-the-difference: you added a newline.
Reviewed-by: James Morse <james.morse@arm.com>

Previously here:
https://lore.kernel.org/linux-edac/7017c91e-8923-c8d2-26ca-875328ab855a@arm.com/

Please pick up tags when posting a new version.


Thanks,

James
