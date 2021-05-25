Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D01390A28
	for <lists+linux-edac@lfdr.de>; Tue, 25 May 2021 22:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhEYUEC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 May 2021 16:04:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57664 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232742AbhEYUEB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 May 2021 16:04:01 -0400
Received: from zn.tnic (p200300ec2f0c1b00461d55376053aa07.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1b00:461d:5537:6053:aa07])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 81F371EC0249;
        Tue, 25 May 2021 22:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1621972950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kKmJ94cXhtjrWM6K54qe0OB7u9xJg/lrPazNRZKb8ig=;
        b=LoXChJs1KWMr/uPz9jC1TIxV10MKf1Rr3Xs54LJ9thyLFcmIxrjdRfs1IgZ4G4YFALmij4
        Yje7e9xzvpXKvhrS7xjnl3mUcS/tb6DPakNh5IGmxj6VQiu6TFWwm/1uXmgVmtYKNCKdPt
        Q/d8IU6ITJLNRGs10+gCjOWB+f9Y060=
Date:   Tue, 25 May 2021 22:02:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Yazen Ghannam as maintainer for
 EDAC-AMD64
Message-ID: <YK1X0MJuBFf4699w@zn.tnic>
References: <20210525194834.2710362-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210525194834.2710362-1-Yazen.Ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, May 25, 2021 at 07:48:34PM +0000, Yazen Ghannam wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Also, include the mce_amd* files under this section.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60f4c3079b11..c5f7853ef2b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6443,10 +6443,11 @@ F:	Documentation/filesystems/ecryptfs.rst
>  F:	fs/ecryptfs/
>  
>  EDAC-AMD64
> -M:	Borislav Petkov <bp@alien8.de>
> +M:	Yazen Ghannam <yazen.ghannam@amd.com>
>  L:	linux-edac@vger.kernel.org
> -S:	Maintained
> +S:	Supported
>  F:	drivers/edac/amd64_edac*
> +F:	drivers/edac/mce_amd*
>  
>  EDAC-ARMADA
>  M:	Jan Luebbe <jlu@pengutronix.de>
> -- 

Thanks for taking over - Godspeed! :-)

Applied,
thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
