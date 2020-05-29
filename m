Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B611E7E80
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 15:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2NUR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 09:20:17 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgE2NUQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 09:20:16 -0400
Received: from zn.tnic (p200300ec2f0f5e00857ed3907e46012a.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5e00:857e:d390:7e46:12a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CDA41EC03C5;
        Fri, 29 May 2020 15:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590758413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XVaZiehB90ylZm8b6gsSiQdmzzkWhRJkko9zO0S+8Bc=;
        b=Qtz75ZfzhMRraEPBn64PkGQTSDRPq5rwwteABf59yEftCQGx51Vuwdsj1TFr8Y+Ge9dqjS
        jgy6ukI+tRz2vO3Iw6y74dhjL8+dQta1P3LZadeTvf4wUe/DwEaPYpngvpFIFR4gnRcQmA
        NqWT9Vj/LG2QDcrc30h5KRNqlmRb74E=
Date:   Fri, 29 May 2020 15:20:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: remove redundant assignment to variable ret
Message-ID: <20200529132008.GI9011@zn.tnic>
References: <20200429154847.287001-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200429154847.287001-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 29, 2020 at 04:48:47PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable ret is being assigned with a value that is never read
> and it is being updated later with a new value. The initialization is
> redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/amd64_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 6bdc5bb8c8bc..e33f66cee132 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3400,7 +3400,7 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
>  static int hw_info_get(struct amd64_pvt *pvt)
>  {
>  	u16 pci_id1, pci_id2;
> -	int ret = -EINVAL;
> +	int ret;
>  
>  	if (pvt->fam >= 0x17) {
>  		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
