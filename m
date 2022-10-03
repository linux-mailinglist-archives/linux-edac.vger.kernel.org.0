Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2D5F3114
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJCNYx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJCNYw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 09:24:52 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFFC15838;
        Mon,  3 Oct 2022 06:24:50 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1329abb0ec6so280842fac.8;
        Mon, 03 Oct 2022 06:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qSO7qnJMEoAv/N/5Guuwb7phDFolVlCpixOYlUq0vdk=;
        b=vd9OPOKoT9g2UPQ5Vi0vKu7Y3sThXFbiICj74AI442TENygdGRIKUfaxi7KT00wtFG
         qkNDJMVW0K6pS9l2O9P31EuKkSMIlx05WVA+1Ip3xZhfnvwPDE+NXefYBF6y12q+P0kk
         mwNLrpDTnC4Mu0Jlfjk1YLsu8ECG04yB2R1o7nH7/X/oqfe/O3+AXt5KzNMlVs1s3LF1
         ljAwDY07OzAtdm4mRoNrecl1f6LIBzftxGptBXqXqWhzIZswJ0AaDBC+IIlLL0vWY7tG
         MryUjcfvglTkenVWeglKYm99RFNWo1YV7Y+xpBe7CwScfTkxmft6rBpzbqir8Ob+NuwQ
         BagQ==
X-Gm-Message-State: ACrzQf29fJ6YUZN9R+lkLAv6zroIUnMriY+mS3LV0J6y2fO/ueVPwUAj
        dEV/DWgXY1+etu0eyZkANgYBK2v+OA==
X-Google-Smtp-Source: AMsMyM6cbr9erebay9Hur/kc1XaIhAzhd2mZOMTqB/c09kEeP+5cF2bA2wir/2QQ2J8XqPGKx5Yx3A==
X-Received: by 2002:a05:6870:168c:b0:132:9664:f6d5 with SMTP id j12-20020a056870168c00b001329664f6d5mr496866oae.243.1664803489203;
        Mon, 03 Oct 2022 06:24:49 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v4-20020a4a9744000000b00448a3ecdc9dsm2062708ooi.22.2022.10.03.06.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 06:24:48 -0700 (PDT)
Received: (nullmailer pid 1863792 invoked by uid 1000);
        Mon, 03 Oct 2022 13:24:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        James Morse <james.morse@arm.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Tony Luck <tony.luck@intel.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>, linux-edac@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Robert Richter <rric@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
In-Reply-To: <20220929234121.13955-3-Sergey.Semin@baikalelectronics.ru>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru> <20220929234121.13955-3-Sergey.Semin@baikalelectronics.ru>
Message-Id: <166479586876.1658787.6925988592765037866.robh@kernel.org>
Subject: Re: [PATCH v3 02/13] dt-bindings: memory: Add Baikal-T1 DDRC DT-schema
Date:   Mon, 03 Oct 2022 08:24:47 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 30 Sep 2022 02:41:10 +0300, Serge Semin wrote:
> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
> are individual IRQs for each ECC and DFI events. The dedicated scrubber
> clock source is absent since it's fully synchronous to the core clock.
> In addition to that the DFI-DDR PHY CSRs can be accessed via a separate
> registers space.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
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
./Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml: Unable to find schema file matching $id: http://devicetree.org/schemas/memory-controllers/snps,dw-umctl2-common.yaml
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

