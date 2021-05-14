Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D6380717
	for <lists+linux-edac@lfdr.de>; Fri, 14 May 2021 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhENKYN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 May 2021 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhENKYN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 14 May 2021 06:24:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE87C061574;
        Fri, 14 May 2021 03:23:02 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b2c00e75fd5d24a8a460d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2c00:e75f:d5d2:4a8a:460d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 07EF91EC03A0;
        Fri, 14 May 2021 12:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1620987781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8uN+blNbUuTK1vAwzHY9/vcgYGqsYhOW4M+ryJ3GiSU=;
        b=F7lBy7xAxK9LBSD9DH34xrgrd+Khh424Ubas3gkWty3pu2mFkiFEPhL8k9Pu3kUmBbhPXI
        0EoOhwc/A8ray8RpYVq/t/2LrJE1W2qlo5NSVfoRLaU3FWocSVABzUuvKkOL+24VXjFq8A
        jfBbOkAqWSeNQjepmS7H7+DbeGkJdhU=
Date:   Fri, 14 May 2021 12:22:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Bixuan Cui <cuibixuan@huawei.com>
Cc:     kristo@kernel.org, mchehab@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next v2] EDAC: ti: Add missing MODULE_DEVICE_TABLE
Message-ID: <YJ5PgRDG9OZ4msyJ@zn.tnic>
References: <20210512033727.26701-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210512033727.26701-1-cuibixuan@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, May 12, 2021 at 11:37:27AM +0800, Bixuan Cui wrote:
> The module misses MODULE_DEVICE_TABLE() for of_device_id tables
> and thus never autoloads on ID matches.
> Add the missing declarations.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> Changes v2:
> * Modify the commit message to make it more suitable.
> 
>  drivers/edac/ti_edac.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index e7eae20f83d1..169f96e51c29 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -197,6 +197,7 @@ static const struct of_device_id ti_edac_of_match[] = {
>  	{ .compatible = "ti,emif-dra7xx", .data = (void *)EMIF_TYPE_DRA7 },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, ti_edac_of_match);
>  
>  static int _emif_get_id(struct device_node *node)
>  {
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
