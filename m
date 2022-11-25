Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C0638FD2
	for <lists+linux-edac@lfdr.de>; Fri, 25 Nov 2022 19:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiKYSbg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Nov 2022 13:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKYSbf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Nov 2022 13:31:35 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B831317C6;
        Fri, 25 Nov 2022 10:31:34 -0800 (PST)
Received: from zn.tnic (p200300ea9733e784329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e784:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F0A11EC0819;
        Fri, 25 Nov 2022 19:31:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669401093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Xa9/Mjp4trw5L6BElLdgRFWhYOF8m3uvBNDE2l4lgB0=;
        b=C8YTia6TnZrJ1OOZdk87HoZx/qJrV8eIutlfthiKuQjLdZ9bVK5gsgU+oZamCTJG2bMoil
        Oi61JHb2KC81vgFSRbrgrndb/azRNYOlLRsiWBCmeZKizc1sJGYZhua6PAP601JoWJcH/I
        tgwpbc1mGAZ3wOptIh3HVzEywsM4MtM=
Date:   Fri, 25 Nov 2022 19:31:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     chen zhang <chenzhang@kylinos.cn>
Cc:     mchehab@kernel.org, james.morse@arm.com, rric@kernel.org,
        chenzhang_0901@163.com, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] EDAC: Fix typo in comments
Message-ID: <Y4EKABVdXc69XoJv@zn.tnic>
References: <20221102081248.45694-1-chenzhang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102081248.45694-1-chenzhang@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 02, 2022 at 04:12:48PM +0800, chen zhang wrote:
> Fix spelling typo in comments.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: chen zhang <chenzhang@kylinos.cn>
> ---
>  drivers/edac/i5400_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
> index f76624ee82ef..b04c6dc0cf1f 100644
> --- a/drivers/edac/i5400_edac.c
> +++ b/drivers/edac/i5400_edac.c
> @@ -279,7 +279,7 @@ static inline int from_nf_ferr(unsigned int mask)
>  #define FERR_NF_RECOVERABLE	to_nf_mask(ERROR_NF_RECOVERABLE)
>  #define FERR_NF_UNCORRECTABLE	to_nf_mask(ERROR_NF_UNCORRECTABLE)
>  
> -/* Defines to extract the vaious fields from the
> +/* Defines to extract the various fields from the
>   *	MTRx - Memory Technology Registers
>   */
>  #define MTR_DIMMS_PRESENT(mtr)		((mtr) & (1 << 10))
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
