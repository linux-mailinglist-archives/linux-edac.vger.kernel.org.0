Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA8D5A005C
	for <lists+linux-edac@lfdr.de>; Wed, 24 Aug 2022 19:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240120AbiHXR1b (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 Aug 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiHXR1a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 Aug 2022 13:27:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35197CA8B;
        Wed, 24 Aug 2022 10:27:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bt10so11972082lfb.1;
        Wed, 24 Aug 2022 10:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=NjHy2o/fmB9DWprX09I0JSv6Fo77g+SVAQzwM2LyQ1s=;
        b=i2hm69Zjvabebhj2pgzGV5LLIBxmREC02IKkyBWPCdAL0+T9HnTc0xijsUdUCbtp05
         +XJFx2NiDzqpChpGH+D2qJ1xvHvIiFZaZbv0bif1MHdJHNF+kAxTJ6SwNOxHHIhcZr1r
         P9vR9idYU+QL2Mr+gXF8eWGHTpNZus+PSFejVHv8x4LQSPKS79xwRncrP8NzQaTJjGEQ
         A35/hPmDwwbbGg5T0DQURUAtMHF1BcpdFkIN/6Y0y2Hg39/P+BWS44shu/p3hzyY9rVA
         JB1VRqoahR7f3252ykF15bMf8CW18lCnJP+l+Mz5JiWfOknR5G0VUv5fPoqrR7ZEEWyU
         frWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=NjHy2o/fmB9DWprX09I0JSv6Fo77g+SVAQzwM2LyQ1s=;
        b=EEaJyhoYbfC3X2qAWd4Fi3NzLFUbd0oNoXyJloBlE6H+ql++viy4QKfRkXSD10YsJv
         sLLOX5MpfdiXQkj2BPDq84v+XwwFv6v6nJxhfqHozRl4dgZjplPi4kvNeT9GY77InU6w
         EHt9O16wdhYRAq0RjZQqak3UPR+MC227Zv2z1S2IjsMTdbkIxcu3xVe8NCpgYwYe6dhh
         Duys+/mY5U4jUKeJHY8i1bnhMmAwc76Kailm98Jl7Cr+yhWu4WME6KHp/1CPRCeRKKTC
         8PtQodLaL6dtqnW7rly2zudpnGK77MEBmDUfRlZSjwKijPFMie7g5nQzucK50rjQvj5R
         NdBg==
X-Gm-Message-State: ACgBeo25Xqwxe2agmFjFHzBt6ghPCSr2jSE1i6h8BJr4ZEjgbyhQkGkD
        T5g4PVN2gmni0VAH89ovZGg=
X-Google-Smtp-Source: AA6agR4DnbBzrlOOgaZWCVmMZ9PZai5HHLlQfDo6tn0Q2s5gEjc8K2piZQ/yZEvgNggo1olyuDwmqw==
X-Received: by 2002:a05:6512:234a:b0:492:d80a:e570 with SMTP id p10-20020a056512234a00b00492d80ae570mr2697lfu.652.1661362047127;
        Wed, 24 Aug 2022 10:27:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id i15-20020a2e540f000000b00261b9df2ca2sm13051ljb.51.2022.08.24.10.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 10:27:26 -0700 (PDT)
Date:   Wed, 24 Aug 2022 20:27:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Message-ID: <20220824172724.ny2xpryn76h6ftv6@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <20220823083243.aovlgu22j7uv73qv@mobilestation>
 <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
 <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
 <6661dcc1-cc93-efbb-b248-0d93f681a1bf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6661dcc1-cc93-efbb-b248-0d93f681a1bf@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 03:03:51PM +0300, Krzysztof Kozlowski wrote:
> On 23/08/2022 14:45, Serge Semin wrote:
> > On Tue, Aug 23, 2022 at 11:44:16AM +0300, Krzysztof Kozlowski wrote:
> >> On 23/08/2022 11:32, Serge Semin wrote:
> >>> On Tue, Aug 23, 2022 at 11:17:23AM +0300, Krzysztof Kozlowski wrote:
> >>>> On 22/08/2022 22:07, Serge Semin wrote:
> >>>>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> >>>>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
> >>>>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
> >>>>> no any reason to have these controllers described by the same bindings.
> >>>>> Thus let's split them up.
> >>>>>
> >>>>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
> >>>>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
> >>>>> description of the device bindings.
> >>>>
> >>>
> > 
> >>>> Filename should be based on compatible, so if renaming then
> >>>> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> >>>> filename anyway. Therefore nack for rename.
> > 
> > Original name was synopsys,ddrc-ecc.yaml which doesn't match any of
> > the compatible strings. 
> > 
> >>>
> >>> New requirement? I've submitted not a single patch to the DT-bindings
> >>> sources and didn't get any comment from Rob about that. 
> >>
> > 
> >> This is not a new requirement. It has been since some time and Rob gave
> >> such reviews.
> >>
> >> https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel.org/
> > 
> > April 2022. So it's new. It would be nice to have it defined somewhere
> > in docs (writing-bindings.rst?). So does the compatibles order (this
> > was surprising to me too).
> > 
> >>
> >> For devices with multiple compatibles that's a bit tricky, but assuming
> >> the bindings describe both original design from Synopsys and it's
> >> implementations, then something closer to Synopsys makes sense.
> > 
> > The closest name would be snps,dw-umctl2-ddrc.yaml. snps,ddrc is too
> > generic especially for the IP-cores vendor. It doesn't have a
> > reference to the actual IP-core the device in subject is based on.
> 

> You are aware that in such case mistake is not in the file name but in
> the compatible?

Let's compare, what is defined for Synopsys DW uMCTL2 DDRC in the
DT-bindings now:
compatible string: snps,ddrc-3.80a
file name: synopsys,ddrc-ecc.yaml

First of all they don't match at all. Secondly none of the names refer
to the actual IP-core the DT-bindings file is defined for. So in this
case the problem is in both:
1. file name has undefined vendor-prefix. It's supposed to be "snps".
2. file name has "ecc" suffix, which is a device property, but has
nothing to do with the device actual name.
2. actual device name is different. It's DW uMCTL2 DDRC. Just DDRC
doesn't identify the IP-core in subject.

> 
> > 
> >>
> >>
> >>> In addition
> >>> There are DT bindings with names different from what is defined in the
> >>> compatible name. Moreover there are tons of bindings with various
> >>> compatible names. What name to choose then? Finally the current name
> >>> is too generic to use for actual DW uMCTL2 DDRC controller.
> >>
> > 
> >> There are thousands of bugs, inconsistencies, naming differences in
> >> kernel. I don't find these as arguments to repeat the practice...so the
> >> bindings file name should be based on the compatible.
> > 
> > Did I ask for an exception? I justified why the renaming was necessary. You
> > said it goes against the practice of having the DT-schema named as the
> > device compatible strings and just nacked. But above in this message you said
> > 
> >> "assuming the bindings describe both original design from Synopsys
> >> and it's implementations, then something closer to Synopsys makes sense"
> > 
> > What I suggest makes more sense than some abstract Synopsys DDRC,
> > which may refer to a Synopsys DDR controller other than the subject
> > one. So I see two solutions here:
> > 1. Adding a new generic compatible string like "snps,dw-umctl2-ddrc"
> > and deprecate the "snps,ddrc-3.80a". 
> 

> This might be good idea, although unfortunately replacing compatibles
> takes quite a lot of time if you do not want to break any out-of-tree
> users (read: other users of bindings).

Well, I didn't imply the replacement, but "deprecation". It means to
just mark the "snps,ddrc-3.80a" compatible string as deprecated in the
bindings file and define a new one "snps,dw-umctl2-ddrc" which wouldn't have
the "deprecated: true" property set. It shall at least implicitly warn
people not to add new DTS-files with the deprecated device name. As I
see it eventually the dtbs-check tool will be updated to auto-detect
such attempts and, for instance, print a warning.

> 
> 
> > It gets to be even more justified
> > seeing the Synopsys IP-core version has been exported in the device
> > CSRs since IP-core v3.20a. So having the version attached to the
> > compatible string was absolutely redundant.
> 

> The version might have sense in a way to differentiate from some older
> versions, pre 3.20a.

I've almost fully refactored the device driver, and can say for sure
that the driver doesn't implement any Synopsys IP-core versions
specifics:
1. "xlnx,zynq-ddrc-a05" - has absolutely nothing in common with the
Synopsys DW uMCTL2 DDR controller (see the patch log for details).
That's why I've split the driver and DT-bindings up.
2. "xlnx,zynqmp-ddrc-2.40a" - ZynqMP DDR controller based on the
Synopsys uMCTL2 DDRC v2.40a. The device name is vendor-specific
anyway. So seeing there is no any other ZynqMP DDR controller added,
having IP-core version attached to the compatible string has been
redundant in the first place. Anyway the driver implements only the
ZynqMP-platform specifics irrespective to the IP-core version.
3. "snps,ddrc-3.80a" - without my patchsets this represents a
Synopsys DW uMCTL2 DDR controller synthesized with 64-bit DQ-bus and
8xSDRAM words burst config. The later settings have nothing to do with
the IP-core version, meanwhile what is really v3.x-specific isn't
implemented in the driver.

> The binding was probably incomplete anyway.

At the current state it's incomplete indeed. After applying all my
DT-related patches it will get to be almost complete, at least in the
CSRs, IRQs, clocks and resets resources part. There is always room for
the device-specific properties though, but judging by my experience caught
from Rob' reviews such properties aren't welcome if we have the IP-core
version detectable and if we can add the platform-specific compatible
string. The later one could be used to define the platform-specific
parameters right in the driver so the DT-bindings could be kept
relatively simple.

> 
> 
> > 2. Just deprecate the generic compatible string, the new compatible
> > devices will be supposed to use a vendor-specific compatible strings,
> > but still rename the DT-bindings file. This makes sense since the
> > current generic name isn't quiet well structured. It' prefix-part is
> > too generic and at the same time it refers to a device reversion for
> > no much reason.
> 

> You mean disallow entirely "snps,ddrc-3.80a" and expect everyone to use
> device/implementation specific compatible?

Yes as an alternative to the solution 1. described above.

> I guess this depends whether
> this custom block can be used without vendor specific addons. For
> several other DW blocks we expect to have the generic snsp fallback and
> this generic fallback can be used alone in Linux (pcie-designware-plat.c
> binds to it).

Just recently I've got a very long discussion with Rob regarding the
generic fallback compatible string. What he said "drop the generic
compatible fallback string. It proved to be useless." So I had to drop
the generic fallback compatible string from the nodes of my local DTS
files where it was appropriate and update all my DT-related patches to
disallow having vendor-specific and generic compatible strings specified
together.

Note what Rob said concerned the generic compatible "fallback" case,
not the generic compatible string in general. It's ok to have a
generic device name defined irrespective to the platform vendor.
Moreover it's applicable in case of the DW uMCTL2 DDRC IP-core since
first IP-core version is auto-detectable starting from v3.20a and
second I managed to implement auto-detection solutions for almost
all the DDR/ECC-specific parameters. So I am more inclined to the
solution 1) suggested by me in the previous email message:
- deprecate "snps,ddrc-3.80a" string.
- add new generic "snps,dw-umctl2-ddrc" compatible string.
- rename the DT-bindings file.

> 
> Here the Linux driver also binds to generic synopsys compatible, so I
> would assume it has a meaning and use case on its own.

Please see my messages above regarding the current Synopsys DW uMCTL2
EDAC driver implementation.

> 
> > 
> > What do you think?
> > 
> > * Note I've got it you'd prefer the renaming being performed in a
> > separate patch.
> 
> The rename could be in the split patch as here, but then I assume the
> rename part to be detected by git and be a pure rename. However:
> 1. The git did not mark it as rename (you might need to use custom
> arguments to -M/-B/-C),

Of course git hasn't detected it as rename, because aside with renaming
I've split the bindings up. Splitting these two updates up into two
patches will give us what you said. So to speak I suggest the next
updates for v2:
PATCH X. Detach the Zynq A05 DDRC DT-bindings to a separate schema.
PATCH X + 1. Rename the Synopsys DW uMCTL2 DDRC bindings file and add a more
descriptive generic compatible string name.

What do you think?

> 2. There were also changes in the process (allOf:if:then).

Right. But this is in another patchset. I'll address your notes in there.

-Sergey

> 
> 
> Best regards,
> Krzysztof
