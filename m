Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2E05EA644
	for <lists+linux-edac@lfdr.de>; Mon, 26 Sep 2022 14:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiIZMhh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Sep 2022 08:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235749AbiIZMhL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Sep 2022 08:37:11 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94610766F;
        Mon, 26 Sep 2022 04:14:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so10256890lfo.7;
        Mon, 26 Sep 2022 04:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Jl6cjv+drkaJXciTp9WRqX81dzsBqWQTjT/Pmz2Ud+k=;
        b=BzAkBsi7CtYIjezHbmpZx5ZGxpGRZyB9yGeQMV6lVe9HR2svwaxddtPLmOelpPor8G
         V9Gt2sV7WJYTNEA95h0/cpXwsH9RmVrgtO11FoXn4RiEwSfof9xyrbaYbDf/j9OsU7+d
         XP0E8SSOuSFSyXBKiUAt/FcFHBku1KEA+iWzUTagsE8o0yUBR8PQll90FWQHeuNUZQLo
         AD8qZpt4GITl1bT/HX4++H8SVgN6qRlMYCtf/bt5RtMaz8GU2oA4CCekd3Ccd7YDH+xp
         EHU9+aApQrPakiDLVjGV+8uo7Do92pUUN5PlLXainiGbWu5/EVkCuL1sMl+5MxXg38LS
         Qlvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Jl6cjv+drkaJXciTp9WRqX81dzsBqWQTjT/Pmz2Ud+k=;
        b=pthB71/JOtJttEo9dUd8Qewe9tyDuLi/f9z13ilkbbG+44cFqXtTBbdzxC2eBE9IFD
         N1vGK0nP0V9pTZCd69pJdjz4qTToJcZe8Nu81s94ffIhmhIzlb2Gv586LEUKAh7ZJgDg
         AGr4ksmW3znx4xUIjBf+wb701qonMx/S3Z5c3TieUI64nLcyZ7Am6IzdA+BVtBz8QvLz
         bsbqIuGCjbwobluuEU4d4EtF0/BKhYq65f53QPb8pl17Z0OeG8aqefdfPp+W+bUICH7H
         8GEZ73xBTyWwMLNl7Y6+iEkpzFd2+BJj/tqUeYh5MFlI4WJmGrdb02ONRLg/cpnMuC5s
         n/mg==
X-Gm-Message-State: ACrzQf06Yox+/smVqICE7bjMZKAy8ULryKDvL2oW6efGuQGTevvU54uo
        J2/ICvS9s5ahpS4Fe98QczBtnZ+r0Lssag==
X-Google-Smtp-Source: AMsMyM7FUus+1W/kisiRcKm/uEjq7jN214VSWYzTOL/eGPntWFSEYsMYvV9p54z041a08kyfsUw7Sg==
X-Received: by 2002:a05:651c:1591:b0:261:c388:aa58 with SMTP id h17-20020a05651c159100b00261c388aa58mr7587463ljq.277.1664189775575;
        Mon, 26 Sep 2022 03:56:15 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id p26-20020a056512313a00b00490b5f09973sm2505226lfd.92.2022.09.26.03.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:56:15 -0700 (PDT)
Date:   Mon, 26 Sep 2022 13:56:11 +0300
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
Message-ID: <20220926105611.32od2rjlvybmzmut@mobilestation>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
 <20220912143219.GC1170702-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912143219.GC1170702-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Sep 12, 2022 at 09:32:19AM -0500, Rob Herring wrote:
> On Sat, Sep 10, 2022 at 10:56:47PM +0300, Serge Semin wrote:
> > At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
> > common one for all the IP-core-based devices due to the compatible string
> > property constraining the list of the supported device names. In order to
> > fix that we suggest to update the compatible property constraints so one
> > would permit having any value aside with the generic device names. At the
> > same time the generic DT-schema selection must be restricted to the
> > denoted generic devices only so not to permit the generic fallback
> > compatibles. Finally since the generic schema will be referenced from the
> > vendor-specific DT-bindings with possibly non-standard properties defined
> > it must permit having additional properties specified.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Note alternatively we could drop the "additionalProperties" keyword
> > modification since currently there is no actual device available with the
> > properties not listed in the generic DT-schema.
> 

> Normally, this has required 2 schema files. However, I think you can 
> do something like this:
> 
> if:
>   compatible:
>     enum:
>       - snps,ddrc-3.80a
>       - snps,dw-umctl2-ddrc
>       - xlnx,zynqmp-ddrc-2.40a
> then:
>   unevaluatedProperties: false
> 
> 
> But please make sure that actually catches undocumented properties 
> because unevaluateProperties under 'then' is not something I've tried.

Oh, I wish this would work! Alas it doesn't. AFAIU the schemas under
the "then" and "else" keywords are considered as separate schemas
and are independently applied to the DT node. As soon as I added the
construction suggested by you the schema evaluation started failing
with error as none of the DT-node properties in the examples are valid:

< ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@fd070000:
<     Unevaluated properties are not allowed ('compatible', 'reg', interrupts', 'interrupt-names', '$nodename' were unexpected)

< ... /snps,dw-umctl2-ddrc.example.dtb: memory-controller@3d400000:
<     Unevaluated properties are not allowed ('compatible', 'reg', 'interrupts', 'interrupt-names', 'clocks', 'clock-names', '$nodename' were unexpected)

Any suggestion of how this could be fixed? Perhaps updating the
dtschema tool anyhow? (I failed to find a quick-fix for it) Creating
an additional separate schema with the common properties seems a bit
overkill in this case. On the other hand is there a decent
alternative?

What about accepting what I suggested in this patch? It does permit
additional properties, but we won't need to have a separate schema
with just several common properties.

-Sergey

> 
> Rob
