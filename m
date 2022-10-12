Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AAA5FC9E2
	for <lists+linux-edac@lfdr.de>; Wed, 12 Oct 2022 19:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJLR3A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Oct 2022 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJLR27 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Oct 2022 13:28:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FD23BF7;
        Wed, 12 Oct 2022 10:28:58 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e705329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e705:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 236C31EC0230;
        Wed, 12 Oct 2022 19:28:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665595733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tvU0jXONYGKul0OD5+J1AKqveaybDvPpuFUBUK5EsXs=;
        b=FdvHDdZld/xnP6bockOGkgC1rORd/ZaNU6hr3q6rr4bequvgRl1Nph4PuLjo5NgzYxVok+
        cgGFPcbw8G50m8XIX5PLU3IJ0aV+pZiBB2q5tc3WpCqEkig3xxVs/pPlRECGNzR5+qcNZ0
        H10kmHxCoGqDqhLCY3MAcL6ZW8qtbxg=
Date:   Wed, 12 Oct 2022 19:28:48 +0200
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
Message-ID: <Y0b5UAMXPWbDC6HK@zn.tnic>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
 <20220929232712.12202-15-Sergey.Semin@baikalelectronics.ru>
 <YzcAV2I/rhILfhwR@zn.tnic>
 <20221006121740.ksugoodbagr45fky@mobilestation>
 <Yz7XVqeopgGVR7+3@zn.tnic>
 <20221008004224.owqbzbdctclua2hb@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221008004224.owqbzbdctclua2hb@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Oct 08, 2022 at 03:42:24AM +0300, Serge Semin wrote:
> Of course I did. Here is a short summary:

You didn't have to do a short summary but sure, if you prefer...

> 7. So you all decided to keep both controllers support in a single file,
> but would get back to a discussion of having separate drivers for them
> later.

Yes, pretty much.

> But after all these years of the Synopsys EDAC driver living in kernel
> we can conclude that combining the two different devices support in a
> single driver was pointless. First by the driver design nobody ever
> used the driver to handle both of them at the same time (MC index is
> fixed to zero).

So how was this supposed to work on his system?

If you have a system with two different memory controllers and you want
to have two different EDAC drivers for each, then the whole EDAC core
code needs to be audited wrt concurrency and synchronizing access to
its facilities because I don't think it has ever supported more than a
single EDAC driver per system.

And it has never needed to, at least not on x86 land. Which is
currently changing because of CXL, because of accelerators needing
RAS, GPUs needing RAS and so on and so on. So eventually we'd have to
either put the new RAS functionality in the existing chipset-specific
driver or have to go the multiple EDAC drivers route. But that's only
tangential...

So first I'd like to hear what your use case is: single EDAC driver for
your particular Baical-T1 device or you need to support multiple EDAC
drivers.

If so, why?

> Moreover in order to cover a still possible case of having both
> Synopsys uMCTL2 DDRC and Zynq A05 DDRC used on the same system in
> future I have implemented the solution 2.

See above.

> Em, if there is something else which makes the EDAC drivers to be
> impossible to co-exist on the same system, then it greatly violates
> the bus-device-driver model.

If by that you mean the aspect of a driver associating with a device and
performing operations with it then why do you assume that EDAC drivers
have to adhere to that model?

> Have you read the patchlog?

Lemme reply to it directly.

> BTW have you read the cover letter? It contains a short summary of the
> changes and their justification.

Yes, I have read it and it contains a lot of unnecessary detail which
should be in the respective patches themselves. And I still don't know
exactly what *you* are trying to do, as I said above.

A cover letter should contain a short executive summary explaining only
the goal of the patchset and then you can go into details if you prefer.
A reviewer should not have to dig into patch management details to know
what this patchset is trying to do.

A possible structure could be:

Problem is A.

It happens because of B.

Fix it by doing C.

(Potentially do D).

Btw, when you're writing your commit messages, please use passive voice
in your commit message: no "we" or "I", etc, and describe your changes
in imperative mood.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
