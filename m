Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BDF5B1929
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiIHJql (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 05:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiIHJqk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 05:46:40 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD52DFF7C;
        Thu,  8 Sep 2022 02:46:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id l12so10773297ljg.9;
        Thu, 08 Sep 2022 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ALmjZmyHYM2cBn/xj7Tq1X/P8kH0HgKp0PnkmVdAnGg=;
        b=j1Jo9160KpsbW5XlguQb+WQNfHvsekgXu5cyZotOz4HClvYMJWiEBtRDIJ1PGCy8Ef
         VxSL0VqEUUX4fdBLlnYiwsnd4d3rU2evaNeIYLOahRM2jEVgArNwprC2ud+4KMBCPPX9
         G+9xC9IJU75UnrsFpZQCd1aqmJRo41ZYOzjYSkiTMUWQs+5YFrKq2aw0MkQgAB5OiT7+
         C5xFn/tCbE5uxCTKinaAmUHCBcCjyJYJXnHDDsfIW708PrfLQgl3SF4ndjvbG7whCm69
         /ha//j5vgJnO9rKZRMoFd0BRWzoFDV/U9jCWAXMrnY74WbRrwTXFOqRLRqOjLK51/z+q
         W8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ALmjZmyHYM2cBn/xj7Tq1X/P8kH0HgKp0PnkmVdAnGg=;
        b=2Dn6qGCCBO1DNozZzGEcsnEQX4Qm934QKYlAJ3i85K7to7BLEdW0DbvlDiI6HiCOMB
         4vZ7KPhiZOJcSjxs9m8MRqW9p3OGUWHxNuncLJA5m+ZkxdMNEq7cpisWp+AGENV/7aua
         7wicFCbevmhMzF8GUPOU5qqjuHEQFzyf1WFBa53lpC9B2chODL2FJKVYp9gn+SxW2gv4
         PDW5mM+f4ljXgnu3f8AADVLS8m5mOT6ACnR4gZw3uuLkeUDkds+6AgLjSUXQO5o0/mdn
         yzrW3mtQ7di7CdNGdNhKGNlRuhB8PZFw2iT3zlvbGsjQwbYTii0ZNJ/bfr7dTrGoPZt0
         a0HA==
X-Gm-Message-State: ACgBeo0H4tR/vN5lDLy+Qnbztyi7APj1+TAtquzIDvN8J4MNk9ADuF/3
        NxSu1eAURTlAkGvvvle9lC/Rrz9w0RIi4Q==
X-Google-Smtp-Source: AA6agR6Ppq3bQoSo0/8/xUsMzq2EiG98pBKlGXNy6y2LP2oWAwPLoZWiwDUG+MlQW8IKMT1qKIk7vA==
X-Received: by 2002:a2e:a99b:0:b0:25e:be66:72f2 with SMTP id x27-20020a2ea99b000000b0025ebe6672f2mr2120184ljq.27.1662630394842;
        Thu, 08 Sep 2022 02:46:34 -0700 (PDT)
Received: from mobilestation (89-109-47-111.dynamic.mts-nn.ru. [89.109.47.111])
        by smtp.gmail.com with ESMTPSA id m16-20020a056512359000b004978e51b691sm1571799lfr.266.2022.09.08.02.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 02:46:34 -0700 (PDT)
Date:   Thu, 8 Sep 2022 12:46:31 +0300
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
Message-ID: <20220908094307.civtqiwxadas3ys3@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
 <20220826095447.qxfvty6xq4tufe75@mobilestation>
 <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 05, 2022 at 12:14:21PM +0200, Krzysztof Kozlowski wrote:
> On 26/08/2022 11:54, Serge Semin wrote:
> > On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
> >> On 22/08/2022 22:19, Serge Semin wrote:
> >>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> >>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> >>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
> >>
> > 
> >> Missing space before "The".
> > 
> > Ok. Thanks.
> > 
> >>
> >>> clock source is absent since it's fully synchronous to the core clock.
> >>
> > 
> >> You need allOf:if-then restricting this per variant.
> > 
> > I really don't like the allOf-if-if-etc pattern because it gets to be
> > very bulky if all the vendor-specific and generic platform
> > peculiarities are placed in there. I am more keen of having a
> > generic DT-schema which would be then allOf-ed by the vendor-specific
> > device bindings. What do you think I'd provide such design in this
> > case too?
> 
> Sure, it would work.
> 
> > 
> > But I'll need to move the compatible property definition to the
> > "select" property. Like this:
> > 
> > Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
> > +[...]
> > +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
> > +# and make sure it's assigned with the vendor-specific compatible string.
> > +select:
> > +  properties:
> > +    compatible:
> > +      oneOf:
> > +        - deprecated: true
> > +          description: Synopsys DW uMCTL2 DDR controller v3.80a
> > +          const: snps,ddrc-3.80a
> > +        - description: Synopsys DW uMCTL2 DDR controller
> > +          const: snps,dw-umctl2-ddrc
> > +        - description: Xilinx ZynqMP DDR controller v2.40a
> > +          const: xlnx,zynqmp-ddrc-2.40a
> > +  required:
> > +    - compatible
> 

> Not entirely. If you need select, then add it with compatibles, but all
> descriptions and deprecated are staying in properties.

Ok. But note in such case the compatible string constraints will get
to be opened for any non-common string. Like this:

+ properties:
+   compatible:
+     oneOf:
+       - const: snps,ddrc-3.80a
+       - {}

It's required for the DT-schemas referencing the common one, otherwise
they will fail DT-nodes evaluation due to the "compatible" property
missing the vendor-specific string.

> 
> 
> > +
> > +properties:
> > +  compatible: true
> > +[...]
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +
> > +additionalProperties: true
> > 
> > After that the "snps,dw-umctl2-ddrc.yaml" schema can be referenced in the
> > allOf composition. Like this:
> > 
> > Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml:
> > +[...]
> > +allOf:
> > +  - $ref: /schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml#
> > +[...]
> > 
> > At the same time the generic DT-schema will be used to evaluate the
> > "snps,ddrc-3.80a", "snps,dw-umctl2-ddrc" and "xlnx,zynqmp-ddrc-2.40a"
> > device nodes as before. What do you think about that?
> > 
> > One big positive side of this that even though the generic schema
> > can't define the IRQ/resets/clocks phandlers order because various
> > platforms may have different external signals setup, the
> > vendor-specific schema can and should. So I'll be able to describe the
> > Baikal-T1 DDRC specific properties (clocks, clock-names, interrupts,
> > interrupt-names, etc) in much more details including the reference
> > signals order what you asked in the previous patch review.
> 

> It's ok. You need then second schema for your device, because something
> must end with additional/unevaluatedProperties false.

Right. I'll add a separate DT-schema for my device.

-Sergey

> 
> Best regards,
> Krzysztof
