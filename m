Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E087514566
	for <lists+linux-edac@lfdr.de>; Fri, 29 Apr 2022 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiD2JaV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 Apr 2022 05:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234867AbiD2JaU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 29 Apr 2022 05:30:20 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83CEC3EAF;
        Fri, 29 Apr 2022 02:27:00 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CAF431EC04F9;
        Fri, 29 Apr 2022 11:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651224414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GHHuat7VTiEyDkNT9ftkI1J6tKCfT5inh01VZHbvo00=;
        b=bN/LBG8/GhusIwjR33ja3jSSKsaZ2m488lrpZOqziGDruWbIaBooFpZPNrSuG3ZGAClg23
        T2zPWuVhVXsV2Gx0b/PgNewPe6UoMTTYLmMCCqxtixd8Ezt48Pfzs6mZoS1LQszf47HKtl
        vL1w6cAuYhXsUd2rxGGcqhyq3mEn9X8=
Date:   Fri, 29 Apr 2022 11:26:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Rix <trix@redhat.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/ghes: change ghes_hw from global to static
Message-ID: <YmuvX8APTbzCNqRQ@zn.tnic>
References: <20220421135319.1508754-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220421135319.1508754-1-trix@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Apr 21, 2022 at 09:53:19AM -0400, Tom Rix wrote:
> Smatch reports this issue
> ghes_edac.c:44:3: warning: symbol 'ghes_hw' was not declared. Should it be static?
> 
> ghes_hw is only used in ghes_edac.c so change its
> storage-class specifier to static.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/edac/ghes_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 2805d5610300..59b0bedc9c24 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -38,7 +38,7 @@ static struct ghes_pvt *ghes_pvt;
>   * This driver's representation of the system hardware, as collected
>   * from DMI.
>   */
> -struct ghes_hw_desc {
> +static struct ghes_hw_desc {
>  	int num_dimms;
>  	struct dimm_info *dimms;
>  } ghes_hw;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
