Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68AD5FD732
	for <lists+linux-edac@lfdr.de>; Thu, 13 Oct 2022 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJMJiw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Oct 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJMJiv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 13 Oct 2022 05:38:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407A91217F9;
        Thu, 13 Oct 2022 02:38:50 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e733329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e733:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C35B21EC053B;
        Thu, 13 Oct 2022 11:38:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665653924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7sFMAuZJzUPv1j5Nd1UXqoUcoLytDTmELcFfg6XdXbI=;
        b=UkfI9X4nygXICvQV52k1J8hwljulApTQLTNIi7MOwkzbgsvqYYHYuYnNu+FJaG1Z3N+9rY
        lq2edsvl2cTGRsLoRUyhiugNuI4SUIjaHzo8Un66CpOwlEZUuauIwVoEvb/ZO2tfTdEVkb
        DHDvHBKrJGdhcQZybcXqlqGiRO0W078=
Date:   Thu, 13 Oct 2022 11:38:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation
 procedure
Message-ID: <Y0fcoSVN0mKMuCjo@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
 <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
 <Y0ckn5r3KN416Jeg@zn.tnic>
 <20221012223039.upbjsiywiipdrjjk@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012223039.upbjsiywiipdrjjk@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 13, 2022 at 01:30:39AM +0300, Serge Semin wrote:
> A level of completeness can be relative to each person. For all the
> years I've submitting the patches to the kernel I couldn't even
> remember the last request to elaborate my logs. In no means I want to
> say they were perfect. I could just be too immersed into the problem
> so thought that the provided text was descriptive enough especially
> for the subsystem maintainer. So to speak asking for more details
> would be more than enough.

Dude, are you even reading what I'm writing to you?!

I don't care how immersed you were in the problem and who asked or
didn't ask you to elaborate your logs. If you're submitting patches
to the EDAC tree, those logs need to be complete and explain things
sufficiently and exactly. Period.

> So you need more details. You should have just asked. I can't read
> your mind after all.

And I can't read yours too. And I asked like three times already. And
yet, you still are not giving me a concrete answer.

I said "exact pointers please". That means, you point me to a driver and
the *exact* *code* in there which you think is doing something which
needs fixing.

What you've given me again is the same spiel as before.

So let me save you and me some time: your patches are not going anywhere
until they explain the thing they're fixing properly and precisely. End
of story.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
