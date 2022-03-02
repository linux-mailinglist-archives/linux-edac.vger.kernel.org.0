Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856694CAC74
	for <lists+linux-edac@lfdr.de>; Wed,  2 Mar 2022 18:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiCBRvA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Mar 2022 12:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiCBRu7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Mar 2022 12:50:59 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE462C121;
        Wed,  2 Mar 2022 09:50:16 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso2240202oou.5;
        Wed, 02 Mar 2022 09:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iaHBmL19/aGsObKDNYAKvkBrYFk5c1tAvLVtd0VRmtM=;
        b=vrQWmFmrG+gdoMwEZXAtPPI0+9gucvFk2eka5lgZzf1LImUDR2TTDGVAd9v9mfqjRO
         pF6X32sPhal3PmG5+iAeAO9rP0YTkppRgwUbIaHqYKongJIX0SnpnJ6QKolZPOXVHaCL
         WdPJMjp6kC1RXaPI1jCz5qF3W6hbCOO3CdCeYkYhktbPT3btGqPq1RZvFm+tcf422EjK
         0cEt0GkheB5QK15jyBCuOHrtOXrgvp4yDR1LPH+U4mcXUY3RLEJxrYlbeDKLSwIjDof8
         6/TkRqZu7/Gvwl8eWhVo/VW66ugGv2Dmtfy8eh+F1X/8a9oPZ56ejtXwZWCIZzirjpo9
         Mc1w==
X-Gm-Message-State: AOAM531kYxDuq/wzOBxZMPfxnva2G0YzIspdHg69GCyGRO7YL6cKWkqM
        3ml/TOUXMJGlcQsLynEz7ZfojzPiNg==
X-Google-Smtp-Source: ABdhPJzUSrz4rx3I2XeOi33guW/PnNOyNKyG6Hw6f5iggsUNXdmqsv4Cp2y6zU1f0m8KB9v/1tlNhw==
X-Received: by 2002:a4a:7601:0:b0:2e0:3c62:4787 with SMTP id t1-20020a4a7601000000b002e03c624787mr15642954ooc.11.1646243415969;
        Wed, 02 Mar 2022 09:50:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1-20020a4aa781000000b0031cf8e00738sm7916823oom.1.2022.03.02.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:50:15 -0800 (PST)
Received: (nullmailer pid 3953295 invoked by uid 1000);
        Wed, 02 Mar 2022 17:50:13 -0000
Date:   Wed, 2 Mar 2022 11:50:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad CChien <ctcchien@nuvoton.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: edac: npcm-edac.yaml
Message-ID: <Yh+uVYzaXdfEaW7R@robh.at.kernel.org>
References: <20220302092434.16625-1-ctcchien@nuvoton.com>
 <20220302092434.16625-3-ctcchien@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302092434.16625-3-ctcchien@nuvoton.com>
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

On Wed, Mar 02, 2022 at 05:24:33PM +0800, Medad CChien wrote:
> Add the device tree bindings for the EDAC driver npcm-edac.
> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../devicetree/bindings/edac/npcm-edac.yaml   | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/npcm-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/npcm-edac.yaml b/Documentation/devicetree/bindings/edac/npcm-edac.yaml
> new file mode 100644
> index 000000000000..936e9787ec80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/npcm-edac.yaml

nuvoton,npcm-memory-controller.yaml

> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Memory Controller EDAC

Drop 'EDAC'

> +
> +maintainers:
> +  - Medad CChien <ctcchien@nuvoton.com>
> +
> +description: |
> +  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
> +  correction check).
> +
> +  The memory controller supports single bit error correction, double bit
> +  error detection (in-line ECC in which a section (1/8th) of the
> +  memory device used to store data is used for ECC storage).
> +
> +  Note, the bootloader must configure ECC mode for the memory controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm8xx-memory-controller
> +      - nuvoton,npcm7xx-memory-controller

Don't use wildcards in compatible strings. Use specific SoC.

> +
> +  reg:
> +    maxItems: 1
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
> +            compatible = "nuvoton,npcm7xx-memory-controller";
> +            reg = <0x0 0xf0824000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +
> -- 
> 2.17.1
> 
