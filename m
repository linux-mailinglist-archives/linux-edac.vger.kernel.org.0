Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A27D6C045C
	for <lists+linux-edac@lfdr.de>; Sun, 19 Mar 2023 20:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCSTXO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 19 Mar 2023 15:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjCSTWy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 19 Mar 2023 15:22:54 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC1315CAC;
        Sun, 19 Mar 2023 12:21:16 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E5691EC067D;
        Sun, 19 Mar 2023 20:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679253616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dqvSWXtXbX4vCGrP54zEauybjI/2xsN+HP4vBLgozEg=;
        b=kDFuLpHwSW9W4oUPt+YSWLV8eCFzFtH8xlXQUIVhiBSGn7GLKwpDVd/XLH9OEft+KmC/4q
        zikkvh1sWmNPm4Zt0Y/4bMD3oEG/7kwKEz+UaqdrxteObRvvWRpQqpMWF/KCgwrp1PbP7b
        mc4fAp0vdfy/nlCD79VqljNR0/aYww0=
Date:   Sun, 19 Mar 2023 20:20:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd81*1: Remove "\n" from MODULE_AUTHOR
Message-ID: <20230319192011.GEZBdga+n600nFi/tA@fat_crate.local>
References: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, Jan 29, 2023 at 05:50:54PM +0100, Jonathan Neuschäfer wrote:
> MODULE_AUTHOR strings don't usually include a newline character.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  drivers/edac/amd8111_edac.c | 2 +-
>  drivers/edac/amd8131_edac.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/amd8111_edac.c b/drivers/edac/amd8111_edac.c
> index 7508aa416ddbd..ca718f63fcbcd 100644
> --- a/drivers/edac/amd8111_edac.c
> +++ b/drivers/edac/amd8111_edac.c
> @@ -593,5 +593,5 @@ module_init(amd8111_edac_init);
>  module_exit(amd8111_edac_exit);
> 
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>\n");
> +MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>");
>  MODULE_DESCRIPTION("AMD8111 HyperTransport I/O Hub EDAC kernel module");
> diff --git a/drivers/edac/amd8131_edac.c b/drivers/edac/amd8131_edac.c
> index 1693537109826..28610ba514f4d 100644
> --- a/drivers/edac/amd8131_edac.c
> +++ b/drivers/edac/amd8131_edac.c
> @@ -354,5 +354,5 @@ module_init(amd8131_edac_init);
>  module_exit(amd8131_edac_exit);
> 
>  MODULE_LICENSE("GPL");
> -MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>\n");
> +MODULE_AUTHOR("Cao Qingtao <qingtao.cao@windriver.com>");
>  MODULE_DESCRIPTION("AMD8131 HyperTransport PCI-X Tunnel EDAC kernel module");
> --

Wanna fix the other two in the EDAC tree:

drivers/edac/e752x_edac.c:1465:MODULE_AUTHOR("Linux Networx (http://lnxi.com) Tom Zimmerman\n");
drivers/edac/e7xxx_edac.c:599:MODULE_AUTHOR("Linux Networx (http://lnxi.com) Thayne Harbaugh et al\n"

?

That macro takes:

/*
 * Author(s), use "Name <email>" or just "Name", for multiple
 * authors use multiple MODULE_AUTHOR() statements/lines.
 */
#define MODULE_AUTHOR(_author) MODULE_INFO(author, _author)

and not prose.

You can move the prose to the top comment in the respective file, if it
doesn't contain it yet.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
