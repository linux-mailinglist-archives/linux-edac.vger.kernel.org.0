Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7858D140104
	for <lists+linux-edac@lfdr.de>; Fri, 17 Jan 2020 01:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgAQAff (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jan 2020 19:35:35 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgAQAfe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jan 2020 19:35:34 -0500
Received: from zn.tnic (p200300EC2F0B23003D0DC5C907B4D929.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:3d0d:c5c9:7b4:d929])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D0171EC0C8A;
        Fri, 17 Jan 2020 01:35:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579221333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i1i+BUVl6X3dVlLrJ1ezNZBhRrN2tvT8AcA1Jjxsl6o=;
        b=Zee8qfedPj1RhUqUw0X36j2qSZ1p5ge8Xp/CVKrXnCMY4M2kt1gi34TuURop2u/bHG3iaQ
        zMY+pc/mtH3ry1EDkTwT8GK8sV6j1mzaCVHRaRqJZHiTKBcV0Doc0hGmZqFzdGk/1cpk05
        wPcBc3z6midbSR7wjOt2MxiYqfT2wyA=
Date:   Fri, 17 Jan 2020 01:35:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Yash Shah <yash.shah@sifive.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-edac@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH]  EDAC/sifive: fix return value check in ecc_register()
Message-ID: <20200117003523.GK27148@zn.tnic>
References: <20200115150303.112627-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200115150303.112627-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 15, 2020 at 03:03:03PM +0000, Wei Yongjun wrote:
> In case of error, the function edac_device_alloc_ctl_info() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Fixes: 91abaeaaff35 ("EDAC/sifive: Add EDAC platform driver for SiFive SoCs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/edac/sifive_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> index c0cc72a3b2be..3a3dcb14ed99 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -54,8 +54,8 @@ static int ecc_register(struct platform_device *pdev)
>  	p->dci = edac_device_alloc_ctl_info(0, "sifive_ecc", 1, "sifive_ecc",
>  					    1, 1, NULL, 0,
>  					    edac_device_alloc_index());
> -	if (IS_ERR(p->dci))
> -		return PTR_ERR(p->dci);
> +	if (!p->dci)
> +		return -ENOMEM;
>  
>  	p->dci->dev = &pdev->dev;
>  	p->dci->mod_name = "Sifive ECC Manager";

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
