Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948B65E84A6
	for <lists+linux-edac@lfdr.de>; Fri, 23 Sep 2022 23:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiIWVKD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Sep 2022 17:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiIWVKC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Sep 2022 17:10:02 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC254BA5F;
        Fri, 23 Sep 2022 14:09:59 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e795329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e795:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1296C1EC0589;
        Fri, 23 Sep 2022 23:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663967394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=x8iM+Vc59YFqCyZ1VFiBckSWmKyYOocx+5VU91P32ZI=;
        b=kw2jPxg1gp9sK6BCJqRjV1OtgGn2ul95Vup1D7C3O149WTKRfFJ5NMafdaTY4kvYCl6p0Q
        2x6IkEiqZGeopGej+2mrKatnLSc53JxN4IunI9F0YSmn7llkGmNiAbPzQlNztoIkbV4z6p
        X11ArGcYFuYqSLHF0fNsPNKpJUbBKTY=
Date:   Fri, 23 Sep 2022 23:09:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i7300_edac: Set correct function name i7300_exit in
 comment
Message-ID: <Yy4gnfpupNm4UPLC@zn.tnic>
References: <20220805125008.2346559-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220805125008.2346559-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 05, 2022 at 01:50:08PM +0100, Colin Ian King wrote:
> The incorrect function name is being used in the comment for function
> i7300_exit. Correct this.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/edac/i7300_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
> index 4f28b8c8d378..61adaa872ba7 100644
> --- a/drivers/edac/i7300_edac.c
> +++ b/drivers/edac/i7300_edac.c
> @@ -1193,7 +1193,7 @@ static int __init i7300_init(void)
>  }
>  
>  /**
> - * i7300_init() - Unregisters the driver
> + * i7300_exit() - Unregisters the driver
>   */
>  static void __exit i7300_exit(void)
>  {
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
