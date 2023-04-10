Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F616DCC42
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 22:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDJUrT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 16:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJUrS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 16:47:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E8E9;
        Mon, 10 Apr 2023 13:47:16 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F2C621EC03F1;
        Mon, 10 Apr 2023 22:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681159635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iL2daBPD946fMEUmXAbOggLKCH0CPV1KKIYQPbODX48=;
        b=izfXI+2bzoSONA6emB916RXN5apHA7tYioWCIziY+1dNGjSHPuCVOfN8HSFhgK1nlSSlvY
        Gcrm9YepdrwuCwHYK0o/S+dpE4VoW/C6yPvTI+WOxLw9BFs7/CCSY3o5BgA8TS0B5mxgTE
        iYmVINmxPYYAcfhMnJDM7mJ/Tf/rKLI=
Date:   Mon, 10 Apr 2023 22:47:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        avadhut.naik@amd.com
Subject: Re: [PATCH] EDAC/mce_amd: Decode Cache Level "L0" Error Code
Message-ID: <20230410204710.GBZDR1ziKdqr4ihJZh@fat_crate.local>
References: <20230410203357.17704-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230410203357.17704-1-yazen.ghannam@amd.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Apr 10, 2023 at 03:33:57PM -0500, Yazen Ghannam wrote:
> The "L0" cache level is listed as "reserved" in legacy documentation.
> This has now been defined as "Core" in current documentation for
> Zen-based systems.
> 
> Update the cache level strings to include this new definition.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/mce_amd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
> index cc5c63feb26a..1d1b9da3b9bd 100644
> --- a/drivers/edac/mce_amd.c
> +++ b/drivers/edac/mce_amd.c
> @@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(amd_unregister_ecc_decoder);
>  static const char * const tt_msgs[] = { "INSN", "DATA", "GEN", "RESV" };
>  
>  /* cache level */
> -static const char * const ll_msgs[] = { "RESV", "L1", "L2", "L3/GEN" };
> +static const char * const ll_msgs[] = { "CORE", "L1", "L2", "L3/GEN" };

Still used on legacy machines. I thought we agreed we'll move all the
decoding to luserspace, for newer Zens...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
