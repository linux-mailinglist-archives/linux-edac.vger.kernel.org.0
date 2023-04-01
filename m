Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED86B6D309C
	for <lists+linux-edac@lfdr.de>; Sat,  1 Apr 2023 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjDAL52 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 1 Apr 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjDAL5K (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 1 Apr 2023 07:57:10 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B6724413;
        Sat,  1 Apr 2023 04:56:41 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8E4591EC0420;
        Sat,  1 Apr 2023 13:56:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680350186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BRoEIkIG+7eAVhs9duV3p3lIy/wXARVavujoy8JQa7o=;
        b=OCWazxffDgwyQU8bVPdKGu4Zw3dZA3N5/z1oKXVCZXRotfDERE9Xg2dIWiZx/sEu5F+seO
        PAqFKHBg+lqfXA6aXejznrl5r2BS/d/lQVd7/F7O02876bTo5oOqCJjlidLgrRTctSp535
        DeXPuEz3b9ikdIvVwMQSRF3CtoYCdPY=
Date:   Sat, 1 Apr 2023 13:56:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 23/24] kbuild, EDAC, altera: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230401115623.GBZCgb50aBhMs/nUlO@fat_crate.local>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-24-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230217141059.392471-24-nick.alcock@oracle.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 17, 2023 at 02:10:58PM +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-edac@vger.kernel.org
> ---
>  drivers/edac/altera_edac.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index e7e8e624a436..ba325d4c5e83 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2226,6 +2226,5 @@ static struct platform_driver altr_edac_a10_driver = {
>  };
>  module_platform_driver(altr_edac_a10_driver);
>  
> -MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Thor Thayer");
>  MODULE_DESCRIPTION("EDAC Driver for Altera Memories");
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
