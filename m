Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A452CBB84
	for <lists+linux-edac@lfdr.de>; Wed,  2 Dec 2020 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLBL0B (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Dec 2020 06:26:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36320 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLBL0B (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 2 Dec 2020 06:26:01 -0500
Received: from zn.tnic (p200300ec2f161b00e186258fb055049e.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1b00:e186:258f:b055:49e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5938E1EC04D6;
        Wed,  2 Dec 2020 12:25:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606908319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=auyM2v2JUyjcuzu7CPUf133Nl+wA9VC3RsABVwER50A=;
        b=HrvlMCQDSwyBJUvAUrSYUGvqLJKpRoJhr2fJO/O7GryF/KJ/kaNcQ+FZC0owkEvxlRx3ke
        PWcsKYyHABE1dZfvDA6gAKmgs66Y4gaTbr2LP93YxZSHb97QCsPFDwuwuu/4EBGmtIXH7d
        QS5VnEr+bP4cyAALPbsFlCfAJYQllXI=
Date:   Wed, 2 Dec 2020 12:25:15 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Wang ShaoBo <bobo.shaobowang@huawei.com>, mchehab@kernel.org,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        cj.chengjian@huawei.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] EDAC, mv64x60: Fix error return code in
 mv64x60_pci_err_probe()
Message-ID: <20201202112515.GC2951@zn.tnic>
References: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124063009.1529-1-bobo.shaobowang@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Nov 24, 2020 at 02:30:09PM +0800, Wang ShaoBo wrote:
> Fix to return -ENODEV error code when edac_pci_add_device() failed instaed
> of 0 in mv64x60_pci_err_probe(), as done elsewhere in this function.
> 
> Fixes: 4f4aeeabc061 ("drivers-edac: add marvell mv64x60 driver")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  drivers/edac/mv64x60_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c
> index 3c68bb525d5d..456b9ca1fe8d 100644
> --- a/drivers/edac/mv64x60_edac.c
> +++ b/drivers/edac/mv64x60_edac.c
> @@ -168,6 +168,7 @@ static int mv64x60_pci_err_probe(struct platform_device *pdev)
>  
>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>  		edac_dbg(3, "failed edac_pci_add_device()\n");
> +		res = -ENODEV;
>  		goto err;
>  	}

That driver depends on MV64X60 and I don't see anything in the tree
enabling it and I can't select it AFAICT:

config MV64X60
        bool
        select PPC_INDIRECT_PCI
        select CHECK_CACHE_COHERENCY

PPC folks, what do we do here?

If not used anymore, I'd love to have one less EDAC driver.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
