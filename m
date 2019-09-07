Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB71EAC4D5
	for <lists+linux-edac@lfdr.de>; Sat,  7 Sep 2019 07:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbfIGF7a (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 7 Sep 2019 01:59:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52384 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733303AbfIGF7a (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 7 Sep 2019 01:59:30 -0400
Received: from zn.tnic (p200300EC2F2077001838F3417D010484.dip0.t-ipconnect.de [IPv6:2003:ec:2f20:7700:1838:f341:7d01:484])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A4D141EC0528;
        Sat,  7 Sep 2019 07:59:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1567835968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=d7NMox/+dvpQNLkfYKsBZgqhLe96vIyuMuvL3ccHE8Y=;
        b=QmoNlYv89oH7ItOnb6zNYqxucE75zFzjD1m2c+Afag6O87zWDq3Cl/7JZg5Dpet4crdRNI
        ufKYD4GbCiz361/96Zwsby7BmBUjXhvXv2UpPxDvZ7dc65+J0l2sb/4VfqX1A6S4rAboMU
        CGkWwEZelNvALYJnxGftt1eEdgAMjCA=
Date:   Sat, 7 Sep 2019 07:59:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190907055917.GA10446@zn.tnic>
References: <20190906192131.8ced0ca112146f32d82b6cae@knights.ucf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906192131.8ced0ca112146f32d82b6cae@knights.ucf.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 06, 2019 at 11:21:38PM +0000, Isaac Vaughn wrote:
> Add the new Family 17h Model 70h PCI IDs (device 18h functions 0 and 6)
> to the AMD64 EDAC module.
> 
> Cc: Borislav Petkov <bp@alien8.de> (maintainer:EDAC-AMD64)
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org> (supporter:EDAC-CORE)
> Cc: James Morse <james.morse@arm.com> (reviewer:EDAC-CORE)
> Cc: linux-edac@vger.kernel.org (open list:EDAC-AMD64)
> Cc: linux-kernel@vger.kernel.org (open list)
> Signed-off-by: Isaac Vaughn <isaac.vaughn@knights.ucf.edu>
> ---
>  drivers/edac/amd64_edac.c | 13 +++++++++++++
>  drivers/edac/amd64_edac.h |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 873437be86d9..a35c97f9100a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -2253,6 +2253,15 @@ static struct amd64_family_type family_types[] = {
>  			.dbam_to_cs		= f17_base_addr_to_cs_size,
>  		}
>  	},
> +	[F17_M70H_CPUS] = {
> +		.ctl_name = "F17h_M70h",
> +		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
> +		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
> +		.ops = {
> +			.early_channel_count	= f17_early_channel_count,
> +			.dbam_to_cs		= f17_base_addr_to_cs_size,

You still have f17_base_addr_to_cs_size here. If you'd built it against
the branch I pointed you at:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

it would have failed.

Anyway, I fixed it up and applied it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
