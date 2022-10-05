Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04CD5F5518
	for <lists+linux-edac@lfdr.de>; Wed,  5 Oct 2022 15:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJENMl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Oct 2022 09:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiJENMe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 5 Oct 2022 09:12:34 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6518A27FC8;
        Wed,  5 Oct 2022 06:12:28 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-132555b7121so10829605fac.2;
        Wed, 05 Oct 2022 06:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuEycmirLJ2sTje2Gsy6g5oIu/kkaAJAXNLWopiiXEs=;
        b=gpOl+PAgmB1SaX5d6CDIfO3Cv5qXetk/W2RzYCkVR6q3yajSWBkE7L4rkZyZ8KRhVT
         rbds8SKqTjH5lCGMoGC+5ctAvi9LwxOvokl8puXMA8hDj0EhxOjQthamO6P23YSuwRNd
         NBg3n562kuVRHTxqVBsHbyH/MLiHxpWBDlpEYsXIDj/Bk0VnmjiOwkY5wPJ9qIM2e35c
         ZtQciGS9nT70wEIQXYkOWTRMHYLixlKA5umQeK+kKpR9thavW9kjma5pKHfhpt2fKrPj
         +nr5+L7TpqTL+hcwFVDWqjwMYrIiwvosOeNL3xWAPfxslNoCCEUfkNshxfJGpW2hiasu
         ob4g==
X-Gm-Message-State: ACrzQf3mQQS1uccJDQLwRLmxCXT7823rmdmk+0ddIqafecXGSs/vzMEZ
        pOHkc/c0qOqu6fwJQYopZcsP6BYUVw==
X-Google-Smtp-Source: AMsMyM78NyVVomuk5mdVe/SS0eJKmWpnVXbK6YOT1P0qYTelXQkYONNKw/Oee5yE9hRyr7P7KzBKhw==
X-Received: by 2002:a05:6870:a78f:b0:127:ef52:2c7f with SMTP id x15-20020a056870a78f00b00127ef522c7fmr2439112oao.237.1664975547652;
        Wed, 05 Oct 2022 06:12:27 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:5fee:ea3a:4239:ad4:650a:6e66])
        by smtp.gmail.com with ESMTPSA id d62-20020a9d2944000000b0065818e6fbdasm4128665otb.24.2022.10.05.06.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:12:24 -0700 (PDT)
Received: (nullmailer pid 3254085 invoked by uid 1000);
        Wed, 05 Oct 2022 13:12:22 -0000
Date:   Wed, 5 Oct 2022 08:12:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-edac@vger.kernel.org,
        Manish Narani <manish.narani@xilinx.com>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 01/13] dt-bindings: memory: snps: Convert the schema
 to being generic
Message-ID: <166497554222.3254032.7587684643213841426.robh@kernel.org>
References: <20220929234121.13955-1-Sergey.Semin@baikalelectronics.ru>
 <20220929234121.13955-2-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929234121.13955-2-Sergey.Semin@baikalelectronics.ru>
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

On Fri, 30 Sep 2022 02:41:09 +0300, Serge Semin wrote:
> At the current state the DW uMCTL2 DDRC DT-schema can't be used as the
> common one for all the IP-core-based devices due to the compatible string
> property constraining the list of the supported device names. In order to
> fix that let's detach the common properties definition to the separate
> schema. The later will be used by the vendor-specific controller
> implementations to preserve the DT-bindings convention defined for the DW
> uMCTL2 DDR controller. Thus the generic DW uMCTL2 DDRC DT-bindings will be
> left with the compatible property definition only and will just refer to
> the detached common DT-schema.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - This is a new patch created on v2 cycle of the patchset. (@Krzysztof)
> 
> Changelog v3:
> - Create common DT-schema instead of using the generic device DT-bindings.
>   (@Rob)
> ---
>  .../snps,dw-umctl2-common.yaml                | 75 +++++++++++++++++++
>  .../snps,dw-umctl2-ddrc.yaml                  | 57 ++------------
>  2 files changed, 81 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-common.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
