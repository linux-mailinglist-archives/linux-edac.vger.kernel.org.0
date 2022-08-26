Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4C25A237C
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbiHZIrg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbiHZIre (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 04:47:34 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A9ABCC22;
        Fri, 26 Aug 2022 01:47:32 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bx38so921123ljb.10;
        Fri, 26 Aug 2022 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=uzcRohvbBhqjcSWyHd3c3YKQQRgXjC0tFfXFqKAXllc=;
        b=RMz3QFn8cpiiytx48RSy5mO2azikJR9JYcLa4TPyM5kX29wZDTq6BxkrJReT3bDpD/
         wgXpqdzWAgxCTzg8kg4soBaJjbnk3EQiS5xi2o7kA8nQNR2WVKWQ9vTwAy8APcruc8BB
         C55hpNb2nXWJ5VcvXNKehm3rN14Xsu4pTTHsXjlSQIgUDc+2sCtZlHpGs74Hv1W11sU8
         fWdt2NOWWdDFD/RKblPcrALZChg1tPYbc6ei7lJPNpTWes1LYmuRgzCTTRBOag72OUz8
         Qc8SiBtVYzzyvLXuMyflBgtrmsK0CBMNzuggh3BaGgyxco+81S6m3J50F14xg395TrZJ
         UCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=uzcRohvbBhqjcSWyHd3c3YKQQRgXjC0tFfXFqKAXllc=;
        b=icelP0YcofTg9ZXXFjvjhOh/9HM82dxWwZTTQK104wyWYYhsSR+x8g0IxRHRtCVmfI
         aWW1i5/XrT9+fI/Xq4YAu3nKANhwWVJ7SAtHO0hEb8Dtj+nKX048woET4VMdKtfVxV+I
         DVU8tKipO60+7L0cDCIhIhLLZzDJH1/ry6qJRKxjTl0FYIW/SrdenfyNA6on5Y6I4fkc
         6ymQYhMkS1BqnN9A7Exw/OhpxD+kNnAf9RanGCTVsXBFTu70O65D61tGlCemBp2j3Z+j
         tQ5U888cfKPUpQuXWZX/V+Y+Z570rYJPMkPxX/mZvhZx2H2qfHylj9Zq+iDionJM3iti
         Gqkw==
X-Gm-Message-State: ACgBeo2hLXrqDTyjL4bA7j20rFRY6YiNcgES5mwudS5fKvJyO5dQMXT6
        BhSETQQtGs1EYLsJbYqcKEQ=
X-Google-Smtp-Source: AA6agR5zu1vqqcn8tswJzFY0GOx6nLp55E1cNfwGk48LG4zenXPxJDucyj1pGnaor/pEVH/6M2jLlg==
X-Received: by 2002:a05:651c:1720:b0:261:bfb0:f832 with SMTP id be32-20020a05651c172000b00261bfb0f832mr1933020ljb.346.1661503650333;
        Fri, 26 Aug 2022 01:47:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id t8-20020a056512208800b0048b13d0b896sm306711lfr.141.2022.08.26.01.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:47:29 -0700 (PDT)
Date:   Fri, 26 Aug 2022 11:47:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Subject: Re: [PATCH 01/13] dt-bindings: memory: snps: Extend schema with
 IRQs/resets/clocks props
Message-ID: <20220826084726.7ra7342pa33bci5h@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
 <6a803554-bc1a-9f53-b7e2-7571fffea7e0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a803554-bc1a-9f53-b7e2-7571fffea7e0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:11:08AM +0300, Krzysztof Kozlowski wrote:
> On 22/08/2022 22:19, Serge Semin wrote:
> > First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
> > for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
> > Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
> > possible that the platform engineers merge them up in the IRQ controller
> > level. So let's add both configuration support to the DT-schema.
> > 
> > Secondly each IP-core interface is supplied with a clock source like APB
> > reference clock, AXI-ports clock, main DDRC core reference clock and
> > Scrubber low-power clock. In addition to that each clock domain can have a
> > dedicated reset signal. Let's add the properties for at least the denoted
> > clock sources and the corresponding reset controls.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../snps,dw-umctl2-ddrc.yaml                  | 65 +++++++++++++++++--
> >  1 file changed, 60 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > index 787d91d64eee..8db92210cfe1 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > @@ -13,13 +13,13 @@ maintainers:
> >  
> >  description: |
> >    Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is cappable of
> 

> Typo in original text: capable
> 
> > -  working with DDR devices up to (LP)DDR4 protocol. It can be equipped
> > +  working with DDR devices upporting to (LP)DDR4 protocol. It can be equipped
> 
> Typo - supporting?
> 
> >    with SEC/DEC ECC feature if DRAM data bus width is either 16-bits or
> >    32-bits or 64-bits wide.
> >  
> > -  The ZynqMP DDR controller is based on the DW uMCTL2 v2.40a controller.
> > -  It has an optional SEC/DEC ECC support in 64-bit and 32-bit bus width
> > -  configurations.
> > +  For instance the ZynqMP DDR controller is based on the DW uMCTL2 v2.40a
> > +  controller. It has an optional SEC/DEC ECC support in 64-bit and 32-bit
> > +  bus width configurations.
> 
> These changes do not look related to your patch, so split them.

Right. Sorry for the confusing change. Indeed this update belongs to a
different patch. I'll move it to the patchset #0 to the patch with the
Zynq DT-bindings detachment.

> 
> >  
> >  properties:
> >    compatible:
> > @@ -28,11 +28,55 @@ properties:
> >        - xlnx,zynqmp-ddrc-2.40a
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    description:
> > +      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
> > +      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
> > +      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
> > +      signals merged before they reach the IRQ controller or have some of them
> > +      absent in case if the corresponding feature is unavailable/disabled.
> > +    minItems: 1
> > +    maxItems: 5
> 

> List has to be strictly ordered, so instead list and describe the
> items... unless you are sure that any of these interrupt lines can be
> merged into any other one?

That's what I noted in the property description. Anyway please see the
interrupt-names property for the possible interrupts setup. To sum up
some of the IRQs might be absent or some of them merged into a single
signal.

> 
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    maxItems: 5
> > +    oneOf:
> > +      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
> > +        items:
> > +          - const: ecc
> > +      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
> > +        items:
> > +          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
> >  
> >    reg:
> >      maxItems: 1
> >  
> > +  clocks:
> > +    description:
> > +      A standard set of the clock sources contains CSRs bus clock, AXI-ports
> > +      reference clock, DDRC core clock, Scrubber standalone clock
> > +      (synchronous to the DDRC clock).
> > +    minItems: 1
> > +    maxItems: 4
> 

> I expect list to be strictly defined, not flexible.

Some of the clock sources might be absent or tied up to another one
(for instance pclk, aclk and sbr can be clocked from a single core
clock source). It depends on the IP-core synthesize parameters.

> 
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +    items:
> > +      enum: [ pclk, aclk, core, sbr ]
> > +
> > +  resets:
> > +    description:
> > +      Each clock domain can have separate reset signal.
> > +    minItems: 1
> > +    maxItems: 4
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +    items:
> > +      enum: [ prst, arst, core, sbr ]
> 

> The same.

The same as for the clock.

> 
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -48,4 +92,15 @@ examples:
> >        interrupt-parent = <&gic>;
> >        interrupts = <0 112 4>;
> >      };
> > +  - |
> > +    memory-controller@fd070000 {
> > +      compatible = "snps,ddrc-3.80a";
> > +      reg = <0x3d400000 0x400000>;
> > +
> > +      interrupts = <0 147 4>, <0 148 4>, <0 149 4>, <0 150 4>;
> 

> Use proper defines.

What do you mean? Which defines do you think would be proper? If you
meant the IRQ DT-bindings macros, then what difference does it make
for a generic device in the DT-binding example? Note since the device
is defined as generic it can be placed on different platforms with
different interrupt controller requirements. So what do you mean by
"proper" in this case?

-Serge

> 
> > +      interrupt-names = "ecc_ce", "ecc_ue", "ecc_sbr", "dfi_e";
> > +
> > +      clocks = <&rcu 0>, <&rcu 5>, <&rcu 6>, <&rcu 7>;
> > +      clock-names = "pclk", "aclk", "core", "sbr";
> > +    };
> >  ...
> 
> 
> Best regards,
> Krzysztof
