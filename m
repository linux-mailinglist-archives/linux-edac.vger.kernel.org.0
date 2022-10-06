Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F25F65F3
	for <lists+linux-edac@lfdr.de>; Thu,  6 Oct 2022 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJFM04 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 Oct 2022 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbiJFM0y (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 Oct 2022 08:26:54 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0B21E3A;
        Thu,  6 Oct 2022 05:26:50 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j23so1919799lji.8;
        Thu, 06 Oct 2022 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hjVor9JuobC2uEQuOEct7DgOuQUUCZT91TYunixeG0=;
        b=fZqsRkD+7FvrKj8UuHJzmHwn7fFeYjlYCtf0EAwEYltFvA3dp2DmhV7245knl7byBM
         65poeOLibO4oA5qbvbbCdD15MeuIBweWIH4i6GllVuUUddxyqdGgXdLEKTRDMmodGZKv
         2O6rYrjDiuJe9upeVmDZBVAdaDotvbyLK8A9bnQ9Cr91cH+eGqJ3TvaIDAHdIdVCwFr4
         ddFAIx6WfbbHDEKWac674aRfU415K1F0hRLGOczpKsaYd3COTe/1mUqzZhIuN6ONNgDs
         1ovnvbE/31w79EgM7TAxB6f4ocoUqDqo9VDmWxMB2kJcXzRoeL002CMHiM6hbYsnBlTs
         XobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hjVor9JuobC2uEQuOEct7DgOuQUUCZT91TYunixeG0=;
        b=hFS2bktxhUonJqDJolaWm3yNYOxohWvzN2qtZg6X5WqY1JVI6ILJmUOMKnDdgM0W52
         8jyc9KbkmOD5g4xhKfxNeXtYrr2HiurQUAgfAmHcaR6Eu3YmL6rUzKfW8rLVZghHs3ux
         Vdr62zNVpNiLjGvhvrF9ZYxrKmUjJPa4mpk7LB+j39i1JIPidpnACc8Qb89EbxHt4rw4
         1YxWY0gfLxUC7qPPwcSgsoq9HgsbNlCQcA4W+jFHFpQDgrralS+aw9zRxit/X+7HQn93
         VPx0qxoyAjNAg9hX5N7oOnpILCvIb1vbaTpvA3xZX2+tCjA4rhBNxWGBNP2BpQUvVK4L
         NQ4A==
X-Gm-Message-State: ACrzQf1QmrQOxzQm0F6T2PQhMP8zlaG8WAUOtRc9L8Rq6Uql0eBppoMh
        Un7YvqZ7tBi1MjZoSzxiN4u0tLshxTpdBQ==
X-Google-Smtp-Source: AMsMyM7MDvnN3uALRHyma3iYINrCmPrID9WCw3ZlCyKVmm78WggjXdV16dcy7kRYYEQ4gug3PctirA==
X-Received: by 2002:a05:651c:222c:b0:25f:e654:36e3 with SMTP id y44-20020a05651c222c00b0025fe65436e3mr1642330ljq.20.1665059209005;
        Thu, 06 Oct 2022 05:26:49 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id s16-20020a05651c201000b0026c34bed71csm1827642ljo.87.2022.10.06.05.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 05:26:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:26:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        James Morse <james.morse@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/13] dt-bindings: memory: Add Baikal-T1 DDRC
 DT-schema
Message-ID: <20221006122646.u3vi4xwgo3yswyxj@mobilestation>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
 <20220929234121.13955-3-Sergey.Semin@baikalelectronics.ru>
 <166479586876.1658787.6925988592765037866.robh@kernel.org>
 <3ee1bff2-ab11-2dcd-aede-628d2735d6de@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ee1bff2-ab11-2dcd-aede-628d2735d6de@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Oct 05, 2022 at 04:59:52PM +0200, Krzysztof Kozlowski wrote:
> On 03/10/2022 15:24, Rob Herring wrote:
> > On Fri, 30 Sep 2022 02:41:10 +0300, Serge Semin wrote:
> >> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> >> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> >> are individual IRQs for each ECC and DFI events. The dedicated scrubber
> >> clock source is absent since it's fully synchronous to the core clock.
> >> In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> >> registers space.
> >>
> >> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >>
> >> ---
> >>
> >> Changelog v2:
> >> - Keep the alphabetically ordered compatible strings list. (@Krzysztof)
> >> - Fix grammar nitpicks in the patch log. (@Krzysztof)
> >> - Drop the PHY CSR region. (@Rob)
> >> - Move the device bindings to the separate DT-schema.
> >> ---
> >>  .../memory-controllers/baikal,bt1-ddrc.yaml   | 91 +++++++++++++++++++
> >>  1 file changed, 91 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > ./Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-common.yaml
> 

> This is result of patch #1 failing to apply:
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220929234121.13955-2-Sergey.Semin@baikalelectronics.ru/

I couldn't parse the patch-applied log 

< error: sha1 information is lacking or useless (Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml).
< error: could not build fake ancestor
< hint: Use 'git am --show-current-patch=diff' to see the failed patch

What does it mean?

-Sergey

> 
> The bindings look ok, but anyway it is a merge window now.
> 
> 
> Best regards,
> Krzysztof
> 
