Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A085BB263
	for <lists+linux-edac@lfdr.de>; Fri, 16 Sep 2022 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiIPSqo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Sep 2022 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiIPSqn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Sep 2022 14:46:43 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F4B8A45;
        Fri, 16 Sep 2022 11:46:42 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1274ec87ad5so53444426fac.0;
        Fri, 16 Sep 2022 11:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QUdpooO9e0LGNAHrNgijCx8KjhavOiFYv353gJdgjLg=;
        b=6fKTJ4lySyYBKr56yMQhxs1PC92EbgOo4V6+AbMbNixwP8yR6RF3drgVhXQJnsjkD1
         GA+yPKyCAigZZ70cR0WxyHMO2NlM11yptSGS06yYTn4zmm+L9/OYjbbPFV+BeTN8bIbI
         qvoosgB+3d34IJUIgTCnEyxA6hpg5JUwzlm95jSVCi+2N+zJ9VputjJ6b5LnNvlonDoH
         ZixqD8fyg8vHpZlb6qAZVC6zypBMgR7oGnR7B2oKJl/VmR0Hhn85frQkhhLIq4gaaXeM
         PkYBK8nZiY2FoW9icH+tiPoj7ihteF5L+quj4PLuGLh/e5irlMuj/buVkhlN2M4r7K7N
         pMxQ==
X-Gm-Message-State: ACgBeo1SNYtqc3cRGoMgQQ+URMeC1ruPumL+P4EogYTuitBP0lQc1VOZ
        2OuxfHmuswiEJV0NWLzUpw==
X-Google-Smtp-Source: AA6agR6KmphzttLac6xuaL6iI0nS11BIfzySChDgOV0I3cczYqIwZ94ESDSla3WlqkrWI/woZzMqcw==
X-Received: by 2002:a05:6870:a710:b0:127:b0be:3d39 with SMTP id g16-20020a056870a71000b00127b0be3d39mr9253715oam.119.1663354001504;
        Fri, 16 Sep 2022 11:46:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j17-20020a056830271100b00638ac7ddb77sm10290804otu.10.2022.09.16.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 11:46:40 -0700 (PDT)
Received: (nullmailer pid 1057721 invoked by uid 1000);
        Fri, 16 Sep 2022 18:46:40 -0000
Date:   Fri, 16 Sep 2022 13:46:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Dinh Nguyen <dinguyen@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
        linux-kernel@vger.kernel.org,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-edac@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2 15/19] dt-bindings: memory: snps: Use more descriptive
 device name
Message-ID: <20220916184640.GA1057644-robh@kernel.org>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
 <20220910194237.10142-16-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220910194237.10142-16-Sergey.Semin@baikalelectronics.ru>
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

On Sat, 10 Sep 2022 22:42:33 +0300, Serge Semin wrote:
> The DT-schema name and the corresponding generic compatible string look
> inappropriate in the current DW uMCTL2 DDRC DT-bindings:
> 1. DT-schema name contains undefined vendor-prefix. It's supposed to be
> "snps", not "synopsys".
> 2. DT-schema name has "ecc" suffix. That is a device property, and has
> nothing to do with the controller actual name.
> 3. The controller name is different. It's DW uMCTL2 DDRC. Just DDRC
> doesn't identify the IP-core in subject.
> 4. There is no much point in using the IP-core version in the device name
> since it can be retrieved from the corresponding device CSR. Moreover the
> DW uMCTL2 DDRC driver doesn't differentiate the IP-core version at the
> current state.
> 
> In order to fix all the inconsistencies described above we suggest to
> rename the DT-schema to "snps,dw-umctl2-ddrc.yaml", deprecate the
> compatible string "snps,ddrc-3.80a" and define a new generic device
> name as "snps,dw-umctl2-ddrc".
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created on v2 by detaching the DT-schema renaming
>   from the previous patch in the series. (@Krzysztof)
> - Fix the compatible string name so one would match the new DT-schema
>   name.
> ---
>  .../{synopsys,ddrc-ecc.yaml => snps,dw-umctl2-ddrc.yaml}   | 7 +++++--
>  MAINTAINERS                                                | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>  rename Documentation/devicetree/bindings/memory-controllers/{synopsys,ddrc-ecc.yaml => snps,dw-umctl2-ddrc.yaml} (83%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
