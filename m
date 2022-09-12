Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008AA5B5C3C
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 16:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiILOcX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 10:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiILOcW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 10:32:22 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0D5248;
        Mon, 12 Sep 2022 07:32:22 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso5975916otb.6;
        Mon, 12 Sep 2022 07:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=t2YwspAUEJbS9bWldAsROuxOz8niEIm2reQgAgYzGCU=;
        b=fd2pMwc7MJX94th7ufOazHgcl5xTciKvZgQdL6r4BkaZ0/8Ve2VCwirPkQbOHCtKMZ
         +Uu2D8Bmp+jisXpxT0StnITkOJazsNZv47LVaLte1bs9bk+95yn0fY8WrGiOdJYVho/r
         rmjo2Gx46u5M+BFY2y/UrUk6nyR0udUL0p8lYfSMUI/9VdBppmPCcZddVcFn0posqHZX
         fnhzd+A3Hg6qgCc3dpxsuD0rE+NYrJSu72BBmUvx6oTKwAc1WrMfF2pHwNQsB+5V7zbt
         2l2/tIH20CKj70ix6RG14QsQzlh7UNW3F8ioi/qUWxTR+69c99+4imReRT+3SXoPk9mr
         EZcg==
X-Gm-Message-State: ACgBeo1pKTOcLN1qOs0KAdw02CULTT3CxjDjxUYrWD1j9JpEfzxiGz/a
        srY3NuYKS3D1qPrnx7SZXw==
X-Google-Smtp-Source: AA6agR5Tj+MTUbTBejFb9zYKTm4S39/GS0kXs6RYH4dvSuF3fD+tbpg+JtOz6Zz6P872LY5aRUZ7VQ==
X-Received: by 2002:a05:6830:1496:b0:639:648a:55f4 with SMTP id s22-20020a056830149600b00639648a55f4mr10557961otq.370.1662993141339;
        Mon, 12 Sep 2022 07:32:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t6-20020a4a8246000000b0044b491ccf97sm4142572oog.25.2022.09.12.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:32:20 -0700 (PDT)
Received: (nullmailer pid 1227261 invoked by uid 1000);
        Mon, 12 Sep 2022 14:32:19 -0000
Date:   Mon, 12 Sep 2022 09:32:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <20220912143219.GC1170702-robh@kernel.org>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910195659.11843-4-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Sep 10, 2022 at 10:56:47PM +0300, Serge Semin wrote:
> At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
> common one for all the IP-core-based devices due to the compatible string
> property constraining the list of the supported device names. In order to
> fix that we suggest to update the compatible property constraints so one
> would permit having any value aside with the generic device names. At the
> same time the generic DT-schema selection must be restricted to the
> denoted generic devices only so not to permit the generic fallback
> compatibles. Finally since the generic schema will be referenced from the
> vendor-specific DT-bindings with possibly non-standard properties defined
> it must permit having additional properties specified.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Note alternatively we could drop the "additionalProperties" keyword
> modification since currently there is no actual device available with the
> properties not listed in the generic DT-schema.

Normally, this has required 2 schema files. However, I think you can 
do something like this:

if:
  compatible:
    enum:
      - snps,ddrc-3.80a
      - snps,dw-umctl2-ddrc
      - xlnx,zynqmp-ddrc-2.40a
then:
  unevaluatedProperties: false


But please make sure that actually catches undocumented properties 
because unevaluateProperties under 'then' is not something I've tried.

Rob
