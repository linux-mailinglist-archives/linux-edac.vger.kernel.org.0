Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65EA2438DD
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732522AbfFMPJK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 11:09:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51706 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732365AbfFMN6d (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 09:58:33 -0400
Received: from zn.tnic (p200300EC2F06D50021762B7834B766B8.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d500:2176:2b78:34b7:66b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 24D161EC0235;
        Thu, 13 Jun 2019 15:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560434311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Maz4qhAv7CzEe1mERK2XkKpnUOaeRk1rwNJ3zxGQF7I=;
        b=N7WXUKUIVx0KgZifoTbCmMOS7qM3sPGf7X/zw2AGmVlrIytZIXqgLLPwJHp3m0cCWg4JHi
        nb53PKNfplx9ToP2i9o/CXOlul4FRsMK1FcqRDiH11isM00a4NU99UpEom0qVpZyXq3aL9
        bVXYL6LJaKzUkImk+V2fOArCJJkqHuE=
Date:   Thu, 13 Jun 2019 15:58:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] EDAC/amd64: Fix number of DIMMs and Chip Select
 bases/masks on Family17h
Message-ID: <20190613135822.GC11598@zn.tnic>
References: <20190531234501.32826-1-Yazen.Ghannam@amd.com>
 <20190531234501.32826-2-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190531234501.32826-2-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, May 31, 2019 at 11:45:11PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> ...because AMD Family 17h systems support 2 DIMMs, 4 CS bases, and 2 CS
> masks per channel.
> 
> Fixes: 07ed82ef93d6 ("EDAC, amd64: Add Fam17h debug output")
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 873437be86d9..9fa2f205f05c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -810,7 +810,7 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
>  
>  	edac_printk(KERN_DEBUG, EDAC_MC, "UMC%d chip selects:\n", ctrl);
>  
> -	for (dimm = 0; dimm < 4; dimm++) {
> +	for (dimm = 0; dimm < 2; dimm++) {
>  		size0 = 0;
>  		cs0 = dimm * 2;
>  
> @@ -942,6 +942,9 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
>  	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
>  		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
>  		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
> +	} else if (pvt->fam >= 0x17) {
> +		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
> +		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;

I guess it is about time that function gets turned into a switch-case so
that the assignment lines do not get duplicated.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
