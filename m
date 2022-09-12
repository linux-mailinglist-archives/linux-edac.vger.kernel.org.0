Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AC5B5C1C
	for <lists+linux-edac@lfdr.de>; Mon, 12 Sep 2022 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiILOUx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Sep 2022 10:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiILOUv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Sep 2022 10:20:51 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA3224F2E;
        Mon, 12 Sep 2022 07:20:50 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1278a61bd57so23748605fac.7;
        Mon, 12 Sep 2022 07:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yaLHWCDdqtnwZ0Y8klbSULWFVxiLtCf1mt0pn0PChYk=;
        b=UevkIKMo1qHJu45rDkYUL+9nvSVVjFBMhOEwTnnlUrVJKGQ09XIZHYiNOHQk0E+gd4
         98mePrVI2KdDJKYSmRSxt7zWOYn8/QdUd/nDGeIz7DaOK8DXqVen06Xdh5K+tTqcyivJ
         DCanw9IsSzUbujH4H9TkPdyDs1NRkKhJefq+YkVThYwJzghM5vCd+XynWgdxH7wqIFc1
         uzK+DBFsHI8ohJDbJiYd5OYm+J5hy3uh2MKhDxqeoxpPNdSW+2qfrYTRgAE+YTefihl+
         F/Ths5ou0Q71pLcojsHP8BxiUdH4MKDvExNlUJ9sFny+/OWUDURpvrhC8eK+ML1MSNZQ
         oDqQ==
X-Gm-Message-State: ACgBeo3jRASvVZqQOKAQ+hjhV262w/lawhpf8rVJSQeX1Qg7qAp/KKYM
        Cbxi3JbsylCTSFeDlbkoow==
X-Google-Smtp-Source: AA6agR5AHT1bcQ+tAGaGp2dlEU06tO9vze/HJbIBemYiF+fhs+xz3H+jrsIpHfV/9LzANynhLoow/g==
X-Received: by 2002:a05:6808:2387:b0:347:c6d4:503d with SMTP id bp7-20020a056808238700b00347c6d4503dmr8886781oib.142.1662992449774;
        Mon, 12 Sep 2022 07:20:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h20-20020a9d6414000000b0061d31170573sm4681362otl.20.2022.09.12.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 07:20:49 -0700 (PDT)
Received: (nullmailer pid 1186216 invoked by uid 1000);
        Mon, 12 Sep 2022 14:20:48 -0000
Date:   Mon, 12 Sep 2022 09:20:48 -0500
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
Subject: Re: [PATCH v2 02/15] dt-bindings: memory: snps: Extend schema with
 IRQs/resets/clocks props
Message-ID: <20220912142048.GB1170702-robh@kernel.org>
References: <20220910195659.11843-1-Sergey.Semin@baikalelectronics.ru>
 <20220910195659.11843-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910195659.11843-3-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Sep 10, 2022 at 10:56:46PM +0300, Serge Semin wrote:
> First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
> for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
> Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
> possible that the platform engineers merge them up in the IRQ controller
> level. So let's add both configuration support to the DT-schema.
> 
> Secondly the DW uMCTL2 DDRC IP-core can have clock sources like APB
> reference clock, AXI-ports clock, main DDRC core reference clock and
> Scrubber low-power clock. In addition to that each clock domain can have a
> dedicated reset signal. Let's add the properties for at least the denoted
> clock sources and the corresponding reset controls.
> 
> Note the IRQs and the phandles order is deliberately not fixed since some
> of the sources may be absent depending on the IP-core synthesize
> parameters and the particular platform setups.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Replace "snps,ddrc-3.80a" compatible string with "snps,dw-umctl2-ddrc"
>   in the example.
> - Move unrelated changes in to the dedicated patches. (@Krzysztof)
> - Use the IRQ macros in the example. (@Krzysztof)
> ---
>  .../snps,dw-umctl2-ddrc.yaml                  | 61 ++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
