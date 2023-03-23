Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E1E6C661F
	for <lists+linux-edac@lfdr.de>; Thu, 23 Mar 2023 12:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCWLGk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 Mar 2023 07:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjCWLGj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 23 Mar 2023 07:06:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBBE2D162;
        Thu, 23 Mar 2023 04:06:37 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBEF11EC0716;
        Thu, 23 Mar 2023 12:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679569595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FnQaXPVQ/yAcYZ9LCUiXXIRRl46i/tjadULUWjr+Cqg=;
        b=obmLCxOLJRnfDcEdzZzWr8nEWr5ldR74/92v+RnlkTvYgdxaSRW8aUnuydVR6pQO1kbvEk
        9hC1U3CLFqPcIJ+p23rUWQ2FMNxXKl5pw6VkC/whmWNkGVZeK/Scd1EObYjZgULeDywyVx
        xfzw/WeAoYECpO/YAK/VQ+6hEkLdYhM=
Date:   Thu, 23 Mar 2023 12:06:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jongwoo Han <jongwooo.han@gmail.com>
Cc:     tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/i5100: Fix typo in comment
Message-ID: <20230323110635.GDZBwyu8J92Qyun6Pp@fat_crate.local>
References: <20230302021120.56794-1-jongwooo.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230302021120.56794-1-jongwooo.han@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Mar 02, 2023 at 11:11:20AM +0900, Jongwoo Han wrote:
> Correct typo from 'preform' to 'perform' in comment.
> 
> Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
> ---
>  drivers/edac/i5100_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index f5d82518c..8db680b6a 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -909,7 +909,7 @@ static void i5100_do_inject(struct mem_ctl_info *mci)
>  	 *
>  	 * The injection code don't work without setting this register.
>  	 * The register needs to be flipped off then on else the hardware
> -	 * will only preform the first injection.
> +	 * will only perform the first injection.
>  	 *
>  	 * Stop condition bits 7:4
>  	 * 1010 - Stop after one injection
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
