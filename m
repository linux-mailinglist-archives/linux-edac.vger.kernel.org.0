Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D505B5B5248
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 02:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiILAoV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 11 Sep 2022 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiILAoU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 11 Sep 2022 20:44:20 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E327CFA;
        Sun, 11 Sep 2022 17:44:19 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11eab59db71so19422096fac.11;
        Sun, 11 Sep 2022 17:44:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=G4LMGcvCKWdX8ZW0SlwK4qBuWUuNaONNCQZf+AVadoc=;
        b=zc7gC9Fdzt1oud5JULQj6g525jXFJC0Ucu5U/7gZ43P5F/IJw6YlQN2ij1nJg6n0eH
         T4NXCW8jTav+Vu+y9loGOcTeMZJZBZu3QsuA1R80A2WB7tKAsg9lcoOEtXT1i9qMAYbq
         E1TNBHDlepbV8V+jKWx5A1BTsdTtsn09pcED5fKamtXmvxt0+PcBuEWfxmrlnjDaa3jz
         LksDJmOAf6/5vNiT9ckFtVJQwA8UF6wSS8kk8E7VuLiH6g9FaeY7WlumuOa5KhKzYRKo
         9XqOEf3b8x1IW1GxAQR9gwaTrAqKivmRqk+kdrTa1IsaZ3O3qgX+TsHoOfCMxcc6vUhZ
         RrwQ==
X-Gm-Message-State: ACgBeo26S8tDRSNEYxyrzmJCXwt7sPvGf/zX60tI0SS+VT2DmAbvC/I2
        YnuNOd8w7/nm9uEsoqaCvOl54sycMg==
X-Google-Smtp-Source: AA6agR4Akk0wG90W277ZFdqUzY3KRxT08OJA6dA8OrxbA2sgHrzPgVTYT/x66ZFYRQ0TjvQ07r0jTQ==
X-Received: by 2002:a05:6808:15aa:b0:34f:b7e3:26f5 with SMTP id t42-20020a05680815aa00b0034fb7e326f5mr1073510oiw.22.1662943458547;
        Sun, 11 Sep 2022 17:44:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd22-20020a056870d79600b0011f390fdb0asm4693510oab.12.2022.09.11.17.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:44:18 -0700 (PDT)
Received: (nullmailer pid 3629326 invoked by uid 1000);
        Mon, 12 Sep 2022 00:44:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Manish Narani <manish.narani@xilinx.com>,
        devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Borislav Petkov <bp@alien8.de>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220910195659.11843-5-Sergey.Semin@baikalelectronics.ru>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru> <20220910195659.11843-5-Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2 04/15] dt-bindings: memory: Add Baikal-T1 DDRC DT-schema
Date:   Sun, 11 Sep 2022 19:44:15 -0500
Message-Id: <1662943455.973058.3629325.nullmailer@robh.at.kernel.org>
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

On Sat, 10 Sep 2022 22:56:48 +0300, Serge Semin wrote:
> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> are individual IRQs for each ECC and DFI events. The dedicated scrubber
> clock source is absent since it's fully synchronous to the core clock.
> In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> registers space.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Keep the alphabetically ordered compatible strings list. (@Krzysztof)
> - Fix grammar nitpicks in the patch log. (@Krzysztof)
> - Drop the PHY CSR region. (@Rob)
> - Move the device bindings to the separate DT-schema.
> ---
>  .../memory-controllers/baikal,bt1-ddrc.yaml   | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
./Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml
Error: Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.example.dts:41.30-31 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:384: Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1420: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

