Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084234B7655
	for <lists+linux-edac@lfdr.de>; Tue, 15 Feb 2022 21:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbiBORIg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Feb 2022 12:08:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242199AbiBORIe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Feb 2022 12:08:34 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CC11ACCE;
        Tue, 15 Feb 2022 09:08:23 -0800 (PST)
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0275D1EC0411;
        Tue, 15 Feb 2022 18:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1644944898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HEtcDpWLQ83O3kPD573D0V/wU8u6oJoMHsArXW8ggTY=;
        b=ZMyUBd7Z8t9L2at60sSRbMjSjlXH1ydK5QvTBj+d8zZVPIueCVb2QkuTDl/Wm2zp9SZ1x6
        vO9BEQtOOErGCmuptcuZKzralCFnDyBf9kucvpMNbCretI3/Yz4qAP6du7199mQB2dTX+K
        oorw53TY5bZCC6eQo7JBNHNv3Dp+1dA=
Date:   Tue, 15 Feb 2022 18:08:20 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Eliav Farber <farbere@amazon.com>
Cc:     mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, talel@amazon.com,
        hhhawa@amazon.com, jonnyc@amazon.com, hanochu@amazon.com
Subject: Re: [PATCH 4/4] EDAC: Refactor edac_align_ptr() flow
Message-ID: <Ygvd6ATqmb537dEC@zn.tnic>
References: <20220113100622.12783-1-farbere@amazon.com>
 <20220113100622.12783-5-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220113100622.12783-5-farbere@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 13, 2022 at 10:06:22AM +0000, Eliav Farber wrote:
> Modify flow to be more clear:
>  - Calculate required alignment based on size.
>  - Check if *p is aligned and fix if not.
>  - Set return ptr to to be *p.
>  - Increase *p by new size for the next call.

Right, as I said earlier, piling more on this crap design is not the
right thing to do. Looking at the call sites, what I think you should do
instead is simply compute the whole allocation size by making sure the
alignment of those substruct element pointers we're assigning to, is 8
or so, for simplicity.

You can store the offsets in those helper variables, like it is done
now.

Then do the allocation and add the offsets to the pointer kzalloc has
returned.

And then get rid of that edac_align_ptr() crap. This thing is silly
beyond repair and passing in that **p offset back'n'forth is making
stuff more complicated than it is - one can simply do that computation
before calling kzalloc and doesn't need a "helper" which ain't helping.

I'd say.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
