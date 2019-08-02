Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 706837EDBB
	for <lists+linux-edac@lfdr.de>; Fri,  2 Aug 2019 09:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbfHBHmb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Aug 2019 03:42:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56340 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfHBHma (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Aug 2019 03:42:30 -0400
Received: from zn.tnic (p200300EC2F0D960039009D029409112E.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:9600:3900:9d02:9409:112e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8DE51EC09A0;
        Fri,  2 Aug 2019 09:42:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564731748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/UtwsoWOHyCwYxaqkD7pCcazSZC5S1yzYUzg69yEA1M=;
        b=kJbslpfjdHMYQSL1PgYVoW9RNvZQcoKYiWySwmslTXv4oKxSVM4nbSEX/OeXx7flgn6z99
        L3Oqw893Fi6HQxDRMxwo5S1tO54d5FBEwvngTqs6HUJnvPqHsJX2tMb2VNJ+UXDRyZECEn
        ySI8xUgVoJYTEQ2Pxri5B8wmQST7vxI=
Date:   Fri, 2 Aug 2019 09:42:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] EDAC/amd64: Recognize DRAM device type with
 EDAC_CTL_CAP
Message-ID: <20190802074224.GB30661@zn.tnic>
References: <20190709215643.171078-1-Yazen.Ghannam@amd.com>
 <20190709215643.171078-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190709215643.171078-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jul 09, 2019 at 09:56:55PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> AMD Family 17h systems support x4 and x16 DRAM devices. However, the
> device type is not checked when setting EDAC_CTL_CAP.
> 
> Set the appropriate EDAC_CTL_CAP flag based on the device type.
> 
> Fixes: 2d09d8f301f5 ("EDAC, amd64: Determine EDAC MC capabilities on Fam17h")

This is better: a patch which fixes a previous patch and is simple,
small and clear. That you can tag with Fixes: just fine.

> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> Link:
> https://lkml.kernel.org/r/20190531234501.32826-4-Yazen.Ghannam@amd.com
> 
> v1->v2:
> * No change.
> 
>  drivers/edac/amd64_edac.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index dd60cf5a3d96..125d6e2a828e 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3150,12 +3150,15 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
>  static inline void
>  f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
>  {
> -	u8 i, ecc_en = 1, cpk_en = 1;
> +	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
>  
>  	for_each_umc(i) {
>  		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
>  			ecc_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
>  			cpk_en &= !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
> +
> +			dev_x4 &= !!(pvt->umc[i].dimm_cfg & BIT(6));
> +			dev_x16 &= !!(pvt->umc[i].dimm_cfg & BIT(7));

Are those bits mutually exclusive?

I.e., so that you can do:

	if (dev_x4)
		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
	else
		mci->edac_ctl_cap |= EDAC_FLAG_S16ECD16ED;

?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
