Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048E552FD1E
	for <lists+linux-edac@lfdr.de>; Sat, 21 May 2022 16:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350463AbiEUOIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 21 May 2022 10:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiEUOIE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 21 May 2022 10:08:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D060120B4;
        Sat, 21 May 2022 07:07:58 -0700 (PDT)
Received: from zn.tnic (p200300ea97465730329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5730:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 30D741EC0373;
        Sat, 21 May 2022 16:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653142073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NE6tLwMswcU3YeCTFhumZzQzJ0LL7mkMq97jiJPMw98=;
        b=fHZkclpNo6CRrawrtbze/WCiFbqqj8xynscCVive1NQFgDydMd9t77HNlSEfVyNeZ1NoMe
        eutAZInHk+rGHuZblzrZXm+koixCitwZc2E5C0izORQzFlnUF3wGHUYD/YfleSxFyHKoOq
        28DtD+ZKVo5S76JRXjGLuCr+pyN1kq4=
Date:   Sat, 21 May 2022 16:07:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Khuong Dinh <khuong@os.amperecomputing.com>,
        kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/xgene: fix typo in comment
Message-ID: <YojyNDM5BJP3rpbC@zn.tnic>
References: <20220521111145.81697-39-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220521111145.81697-39-Julia.Lawall@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, May 21, 2022 at 01:10:49PM +0200, Julia Lawall wrote:
> Spelling mistake (triple letters) in comment.
> Detected with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  drivers/edac/xgene_edac.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
> index 7197f9fa0245..54081403db4f 100644
> --- a/drivers/edac/xgene_edac.c
> +++ b/drivers/edac/xgene_edac.c
> @@ -501,7 +501,7 @@ static int xgene_edac_mc_remove(struct xgene_edac_mc_ctx *mcu)
>  #define MEMERR_L2C_L2ESRA_PAGE_OFFSET		0x0804
>  
>  /*
> - * Processor Module Domain (PMD) context - Context for a pair of processsors.
> + * Processor Module Domain (PMD) context - Context for a pair of processors.
>   * Each PMD consists of 2 CPUs and a shared L2 cache. Each CPU consists of
>   * its own L1 cache.
>   */

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
