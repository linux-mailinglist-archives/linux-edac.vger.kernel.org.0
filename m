Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77E25B30EB
	for <lists+linux-edac@lfdr.de>; Fri,  9 Sep 2022 09:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiIIHw7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Sep 2022 03:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiIIHwm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Sep 2022 03:52:42 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6AFD25;
        Fri,  9 Sep 2022 00:49:32 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k10so1333668lfm.4;
        Fri, 09 Sep 2022 00:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=YDBePgfxHMfutz0NOj3naynVayDcfl77GYakOLW8o7E=;
        b=qCMmBKRFPHbwu2S8hKnhP7EaHw+InKOw2AaFu2nCNZqtrNUnx5mG2kvXW8fv3o6EdU
         HmjscBddTZ7JG8EYKUY6IZqIY5az3xzYNcL0dRvmZOysevItk5YCziYPWTqHgKs4MNqs
         NFxxHzl1TYnl5NGPd7ARuKnvkDmDgbYKMWw0ZJqH8ktr7gM9ujmgRSm2DQKd/l4tVAqo
         E6uXn8pHbn4taAhgKls5fMKFXhPzWdFYv2HSx/jglGkL6LIXP/H+UQpp0qKtXRljRr4H
         pyAwKrkdussq5blChHn2ZmBi8rYB8p3Wu2tJbWI0FExKCfGggkiFGOkeKHmEd0+lQvBQ
         qZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=YDBePgfxHMfutz0NOj3naynVayDcfl77GYakOLW8o7E=;
        b=AhDUR1LtxQJ8S74XsPh/O7xIcc6NZFmEHoSatN90he8+26zwmi7cmhY02zFfh2w2Km
         CqRIyf6jlbDAg25TM2dtbwu0BcLr+D/fp+ezU7f0c8Wma4d+Dd//z4W/0DLIPrKTo7u9
         3sHWcVOAA0QJvOZl1XGHDbNFjZlDR/WTc3ggPf+YbTq4u7gcmxCf2DCJY8ETEoJU06Oo
         1Vr6JK3UcRrmujKQE0xEKqHVdU4S/dxXWdEJ7Lla3paNKnjn+21nQZJTwH/1utaCnLYC
         RfbXGvvRuUX5DwNray64W2a4DiXYnC0fH8iijgFWRetow3vMiQJmSuZDRlRYaMNlZIQ8
         XtTw==
X-Gm-Message-State: ACgBeo0bgZZOMQ9JWufsun/F+tnPozVNx65AWOOeefTrp8k6n28X5Ss9
        yEVpF4Zm2kn9ZKaSGimR6mE=
X-Google-Smtp-Source: AA6agR6Ub9PFeFp51SJQpsb7FbX/qFqnsfcjp88hbV7D4bfA9NC9QegtgJNFuZKZAOCZUTrd78vo9g==
X-Received: by 2002:a05:6512:903:b0:494:8355:baef with SMTP id e3-20020a056512090300b004948355baefmr3795371lft.180.1662709770406;
        Fri, 09 Sep 2022 00:49:30 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s2-20020a19ad42000000b00497ac35ae1esm174238lfd.85.2022.09.09.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 00:49:29 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:49:27 +0300
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
Message-ID: <20220909074927.mt2cjz6fgtyce4rk@mobilestation>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
 <6a803554-bc1a-9f53-b7e2-7571fffea7e0@linaro.org>
 <20220826084726.7ra7342pa33bci5h@mobilestation>
 <3bb4b2c9-de07-f981-14bd-02c58c9fad35@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb4b2c9-de07-f981-14bd-02c58c9fad35@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 30, 2022 at 06:01:56PM +0300, Krzysztof Kozlowski wrote:
> On 26/08/2022 11:47, Serge Semin wrote:
> 
> >>
> >>> +
> >>> +  interrupt-names:
> >>> +    minItems: 1
> >>> +    maxItems: 5
> >>> +    oneOf:
> >>> +      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
> >>> +        items:
> >>> +          - const: ecc
> >>> +      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
> >>> +        items:
> >>> +          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
> >>>  
> >>>    reg:
> >>>      maxItems: 1
> >>>  
> >>> +  clocks:
> >>> +    description:
> >>> +      A standard set of the clock sources contains CSRs bus clock, AXI-ports
> >>> +      reference clock, DDRC core clock, Scrubber standalone clock
> >>> +      (synchronous to the DDRC clock).
> >>> +    minItems: 1
> >>> +    maxItems: 4
> >>
> > 
> >> I expect list to be strictly defined, not flexible.
> > 

> > Some of the clock sources might be absent or tied up to another one
> > (for instance pclk, aclk and sbr can be clocked from a single core
> > clock source). It depends on the IP-core synthesize parameters.
> 
> Yet still your device has clock lines - clock inputs, right? Therefore
> still 4 clocks will be going there or you want to say that the pin is
> not connected (or pulled down)?

As we agreed my device will have dedicated DT-schema referencing this
one. The DT-bindings in the subject is the generic IP-core bindings.
So some of the lines indeed may be absent depending on the synthesize
parameters or the particular platform specifics. My device DT-schema
will contain more specific clocks/resets/irqs properties constraints.

> 
> > 
> >>
> >>> +
> >>> +  clock-names:
> >>> +    minItems: 1
> >>> +    maxItems: 4
> >>> +    items:
> >>> +      enum: [ pclk, aclk, core, sbr ]
> >>> +
> >>> +  resets:
> >>> +    description:
> >>> +      Each clock domain can have separate reset signal.
> >>> +    minItems: 1
> >>> +    maxItems: 4
> >>> +
> >>> +  reset-names:
> >>> +    minItems: 1
> >>> +    maxItems: 4
> >>> +    items:
> >>> +      enum: [ prst, arst, core, sbr ]
> >>
> > 
> >> The same.
> > 
> > The same as for the clock.
> > 
> >>
> >>> +
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>> @@ -48,4 +92,15 @@ examples:
> >>>        interrupt-parent = <&gic>;
> >>>        interrupts = <0 112 4>;
> >>>      };
> >>> +  - |
> >>> +    memory-controller@fd070000 {
> >>> +      compatible = "snps,ddrc-3.80a";
> >>> +      reg = <0x3d400000 0x400000>;
> >>> +
> >>> +      interrupts = <0 147 4>, <0 148 4>, <0 149 4>, <0 150 4>;
> >>
> > 
> >> Use proper defines.
> > 
> > What do you mean? Which defines do you think would be proper? If you
> > meant the IRQ DT-bindings macros, then what difference does it make
> > for a generic device in the DT-binding example? 
> 

> The macros/defines representing these numbers.
> 
> 
> > Note since the device
> > is defined as generic it can be placed on different platforms with
> > different interrupt controller requirements. So what do you mean by
> > "proper" in this case?
> 
> Proper means text instead of hard-coded number. This piece of code has
> meaning in a specific context, because you used interrupts matching some
> specific interrupt controllers. In that controller context, the "4" has
> a meaning. Just like "0". You cannot say that this piece of code is
> interrupt-controller-independent, because it is not. 4 has meaning.
> 
> If you want it to be independent, drop all the flags... If you use flags
> from a specific implementation, then use proper defines matching them,
> not hard-coded numbers.

I'll replace the number 4 with the IRQ-level triggered macro and drop
the flag 0 then.

-Sergey

> 
> Best regards,
> Krzysztof
