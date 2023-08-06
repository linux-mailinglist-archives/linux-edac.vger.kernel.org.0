Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9BA771553
	for <lists+linux-edac@lfdr.de>; Sun,  6 Aug 2023 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHFNhH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Aug 2023 09:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHFNhG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Aug 2023 09:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C25CA
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 06:37:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDF1B61074
        for <linux-edac@vger.kernel.org>; Sun,  6 Aug 2023 13:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB13C433C8;
        Sun,  6 Aug 2023 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691329025;
        bh=KuCvxLI7rGSZBiSQ5Ug9coV+E/jeG1SLo1evNAgT+mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0UCVL7SDQ3iwSehoYajeSilELQX0H4gDvQi1KDUO04eTMyrW1PMoi2qzBU0iGsBt
         SmoKbGr1HYBQS9SymS5iafegHdl6yvdIYGEdSLYiyIZ3unb7HGPEyaixS+NIR4oXaf
         WxWYmCi+3oqgXuPNKfALxRDJq2zRkA5XVEUNif6g=
Date:   Sun, 6 Aug 2023 15:37:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Atul Kumar Pant <atulpant.linux@gmail.com>
Cc:     shubhrajyoti.datta@amd.com, sai.krishna.potthuri@amd.com,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        bp@alien8.de, tony.luck@intel.com, michal.simek@amd.com,
        shuah@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v1] drivers: edac: zynqmp_edac: Updates return value check
Message-ID: <2023080631-salon-banter-31b7@gregkh>
References: <20230806130514.159102-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806130514.159102-1-atulpant.linux@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Aug 06, 2023 at 06:35:14PM +0530, Atul Kumar Pant wrote:
> Updating the check of return value from edac_debugfs_create_dir
> to use IS_ERR.
> 
> Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
> ---
>  drivers/edac/zynqmp_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
> index ac7d1e0b324c..cefbbafb945e 100644
> --- a/drivers/edac/zynqmp_edac.c
> +++ b/drivers/edac/zynqmp_edac.c
> @@ -351,7 +351,7 @@ static void setup_debugfs(struct edac_device_ctl_info *edac_dev)
>  	struct edac_priv *priv = edac_dev->pvt_info;
>  
>  	priv->debugfs_dir = edac_debugfs_create_dir("ocm");
> -	if (!priv->debugfs_dir)
> +	if (IS_ERR(priv->debugfs_dir))
>  		return;

Again, not correct, sorry.  Please do not make these types of changes.

Why do you feel this is needed at all?

thanks,

greg k-h
