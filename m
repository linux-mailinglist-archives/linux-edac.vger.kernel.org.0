Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDA243AEA
	for <lists+linux-edac@lfdr.de>; Thu, 13 Aug 2020 15:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMNoN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Aug 2020 09:44:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726053AbgHMNoM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Aug 2020 09:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597326250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wrh7SXz1gHM5MAGHpwCXxQx2upVBjWzIIwEO32ATCoo=;
        b=BluMllREnKuiE0d7pINu9TzyOQY6l5mI/7xGntmMPzWj/ScfSZLa4PVF5r0Karc6KqCfI1
        4Q8lhLg+H6IoNPOHkacUUiYnv1/KjjfGzJD8INnWZC2UaoYJtN3ZgDm+xstQ48Rrx7aXk6
        AcNIW1TYO4W+6JDTi0FmGhnjPZsBdys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-ko1zUyZWPs61tCEBw4W32A-1; Thu, 13 Aug 2020 09:44:20 -0400
X-MC-Unique: ko1zUyZWPs61tCEBw4W32A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51E981019626;
        Thu, 13 Aug 2020 13:44:07 +0000 (UTC)
Received: from napanee.usersys.redhat.com (dhcp-17-195.bos.redhat.com [10.18.17.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB2C25F206;
        Thu, 13 Aug 2020 13:44:06 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 9E67EC1C51; Thu, 13 Aug 2020 09:44:06 -0400 (EDT)
Date:   Thu, 13 Aug 2020 09:44:06 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     bp@suse.de, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ie31200: fallback if host bridge device is already
 initialized
Message-ID: <20200813134406.23dvvsulfxend5jx@redhat.com>
References: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
User-Agent: NeoMutt/20200501
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 16, 2020 at 02:25:11PM -0400, Jason Baron wrote:
> The Intel uncore driver may claim some of the pci ids from ie31200 which
> means that the ie31200 edac driver will not initialize them as part of
> pci_register_driver().
> 
> Let's add a fallback for this case to 'pci_get_device()' to get a
> reference on the device such that it can still be configured. This is
> similar in approach to other edac drivers.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-edac <linux-edac@vger.kernel.org>
> ---
>  drivers/edac/ie31200_edac.c | 50 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index d68346a..ebe5099 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -170,6 +170,8 @@
>  	(n << (28 + (2 * skl) - PAGE_SHIFT))
>  
>  static int nr_channels;
> +static struct pci_dev *mci_pdev;
> +static int ie31200_registered = 1;
>  
>  struct ie31200_priv {
>  	void __iomem *window;
> @@ -538,12 +540,16 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
>  static int ie31200_init_one(struct pci_dev *pdev,
>  			    const struct pci_device_id *ent)
>  {
> -	edac_dbg(0, "MC:\n");
> +	int rc;
>  
> +	edac_dbg(0, "MC:\n");
>  	if (pci_enable_device(pdev) < 0)
>  		return -EIO;
> +	rc = ie31200_probe1(pdev, ent->driver_data);
> +	if (rc == 0 && !mci_pdev)
> +		mci_pdev = pci_dev_get(pdev);
>  
> -	return ie31200_probe1(pdev, ent->driver_data);
> +	return rc;
>  }
>  
>  static void ie31200_remove_one(struct pci_dev *pdev)
> @@ -552,6 +558,8 @@ static void ie31200_remove_one(struct pci_dev *pdev)
>  	struct ie31200_priv *priv;
>  
>  	edac_dbg(0, "\n");
> +	pci_dev_put(mci_pdev);
> +	mci_pdev = NULL;
>  	mci = edac_mc_del_mc(&pdev->dev);
>  	if (!mci)
>  		return;
> @@ -593,17 +601,53 @@ static struct pci_driver ie31200_driver = {
>  
>  static int __init ie31200_init(void)
>  {
> +	int pci_rc, i;
> +
>  	edac_dbg(3, "MC:\n");
>  	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
>  	opstate_init();
>  
> -	return pci_register_driver(&ie31200_driver);
> +	pci_rc = pci_register_driver(&ie31200_driver);
> +	if (pci_rc < 0)
> +		goto fail0;
> +
> +	if (!mci_pdev) {
> +		ie31200_registered = 0;
> +		for (i = 0; ie31200_pci_tbl[i].vendor != 0; i++) {
> +			mci_pdev = pci_get_device(ie31200_pci_tbl[i].vendor,
> +						  ie31200_pci_tbl[i].device,
> +						  NULL);
> +			if (mci_pdev)
> +				break;
> +		}
> +		if (!mci_pdev) {
> +			edac_dbg(0, "ie31200 pci_get_device fail\n");
> +			pci_rc = -ENODEV;
> +			goto fail1;
> +		}
> +		pci_rc = ie31200_init_one(mci_pdev, &ie31200_pci_tbl[i]);
> +		if (pci_rc < 0) {
> +			edac_dbg(0, "ie31200 init fail\n");
> +			pci_rc = -ENODEV;
> +			goto fail1;
> +		}
> +	}
> +	return 0;
> +
> +fail1:
> +	pci_unregister_driver(&ie31200_driver);
> +fail0:
> +	pci_dev_put(mci_pdev);
> +
> +	return pci_rc;
>  }
>  
>  static void __exit ie31200_exit(void)
>  {
>  	edac_dbg(3, "MC:\n");
>  	pci_unregister_driver(&ie31200_driver);
> +	if (!ie31200_registered)
> +		ie31200_remove_one(mci_pdev);
>  }
>  
>  module_init(ie31200_init);

We tested this inside in machines having this issue and it works.
Patch looks good to me.

Acked-by: Aristeu Rozanski <aris@redhat.com>

-- 
Aristeu

