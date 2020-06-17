Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75101FD3E2
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jun 2020 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFQR6T (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jun 2020 13:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQR6T (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 17 Jun 2020 13:58:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A50C06174E
        for <linux-edac@vger.kernel.org>; Wed, 17 Jun 2020 10:58:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bb000eca79a131b243ace.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:b000:eca7:9a13:1b24:3ace])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33E9A1EC03E3;
        Wed, 17 Jun 2020 19:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592416697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H5mvB7EfQquLpJvPqMQh9hhExxbj0cV81WCerLfjy2g=;
        b=hNZ/6erQQg/KnuGvBYuoSnK58D8sjzQdazm9UVzZDJKRcfA7zn71xYO3X9pXj58d7pGiAp
        e5Ndl5hMNHe54Nq3hxtFDksGpIBMNN7NNZtbsINfwPnXV2b82ozk5LwYPOE9kTlf0CPwjU
        wRylNaGKVlVx8LZrtpMEbuyk52nuX+A=
Date:   Wed, 17 Jun 2020 19:58:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     wata2ki <wata2ki@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>,
        Mauro Carvalho Chehab <mchehab@infradead.org>
Cc:     linux-edac@vger.kernel.org,
        Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
Subject: Re: [PATCH] EDAC/mc: Fix memory alignment calculation formula
Message-ID: <20200617175809.GH10118@zn.tnic>
References: <20200516162115.16545-1-wata2ki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200516162115.16545-1-wata2ki@gmail.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sun, May 17, 2020 at 01:21:15AM +0900, wata2ki wrote:
> From: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
> 
> During the development of the off-tree driver, we found a bug that
> causes alignment fault exception in mutex_lock.
> 
> Line of the code:
> ffffffc010536ce4: c85ffe62 ldaxr x2, [x19]
> 
> Register value:
> x19: ffffff800e90f6c4
> 
> This problem was caused by the alignment error of pvt_info
> in struct mem_ctl_info.  It is caused by a calculation formula
> error in edac_align_ptr.
> 
> Existing calculation formula is using variable p, but this
> variable is address of the pointer variable not memory offset.
> In this calculation formula should use *p.
> 
> Signed-off-by: Naoto Yamaguchi <i33399_YAMAGUCHI@aisin-aw.co.jp>
> ---
>  drivers/edac/edac_mc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 drivers/edac/edac_mc.c
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> old mode 100644
> new mode 100755
> index 75ede27bdf6a..70929f136dd7
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -271,7 +271,7 @@ void *edac_align_ptr(void **p, unsigned int size, int n_elems)
>  	else
>  		return (char *)ptr;
>  
> -	r = (unsigned long)p % align;
> +	r = (unsigned long)(*p) % align;

Looks about right to me.

Btw, you don't need the () around *p - that's evaluated right-to-left so
the dereference happens first and *then* the typecast, i.e., what you
want here.

In any case, this line comes from

  8447c4d15e35 ("edac: Do alignment logic properly in edac_align_ptr()")

and I believe it was wrong to use 'p' as that function works with the
memory offsets - not with the pointer to the pointer. It's a whole
different story whether I think this whole thing makes sense and it is
ugly...

Anyway, adding the gentlemen from that commit to Cc.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
