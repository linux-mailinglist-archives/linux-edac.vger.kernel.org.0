Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB60A7258AA
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 10:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbjFGIxV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 04:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbjFGIwz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 04:52:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E430C1;
        Wed,  7 Jun 2023 01:51:26 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 141B01EC070A;
        Wed,  7 Jun 2023 10:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1686127877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i0NdrTonshlL/BOe+jeCJAL3DUzvRCF9nn7dYvXfpgA=;
        b=ovD6gDNsAoZKr0mmK15yDaJkRuClKaJF7dB6L49Rx9rUF2Bey3G8A4Iqxm4nDONlJ3skGu
        3ddytbBAPm+bdAV7oXpm8C6rOs4WgoC5Z1avOllxU+xSU9jbuEXhEnopMQR+Q8KxdzqdCi
        tXU9rWFOrXwAiHZh+o8MlFF2IPVOvOg=
Date:   Wed, 7 Jun 2023 10:51:10 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yeqi Fu <asuk4.q@gmail.com>
Cc:     dinguyen@kernel.org, tony.luck@intel.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Fix error checking
Message-ID: <20230607085110.GAZIBE/gLYW5szBwwo@fat_crate.local>
References: <20230517191556.367689-1-asuk4.q@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517191556.367689-1-asuk4.q@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, May 18, 2023 at 03:15:56AM +0800, Yeqi Fu wrote:
> The function edac_debugfs_create_dir returns ERR_PTR if an error
> occurs, and the appropriate way to verify for errors is to use the
> inline function IS_ERR. The patch will substitute the null-comparison
> with IS_ERR.
> 
> Signed-off-by: Yeqi Fu <asuk4.q@gmail.com>
> ---
>  drivers/edac/altera_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8b31cd54bdb6..19693333408f 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -683,7 +683,7 @@ static void altr_create_edacdev_dbgfs(struct edac_device_ctl_info *edac_dci,
>  		return;
>  
>  	drvdata->debugfs_dir = edac_debugfs_create_dir(drvdata->edac_dev_name);
> -	if (!drvdata->debugfs_dir)
> +	if (IS_ERR(drvdata->debugfs_dir))
>  		return;
>  
>  	if (!edac_debugfs_create_file("altr_trigger", S_IWUSR,
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
