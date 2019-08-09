Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA4087AE7
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2019 15:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfHINPQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Aug 2019 09:15:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43872 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHINPQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 9 Aug 2019 09:15:16 -0400
Received: from zn.tnic (p200300EC2F0BAF004D276273DCAF0EAA.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:af00:4d27:6273:dcaf:eaa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C2EC1EC0B07;
        Fri,  9 Aug 2019 15:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565356515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sTeaFwbbAjE+f6AcN4Z6yDkT173vzN9tQEm11E8OlTA=;
        b=RYY8FKu7Twf/EdUKVlLXRvsHCtn439oWBKH7rrhZbR0L61VvLkZlXzwwDNLVg8UmWbylfv
        zbk3z0cKDnrq2C1RUIVHp3ZuFiJRa3RJ6mN+B6rGnRPh4oe2GvL5abRkxuypeW9ChXoitg
        /AgJWbAhoBdgb3wnJrkbUmltKUVFoJo=
Date:   Fri, 9 Aug 2019 15:15:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/24] EDAC, ghes: Fix grain calculation
Message-ID: <20190809131559.GF2152@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-3-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-3-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:08:57PM +0000, Robert Richter wrote:
> The conversion from the physical address mask to a grain (defined as
> granularity in bytes) is broken:
> 
> 	e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> 
> E.g., a physical address mask of ~0xfff should give a grain of 0x1000,
> instead the grain is wrong with the upper bits always set. We also
> remove the limitation to the page size as the granularity is unrelated
> to the page size used in the system. We fix this with:
> 
> 	e->grain = ~mem_err->physical_addr_mask + 1;
> 
> Note: We need to adopt the grain_bits calculation as e->grain is now a
> power of 2 and no longer a bit mask. The formula is now the same as in
> edac_mc and can later be unified.

Please refrain from using "We" or "I" or etc personal pronouns in a
commit message and in the code comments below.

From Documentation/process/submitting-patches.rst:

 "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour."

Please fix all your other commit messages for the next submission.

> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 7f19f1c672c3..d095d98d6a8d 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -222,6 +222,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	/* Cleans the error report buffer */
>  	memset(e, 0, sizeof (*e));
>  	e->error_count = 1;
> +	e->grain = 1;
>  	strcpy(e->label, "unknown label");
>  	e->msg = pvt->msg;
>  	e->other_detail = pvt->other_detail;
> @@ -317,7 +318,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  
>  	/* Error grain */
>  	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
> -		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
> +		e->grain = ~mem_err->physical_addr_mask + 1;

This is assuming that that ->physical_addr_mask is contiguous but I
don't trust any firmware. I guess we can leave it like that for now
until some "inventive" firmware actually does it.

>  
>  	/* Memory error location, mapped on e->location */
>  	p = e->location;
> @@ -433,8 +434,15 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  	if (p > pvt->other_detail)
>  		*(p - 1) = '\0';
>  
> +	/*
> +	 * We expect the hw to report a reasonable grain, fallback to
> +	 * 1 byte granularity otherwise.
> +	 */
> +	if (WARN_ON_ONCE(!e->grain))

Please move that WARN_ON_ONCE in the

	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)

branch above because you're presetting grain to 1 so the warn should be
close to where it could happen, i.e., when coming from the firmware.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
