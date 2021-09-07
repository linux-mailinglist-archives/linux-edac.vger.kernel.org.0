Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7EF40279B
	for <lists+linux-edac@lfdr.de>; Tue,  7 Sep 2021 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbhIGLNG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 7 Sep 2021 07:13:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33424 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233669AbhIGLNF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 7 Sep 2021 07:13:05 -0400
Received: from zn.tnic (p200300ec2f1090004feb6f43ecfb7e39.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:9000:4feb:6f43:ecfb:7e39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3558B1EC0324;
        Tue,  7 Sep 2021 13:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631013118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Rb+s6nWrXZZPb+h+qjGLqr6R+QDvS03QLx+8+R4HbKA=;
        b=Hbs7V0sgghfv7SEsyxUvt4OaFXoMILNeyRAZclDALp3zA+tOkipvsBHDAwuuhVKoXDJUIr
        lo/AQv7tgh1HN9UVVYeqpy1zkEIy/eBh8Z9q5gb8/e7HWYNHmo39AUMJPIl8V0ihnhSUFA
        rCfXiDcA6EWpG3UXgojy6zF3lwic/2k=
Date:   Tue, 7 Sep 2021 13:11:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/device: Remove redundant initialization of pointer
 dev_ctl
Message-ID: <YTdI98H5yF55fYsC@zn.tnic>
References: <20210907105913.15077-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210907105913.15077-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 07, 2021 at 11:59:13AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable dev_ctl is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> Addresses-Coverity: ("Unused value")

I'll never get a public reference to what those things mean, will I?

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/edac/edac_device.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
> index 8c4d947fb848..a337f7afc3b9 100644
> --- a/drivers/edac/edac_device.c
> +++ b/drivers/edac/edac_device.c
> @@ -75,7 +75,6 @@ struct edac_device_ctl_info *edac_device_alloc_ctl_info(
>  	 * provide if we could simply hardcode everything into a single struct.
>  	 */
>  	p = NULL;
> -	dev_ctl = edac_align_ptr(&p, sizeof(*dev_ctl), 1);

Are you absolutely sure this function doesn't have any side-effects,
say, to &p and removing the call would break the pointer offsets for the
one-shot allocation?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
