Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED4659E655
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241871AbiHWPrK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 11:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242146AbiHWPqz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 11:46:55 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D832AB3D6;
        Tue, 23 Aug 2022 04:47:11 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id l1so18767574lfk.8;
        Tue, 23 Aug 2022 04:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=9DFi8GMavWCQGHl6/b/DfpLAu8GPfBlHk4CuJF22IMY=;
        b=UKCmuVB+XW4lw2kUy4PfUbWfaQWfujDghz5LxBd0za58bJ6PIhTEhS7R5R1uukm3hl
         AziPWSsrq88P5KAGGRkLOfbahVbEDG93ff7xayS1kWQGL4/dadXylHN5WLG+miNpYPRm
         9W/zhxJ4oaw+fFSGeyot1ncmdHtuCVgb8VxtxqNU+tPOjYsNmZu/xoYMoxwdMK8Xay4q
         r6v2P6fgy+cQGBwRRNA4CxhyAw9jd1OM0xdpM2RfAgGGztob3qor7bd/Mk3IY0doeqcM
         lc4+WY3tGrY53hvXzvip9MTQomIzCmv+FxHEfWqqLTPUZLoENGiyl15QTlJ6gv3sUyJf
         olKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9DFi8GMavWCQGHl6/b/DfpLAu8GPfBlHk4CuJF22IMY=;
        b=TDCSB64xWgdlZ95Z5AypldBhJTgMjx8qBH+K2fJOME2ps8RYDWP1rxd6GFapsNll0w
         2scFdmTIIKcm1OaHP7jvUwXYb28X+WAtv/oHhqrtY/EEemEV1ze+O4VG7O/3Ywn9JoBp
         /zuodvrBORkx1Z3PXhlqW4rlxYzhcyJHcVrDljvQAmUM2Zqwfg/L2+hdw4a8+Q85ouhp
         87v69cfEoO9tzz6TXr/NqQ3ZNDwI8974TvNVhoFK5uiGv/1NXx/35OGhqosDYJtXQIUv
         9RcmihIXPtd5S2LNGZl2cEo/+oDHiT7lqfYHbNiYZPD7HsNuyhHU5bfhWsY82Mh4LXoA
         Sukg==
X-Gm-Message-State: ACgBeo0W6lbs6LHmkFZJmrPD99TEPjTf+LJFL7lNGfeSYEI+2ANTTYXW
        +0tozZSWbn9gKT5LJFKkBJw=
X-Google-Smtp-Source: AA6agR5OnjnsYrTSUwMVA6+5CrajZGLUzWP+V59b0pBkkaaZWn8k3q650yb2pDZT7GNHJgbPFj/eHQ==
X-Received: by 2002:a05:6512:3d1f:b0:48a:f6d5:644e with SMTP id d31-20020a0565123d1f00b0048af6d5644emr8131478lfv.589.1661255119618;
        Tue, 23 Aug 2022 04:45:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b0047dace7c7e5sm2456808lfq.212.2022.08.23.04.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 04:45:18 -0700 (PDT)
Date:   Tue, 23 Aug 2022 14:45:16 +0300
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
Message-ID: <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <20220823083243.aovlgu22j7uv73qv@mobilestation>
 <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:44:16AM +0300, Krzysztof Kozlowski wrote:
> On 23/08/2022 11:32, Serge Semin wrote:
> > On Tue, Aug 23, 2022 at 11:17:23AM +0300, Krzysztof Kozlowski wrote:
> >> On 22/08/2022 22:07, Serge Semin wrote:
> >>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> >>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
> >>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
> >>> no any reason to have these controllers described by the same bindings.
> >>> Thus let's split them up.
> >>>
> >>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
> >>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
> >>> description of the device bindings.
> >>
> > 

> >> Filename should be based on compatible, so if renaming then
> >> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
> >> filename anyway. Therefore nack for rename.

Original name was synopsys,ddrc-ecc.yaml which doesn't match any of
the compatible strings. 

> > 
> > New requirement? I've submitted not a single patch to the DT-bindings
> > sources and didn't get any comment from Rob about that. 
> 

> This is not a new requirement. It has been since some time and Rob gave
> such reviews.
> 
> https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel.org/

April 2022. So it's new. It would be nice to have it defined somewhere
in docs (writing-bindings.rst?). So does the compatibles order (this
was surprising to me too).

> 
> For devices with multiple compatibles that's a bit tricky, but assuming
> the bindings describe both original design from Synopsys and it's
> implementations, then something closer to Synopsys makes sense.

The closest name would be snps,dw-umctl2-ddrc.yaml. snps,ddrc is too
generic especially for the IP-cores vendor. It doesn't have a
reference to the actual IP-core the device in subject is based on.

> 
> 
> > In addition
> > There are DT bindings with names different from what is defined in the
> > compatible name. Moreover there are tons of bindings with various
> > compatible names. What name to choose then? Finally the current name
> > is too generic to use for actual DW uMCTL2 DDRC controller.
> 

> There are thousands of bugs, inconsistencies, naming differences in
> kernel. I don't find these as arguments to repeat the practice...so the
> bindings file name should be based on the compatible.

Did I ask for an exception? I justified why the renaming was necessary. You
said it goes against the practice of having the DT-schema named as the
device compatible strings and just nacked. But above in this message you said

> "assuming the bindings describe both original design from Synopsys
> and it's implementations, then something closer to Synopsys makes sense"

What I suggest makes more sense than some abstract Synopsys DDRC,
which may refer to a Synopsys DDR controller other than the subject
one. So I see two solutions here:
1. Adding a new generic compatible string like "snps,dw-umctl2-ddrc"
and deprecate the "snps,ddrc-3.80a". It gets to be even more justified
seeing the Synopsys IP-core version has been exported in the device
CSRs since IP-core v3.20a. So having the version attached to the
compatible string was absolutely redundant.
2. Just deprecate the generic compatible string, the new compatible
devices will be supposed to use a vendor-specific compatible strings,
but still rename the DT-bindings file. This makes sense since the
current generic name isn't quiet well structured. It' prefix-part is
too generic and at the same time it refers to a device reversion for
no much reason.

What do you think?

* Note I've got it you'd prefer the renaming being performed in a
separate patch.

-Sergey

> 
> Best regards,
> Krzysztof
