Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313BA5B2292
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 17:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbiIHPkR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 11:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiIHPkQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 11:40:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDEC7B7B9;
        Thu,  8 Sep 2022 08:40:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so28403957lfb.1;
        Thu, 08 Sep 2022 08:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XWThZaaJW5rxJARpcsN0KTiDCg6hXRHLoH9gE2BtbGc=;
        b=jAXfa+JsUEs8GfAw9C+/VCetxlAu6rT9f3YWLLJad/YQnLjEEQ5SdpNOdgkceDv/yK
         OULWC4no2uiU7MbacScAO3UU4VtxYOAt93lVFkpBp5FA1xbL+N+/bbX2wCSCElQyDOKI
         P0JQQrdw4RH8zRpO9fRsW3KRUSNPfyJRJN/irSiNZDpHncZ5J1HcGVsGVeGqqnekd2Yd
         C07Z4TEZGPnakqYUtW5kJT/NS3pbsUwSMvcBnsSMK2ocmkvx3oGyvW/J2xMX4RNnVRN0
         aXQtC2b96uEvR9j0608849jbW0gwMBYUxCIlE1LsZJr5Ngxabv52bzdRBZNgBlNiv1Na
         G1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XWThZaaJW5rxJARpcsN0KTiDCg6hXRHLoH9gE2BtbGc=;
        b=Un5EqG9xOwnTDEHSirdilL3ZJTSGUzT6Bq0S2f1IvkclzzeBJMnSVNB7Sv/LB+OILa
         ykE6ifqHINhkVOLeJdoL35revNyZn+acUzvkZwuBZDjTMplfDZQkP0uClY9ejMSU257m
         1Ryu5hy5FOnEWllRBwBrqDGggNhsa1TkZ/8R4tY/vdcvv/jycdUEAAlHqb/1XV6Y7S+h
         iibglRnUDavUEz5N2lFUjMcYimOO5h+Sxb7W3UZdZuFn6uilaC6jMG9sTD8ZuPDcQpoV
         JnuZm165x/C3GSeSKYvFyx36bVPgkhqyMQgjDXWCxVTrCrA6W9tavWstOp9DROO+Jisz
         V5VA==
X-Gm-Message-State: ACgBeo11s9MGNy/RX7f9QWIWniBqiwBU9HGReStTp0pnewM71tLgn6sk
        e1EZE86T1CB66ypYeKvZ0As=
X-Google-Smtp-Source: AA6agR6y24jTRx4/cW3jPkb/B0UpbZm0M8PKq+v7v7l0RitaJu+J6lRQFuOY69X6j5MKKr0h8d8BSQ==
X-Received: by 2002:ac2:5493:0:b0:498:f55c:7fc7 with SMTP id t19-20020ac25493000000b00498f55c7fc7mr152475lfk.381.1662651612492;
        Thu, 08 Sep 2022 08:40:12 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id r21-20020ac24d15000000b00492e69be4d6sm3080844lfi.27.2022.09.08.08.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:40:11 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:40:09 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
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
Message-ID: <20220908154009.hl4rr5sdzelspctt@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
 <20220826095447.qxfvty6xq4tufe75@mobilestation>
 <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
 <20220908094307.civtqiwxadas3ys3@mobilestation>
 <d49dc1ca-af81-4c08-db80-35d994c6c3a2@linaro.org>
 <20220908150806.oj7d5inifofvtiqk@mobilestation>
 <e81492b1-7fe3-ca79-e0cf-b562c8d67c68@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e81492b1-7fe3-ca79-e0cf-b562c8d67c68@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 08, 2022 at 05:27:30PM +0200, Krzysztof Kozlowski wrote:
> On 08/09/2022 17:08, Serge Semin wrote:
> > On Thu, Sep 08, 2022 at 11:58:50AM +0200, Krzysztof Kozlowski wrote:
> >> On 08/09/2022 11:46, Serge Semin wrote:
> >>> On Mon, Sep 05, 2022 at 12:14:21PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 26/08/2022 11:54, Serge Semin wrote:
> >>>>> On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
> >>>>>> On 22/08/2022 22:19, Serge Semin wrote:
> >>>>>>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> >>>>>>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> >>>>>>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
> >>>>>>
> >>>>>
> >>>>>> Missing space before "The".
> >>>>>
> >>>>> Ok. Thanks.
> >>>>>
> >>>>>>
> >>>>>>> clock source is absent since it's fully synchronous to the core clock.
> >>>>>>
> >>>>>
> >>>>>> You need allOf:if-then restricting this per variant.
> >>>>>
> >>>>> I really don't like the allOf-if-if-etc pattern because it gets to be
> >>>>> very bulky if all the vendor-specific and generic platform
> >>>>> peculiarities are placed in there. I am more keen of having a
> >>>>> generic DT-schema which would be then allOf-ed by the vendor-specific
> >>>>> device bindings. What do you think I'd provide such design in this
> >>>>> case too?
> >>>>
> >>>> Sure, it would work.
> >>>>
> >>>>>
> >>>>> But I'll need to move the compatible property definition to the
> >>>>> "select" property. Like this:
> >>>>>
> >>>>> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
> >>>>> +[...]
> >>>>> +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
> >>>>> +# and make sure it's assigned with the vendor-specific compatible string.
> >>>>> +select:
> >>>>> +  properties:
> >>>>> +    compatible:
> >>>>> +      oneOf:
> >>>>> +        - deprecated: true
> >>>>> +          description: Synopsys DW uMCTL2 DDR controller v3.80a
> >>>>> +          const: snps,ddrc-3.80a
> >>>>> +        - description: Synopsys DW uMCTL2 DDR controller
> >>>>> +          const: snps,dw-umctl2-ddrc
> >>>>> +        - description: Xilinx ZynqMP DDR controller v2.40a
> >>>>> +          const: xlnx,zynqmp-ddrc-2.40a
> >>>>> +  required:
> >>>>> +    - compatible
> >>>>
> >>>
> >>>> Not entirely. If you need select, then add it with compatibles, but all
> >>>> descriptions and deprecated are staying in properties.
> >>>
> >>> Ok. But note in such case the compatible string constraints will get
> >>> to be opened for any non-common string. Like this:
> >>>
> >>> + properties:
> >>> +   compatible:
> >>> +     oneOf:
> >>> +       - const: snps,ddrc-3.80a
> >>> +       - {}
> >>
> >> Not really. If you define here specific device compatibles in select,
> >> they must be here as well.
> >>
> >>>
> >>> It's required for the DT-schemas referencing the common one, otherwise
> >>> they will fail DT-nodes evaluation due to the "compatible" property
> >>> missing the vendor-specific string.
> >>
> > 
> >> o you probably mix here purposes. Either you define common schema or
> >> device specific one. If you define common, usually it does not enforce
> >> any compatibles. You do not need select, no need for compatibles either,
> >> although you can add above syntax if it is valid. If you write here
> >> specific device bindings, then compatibles should be listed. Judging
> >> from what you wrote it's neither this nor that...
> > 
> > My idea was to provide both the common DT-schema and the
> > vendor-specific ones. But the later one would refer to the common
> > schema in the framework of the "allOf:" composition. Like this:
> > 
> > snps,dw-umctl2-ddrc.yaml:
> > + [...]
> > + select:
> > +   properties:
> > +     compatible:
> > +       enum:
> > +         - snps,ddrc-3.80a
> > + [...]
> > + properties:
> > +   compatible:
> > +     oneOf:
> > +       - const: snps,ddrc-3.80a
> > +       - {}
> 

> This is not the approach snps,dwc3.yaml is doing. It is closer to
> snps,dw-pcie.yaml, but that one ends with additionalProperties:true so
> it is expected to be constrained by something else.

Right. I should have used the "additionalProperties: true" instead in
the common DT-schema below.

> 
> You can choose either way, but what you wrote before looked different -
> basically loosing the compatibles documentation.

Ok. I'll make sure the compatibles documentation won't be lost.

> 
> > +   interrupts:
> > +   [...]
> > +   interrupt-names:
> > +   [...]

> > + additionalProperties: false

* here should have been "true" of course.

> > + [...]
> > 
> > baikal,bt1-ddrc.yaml:
> > + [...]
> > + allOf:
> > +   - "schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml:#"
> > + [...]
> > + unevaluateProperties: false
> > + [...]
> > 
> > Thus the common schema as before would provide the widest set of the
> > properties and their constraints, while the vendor-specific one would
> > be !obligated! to follow the common schema conventions, but provide a
> > more specific set of the properties and constraints. A similar
> > approach is implemented for instance in the DW USB3 DT-schemas, but
> > with the generic compatible string fallback. In this case we don't
> > need the fallback string, but in order for the common schema being
> > applicable for both the common and vendor-specific DT-nodes the
> > compatible property constraints need to be designed as is provided in
> > the example above.
> 

> Anyway, it's getting complicated so I am not sure about which option now
> we discuss. You cannot have deprecated entries in select and compatibles
> described there, without describing them in properties.

Ok. That's what I intended in the later approach. I'll resend the
series with the updated bindings. We can continue the discussion after
that in the new emails thread.

-Sergey

> 
> > 
> > Alternatively we can split the snps,dw-umctl2-ddrc.yaml schema up into
> > the two ones:
> > snps,dw-umctl2-ddrc-common.yaml
> > and
> > snps,dw-umctl2-ddrc.yaml
> > So the first schema would contain all the common properties definition
> > and would be only used for being referenced in the particular device
> > DT-bindings (select: false). The snps,dw-umctl2-ddrc.yaml and
> > vendor-specific DT-schemas would just have it "allOf:"ed.
> > 
> > Personally I'd prefer the design pattern with the always-true
> > compatible property constraint as in the example above since it seems
> > easier to maintain than having the common and generic device
> > DT-schemas.
> > 
> > Note having a common DT-schema and a vendor-specific one referencing
> > the common schema is very much useful practice for the devices based
> > on the same IP-core. Vendor-device driver authors tend to create their
> > own bindings for the same clocks/resets/phys/etc thus making the
> > drivers much harder to maintain (for a bright example see what has
> > been done for the DW PCIe RP/EP IP-core). The worst part of it is that
> > ones the DT-bindings interface is implemented it can't be changed
> > since the kernel needs to be backward compatible with the DT-sources
> > compiled before. So the main goal of the common DT-schema is to fix
> > the common DT interface and make sure the new vendor-specific device
> > drivers would at least consider either to follow the IP-core DT
> > convention or to widen it up if required.
> 
> 
> Best regards,
> Krzysztof
