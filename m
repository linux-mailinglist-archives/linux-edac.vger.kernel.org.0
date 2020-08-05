Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3AB23C4DE
	for <lists+linux-edac@lfdr.de>; Wed,  5 Aug 2020 07:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgHEFAb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Aug 2020 01:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgHEFAb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Aug 2020 01:00:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F66BC06174A;
        Tue,  4 Aug 2020 22:00:31 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9267A1EC011B;
        Wed,  5 Aug 2020 07:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1596603626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=M3haVkitNUiWuc7NCIim2ARWnDN/wpkJsTyk3+Ptaso=;
        b=Hm+vhUbO75VtUiOsdn2m1nNHe8V07GnWzm6HS3yR8ekG4/FriMesY9AbCnqW3xGDueT/f/
        fzNwWc5ECYygQ5Iikp0On0tyGy6cQ41kUkJoTiFgivsbTlFKlIr7ZHzWuvlbee6NJX98j9
        mJGfFdkRggKXd8J2iDxJwX+zh1max8I=
Date:   Wed, 5 Aug 2020 06:59:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Luca Stefani <luca.stefani.ge1@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/CEC: Fix cec_init prototype
Message-ID: <20200805045955.GB9127@nazgul.tnic>
References: <20200804161847.825391-1-luca.stefani.ge1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804161847.825391-1-luca.stefani.ge1@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 04, 2020 at 06:18:47PM +0200, Luca Stefani wrote:
> * late_initcall expects a function to return an integer

Please write a proper sentence for a commit message.

> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>  drivers/ras/cec.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 569d9ad2c594..e048e0e3949a 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -553,20 +553,20 @@ static struct notifier_block cec_nb = {
>  	.priority	= MCE_PRIO_CEC,
>  };
>  
> -static void __init cec_init(void)
> +static int __init cec_init(void)
>  {
>  	if (ce_arr.disabled)
> -		return;
> +		return 0;

Why 0?

I'm thinking all the cases when the init doesn't succeed should return
!0...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
