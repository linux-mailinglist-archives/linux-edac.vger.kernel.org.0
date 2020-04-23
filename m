Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F941B62C4
	for <lists+linux-edac@lfdr.de>; Thu, 23 Apr 2020 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgDWRzR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Apr 2020 13:55:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50534 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729995AbgDWRzR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 Apr 2020 13:55:17 -0400
Received: from zn.tnic (p200300EC2F0D2E00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2e00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C4E51EC0716;
        Thu, 23 Apr 2020 19:55:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587664516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fdCosX/br/wnZBw1bt/2AcGwoWApmog1vU5fGIBemdU=;
        b=eFnWmoI2go161GI7ep3qWvw4Pu+5aW1NYgHeRGRtmk7ZcbRcT3qi5Vx2VY6K/4NcNs9cr2
        PFwMXQMVgyKUI4iVh3jPHS5lVKeHywy9/TW0xse2gDrJIbPAOq4hnJ46Maeiqbtltfjeod
        pSGeVL+c65UxG8RRU7CQ4OeqQiye3YI=
Date:   Thu, 23 Apr 2020 19:55:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] EDAC/ghes: Remove unused members of struct
 ghes_edac_pvt, rename it to ghes_mci
Message-ID: <20200423175517.GG26021@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-4-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-4-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:07PM +0200, Robert Richter wrote:
> The struct members list and ghes of struct ghes_edac_pvt are unused,
> remove them. On that occasion, rename it to struct ghes_mci. This is
> shorter and aligns better with the current naming scheme.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index cb3dab56a875..39efce0df881 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -15,9 +15,7 @@
>  #include "edac_module.h"
>  #include <ras/ras_event.h>
>  
> -struct ghes_edac_pvt {
> -	struct list_head list;
> -	struct ghes *ghes;
> +struct ghes_mci {

No, that should be "ghes_pvt" because it *is* ghes_edac's private
structure and there's also an mci pointer in it.

>  	struct mem_ctl_info *mci;
>  
>  	/* Buffers for the error handling routine */
> @@ -32,7 +30,7 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
>   * also provides the necessary (implicit) memory barrier for the SMP
>   * case to make the pointer visible on another CPU.
>   */
> -static struct ghes_edac_pvt *ghes_pvt;
> +static struct ghes_mci *ghes_pvt;
>  
>  /* GHES registration mutex */
>  static DEFINE_MUTEX(ghes_reg_mutex);
> @@ -203,7 +201,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  {
>  	struct edac_raw_error_desc *e;
>  	struct mem_ctl_info *mci;
> -	struct ghes_edac_pvt *pvt;
> +	struct ghes_mci *pvt;
>  	unsigned long flags;
>  	char *p;
>  
> @@ -457,7 +455,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	bool fake = false;
>  	int rc = 0, num_dimm = 0;
>  	struct mem_ctl_info *mci;
> -	struct ghes_edac_pvt *pvt;
> +	struct ghes_mci *pvt;
>  	struct edac_mc_layer layers[1];
>  	struct ghes_edac_dimm_fill dimm_fill;
>  	unsigned long flags;
> @@ -494,7 +492,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	layers[0].size = num_dimm;
>  	layers[0].is_virt_csrow = true;
>  
> -	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));

The sizeof() change doesn't make it better because now I have to go look
up what pvt is.

sizeof(struct ghes_pvt) tells you what size you're getting here.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
