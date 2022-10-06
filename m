Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA85F67DA
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiJFNZ5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJFNZx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 09:25:53 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149FEA9268;
        Thu,  6 Oct 2022 06:25:53 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e732329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e732:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 891AC1EC063A;
        Thu,  6 Oct 2022 15:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665062747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UD/kHZ1QqsxXXC+8XEN1rrv2JXKjTnMsM3a/4/yEYu8=;
        b=gP5Qk1LjooiLMFGuExDBW0oIx3VX8koptyGrokMz6vCfLY8OAWUfMT0C/2CBbMZAAOZCUb
        5ipbPEYifusBCp68dBHdn5ElUNq+HDkBnJLAAuQEEls4KKVqT5jH7cxVRZvH7UWENPvUwn
        ET1kR2EexlnsDqbc2LJmOw1TLqs4x/Y=
Date:   Thu, 6 Oct 2022 15:25:42 +0200
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
Subject: Re: [PATCH RESEND v3 14/17] EDAC/synopsys: Detach Zynq DDRC
 controller support
Message-ID: <Yz7XVqeopgGVR7+3@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221006121740.ksugoodbagr45fky@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 06, 2022 at 03:17:40PM +0300, Serge Semin wrote:
> In general because it needlessly overcomplicates the driver, worsen
> it scalability, maintainability and readability, makes it much harder
> to add new controller features. Moreover even if you still able to add
> some more features support the driver will get to be more and more messy
> (as Michal correctly said in the original thread [1]).

Did you read that thread until the end?

> It will get to be messy since you'll need to add more if-flag-else
> conditionals or define new device-specific callbacks to select the
> right code path for different controllers; you'll need to define
> some private data specific to one controller and unused in another.
> All of that you already have in the driver and all of that would be
> unneeded should the driver author have followed the standard kernel
> bus-device-driver model.

So lemme ask this again because the last time it all sounded weird and I
don't think it got clarified fully: you cannot have more than one memory
controller type at the same time on those systems, can you?

Because if you can and you want to support that, the current EDAC
"design" allows to have only a single EDAC driver per system. So you
can't do two drivers now.

If your answer to that is

Subject: [PATCH RESEND v3 13/17] EDAC/mc: Add MC unique index allocation procedure

then I'm sceptical but I'd need to look at that first.

And reading your commit messages, you're talking a lot about what you're
doing. But that should be visible from the patch. What I wanna read is
*why* you're doing it.

Like in this patch above, what's that "unique index allocation
procedure" for?

edac_mc_alloc() already gets a mc_num as the MC number.

And yes, if you want to do multiple driver instances like x86 does per
NUMA node instances, then that is done with edac_mc_alloc() which gives
you a memory controller descriptor and then you can deal with those.

From all the text it sounds to me you want to add a separate driver for
that Zynq A05 thing but I might still be missing something...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
