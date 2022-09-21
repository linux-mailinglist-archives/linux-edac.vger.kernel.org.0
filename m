Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5785F5E53E4
	for <lists+linux-edac@lfdr.de>; Wed, 21 Sep 2022 21:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiIUTiw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 21 Sep 2022 15:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIUTio (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 21 Sep 2022 15:38:44 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B19E692
        for <linux-edac@vger.kernel.org>; Wed, 21 Sep 2022 12:38:20 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e77f329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e77f:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5109F1EC058A;
        Wed, 21 Sep 2022 21:38:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663789094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=97tihwsldLcQE+rrCc6CCFPwrv+GTW8AuciIGX4eFgY=;
        b=Lyfrye7MltD8XbWC+TcSxqfL1vbpOUt2Xn9hAbnwZYxVyUz8Hfjx2SzSo5kJ0pX4JqJhE/
        Z0I5WZc6B3jR5Xijdbu3y83bRwoOJjLmKx9ocb8CUA1K2AaYU5VhAVw1gRsAeUSxPlsbu6
        /DiNPpvN/gc9+DfUYyabdfTf0y9HtQI=
Date:   Wed, 21 Sep 2022 21:38:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Aristeu Rozanski <aris@redhat.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org, arozansk@redhat.com
Subject: Re: [RESEND PATCH] i5000_edac: fix slot number passed to
 determine_mtr()
Message-ID: <YytoHtVULW7w3/8Z@zn.tnic>
References: <20220921181009.oxytvicy6sry6it7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220921181009.oxytvicy6sry6it7@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Sep 21, 2022 at 02:10:09PM -0400, Aristeu Rozanski wrote:
> When the logic mapping branch/slot/channel was reworked back in
> 64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory information")
> i5000_init_csrows() was not updated and kept passing twice the number
> of slots to determine_mtr(), which leads to acessing past the end of
> i5000_pvt.b1_mtr[]. This was found by KASAN.
> 
> Fixes: 64e1fdaf55d6 ("i5000_edac: Fix the logic that retrieves memory information")
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Borislav Petkov <bp@suse.de>
> Signed-off-by: Aristeu Rozanski <aris@redhat.com>
> 
> ---
>  drivers/edac/i5000_edac.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- linus-2.6.orig/drivers/edac/i5000_edac.c	2022-07-25 15:26:40.093989879 -0400
> +++ linus-2.6/drivers/edac/i5000_edac.c	2022-07-26 14:32:23.644694778 -0400
> @@ -1249,14 +1249,12 @@ static int i5000_init_csrows(struct mem_
>  	struct i5000_pvt *pvt;
>  	struct dimm_info *dimm;
>  	int empty;
> -	int max_csrows;
>  	int mtr;
>  	int csrow_megs;
>  	int channel;
>  	int slot;
>  
>  	pvt = mci->pvt_info;
> -	max_csrows = pvt->maxdimmperch * 2;

So it looks to me like back then, the number of CS rows was twice the
DIMMs per channel, implying two CS rows per DIMM, I guess dual-ranked
DIMMs or so.

Now you're saying the number CS rows is the number of DIMMs. Which
means, single-ranked DIMMs?

But all this is broken as it needs to deal with both single-ranked and
dual-ranked DIMMs elegantly and not assume any DIMM types...

Do we have hardware where we can test this or can we declare this hw for
dead?

Because

https://www.intel.com/content/www/us/en/products/sku/27746/intel-5000p-memory-controller/specifications.html

says launch date Q1 2006 which is a whole another era in IT years.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
