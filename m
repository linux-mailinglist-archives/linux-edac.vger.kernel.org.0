Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051FE5BB25D
	for <lists+linux-edac@lfdr.de>; Fri, 16 Sep 2022 20:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIPSo6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Sep 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIPSo5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Sep 2022 14:44:57 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0619037;
        Fri, 16 Sep 2022 11:44:53 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso4950219otb.10;
        Fri, 16 Sep 2022 11:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AcISesseQOa+PI6N+Szu0u2ec8VrM0pL1w8wMuhGk+A=;
        b=fkBpxGN26ox4PV5QyHbKCkS2ZXsyUmYj9zFYabQjyUILI29ms8+4pbCE14sCRW9x/1
         bmnw+TB5DiYfgua1lGIc2L1ZN5W5CFS5t4dCBueeP0mKD8XER4EFoM6IjMTmxSpCEaLD
         wA5FJjj8j/1rb+KJFl16i7sPGHpG1GFjGXD7i1WxwoNzszrfQuwwT13uFLsxkkVjc+u7
         053QA8Lr2iGDW3A0bFvlitGrOQMMgZF8c8k0j8tRKU6U9rtmrhfp7WujgpFhAsilLSaE
         MC0ztBjgnVXVM6aV9PC5cEXC9OwvZ4SPXxzwVk4+BtLRDfSWd+XJcKrb4Go5iE1XMGFG
         4dUQ==
X-Gm-Message-State: ACrzQf36znK9GLSQS6of72ujQApAnQyayHr+bFah68KFtyNrq1I7cSAr
        17b5C6s+DQdUkXX3buNwJg==
X-Google-Smtp-Source: AMsMyM4ZAUR0TYm2dSOQ/wwRxqpVT9kMdKEEWitydHl4jnUcSMBwbd/m+VsvzleoQWixieqvsTeOrg==
X-Received: by 2002:a05:6830:2a17:b0:636:f7fc:98bb with SMTP id y23-20020a0568302a1700b00636f7fc98bbmr2900347otu.223.1663353892663;
        Fri, 16 Sep 2022 11:44:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l9-20020a056870204900b00127a6357bd5sm3353805oad.49.2022.09.16.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:44:52 -0700 (PDT)
Received: (nullmailer pid 1054596 invoked by uid 1000);
        Fri, 16 Sep 2022 18:44:51 -0000
Date:   Fri, 16 Sep 2022 13:44:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Richter <rric@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, linux-edac@vger.kernel.org,
        Manish Narani <manish.narani@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>
Subject: Re: [PATCH v2 14/19] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Message-ID: <20220916184451.GA1054535-robh@kernel.org>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
 <20220910194237.10142-15-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910194237.10142-15-Sergey.Semin@baikalelectronics.ru>
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

On Sat, 10 Sep 2022 22:42:32 +0300, Serge Semin wrote:
> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
> the CSRs layout is absolutely different and it doesn't support IRQs unlike
> DW uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there
> is no any reason to have these controllers described in the same bindings.
> Let's split the DT-schema up.
> 
> Note since the synopsys,ddrc-ecc.yaml schema describes the Synopsys DW
> uMCTL2 DDR controller only, we need to accordingly fix the device
> descriptions.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Move Synopsys DW uMCTL2 DDRC bindings file renaming to a separate
>   patch. (@Krzysztof)
> ---
>  .../memory-controllers/synopsys,ddrc-ecc.yaml | 63 ++++++-------------
>  .../xlnx,zynq-ddrc-a05.yaml                   | 38 +++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 59 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynq-ddrc-a05.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
