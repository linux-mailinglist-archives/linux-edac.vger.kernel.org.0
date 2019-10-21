Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B51DBDE6D3
	for <lists+linux-edac@lfdr.de>; Mon, 21 Oct 2019 10:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfJUInQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Oct 2019 04:43:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33536 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbfJUInP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 21 Oct 2019 04:43:15 -0400
Received: from zn.tnic (p2E584653.dip0.t-ipconnect.de [46.88.70.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF3441EC06BC;
        Mon, 21 Oct 2019 10:43:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1571647394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+kD1jAx8Cm45kEHTqdRITtIEL5bTWSpmcXQjoaK9FS8=;
        b=GD1wGdfH6JMpwKCUB4WkPwEazofhG+eixVieQYIjcBcyAlyfEppP/Jf43M0OBcBXkQ9dEl
        GI16y8DEjx2S8Nk2U7d7GJqVM/SMZvSK5+1EcsU11GFjajlUya305pDTrotqyCyGTidFx9
        Pm1qxhDKOmaLQ2vmCA+lxr0K2mDAO9w=
Date:   Mon, 21 Oct 2019 10:42:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] EDAC/amd64: Gather hardware information early
Message-ID: <20191021084234.GB7014@zn.tnic>
References: <20191018153114.39378-1-Yazen.Ghannam@amd.com>
 <20191018153114.39378-3-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018153114.39378-3-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 03:31:26PM +0000, Ghannam, Yazen wrote:
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
> Link:
> https://lkml.kernel.org/r/20190821235938.118710-9-Yazen.Ghannam@amd.com
> 
> rfc -> v1:
> * Fixup after making struct amd64_family_type fam_type global.
> 
>  drivers/edac/amd64_edac.c | 72 +++++++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b9a712819c68..4410da7c3a25 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3416,33 +3416,16 @@ static void compute_num_umcs(void)
>  	edac_dbg(1, "Number of UMCs: %x", num_umcs);
>  }
>  
> -static int init_one_instance(unsigned int nid)
> +static int get_hardware_info(struct amd64_pvt *pvt)
>  {
> -	struct pci_dev *F3 = node_to_amd_nb(nid)->misc;
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
>  		if (!pvt->umc) {
>  			ret = -ENOMEM;
> -			goto err_free;
> +			goto err_ret;
>  		}
>  
>  		pci_id1 = fam_type->f0_id;
> @@ -3452,18 +3435,33 @@ static int init_one_instance(unsigned int nid)
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

So you're freeing pvt->umc here but nothing in that function allocated
it. get_hardware_info() in probe_one_instance() did but if you do it
this way, it is kinda hard to follow and the layering is a bit iffy.

So what I'd suggest is:

* Rename get_hardware_info() to something like hw_info_get() so that
you can have a counterpart hw_info_put() which does any cleanup after
hw_info_get(), including the freeing of the ->umc.

* In probe_one_instance(), if init_one_instance() fails, call
hw_info_put() on the error path so that all your flow in the probe/init
functions is nicely ballanced and easily followed.

Makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
