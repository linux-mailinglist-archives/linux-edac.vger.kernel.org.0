Return-Path: <linux-edac+bounces-129-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5207FBF2F
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 17:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16853B2115B
	for <lists+linux-edac@lfdr.de>; Tue, 28 Nov 2023 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343F35287;
	Tue, 28 Nov 2023 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sirOE4d+"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67637D22;
	Tue, 28 Nov 2023 16:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D74C433C7;
	Tue, 28 Nov 2023 16:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701188942;
	bh=mXCYtJybktTvUcwZQ3lRqv8LehqnyJb7pxdRFjMyvM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sirOE4d+QSF1Xl8kCiAmMwh0c4Ifo6V/m0IMgnATnemqcHHCHPzwiQCePwNzdciEF
	 29PQMD+MEHTQqtIMYdH3xK6n8hWEUed9XC0fQp9JS1LQXbdgfC76lAo7jSV4HVChq7
	 m39Fy1piWhX4Rz2rp541eT1WZEgrW+Hqq8F+b5ic=
Date: Tue, 28 Nov 2023 16:28:59 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
	kernel-janitors@vger.kernel.org, error27@gmail.com
Subject: Re: [PATCH] EDAC/sysfs: Fix calling kobject_put() without kobj
 initialization
Message-ID: <2023112824-cupbearer-salvage-b064@gregkh>
References: <20231128130952.3372794-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130952.3372794-1-harshit.m.mogalapalli@oracle.com>

On Tue, Nov 28, 2023 at 05:09:52AM -0800, Harshit Mogalapalli wrote:
> In edac_pci_main_kobj_setup() when dev_root is NULL,
> kobject_init_and_add() is not called.
> 
>         if (err) { // err = -ENODEV;
>                 edac_dbg(1, "Failed to register '.../edac/pci'\n");
>                 goto kobject_init_and_add_fail; // call to kobject_put()
>         }
> 
> This will cause a runtime warning in kobject_put() if the above happens.
> Warning:
> "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."
> 
> Fix the error handling to avoid the above possible situation.
> 
> Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with Smatch and only compile tested.
> ---
>  drivers/edac/edac_pci_sysfs.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
> index 901d4cd3ca38..71a0d4b9c2cf 100644
> --- a/drivers/edac/edac_pci_sysfs.c
> +++ b/drivers/edac/edac_pci_sysfs.c
> @@ -370,12 +370,14 @@ static int edac_pci_main_kobj_setup(void)
>  
>  	/* Instanstiate the pci object */
>  	dev_root = bus_get_dev_root(edac_subsys);
> -	if (dev_root) {
> -		err = kobject_init_and_add(edac_pci_top_main_kobj,
> -					   &ktype_edac_pci_main_kobj,
> -					   &dev_root->kobj, "pci");
> -		put_device(dev_root);
> -	}
> +	if (!dev_root)
> +		goto kzalloc_fail;
> +
> +	err = kobject_init_and_add(edac_pci_top_main_kobj,
> +				   &ktype_edac_pci_main_kobj,
> +				   &dev_root->kobj, "pci");
> +	put_device(dev_root);
> +
>  	if (err) {
>  		edac_dbg(1, "Failed to register '.../edac/pci'\n");
>  		goto kobject_init_and_add_fail;
> -- 
> 2.39.3
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documentation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

