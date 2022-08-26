Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70975A2529
	for <lists+linux-edac@lfdr.de>; Fri, 26 Aug 2022 11:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbiHZJzF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Aug 2022 05:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245573AbiHZJyz (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Aug 2022 05:54:55 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0308616C;
        Fri, 26 Aug 2022 02:54:52 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l23so1095246lji.1;
        Fri, 26 Aug 2022 02:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=jYk14p3K6SzH1R4v3sN43rrmlvIDkPGc70H6u7ButPA=;
        b=mLsrOU2VD1R+D8gTHoG4LLSWU5gfBvllPgC3zetPXsN7QcPVzpXTQGyGZNNkWPEIJw
         B5adWMYZLFMz/04cjtWKEkd7Htcw4QYCt55dV2QejJJxL4GlnkiU27cuhMOM/6SPhvTu
         mZJUOMSbHhg0lttAvhxD4tk/CO1iE1V9JfTGZ8sOdoi0isYDdrmGDYq9Prc5FYVyx9P9
         E/oG7zEaC2rcO7tnl7mYEkS2oKThH7KmXlra/V4oR8WcoTFK2GVLiNLlP6UwFK5ri+G9
         AkRMhnBUMeG49ETn3Jw1bt5b7K+zlIe1FcRcW49Ggaa7MHhUT5BYSYpMGQ4EHXw8uRtm
         yNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=jYk14p3K6SzH1R4v3sN43rrmlvIDkPGc70H6u7ButPA=;
        b=TSUTjSiY/lpBmX/1oqrbM53dBllH1akQY5j/WdRVCf9EmF/9hDj4wKWidaU8OkQFWa
         EofFXl4KxJyff2/T4bB2iyWZ5+bL+5UaFyyJvH4gXakxlRRTBYTH7fDaKTpfAmTfnqe1
         CUnyMcFpvYpnSWc7ITyT/95cRg3xeTchPyMv/lKJ8bpYbBJOWxf4pbzrKGxqjXNgandi
         tedAeevpR31oNnWdibMxj8X7IaMmEJXzZSa7s4IN2reydrvnHO3u/23dChI3dnRNpDIy
         gtchJ0KRDqaeSlH8uQOJ3/kPDOyoPUPAfBYjt5lMR1DZ2ckkqKzDP28S67wZyAa8N7T+
         aF1Q==
X-Gm-Message-State: ACgBeo2s9yyRRTGQSDljOkqIM+MVAeE/fA+2OrdIpzcGcbFfcKuxzoIM
        Xc88U6fCwOeFc+tsvMPG5LU6W+es16vWqg==
X-Google-Smtp-Source: AA6agR7JjPy5O6f7Yu8b5VuDaNtdsi8QUg7axgCfoGqwBf8TISqVR4s/uiUzq5PlKoXqLobv7msVJw==
X-Received: by 2002:a2e:bd0e:0:b0:261:e718:e902 with SMTP id n14-20020a2ebd0e000000b00261e718e902mr2145077ljq.435.1661507690637;
        Fri, 26 Aug 2022 02:54:50 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e2f14000000b0025e60089f34sm401949ljv.52.2022.08.26.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:54:49 -0700 (PDT)
Date:   Fri, 26 Aug 2022 12:54:47 +0300
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
Message-ID: <20220826095447.qxfvty6xq4tufe75@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
> On 22/08/2022 22:19, Serge Semin wrote:
> > Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> > with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> > are individual IRQs for each ECC and DFI events.The dedicated scrubber
> 

> Missing space before "The".

Ok. Thanks.

> 
> > clock source is absent since it's fully synchronous to the core clock.
> 

> You need allOf:if-then restricting this per variant.

I really don't like the allOf-if-if-etc pattern because it gets to be
very bulky if all the vendor-specific and generic platform
peculiarities are placed in there. I am more keen of having a
generic DT-schema which would be then allOf-ed by the vendor-specific
device bindings. What do you think I'd provide such design in this
case too?

But I'll need to move the compatible property definition to the
"select" property. Like this:

Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
+[...]
+# Please create a separate DT-schema for your DW uMCTL2 DDR controller
+# and make sure it's assigned with the vendor-specific compatible string.
+select:
+  properties:
+    compatible:
+      oneOf:
+        - deprecated: true
+          description: Synopsys DW uMCTL2 DDR controller v3.80a
+          const: snps,ddrc-3.80a
+        - description: Synopsys DW uMCTL2 DDR controller
+          const: snps,dw-umctl2-ddrc
+        - description: Xilinx ZynqMP DDR controller v2.40a
+          const: xlnx,zynqmp-ddrc-2.40a
+  required:
+    - compatible
+
+properties:
+  compatible: true
+[...]
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: true

After that the "snps,dw-umctl2-ddrc.yaml" schema can be referenced in the
allOf composition. Like this:

Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml:
+[...]
+allOf:
+  - $ref: /schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml#
+[...]

At the same time the generic DT-schema will be used to evaluate the
"snps,ddrc-3.80a", "snps,dw-umctl2-ddrc" and "xlnx,zynqmp-ddrc-2.40a"
device nodes as before. What do you think about that?

One big positive side of this that even though the generic schema
can't define the IRQ/resets/clocks phandlers order because various
platforms may have different external signals setup, the
vendor-specific schema can and should. So I'll be able to describe the
Baikal-T1 DDRC specific properties (clocks, clock-names, interrupts,
interrupt-names, etc) in much more details including the reference
signals order what you asked in the previous patch review.

-Sergey

> 
> > In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> > registers space.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  .../memory-controllers/snps,dw-umctl2-ddrc.yaml        | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > index 8db92210cfe1..899a6c5f9806 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> > @@ -26,6 +26,7 @@ properties:
> >      enum:
> >        - snps,ddrc-3.80a
> >        - xlnx,zynqmp-ddrc-2.40a
> > +      - baikal,bt1-ddrc
>
 
> Messed order. Don't add stuff at the end, but in alphabetical order.

Ok. But could you please give me a reference with this requirement
documented? I've submitted many DT-bindings patches with the
compatible property updates and none of them received such comment
from Rob.

> 
> >  
> >    interrupts:
> >      description:
> > @@ -49,7 +50,14 @@ properties:
> >            enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
> >  
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    minItems: 1
> > +    items:
> > +      - const: umctl2
> > +      - const: phy
> 

> You need allOf:if-then restricting this per variant.

Please see my comment above regarding possible solution of this.

-Sergey

> 
> Best regards,
> Krzysztof
