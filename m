Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4676E6CC13B
	for <lists+linux-edac@lfdr.de>; Tue, 28 Mar 2023 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjC1Nm6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Mar 2023 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjC1Nmx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Mar 2023 09:42:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F668BDD6;
        Tue, 28 Mar 2023 06:42:48 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B2071EC0338;
        Tue, 28 Mar 2023 15:42:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1680010966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A78xYloQ+yZx5Ifx41UP+WIUtAPbUFWRbtDnsZCyfoU=;
        b=fFEyh6Ig0XjRpwc2iR0PqsACwkxdtXelTmgj5gAlmKYzIS9hXz/w8dU7iwDbwMTWOKif+/
        gULhbXpECPMNL/EkKL/15gXdxbjGir/jpNY7II2fka/JROHbsviQkoE/uAyxlFfXQfK975
        3hqmZW/GQ3kgCLAim59TFKGf2XLmLJM=
Date:   Tue, 28 Mar 2023 15:42:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd81*1: Remove "\n" from MODULE_AUTHOR
Message-ID: <20230328134242.GBZCLu0o9mJm9h9jEL@fat_crate.local>
References: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129165054.1675554-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
