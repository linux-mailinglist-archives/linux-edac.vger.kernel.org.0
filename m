Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C376F19F528
	for <lists+linux-edac@lfdr.de>; Mon,  6 Apr 2020 13:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDFLvf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 Apr 2020 07:51:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbgDFLve (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 Apr 2020 07:51:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 510EFAEA6;
        Mon,  6 Apr 2020 11:51:32 +0000 (UTC)
Subject: Re: [PATCH 03/11] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
To:     Robert Richter <rrichter@marvell.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-4-rrichter@marvell.com>
From:   Matthias Brugger <mbrugger@suse.com>
Message-ID: <f5a5c29b-e72b-9fd0-382d-75290e10153d@suse.com>
Date:   Mon, 6 Apr 2020 13:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306151318.17422-4-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 06/03/2020 16:13, Robert Richter wrote:
> The local variable rdr_mask serves as a static constant here. It hides
> what the code is doing. Remove it and replace it with the actual logic
> that checks some bits.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>  drivers/edac/ghes_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 07fa3867cba1..fce53893731a 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -123,7 +123,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
>  		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
>  		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
> -		u16 rdr_mask = BIT(7) | BIT(13);
>  
>  		if (entry->size == 0xffff) {
>  			pr_info("Can't get DIMM%i size\n",
> @@ -173,7 +172,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  		default:
>  			if (entry->type_detail & BIT(6))
>  				dimm->mtype = MEM_RMBS;
> -			else if ((entry->type_detail & rdr_mask) == rdr_mask)
> +			else if ((entry->type_detail & BIT(7)) &&
> +				 (entry->type_detail & BIT(13)))
>  				dimm->mtype = MEM_RDR;
>  			else if (entry->type_detail & BIT(7))
>  				dimm->mtype = MEM_SDR;
> 

