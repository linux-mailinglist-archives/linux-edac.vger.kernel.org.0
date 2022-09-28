Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3C85EDA3E
	for <lists+linux-edac@lfdr.de>; Wed, 28 Sep 2022 12:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiI1Kj5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Sep 2022 06:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiI1Kjy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Sep 2022 06:39:54 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC15438A8;
        Wed, 28 Sep 2022 03:39:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a3so19677179lfk.9;
        Wed, 28 Sep 2022 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=EdZBNk8VJDVppuaYhVl5jrx/YbPGgB0lTI+ahlH9Qm4=;
        b=TsL/jgEqOMG51pH+mCwGq5qkv/ihHEyMrCB8XMUy5ZiwVPMYUxR/KfMriUda/LxhvB
         bogARgoXRdxa6Vptk28tGQpOXBRiIgd8DDuRp4JJY+FlimVvAqXvv2FwdEivOvouAIxH
         LeLBPFe1GCLlcw3+bjmquS3YHu1qXfJxLDI3/zncbETLW8NQr1wutIOiD1i4JmpVknmn
         UIyHccFDAk3GLW5hbIpk6I3EGza9FioU6fSOmKt6zCjp28tYcESROk3K4pQjq9xtpo80
         j6o5K/FxlH+8Ev7Oo+Q+DLck8osl6rrScwiEF2x0ogJiEGx8OISDvpgldDzv3RKa+QEl
         Uwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=EdZBNk8VJDVppuaYhVl5jrx/YbPGgB0lTI+ahlH9Qm4=;
        b=O5GR1iS/fRwP56GgMien0VX/mByUYJz9Gmc6HnMG//TnmpDdCWWDE2yeHdWMdqrdjG
         oUNpn592TQT4+FL0b7txDqNnHCcOicwwYNje3KWiMnkHe9dTiOEX7S6xORWOQODqisUT
         xcbtnTXkqzRAlJwYY+DqG6LO+dtoon2LjDnKpMt5MhUlpCqdHqRLzZxh0hakFle2Flh0
         6V8VyuXF3N3kBUGLY0aPWKn1chazxYDT3wA88e1KEA2Ly2AtVzSjNtS3tc3GyIwEUHpQ
         0FpLJhbl+KzYnfqGIZ3taeFPqRmMBsNiyMjOirZ2Vq4OwMivEmFB/bAQUKFNLqDU5RjB
         UXkQ==
X-Gm-Message-State: ACrzQf2IKCnzEzccGkF5H8iHtwfNinWAt0NJPyu3L2pvbSHQY9XaBubM
        6iyxSwYxE/TCZqNlCprxde4=
X-Google-Smtp-Source: AMsMyM54g6R4YY+tntd2IyylJg/cB5ADdZbCgCqKowRVI1cra2KWeRr80il+HDEd56OhqpcK5GJKZg==
X-Received: by 2002:a05:6512:1325:b0:4a1:d80e:1cd5 with SMTP id x37-20020a056512132500b004a1d80e1cd5mr5458610lfu.497.1664361581974;
        Wed, 28 Sep 2022 03:39:41 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b00498fc3d4cfdsm436015lfs.189.2022.09.28.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:39:41 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:39:38 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v2 03/15] dt-bindings: memory: snps: Convert the schema
 to being generic
Message-ID: <20220928103938.nx44vprs6npk2eyp@mobilestation>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
 <20220912143219.GC1170702-robh@kernel.org>
 <20220926105611.32od2rjlvybmzmut@mobilestation>
 <CAL_JsqJgkY=xb8ED_oiUBPbjV7dKRd3MRJq+jNVXuJhE3L3t_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJgkY=xb8ED_oiUBPbjV7dKRd3MRJq+jNVXuJhE3L3t_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Sep 27, 2022 at 05:02:40PM -0500, Rob Herring wrote:
> On Mon, Sep 26, 2022 at 5:56 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > On Mon, Sep 12, 2022 at 09:32:19AM -0500, Rob Herring wrote:
> > > On Sat, Sep 10, 2022 at 10:56:47PM +0300, Serge Semin wrote:
> > > > At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
> > > > common one for all the IP-core-based devices due to the compatible string
> > > > property constraining the list of the supported device names. In order to
> > > > fix that we suggest to update the compatible property constraints so one
> > > > would permit having any value aside with the generic device names. At the
> > > > same time the generic DT-schema selection must be restricted to the
> > > > denoted generic devices only so not to permit the generic fallback
> > > > compatibles. Finally since the generic schema will be referenced from the
> > > > vendor-specific DT-bindings with possibly non-standard properties defined
> > > > it must permit having additional properties specified.
> > > >
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > >
> > > > ---
> > > >
> > > > Note alternatively we could drop the "additionalProperties" keyword
> > > > modification since currently there is no actual device available with the
> > > > properties not listed in the generic DT-schema.
> > >
> >
> > > Normally, this has required 2 schema files. However, I think you can
> > > do something like this:
> > >
> > > if:
> > >   compatible:
> > >     enum:
> > >       - snps,ddrc-3.80a
> > >       - snps,dw-umctl2-ddrc
> > >       - xlnx,zynqmp-ddrc-2.40a
> > > then:
> > >   unevaluatedProperties: false
> > >
> > >
> > > But please make sure that actually catches undocumented properties
> > > because unevaluateProperties under 'then' is not something I've tried.
> >
> > Oh, I wish this would work! Alas it doesn't. AFAIU the schemas under
> > the "then" and "else" keywords are considered as separate schemas
> > and are independently applied to the DT node. As soon as I added the
> > construction suggested by you the schema evaluation started failing
> > with error as none of the DT-node properties in the examples are valid:
> >
> > < ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@fd070000:
> > <     Unevaluated properties are not allowed ('compatible', 'reg', interrupts', 'interrupt-names', '$nodename' were unexpected)
> >
> > < ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@3d400000:
> > <     Unevaluated properties are not allowed ('compatible', 'reg', 'interrupts', 'interrupt-names', 'clocks', 'clock-names', '$nodename' were unexpected)
> 
> Indeed. While unevaluatedProperties takes if/then/else into account,
> flipping it around doesn't.
> 
> > Any suggestion of how this could be fixed? Perhaps updating the
> > dtschema tool anyhow? (I failed to find a quick-fix for it) Creating
> > an additional separate schema with the common properties seems a bit
> > overkill in this case. On the other hand is there a decent
> > alternative?
> 
> I don't think there is any other fix.
> 
> > What about accepting what I suggested in this patch? It does permit
> > additional properties, but we won't need to have a separate schema
> > with just several common properties.
> 

> No. You can't have it both ways. Either it is a common schema or a
> specific device schema.

Sigh... I see. Will fix it in the next patchset round.

-Sergey

> 
> Rob
