Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE37DA149A
	for <lists+linux-edac@lfdr.de>; Thu, 29 Aug 2019 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfH2JWs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Aug 2019 05:22:48 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfH2JWs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 29 Aug 2019 05:22:48 -0400
Received: from zn.tnic (p200300EC2F0D0C00346F303E69D456DB.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c00:346f:303e:69d4:56db])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E43EC1EC0BFD;
        Thu, 29 Aug 2019 11:22:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567070566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q98Y/OGa51WnkiBTuk9hX1WNikpgq22MKUdtW3DJCMQ=;
        b=pgjmhZuwB6TJ8lpOMTQruGSANaY21h9eDSnRIayH73ydLm+Dbo/C2Xk+vfM1dUIFVthHwA
        kVGdW57HcZfOOfzOvnugBsG96/I7M0Su7bXMTmUKd0HiR+5jvAIbbABSfeXwV8CVZlQAQz
        6h0N7HREB7eM7Rur3EpzPsyCmcsoxeE=
Date:   Thu, 29 Aug 2019 11:22:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/10] EDAC/amd64: Gather hardware information
 early
Message-ID: <20190829092241.GB1312@zn.tnic>
References: <20190821235938.118710-1-Yazen.Ghannam@amd.com>
 <20190821235938.118710-9-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190821235938.118710-9-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Aug 22, 2019 at 12:00:02AM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Split out gathering hardware information from init_one_instance() into a
> separate function get_hardware_info().
> 
> This is necessary so that the information can be cached earlier and used
> to check if memory is populated and if ECC is enabled on a node.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 76 +++++++++++++++++++++++----------------
>  1 file changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 4d1e6daa7ec4..84832771dec0 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3405,34 +3405,17 @@ static void compute_num_umcs(void)
>  	edac_dbg(1, "Number of UMCs: %x", num_umcs);
>  }
>  
> -static int init_one_instance(unsigned int nid)
> +static int get_hardware_info(struct amd64_pvt *pvt,
> +			     struct amd64_family_type *fam_type)
>  {
> -	struct pci_dev *F3 = node_to_amd_nb(nid)->misc;
> -	struct amd64_family_type *fam_type = NULL;
> -	struct mem_ctl_info *mci = NULL;
> -	struct edac_mc_layer layers[2];
> -	struct amd64_pvt *pvt = NULL;
>  	u16 pci_id1, pci_id2;
> -	int err = 0, ret;
> -
> -	ret = -ENOMEM;
> -	pvt = kzalloc(sizeof(struct amd64_pvt), GFP_KERNEL);
> -	if (!pvt)
> -		goto err_ret;
> -
> -	pvt->mc_node_id	= nid;
> -	pvt->F3 = F3;
> -
> -	ret = -EINVAL;
> -	fam_type = per_family_init(pvt);
> -	if (!fam_type)
> -		goto err_free;
> +	int ret = -EINVAL;
>  
>  	if (pvt->fam >= 0x17) {
>  		pvt->umc = kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);

Yeah, a get_hardware_info() function which does an allocation of that
struct amd64_umc on => F17 which is only 20 bytes. Just add it into the
pvt struct:

struct amd64_pvt {
	...
	struct amd64_umc umc;  /* UMC registers */
};

and be done with it. This should simplify the code flow here a bit and
20 bytes more per pvt is not a big deal.

And I know we do test "if (pvt->umc)" in a bunch of places but that can
be replaced with a "if (pvt->fam >= 0x17)" test which is equivalent.

And that conversion should be a single patch.

>  		if (!pvt->umc) {
>  			ret = -ENOMEM;
> -			goto err_free;
> +			goto err_ret;
>  		}
>  
>  		pci_id1 = fam_type->f0_id;
> @@ -3442,18 +3425,34 @@ static int init_one_instance(unsigned int nid)
>  		pci_id2 = fam_type->f2_id;
>  	}
>  
> -	err = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
> -	if (err)
> +	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
> +	if (ret)
>  		goto err_post_init;
>  
>  	read_mc_regs(pvt);
>  
> +	return 0;
> +
> +err_post_init:
> +	if (pvt->fam >= 0x17)
> +		kfree(pvt->umc);
> +
> +err_ret:
> +	return ret;
> +}
> +
> +static int init_one_instance(struct amd64_pvt *pvt,
> +			     struct amd64_family_type *fam_type)

Yeah, that fam_type can be made global. No need to hand it around in
functions since it is going to be a single struct per system. Do that in
another, separate patch please.

After you've done those things, this patch would become a lot simpler.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
