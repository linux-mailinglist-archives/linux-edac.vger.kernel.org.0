Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCA8B257
	for <lists+linux-edac@lfdr.de>; Tue, 13 Aug 2019 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfHMI0H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Aug 2019 04:26:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727793AbfHMI0H (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Aug 2019 04:26:07 -0400
Received: from zn.tnic (p200300EC2F0D240075AA4C13F769B7E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:75aa:4c13:f769:b7e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4C8A01EC04CD;
        Tue, 13 Aug 2019 10:26:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565684766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kMHQqLdJXGlWXDypDhXFGkicG1MjfC0RcqBNXKxeJyw=;
        b=LoW/iMar3Wlq4ekq1oG1U/IP9qMzb9DTVQdgQ8q16OBILecjuGaswbzJnRbbCViXEKCbNY
        1VbZUGF2/ejKyz2T7heBR6H/71Rgc6IbIBo5tEbP6edOIuMXNB6howRTl8i/guemt10w37
        5ye2vqyukGIi3zUjSDv1vtEUdhKtlcg=
Date:   Tue, 13 Aug 2019 10:26:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/24] EDAC, mc: Fix and improve sysfs init functions
Message-ID: <20190813082655.GD16770@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-6-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-6-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:02PM +0000, Robert Richter wrote:
> Remove gotos as they just create overhead.

Overhead?

> Also, fix debug message for
> the case edac_create_dimm_object() is failing.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc_sysfs.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 7c01e1cc030c..29dd9719f82f 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -655,8 +655,9 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
>  	err = device_add(&dimm->dev);
>  	if (err)
>  		put_device(&dimm->dev);
> -
> -	edac_dbg(0, "created rank/dimm device %s\n", dev_name(&dimm->dev));
> +	else
> +		edac_dbg(0, "created rank/dimm device %s\n",
> +			dev_name(&dimm->dev));

Please add a message to the error case too.

>  	return err;
>  }
> @@ -938,7 +939,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	if (err < 0) {
>  		edac_dbg(1, "failure: create device %s\n", dev_name(&mci->dev));
>  		put_device(&mci->dev);
> -		goto out;
> +		return err;
>  	}
>  
>  	/*
> @@ -987,7 +988,6 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	}
>  	device_unregister(&mci->dev);
>  
> -out:
>  	return err;
>  }
>  
> @@ -1044,10 +1044,8 @@ int __init edac_mc_sysfs_init(void)
>  	int err;
>  
>  	mci_pdev = kzalloc(sizeof(*mci_pdev), GFP_KERNEL);
> -	if (!mci_pdev) {
> -		err = -ENOMEM;
> -		goto out;
> -	}
> +	if (!mci_pdev)
> +		return -ENOMEM;
>  
>  	mci_pdev->bus = edac_get_sysfs_subsys();
>  	mci_pdev->type = &mc_attr_type;
> @@ -1056,15 +1054,10 @@ int __init edac_mc_sysfs_init(void)
>  
>  	err = device_add(mci_pdev);
>  	if (err < 0)
> -		goto out_put_device;
> -
> -	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
> -
> -	return 0;
> +		put_device(mci_pdev);
> +	else
> +		edac_dbg(0, "device %s created\n", dev_name(mci_pdev));

Ditto.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
