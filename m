Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24403587B6E
	for <lists+linux-edac@lfdr.de>; Tue,  2 Aug 2022 13:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbiHBLQE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 2 Aug 2022 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiHBLPk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Aug 2022 07:15:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E8418B3F;
        Tue,  2 Aug 2022 04:15:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lxspq5mcDz4x1P;
        Tue,  2 Aug 2022 21:15:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659438916;
        bh=QUd6PC2Si9JD8mo+JkMA5SafHzZ0731ZhqbEwcSaXJE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OKnuybTApefW3m2zs2oGXCdRishriCtmSW4T2xlKbFjRyRvkkXlPz4XQu2L8O0DCn
         aAMr/nrOZLjsE29c2uHvHC8ohh9YbosZMpduZiwzQrkXSaQqOarrhv+vaHjEv8FU2V
         R+Y+UETZJBMYDbdAPusbFDS6hQTBrHAr2B2ztUdfd1a+jNIaugE/JLOE6dNaQirsVD
         P/eaFSzleC+g5qSR+FErP1Gj5mIQZlfEzAnq9DTuJyvesQ9//GGLJ3BaUWqpBAuSmv
         46gJgdOg4NdKl88iZknrEq8l30I2QPJEzqOb4kDEIwZirLlfq7EbJAiPubwuGNcEse
         mU0EriPxZC6yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-edac@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] EDAC/ppc_4xx: Include required of_irq header directly
In-Reply-To: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
References: <993f5a7da371458cb819b5f3f569073c78523b01.1659436180.git.christophe.leroy@csgroup.eu>
Date:   Tue, 02 Aug 2022 21:15:15 +1000
Message-ID: <87zggmaocc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h
> and asm/pci.h") that cleans up powerpc's asm/prom.h leads to build
> errors in ppc4xx_edac.c due to missing header. Include required
> header directly to avoid the build failure.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 4d5c5bad5193 ("powerpc: Remove asm/prom.h from asm/mpc52xx.h and asm/pci.h")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/edac/ppc4xx_edac.c | 1 +
>  1 file changed, 1 insertion(+)

I'll pick this up as I merged the commit that broke it.

cheers

> diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
> index 6793f6d799e7..0bc670778c99 100644
> --- a/drivers/edac/ppc4xx_edac.c
> +++ b/drivers/edac/ppc4xx_edac.c
> @@ -11,6 +11,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/of_irq.h>
>  #include <linux/of_platform.h>
>  #include <linux/types.h>
>  
> -- 
> 2.36.1
