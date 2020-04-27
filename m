Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4DA1B9821
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 09:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD0HIM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0HIM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 27 Apr 2020 03:08:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594ABC061A0F;
        Mon, 27 Apr 2020 00:08:12 -0700 (PDT)
Received: from zn.tnic (p200300EC2F05F000D9541802070C4AE1.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:d954:1802:70c:4ae1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2D5D1EC0CDA;
        Mon, 27 Apr 2020 09:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587971290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3CxZwGBTt+ToXUeMtFGEKT2BZI/KNjbUZlpY/rw/Ztg=;
        b=W2a981xvH2aNCGTvcwxFjU0F46f/6RRi1rqoV5zYGK9c2LGLloo6nejMad5RsnNg3Yr6+R
        h3zLgOweECmDHK0Te5ziXOnmPWVOoXM9xyvInwmywrfjvgN7fliS+r2rBH9+Yfj6bqV606
        repydKjEz666T8RBkLKYkdrNiD0BSHQ=
Date:   Mon, 27 Apr 2020 09:08:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] EDAC/ghes: Remove local variable rdr_mask in
 ghes_edac_dmidecode()
Message-ID: <20200427070802.GA11036@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-7-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-7-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:10PM +0200, Robert Richter wrote:
> The local variable rdr_mask serves as a static constant here. It hides
> what the code is doing. Remove it and replace it with the actual logic
> that checks some bits.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index a5890afa9c71..038e560fd332 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -191,7 +191,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
>  		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
>  		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
> -		u16 rdr_mask = BIT(7) | BIT(13);
>  
>  		if (entry->size == 0xffff) {
>  			pr_info("Can't get DIMM%i size\n",
> @@ -241,7 +240,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  		default:
>  			if (entry->type_detail & BIT(6))
>  				dimm->mtype = MEM_RMBS;
> -			else if ((entry->type_detail & rdr_mask) == rdr_mask)
> +			else if ((entry->type_detail & BIT(7)) &&
> +				 (entry->type_detail & BIT(13)))

Well, "checks some bits" doesn't make it more telling than checking a
descriptive name like "rdr_mask" but ok, since we're assigning MEM_RDR
here, it is still clear what the check does.

Btw, please write it like this:

			else if (entry->type_detail & (BIT(7) | BIT(13)))

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
