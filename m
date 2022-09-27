Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AEE5ECFF3
	for <lists+linux-edac@lfdr.de>; Wed, 28 Sep 2022 00:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiI0WC5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Sep 2022 18:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbiI0WC4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Sep 2022 18:02:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D4516F9F3;
        Tue, 27 Sep 2022 15:02:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 619BEB81DC8;
        Tue, 27 Sep 2022 22:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22730C43470;
        Tue, 27 Sep 2022 22:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664316173;
        bh=UuJ3kwUDiAb68knmsWu43hQq5qs0xTpLQ/TXrsq5uX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RiuAoDJGaBBKykecBWqY8FUAQ5ELAbsXNXMLfgxjvHOGetEgGXeI97iFzQfmz3g8L
         34k9DcH5N3+vepsgL1XUYzaCQXIs4t1Znbs2u09hQHy455Jn00sbMOn0L/ZErnT9Di
         Kue4uUMUxB1+WTCThlQPqRL1BgAU99tWLX5yAUbVJFqVT81SAeoWyW9BLxDBbECuh4
         Tsxr5Tz0ZPXeUtHVauH1prCkl8GK1LO0c1hNpzAT6aYtyiJ1UfgRuSzaGwq62WV9Yh
         zonGu2Sli1KkuGwIUzK367LNpEDPVUTZDn/58v9dfiDxeWNarkegsB78pkyD6ZXcJ4
         pXU/RNbhfmhWw==
Received: by mail-vs1-f46.google.com with SMTP id j7so10995994vsr.13;
        Tue, 27 Sep 2022 15:02:53 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Sfk0RJ2xwT7Wag3bQY4Wh4jCkK4LGlHyA8tggeLbCaXJOpSW6
        hQIszCbzCM8mGSUYdVjqKXSJPwUtlMQb6vEZ1Q==
X-Google-Smtp-Source: AMsMyM70bDz5TThzupQ37iID3Ydd3fACop7Al24Ytvrso3W9idaA2yl9PjhAHUlKkssMLUWYkI0nFwT4ruzJHKjyxmE=
X-Received: by 2002:a67:3c7:0:b0:39b:45c2:6875 with SMTP id
 190-20020a6703c7000000b0039b45c26875mr11835103vsd.6.1664316171954; Tue, 27
 Sep 2022 15:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
 <20220912143219.GC1170702-robh@kernel.org> <20220926105611.32od2rjlvybmzmut@mobilestation>
In-Reply-To: <20220926105611.32od2rjlvybmzmut@mobilestation>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 27 Sep 2022 17:02:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJgkY=xb8ED_oiUBPbjV7dKRd3MRJq+jNVXuJhE3L3t_Q@mail.gmail.com>
Message-ID: <CAL_JsqJgkY=xb8ED_oiUBPbjV7dKRd3MRJq+jNVXuJhE3L3t_Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] dt-bindings: memory: snps: Convert the schema to
 being generic
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 26, 2022 at 5:56 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Mon, Sep 12, 2022 at 09:32:19AM -0500, Rob Herring wrote:
> > On Sat, Sep 10, 2022 at 10:56:47PM +0300, Serge Semin wrote:
> > > At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
> > > common one for all the IP-core-based devices due to the compatible string
> > > property constraining the list of the supported device names. In order to
> > > fix that we suggest to update the compatible property constraints so one
> > > would permit having any value aside with the generic device names. At the
> > > same time the generic DT-schema selection must be restricted to the
> > > denoted generic devices only so not to permit the generic fallback
> > > compatibles. Finally since the generic schema will be referenced from the
> > > vendor-specific DT-bindings with possibly non-standard properties defined
> > > it must permit having additional properties specified.
> > >
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > >
> > > ---
> > >
> > > Note alternatively we could drop the "additionalProperties" keyword
> > > modification since currently there is no actual device available with the
> > > properties not listed in the generic DT-schema.
> >
>
> > Normally, this has required 2 schema files. However, I think you can
> > do something like this:
> >
> > if:
> >   compatible:
> >     enum:
> >       - snps,ddrc-3.80a
> >       - snps,dw-umctl2-ddrc
> >       - xlnx,zynqmp-ddrc-2.40a
> > then:
> >   unevaluatedProperties: false
> >
> >
> > But please make sure that actually catches undocumented properties
> > because unevaluateProperties under 'then' is not something I've tried.
>
> Oh, I wish this would work! Alas it doesn't. AFAIU the schemas under
> the "then" and "else" keywords are considered as separate schemas
> and are independently applied to the DT node. As soon as I added the
> construction suggested by you the schema evaluation started failing
> with error as none of the DT-node properties in the examples are valid:
>
> < ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@fd070000:
> <     Unevaluated properties are not allowed ('compatible', 'reg', interrupts', 'interrupt-names', '$nodename' were unexpected)
>
> < ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@3d400000:
> <     Unevaluated properties are not allowed ('compatible', 'reg', 'interrupts', 'interrupt-names', 'clocks', 'clock-names', '$nodename' were unexpected)

Indeed. While unevaluatedProperties takes if/then/else into account,
flipping it around doesn't.

> Any suggestion of how this could be fixed? Perhaps updating the
> dtschema tool anyhow? (I failed to find a quick-fix for it) Creating
> an additional separate schema with the common properties seems a bit
> overkill in this case. On the other hand is there a decent
> alternative?

I don't think there is any other fix.

> What about accepting what I suggested in this patch? It does permit
> additional properties, but we won't need to have a separate schema
> with just several common properties.

No. You can't have it both ways. Either it is a common schema or a
specific device schema.

Rob
