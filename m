Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45734754FA
	for <lists+linux-edac@lfdr.de>; Thu, 25 Jul 2019 19:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfGYRBA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 13:01:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43902 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGYRA7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 25 Jul 2019 13:00:59 -0400
Received: from nazgul.tnic (87-126-252-198.ip.btc-net.bg [87.126.252.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC361EC02FF;
        Thu, 25 Jul 2019 19:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1564074058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0dQmHOiTdZL04G/QdMjwXsWVRHfejPCN+tYWIEBHVzM=;
        b=Ic1pqbSM7/cbHB7Cfoqe3dUrLJk+JFguJLc24ZD8/D5NRgh/raq1E/cg/DDlXUDCMIdpLj
        IzmS7/iD70zk5RC2xOh9wZ5F/tOV2DvYJKaEvNATebtZByXxwf6BHZlDHPXfA95EL/MfOo
        9fxvl5gm4TAxzUqw/SEG+YiKzUE4taY=
Date:   Thu, 25 Jul 2019 19:00:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Edac Mailing List <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] MAINTAINERS: update EDAC entry to reflect current tree
 and maintainers
Message-ID: <20190725170050.GA27348@nazgul.tnic>
References: <1eb2d09e58500bef18428e2b3f52b54d3cd707d5.1564071419.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eb2d09e58500bef18428e2b3f52b54d3cd707d5.1564071419.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jul 25, 2019 at 12:17:35PM -0400, Mauro Carvalho Chehab wrote:
> Tony will start to officially maintain EDAC trees. Also, we'll
> be using a single tree for the EDAC development.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 783569e3c4b4..7c22905b5aba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5781,10 +5781,10 @@ F:	drivers/edac/thunderx_edac*
>  EDAC-CORE
>  M:	Borislav Petkov <bp@alien8.de>
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> +M:	Tony Luck <tony.luck@intel.com>
>  R:	James Morse <james.morse@arm.com>
>  L:	linux-edac@vger.kernel.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git for-next
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-edac.git linux_next
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
>  S:	Supported
>  F:	Documentation/admin-guide/ras.rst
>  F:	Documentation/driver-api/edac.rst
> -- 

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
