Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C625A0C09
	for <lists+linux-edac@lfdr.de>; Thu, 25 Aug 2022 10:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiHYI62 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Aug 2022 04:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236307AbiHYI60 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 Aug 2022 04:58:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68632A833C;
        Thu, 25 Aug 2022 01:58:25 -0700 (PDT)
Received: from zn.tnic (p200300ea971b9859329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:9859:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C0D741EC0666;
        Thu, 25 Aug 2022 10:58:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661417899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PXqc4GzXqbvr/U8GCHtHpfJwcpqOliGMW7q64/9Hh4k=;
        b=VkpS6l1np0FBcw+QZtSjBM2PgPeZZfAds39XFKws4+J1I0ZBDwvfdSfeiMP3osniSGmAUa
        bTTOF6uzXQCmryCG0RQZ+7Qt45hmnFWHDiVh6D1x4RI6Fbjir9YaOIxJMTd7hcxaBiEXwn
        K1sM7uN55R0buEzkGOkGXFGnXsNhJS8=
Date:   Thu, 25 Aug 2022 10:58:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     cgel.zte@gmail.com
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] EDAC,wq: remove unneeded flush_workqueue
Message-ID: <Ywc5p1lFSPsyY/cV@zn.tnic>
References: <20220424062127.3219542-1-ran.jianping@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220424062127.3219542-1-ran.jianping@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Apr 24, 2022 at 06:21:26AM +0000, cgel.zte@gmail.com wrote:
> From: ran jianping <ran.jianping@zte.com.cn>
> 
> All work currently pending will be done first by calling destroy_workqueue,
> so there is no need to flush it explicitly.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
> ---
>  drivers/edac/wq.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/wq.c b/drivers/edac/wq.c
> index d021d287eaec..ad3f516627c5 100644
> --- a/drivers/edac/wq.c
> +++ b/drivers/edac/wq.c
> @@ -37,7 +37,6 @@ int edac_workqueue_setup(void)
>  
>  void edac_workqueue_teardown(void)
>  {
> -	flush_workqueue(wq);
>  	destroy_workqueue(wq);
>  	wq = NULL;
>  }
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
