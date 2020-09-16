Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8358926CA95
	for <lists+linux-edac@lfdr.de>; Wed, 16 Sep 2020 22:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgIPUIv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Sep 2020 16:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgIPReN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Sep 2020 13:34:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FDCC0611C0;
        Wed, 16 Sep 2020 10:22:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e00db2f62bd592f04a0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:db2f:62bd:592f:4a0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1522C1EC026F;
        Wed, 16 Sep 2020 19:22:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600276960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CXiDzhd51Y1X9PUqSzctKBUMynV+tiDkIpdtvyBec+o=;
        b=FA22T5GORdlesUNedODvDvgYmaDdj8PkbyqTIBGIJGmwPSV7OwXITkTe+/heqhPzL51mx/
        pz9TN+9/aavENJg5AcMKLXQbd8fQkM/a7YpcMLiW6VU6TuZrjI1W39VNhvn1DoPE0GxQtm
        LTCrTJdKJtIOJzBUC8dhq1g4Pd1Q8lE=
Date:   Wed, 16 Sep 2020 19:22:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Stefan Schaeckeler <sschaeck@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] EDAC/aspeed: use module_platform_driver to
 simplify the code
Message-ID: <20200916172238.GQ2643@zn.tnic>
References: <20200914065358.3726216-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914065358.3726216-1-liushixin2@huawei.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 14, 2020 at 02:53:58PM +0800, Liu Shixin wrote:
> module_platform_driver() makes the code simpler by eliminating
> boilerplate code.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  drivers/edac/aspeed_edac.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index fbec28dc661d..fde809efc520 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -388,23 +388,7 @@ static struct platform_driver aspeed_driver = {
>  	.probe		= aspeed_probe,
>  	.remove		= aspeed_remove
>  };
> -
> -
> -static int __init aspeed_init(void)
> -{
> -	return platform_driver_register(&aspeed_driver);
> -}
> -
> -
> -static void __exit aspeed_exit(void)
> -{
> -	platform_driver_unregister(&aspeed_driver);
> -}
> -
> -
> -module_init(aspeed_init);
> -module_exit(aspeed_exit);
> -
> +module_platform_driver(aspeed_driver);
>  
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Stefan Schaeckeler <sschaeck@cisco.com>");
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
