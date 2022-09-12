Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18665B5CE1
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiILPCB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 11:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILPB7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 11:01:59 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54015FF5;
        Mon, 12 Sep 2022 08:01:58 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1225219ee46so24140467fac.2;
        Mon, 12 Sep 2022 08:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=icGwLkwBgSanb78rbaWZRFroT8eXmRJqz1deDK67DlU=;
        b=3yXHz+bLMss8UYSYUMnkRNwH8dSiOktjaMpSsvYBjllT14E2tX/ivxFgMLXcM5fGqr
         aObz1Mj9Tmz+GgyV38E41YSLOl1VQZydwsVDPfgqE7g8FwTgOwG6kPfNqp8s2VsEW7s6
         KChVD4gZF+08GrqLxPrIVFrOhHZ3E26Un1maaTI+nFhx50F9e5McjMqRCm9nkU28HSNh
         LvZ5cv1sn2iqfQzfnMnOh312WZb3HvwCHBb+g6aYcA84ba6/z4+0/EdwkGIWjx5Emz6G
         XCa5CWJJppnZuvS0h0tnm7CQQT6QjHLM2ANVw/Al7LSxATnscc+bxhIN1iC4dkIEMfDK
         7JXg==
X-Gm-Message-State: ACgBeo2wun7q6So0mtLVjkxHgmCLb3W5kuakwClucST6sL586zW2ZZIc
        g1uMtuoNoAjR1QAwDUbV6Q==
X-Google-Smtp-Source: AA6agR4/6wu/CPLi4SIxeoXhNkjWjchRVuTqWxjwX+Q5/bDKC1MiNY5SAPU++3SVfhj6DHkFTZXwAA==
X-Received: by 2002:a05:6870:63a6:b0:12b:85ee:59ff with SMTP id t38-20020a05687063a600b0012b85ee59ffmr3330458oap.98.1662994916859;
        Mon, 12 Sep 2022 08:01:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p21-20020a9d76d5000000b006396521c804sm4665634otl.55.2022.09.12.08.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 08:01:56 -0700 (PDT)
Received: (nullmailer pid 1293608 invoked by uid 1000);
        Mon, 12 Sep 2022 15:01:55 -0000
Date:   Mon, 12 Sep 2022 10:01:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        James Morse <james.morse@arm.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-edac@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 04/15] dt-bindings: memory: Add Baikal-T1 DDRC
 DT-schema
Message-ID: <20220912150155.GA1293565-robh@kernel.org>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-5-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910195659.11843-5-Sergey.Semin@baikalelectronics.ru>
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

Reviewed-by: Rob Herring <robh@kernel.org>
