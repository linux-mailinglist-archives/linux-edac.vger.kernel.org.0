Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674675B5C14
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 16:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiILOSY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiILOSJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 10:18:09 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F732AB0;
        Mon, 12 Sep 2022 07:18:07 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127d10b4f19so23704932fac.9;
        Mon, 12 Sep 2022 07:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6YGdXNBF/c0oqfE1hMQ7tgrfVLZvvzby7VDXrmZA37w=;
        b=f2iMWglbbFvOYUQMTDB+BQoJSHHJ3p94MM59cGQAIQDl32iC2v+TWxpXOyw3nIIN9K
         eHKMaEhjQrpaZj22YcQ1vUpCH2s95EMXyN1umNKkPCp2ggY18Byoi7lfCxy7NdNg5Cnt
         IOEEDwx8eRRZWUGfdllZJkJKDIkaTrj2hlW2elK9H/s3GNbk1ErL/APKJeAFuSHWoItP
         GatEzJHGVXME0++WSN4Kbb0e+8UjU9rk0tOc4I1E9xBJcEqKRGPry6Zmn4udEOxvk4E8
         6AAPeimAMBi+CKivYoqIR+ZZi4lx10gZWGOnQN9dwowM95SCSZWjzOs3nl/vp+Mt1diR
         PpIQ==
X-Gm-Message-State: ACgBeo25ZJG5ep7cfQuF9Y/6RfO1Y0igCUQ6myr+UCcUbUyO3DFhLmTo
        IzG6wwXd0QoKGiI+eb/HDQ==
X-Google-Smtp-Source: AA6agR4CwSU4uVGK/o+2p9jJRUTXIWhKhhZiIaxeBS8wUBRGOtazNn0fvax4V9LaW4NlZ/FlekrRTg==
X-Received: by 2002:a05:6870:c14a:b0:11d:588:da3a with SMTP id g10-20020a056870c14a00b0011d0588da3amr11611484oad.214.1662992286997;
        Mon, 12 Sep 2022 07:18:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c186-20020acab3c3000000b0034484c532c7sm3963232oif.32.2022.09.12.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:18:06 -0700 (PDT)
Received: (nullmailer pid 1178996 invoked by uid 1000);
        Mon, 12 Sep 2022 14:18:05 -0000
Date:   Mon, 12 Sep 2022 09:18:05 -0500
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
Subject: Re: [PATCH v2 01/15] dt-bindings: memory: snps: Replace opencoded
 numbers with macros
Message-ID: <20220912141805.GA1170702-robh@kernel.org>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910195659.11843-2-Sergey.Semin@baikalelectronics.ru>
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

On Sat, Sep 10, 2022 at 10:56:45PM +0300, Serge Semin wrote:
> Xilinx ZynqMP DDRC-based example contains the opencoded numerical literals
> in the IRQ lines definition. It doesn't seem justified since the
> corresponding platform has well defined ARM GIC interface. Let's replace
> the numbers with the corresponding macros then.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created on v2 based on the @Krzysztof' request not
>   to have the opencoded numbers in the bindings example. (@Krzysztof)
> ---
>  .../bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
