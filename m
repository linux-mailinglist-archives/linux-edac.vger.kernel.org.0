Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE145FC9E5
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 19:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJLR33 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLR32 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 13:29:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7D423BF7;
        Wed, 12 Oct 2022 10:29:27 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D4501EC0304;
        Wed, 12 Oct 2022 19:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665595762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yQ3NJCYhGzQnwvOx2Fbc1ZbVY18C8OhIiN6ipKV7+4Y=;
        b=JZOAjQ0shdBqZOR9jqUdFuqz2kiUEYIEFgLRh+D6pM3KurzGFbfhqt3gopRykRl42J/303
        6cNHZeSM8eHtTeZwMCFsQ7F6X3F7/ZjQlK1bRzAQJYpvKtDAD5frQiu9GXNxzWaBoFZNPP
        SWMwHhjbMtFNXCNM2a5jgiKfjyiVBfw=
Date:   Wed, 12 Oct 2022 19:29:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <Y0b5cq4evSg1nfb0@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929232712.12202-14-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 30, 2022 at 02:27:08AM +0300, Serge Semin wrote:
> In case of the unique index allocation it's not that optimal to always
> rely on the low-level device drivers (platform drivers), because they get
> to start to implement either the same design pattern (for instance global
> static MC counter) or may end-up with having non-unique index eventually
> at runtime. Needless to say that having a generic unique index
> allocation/tracking procedure will make code more readable and safer.

I guess this is trying to say that the current memory controller index
thing doesn't work. But why doesn't it work?

It works just fine with the x86 drivers - there the memory controller
number is the same as the node number where it is located so that works
just fine.

If that scheme cannot work on other systems, then I need to see an
explanation why it cannot work first.

> The suggested implementation is based on the kernel IDA infrastructure
> exposed by the lib/idr.c driver with API described in linux/idr.h header
> file. It's used to create an ID resource descriptor "mc_idr", which then
> is utilized either to track the custom MC idx specified by EDAC LLDDs or
> to allocate the next-free MC idx.

This is talking about the "what" and not the "why".

> A new special MC index is introduced here. It's defined by the
> EDAC_AUTO_MC_NUM macro with a value specifically chosen as the least
> probable value used for the real MC index. In case if the EDAC_AUTO_MC_NUM
> index is specified by the EDAC LLDD, the MC index will be either retrieved
> from the MC device OF-node alias index ("mc[:number:]") or automatically
> generated as the next-free MC index found by the ID allocation procedure.

This is also talking about the "what" and not the "why".

At best, what you're doing should be visible from the patch itself.

Here's a longer explanation of how a commit message should look like:

https://kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
