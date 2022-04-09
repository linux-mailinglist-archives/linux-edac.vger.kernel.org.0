Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEC04FA557
	for <lists+linux-edac@lfdr.de>; Sat,  9 Apr 2022 08:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiDIGOL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Apr 2022 02:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiDIGOK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Apr 2022 02:14:10 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9106DD0A97;
        Fri,  8 Apr 2022 23:12:03 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5ae90c.dynamic.kabel-deutschland.de [95.90.233.12])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CDD4761E6478B;
        Sat,  9 Apr 2022 08:12:01 +0200 (CEST)
Message-ID: <9cf20395-369a-2738-608d-dd5f1aabe48b@molgen.mpg.de>
Date:   Sat, 9 Apr 2022 08:12:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v6 2/3] dt-bindings: edac: nuvoton: add NPCM memory
 controller
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>
Cc:     rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        benjaminfair@google.com, yuenn@google.com, venture@google.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, JJLIU0@nuvoton.com,
        KFTING@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
References: <20220322030152.19018-1-ctcchien@nuvoton.com>
 <20220322030152.19018-3-ctcchien@nuvoton.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220322030152.19018-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear Medad,


Thank you for your patch.

Am 22.03.22 um 04:01 schrieb Medad CChien:
> Added device tree binding documentation for Nuvoton BMC
> NPCM memory controller.

Please use present tense, and spell *devicetree* without a space. The 
line below even fits in 75 characters:

Document devicetree bindings for the Nuvoton BMC NPCM memory controller.

> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>   .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>   1 file changed, 62 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> new file mode 100644
> index 000000000000..97469294f4ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/nuvoton,npcm-memory-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Memory Controller
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

*memory* fits on the line above?

> +
> +  Note, the bootloader must configure ECC mode for the memory controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm845-memory-controller
> +      - nuvoton,npcm750-memory-controller

Sort the entries?


Kind regards,

Paul


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
> +            compatible = "nuvoton,npcm750-memory-controller";
> +            reg = <0x0 0xf0824000 0x0 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };
> +
