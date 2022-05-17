Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20D52A773
	for <lists+linux-edac@lfdr.de>; Tue, 17 May 2022 17:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244212AbiEQP5G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 17 May 2022 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242914AbiEQP5F (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 17 May 2022 11:57:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7289B140C1;
        Tue, 17 May 2022 08:57:04 -0700 (PDT)
Received: from zn.tnic (p200300ea97465748329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5748:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 972B61EC058A;
        Tue, 17 May 2022 17:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652803018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xAoKdhS9VQX3sDi3PtJLveP3nETFOwHhfka6pQzBXGU=;
        b=bceHcIIS99GQ/0tNwT2xlMPQYBVBV2HCV09v0FFKfh+/hf0aZXDNvJfwne+ZLmhSbYV9hu
        qOrN7zfpvFgBKJG0wLxHZ3rBCU4jlaKH9yprxRLQuTN+TBSVBk88y43FDVnMMx/CGgfZQ6
        rs+/5262WEgEtg2xucQcHHQiSvKQsw4=
Date:   Tue, 17 May 2022 17:56:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] edac: i5100_edac: Remove unused inline function
 i5100_nrecmema_dm_buf_id()
Message-ID: <YoPFxaLSi2kmC9Nf@zn.tnic>
References: <20220514080433.29944-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220514080433.29944-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, May 14, 2022 at 04:04:33PM +0800, YueHaibing wrote:
> commit a4972b1b9a04 ("edac: i5100_edac: Remove unused i5100_recmema_dm_buf_id")
> leave this behind, remove it.
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/edac/i5100_edac.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index 324a46b8479b..f5d82518c15e 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -244,11 +244,6 @@ static inline u32 i5100_nrecmema_rank(u32 a)
>  	return a >>  8 & ((1 << 3) - 1);
>  }
>  
> -static inline u32 i5100_nrecmema_dm_buf_id(u32 a)
> -{
> -	return a & ((1 << 8) - 1);
> -}
> -
>  static inline u32 i5100_nrecmemb_cas(u32 a)
>  {
>  	return a >> 16 & ((1 << 13) - 1);
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
