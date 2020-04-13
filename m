Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC4E1A6447
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 10:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDMIQD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 04:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgDMIQC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 04:16:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A318DC00860B;
        Mon, 13 Apr 2020 01:16:02 -0700 (PDT)
Received: from zn.tnic (p200300EC2F06C9001913BA8A68E69387.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:c900:1913:ba8a:68e6:9387])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 411B71EC0C5C;
        Mon, 13 Apr 2020 10:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586765761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KlbV+TNCgKndNj8o0UcAUVp9m90/QKt8MAAbvtHhuoc=;
        b=f5KgIIS5gCRWT2rm3scG1Zav/MPSSpkypBTOVMdiW2iVbxVva/ivl5cP6PtDuKnJsj9xM5
        RIB5qvjg/RjXJKO7MiKaPcnEvOUsxG6Qbg5GGO0kZa5OoDJKJo4aPjV4fH0+yD49+A2U2b
        lleMAaQeZrks/JZVICYmrImCK9p/U4Q=
Date:   Mon, 13 Apr 2020 10:15:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@lst.de>,
        Yash Shah <yash.shah@sifive.com>, linux-edac@vger.kernel.org,
        Sebastian Duda <sebastian.duda@fau.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] MAINTAINERS: rectify EDAC-SIFIVE entry
Message-ID: <20200413081556.GB3772@zn.tnic>
References: <20200413073447.9284-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413073447.9284-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 13, 2020 at 09:34:47AM +0200, Lukas Bulwahn wrote:
> Commit 9209fb51896f ("riscv: move sifive_l2_cache.c to drivers/soc") moved
> arch/riscv/mm/sifive_l2_cache.c to drivers/soc/sifive/sifive_l2_cache.c
> and adjusted the MAINTAINERS EDAC-SIFIVE entry but slipped in a mistake.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: drivers/soc/sifive_l2_cache.c
> 
> Rectify the EDAC-SIFIVE entry in MAINTAINERS now.
> 
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Paul, please pick this patch.
> 
> v1: https://lore.kernel.org/lkml/20200304144045.15060-1-lukas.bulwahn@gmail.com/
>   - was not picked up.
> 
> v1-resend: applies on v5.7-rc1
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64e5db31497..e28676766b26 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6172,7 +6172,7 @@ M:	Yash Shah <yash.shah@sifive.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/edac/sifive_edac.c
> -F:	drivers/soc/sifive_l2_cache.c
> +F:	drivers/soc/sifive/sifive_l2_cache.c

Looking at that a bit - I think the right thing to do is to remove that
sifive_l2_cache.c file from the EDAC-SIFIVE file pattern because the
edac driver is simply using the L2 thing to register on its notifier
chain, i.e., using an external facility, like all the drivers do. And the
l2_cache thing is not part of the edac driver.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
