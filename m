Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A344C4F3F
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 21:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiBYUGO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Feb 2022 15:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBYUGN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 15:06:13 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A91D86ED;
        Fri, 25 Feb 2022 12:05:40 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so7715552oos.10;
        Fri, 25 Feb 2022 12:05:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pt2v58DVMNtnJGowbH5EvHKVW32wfgY0vO3q80Iq09k=;
        b=IAHzAcoy38FChhpdVMJSLwCApYZ0Fn4JMRFjEN6308o1iO9PWvgk5eF0cI+/8Heu84
         EiiW3sTudV3R3PiqLvJgY2avB+68Am0Kfm4g4D7FyGLoNoz5grDtw3vDd8ZeamfBfPhw
         WXFaLMRWjcyRz6kJ+aU5S+1Bk9BQpGEl7SfP/cQQ7x05DStTfnHvwyaK8p6HEJ4bytRr
         m7cpN1XeUVXGZH9Rcvfv69ccqBohkncPK2u6UHPB/TsQXU8Vlt5OwQ9Gvov6Uu2PpsrO
         5b7xOfzMybiF9nbF1WkzFTvi/2DSD2wpYUdvRfYxaQJ1mv0EpyNFu3DZUnRMoDZYlXdf
         IkdA==
X-Gm-Message-State: AOAM531t26HilSuUWv//AwlqfsDnCEhKRpV5N2AC1k/r0ZVSnDism/6h
        gkRrlTvSQHZTeg0WZQSXBQ==
X-Google-Smtp-Source: ABdhPJxzyw7Udfv93wJdvGYw+MZTCJWRad+6vfmdFDmh3pGrt6GAHmmrW577IEiWdVkLZmqZp1fFlg==
X-Received: by 2002:a05:6870:c6a2:b0:d1:60cf:2d66 with SMTP id cv34-20020a056870c6a200b000d160cf2d66mr2137886oab.54.1645819539381;
        Fri, 25 Feb 2022 12:05:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm1906781oiv.21.2022.02.25.12.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:05:38 -0800 (PST)
Received: (nullmailer pid 1344550 invoked by uid 1000);
        Fri, 25 Feb 2022 20:05:36 -0000
Date:   Fri, 25 Feb 2022 14:05:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: edac: npcm-edac.yaml
Message-ID: <Yhk2kF1G74ndY60b@robh.at.kernel.org>
References: <20220224074729.5206-1-ctcchien@nuvoton.com>
 <20220224074729.5206-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224074729.5206-3-ctcchien@nuvoton.com>
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

On Thu, Feb 24, 2022 at 03:47:28PM +0800, Medad CChien wrote:
> Add the device tree bindings for the EDAC driver npcm-edac.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../devicetree/bindings/edac/npcm-edac.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/npcm-edac.yaml b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
> new file mode 100644
> index 000000000000..228ace1025dc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Memory Controller EDAC
> +
> +maintainers:
> +  - Medad CChien <ctcchien@nuvoton.com>
> +
> +description: |
> +  EDAC node is defined to describe on-chip error detection and correction for
> +  Nuvoton NPCM Memory Controller.

The h/w unit is the memory controller. Describe that in your binding. 
EDAC is a Linuxism.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm8xx-edac
> +      - nuvoton,npcm7xx-edac

The h/w manual calls this block 'edac'?

> +
> +  reg:
> +    maxItems: 1
> +

> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2

You don't need these 2. You don't have a child node with an address.

> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: uncorrectable error interrupt
> +      - description: correctable error interrupt
> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: ue
> +      - const: ce
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    ahb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        mc: memory-controller@f0824000 {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            reg = <0x0 0xf0824000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +            compatible = "nuvoton,npcm7xx-edac";
> +        };
> +    };
> +
> -- 
> 2.17.1
> 
> 
