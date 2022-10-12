Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5255FCC11
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 22:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJLUdz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 16:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJLUdx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 16:33:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E09B102DFA;
        Wed, 12 Oct 2022 13:33:45 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C96331EC064C;
        Wed, 12 Oct 2022 22:33:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665606819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uv0bLo+DiHhjI0qr7UFRZvZTyvAh9zHujBnMY+9JeBQ=;
        b=aktmlIcfKWckJoLMl6A2nZWPfgV1kO5+KYXqrb6NSnn67ss1bGlBW2xDUthgHqKcWv2WyU
        ZkU23JDhTlLC6zsn+qQyjMkGN+wNUm12lKzlylNEaNuGpHArDRSmHjxvqq15ZfkzOhQIMM
        oz++lTBZ74Zi/OO5VjfuJBjUMbp3mGA=
Date:   Wed, 12 Oct 2022 22:33:35 +0200
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
Message-ID: <Y0ckn5r3KN416Jeg@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
 <Y0b5cq4evSg1nfb0@zn.tnic>
 <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221012200154.7fq3i7igbgkcy2mx@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 12, 2022 at 11:01:54PM +0300, Serge Semin wrote:
> The unified approach makes code indeed more readable in the platform
> drivers and safer since they didn't have to bother with more coding.
> See for instance the drivers with the static variable-based IDs
> allocation.

Which drivers? Concrete examples please.

> Have you read it yourself? 

Yes. I even have improved it over the years.

> Here is a short excerpt from there:
> "Once the problem is established, describe what you are actually doing
> about it in technical detail.  It's important to describe the change
> in plain English for the reviewer to verify that the code is behaving
> as you intend it to."

Maybe that part can be misunderstood: "describe what you're doing about
it". That doesn't mean the text should explain what you're adding and
how stuff is defined: "It's defined by the EDAC_AUTO_MC_NUM macro." I
can see that from the diff.

So let me try to explain to you what I'm expecting from commit messages
in the EDAC tree:

The commit message should explain *why* a change is being done so that,
months, years from now, when you've gone on to do something else, people
doing git archeology can actually figure out *why* this change was done.

And the explanation in that commit message should be *complete* and
should contain *all* necessary information to understand why this change
was done.

Your commit message is not explaining the problem.

"In case of the unique index allocation it's not that optimal to always
rely on the low-level device drivers (platform drivers)"

That's your statement. That needs to have exact details so that people
can look at that commit message, look at the code which *you* point them
to in it and go, aha, that is the problem.

"because they get to start to implement either the same design pattern
(for instance global static MC counter) or may end-up with having
non-unique index eventually at runtime."

Who are they, exact pointers please.

"The suggested implementation is based on the kernel IDA infrastructure
exposed by the lib/idr.c driver with API described in linux/idr.h header
file."

That doesn't matter one bit for the change you're doing. You could have
added it under the "---" line.

"A new special MC index is introduced here. It's defined by the
EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
index is specified by the EDAC LLDD, the MC index will be either retrieved
from the MC device OF-node alias index ("mc[:number:]") or automatically
generated as the next-free MC index found by the ID allocation procedure."

Some of that paragraph should go over the function as a comment - not in
the commit message as it pertains to what the function does and it would
make a *lot* more sense there when someone tries to figure out what the
function does instead of in the commit message.

So, I'm still not convinced why do some EDAC drivers need unique MC
identifiers, why the current scheme doesn't work and where it doesn't
work.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
