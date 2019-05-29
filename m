Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F08AF2E0BC
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfE2PNX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:13:23 -0400
Received: from foss.arm.com ([217.140.101.70]:47932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfE2PNX (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829D4341;
        Wed, 29 May 2019 08:13:22 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F6E03F5AF;
        Wed, 29 May 2019 08:13:21 -0700 (PDT)
Subject: Re: [PATCH 10/21] EDAC, ghes: Remove pvt->detail_location string
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-11-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7017c91e-8923-c8d2-26ca-875328ab855a@arm.com>
Date:   Wed, 29 May 2019 16:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-11-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> The detail_location[] string in struct ghes_edac_pvt is complete
> useless and data is just copied around. Put everything into
> e->other_detail from the beginning.

We still print all that complete-useless detail_location stuff... so this commit message
had me confused about what you're doing here. I think you meant the space for the string,
instead of the value!

| detail_location[] is used to collect two location strings so they can be passed as one
| to trace_mc_event(). Instead of having an extra copy step, assemble the location string
| in other_detail[] from the beginning.


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 39702bac5eaf..c18f16bc9e4d 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -23,8 +23,7 @@ struct ghes_edac_pvt {
>  	struct mem_ctl_info *mci;
>  
>  	/* Buffers for the error handling routine */
> -	char detail_location[240];
> -	char other_detail[160];
> +	char other_detail[400];
>  	char msg[80];
>  };
>  
> @@ -225,13 +224,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	memset(e, 0, sizeof (*e));
>  	e->error_count = 1;
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

... so no change? Could you drop this hunk?

Regardless,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
