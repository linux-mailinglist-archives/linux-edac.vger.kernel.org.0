Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3869D5B2198
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiIHPIP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 11:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbiIHPIM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 11:08:12 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A3E3D51;
        Thu,  8 Sep 2022 08:08:11 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id y29so7663309ljq.7;
        Thu, 08 Sep 2022 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YLaSuFd5lBqt/iz7YkEFiNfltibKHcycV4w46Fy7wFs=;
        b=Ph+SvjSkTW6QsPROxN1BJZF2H9lESHqodUx0BqCZcptDcyZRbRCwdxCbMmyYwOTiVP
         gLYIRUZBaFahB1a2/tHLQOLC2yxRftoFdUX+fdAMjAG/7I/dl7ew28PXEI9qHRjPLvCA
         W51Msi2UAFMsnziPYX8IaHWbkHlSudcqwXylzlOGbkd6QXHF+0EZ8RGcjAVngQFw1gke
         jwke1Bnv7AW3yQmeQdUhWnIiITWtStj0cU7yJ+a3AU0SY9thi0AOvksyVX+ir6ws3LPo
         VpSMu2AudF67IUFSbbpslw29Os6MQn3hUd26ytU2RbAmbxpTh4SjXh5HN1TUGxEMZF0d
         L6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YLaSuFd5lBqt/iz7YkEFiNfltibKHcycV4w46Fy7wFs=;
        b=LDVYgCCEo+nJ0V9ianQFZeK3aNEZ6O4dN7D4btyQhTiesOBSrWTvmZa4VJwKkr07XR
         kdqaZWbIbmSAeYe/5QGksAv4ti7ixpBowQa5WAvRZ7vGb4HvzKkMctTLvsgxB3lupqtK
         +Vk4k1wHHy8P6xM/wA9ji9Dy/A8PM0DNoE47Cd5WNvJqdvS5OqwhVAkXwKiqC/bsDlVH
         7Pm+FIuiZ7tU56OmIGfjOWxVKpsHK9ET76689JqyXzGy2aDEfax3Zm5bpuiI9/H/iOLo
         pmG7DVdmNLDauQwVWBvOjjhjKk3KHIPUye4os7+Ux/yrInjiu9mRI+WRAaGc/OUc4Kiu
         834w==
X-Gm-Message-State: ACgBeo0FCV1YIucpWBH8CUgoGodtB6Gu7cTXw/WSruJQDBZpBUBG8+w/
        OcdUkLibVbLoxw4n5IGLukw=
X-Google-Smtp-Source: AA6agR6hiSFLtuoITbolv+d616KIQfslm6ytvTmqFZ9GT+NI8hBvOFIrWzJ0gXkitkNHphOwOYI+Jw==
X-Received: by 2002:a2e:a99b:0:b0:25e:be66:72f2 with SMTP id x27-20020a2ea99b000000b0025ebe6672f2mr2516901ljq.27.1662649688965;
        Thu, 08 Sep 2022 08:08:08 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id r21-20020ac24d15000000b00492e69be4d6sm3070426lfi.27.2022.09.08.08.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:08:08 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:08:06 +0300
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
Subject: Re: [PATCH 02/13] dt-bindings: memory: snps: Add Baikal-T1 DDRC
 support
Message-ID: <20220908150806.oj7d5inifofvtiqk@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
 <20220826095447.qxfvty6xq4tufe75@mobilestation>
 <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
 <20220908094307.civtqiwxadas3ys3@mobilestation>
 <d49dc1ca-af81-4c08-db80-35d994c6c3a2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d49dc1ca-af81-4c08-db80-35d994c6c3a2@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 08, 2022 at 11:58:50AM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2022 11:46, Serge Semin wrote:
> > On Mon, Sep 05, 2022 at 12:14:21PM +0200, Krzysztof Kozlowski wrote:
> >> On 26/08/2022 11:54, Serge Semin wrote:
> >>> On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
> >>>> On 22/08/2022 22:19, Serge Semin wrote:
> >>>>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> >>>>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> >>>>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
> >>>>
> >>>
> >>>> Missing space before "The".
> >>>
> >>> Ok. Thanks.
> >>>
> >>>>
> >>>>> clock source is absent since it's fully synchronous to the core clock.
> >>>>
> >>>
> >>>> You need allOf:if-then restricting this per variant.
> >>>
> >>> I really don't like the allOf-if-if-etc pattern because it gets to be
> >>> very bulky if all the vendor-specific and generic platform
> >>> peculiarities are placed in there. I am more keen of having a
> >>> generic DT-schema which would be then allOf-ed by the vendor-specific
> >>> device bindings. What do you think I'd provide such design in this
> >>> case too?
> >>
> >> Sure, it would work.
> >>
> >>>
> >>> But I'll need to move the compatible property definition to the
> >>> "select" property. Like this:
> >>>
> >>> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
> >>> +[...]
> >>> +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
> >>> +# and make sure it's assigned with the vendor-specific compatible string.
> >>> +select:
> >>> +  properties:
> >>> +    compatible:
> >>> +      oneOf:
> >>> +        - deprecated: true
> >>> +          description: Synopsys DW uMCTL2 DDR controller v3.80a
> >>> +          const: snps,ddrc-3.80a
> >>> +        - description: Synopsys DW uMCTL2 DDR controller
> >>> +          const: snps,dw-umctl2-ddrc
> >>> +        - description: Xilinx ZynqMP DDR controller v2.40a
> >>> +          const: xlnx,zynqmp-ddrc-2.40a
> >>> +  required:
> >>> +    - compatible
> >>
> > 
> >> Not entirely. If you need select, then add it with compatibles, but all
> >> descriptions and deprecated are staying in properties.
> > 
> > Ok. But note in such case the compatible string constraints will get
> > to be opened for any non-common string. Like this:
> > 
> > + properties:
> > +   compatible:
> > +     oneOf:
> > +       - const: snps,ddrc-3.80a
> > +       - {}
> 
> Not really. If you define here specific device compatibles in select,
> they must be here as well.
> 
> > 
> > It's required for the DT-schemas referencing the common one, otherwise
> > they will fail DT-nodes evaluation due to the "compatible" property
> > missing the vendor-specific string.
> 

> o you probably mix here purposes. Either you define common schema or
> device specific one. If you define common, usually it does not enforce
> any compatibles. You do not need select, no need for compatibles either,
> although you can add above syntax if it is valid. If you write here
> specific device bindings, then compatibles should be listed. Judging
> from what you wrote it's neither this nor that...

My idea was to provide both the common DT-schema and the
vendor-specific ones. But the later one would refer to the common
schema in the framework of the "allOf:" composition. Like this:

snps,dw-umctl2-ddrc.yaml:
+ [...]
+ select:
+   properties:
+     compatible:
+       enum:
+         - snps,ddrc-3.80a
+ [...]
+ properties:
+   compatible:
+     oneOf:
+       - const: snps,ddrc-3.80a
+       - {}
+   interrupts:
+   [...]
+   interrupt-names:
+   [...]
+ additionalProperties: false
+ [...]

baikal,bt1-ddrc.yaml:
+ [...]
+ allOf:
+   - "schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml:#"
+ [...]
+ unevaluateProperties: false
+ [...]

Thus the common schema as before would provide the widest set of the
properties and their constraints, while the vendor-specific one would
be !obligated! to follow the common schema conventions, but provide a
more specific set of the properties and constraints. A similar
approach is implemented for instance in the DW USB3 DT-schemas, but
with the generic compatible string fallback. In this case we don't
need the fallback string, but in order for the common schema being
applicable for both the common and vendor-specific DT-nodes the
compatible property constraints need to be designed as is provided in
the example above.

Alternatively we can split the snps,dw-umctl2-ddrc.yaml schema up into
the two ones:
snps,dw-umctl2-ddrc-common.yaml
and
snps,dw-umctl2-ddrc.yaml
So the first schema would contain all the common properties definition
and would be only used for being referenced in the particular device
DT-bindings (select: false). The snps,dw-umctl2-ddrc.yaml and
vendor-specific DT-schemas would just have it "allOf:"ed.

Personally I'd prefer the design pattern with the always-true
compatible property constraint as in the example above since it seems
easier to maintain than having the common and generic device
DT-schemas.

Note having a common DT-schema and a vendor-specific one referencing
the common schema is very much useful practice for the devices based
on the same IP-core. Vendor-device driver authors tend to create their
own bindings for the same clocks/resets/phys/etc thus making the
drivers much harder to maintain (for a bright example see what has
been done for the DW PCIe RP/EP IP-core). The worst part of it is that
ones the DT-bindings interface is implemented it can't be changed
since the kernel needs to be backward compatible with the DT-sources
compiled before. So the main goal of the common DT-schema is to fix
the common DT interface and make sure the new vendor-specific device
drivers would at least consider either to follow the IP-core DT
convention or to widen it up if required.

-Sergey

> 
> Best regards,
> Krzysztof
