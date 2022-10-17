Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D5601155
	for <lists+linux-edac@lfdr.de>; Mon, 17 Oct 2022 16:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJQOlj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Oct 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbiJQOlg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Oct 2022 10:41:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0972C66A61
        for <linux-edac@vger.kernel.org>; Mon, 17 Oct 2022 07:41:30 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e793329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e793:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9ADA1EC067D;
        Mon, 17 Oct 2022 16:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1666017684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lxoVEBcEXRPOb0eszK5ysGJSxk7qrH+2h5wuv38DhPo=;
        b=Z07VCLyCrAoNLvwkXvYFgQox8Vx3Oq9xk2LZLS9MB7NqgYuVZm2qtS1VW90mF81hDv0W82
        RL/Mq7Oz6MEtjlDCdbJc+ayi/i/FM8DIv+FES3eqErjpuEhiAJCqlkHYB6ZxzYFxE3BdDZ
        p51uZWna5MaAC9Wb/QGa3mgGa/GJloo=
Date:   Mon, 17 Oct 2022 16:41:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org
Subject: Re: [PATCH] i5000_edac: mark as BROKEN
Message-ID: <Y01pkNgd4oegdk5r@zn.tnic>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
 <YytoHtVULW7w3/8Z@zn.tnic>
 <20220922134659.biiy6g743qplzgiq@redhat.com>
 <YyxpbRkuLPIcW1Om@zn.tnic>
 <20220926165138.kyp24vhh2czvmu2z@redhat.com>
 <YzHpRLVHc+ykfhY7@zn.tnic>
 <20220928124815.ta6k4jiiyy6diudr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220928124815.ta6k4jiiyy6diudr@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 28, 2022 at 08:48:15AM -0400, Aristeu Rozanski wrote:
> i5000_edac supports very old hardware which isn't available and it's
> been broken for single/dual channel for many years without anyone
> noticing. Marking as BROKEN.
> 
> Signed-off-by: Aristeu Rozanski <aris@redhat.com>
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 17562cf1fe97..e659e4712a25 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -211,6 +211,7 @@ config EDAC_R82600
>  config EDAC_I5000
>  	tristate "Intel Greencreek/Blackford chipset"
>  	depends on X86 && PCI
> +	depends on BROKEN
>  	help
>  	  Support for error detection and correction the Intel
>  	  Greekcreek/Blackford chipsets.

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
