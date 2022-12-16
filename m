Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852EE64EC98
	for <lists+linux-edac@lfdr.de>; Fri, 16 Dec 2022 15:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiLPOGK (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 16 Dec 2022 09:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiLPOGF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 16 Dec 2022 09:06:05 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F190056D5D
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:06:02 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id bf43so3617857lfb.6
        for <linux-edac@vger.kernel.org>; Fri, 16 Dec 2022 06:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtA0ZnaQhbMLk3LEMHJjdC9Cb2rxaaaRDqfkUATltms=;
        b=bTZU/vwvJCwBk4fsZcI21p3jJiSyNGS1XC3uUNc/1fed0UfOy7CHVry5XtZWKcQCAF
         G8A7TgrydnFwYCIiqZBGFV9782syeaCaLeehYPmTMCnxXKa/rE4UrHvnZ75bXoeHEFhQ
         XLl87yV135SZGFyG9aGGTUin/KLYgNA2Iw/GYVJpMaO/gf5HtG4UO6D//xCO5Ujb/0o3
         7i8AfIO/clDfT10xYqxJHdCd9WeiD2GqffCQujyRSXWkzUou14uwT+VAPrkZmH9DlH98
         v/UxPn2t+6CY4kc1NNIyrZSMiFFdvOGCYpQRY9JWJZBLLZ1eHm+Et5x3dXl80jEcGetm
         7Mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtA0ZnaQhbMLk3LEMHJjdC9Cb2rxaaaRDqfkUATltms=;
        b=4OfD/GB/NO8CFYKAOmZ/00MuCWha0bdlK1WMEwXCmQue8BE5dMTLlhEFw3TtSfk9Td
         UMaUbT0EC+ujvKkxWBY7v7y8GhIBGm9d1ZGwwwu2n6KDb07m73I0NZpCn1mjwJ9PgSn6
         b21P1401J+A1QcNkUjBzHuibSw4RxUWnJ7zpo0IBVcyMCbhMRe4ULAZU1geivENmI9VU
         lWJVuj4NSZX2gl3tQmY2neMTUjEq4m52rMzXb0H+vE55SD2eI33fX88Kn57OmiP3CPwB
         YtsJ8tkemXjbBnQS0qSs2s8vWi1XJ173arv75+ytzod8b6cPAUiKoGNKOpA2NYr7x77y
         UzTg==
X-Gm-Message-State: ANoB5pkYMlSEj5KEEehKNN6ycWdHQIAMrObGYtDRvfJyTtftIMMBrVd3
        KygQd3LBe5sua5zeEZhtXoNknw==
X-Google-Smtp-Source: AA0mqf4rbB8R8MVzYSQXNJsJHXzC5O6kwcoW/TDFbuL80e27flg1hDbgAL/xzaUiq75HvYIvYpmBZg==
X-Received: by 2002:ac2:539b:0:b0:4b5:5efb:7d26 with SMTP id g27-20020ac2539b000000b004b55efb7d26mr8138734lfh.37.1671199561242;
        Fri, 16 Dec 2022 06:06:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p2-20020ac24ec2000000b004b0b131453csm227585lfr.49.2022.12.16.06.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 06:06:00 -0800 (PST)
Message-ID: <525fd984-0b67-8e11-d13c-7c4ee1853c4e@linaro.org>
Date:   Fri, 16 Dec 2022 15:05:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v16 2/3] dt-bindings: edac: nuvoton: Add document for NPCM
 memory controller
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, linux-edac@vger.kernel.org,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, avifishman70@gmail.com, tmaimon77@gmail.com,
        tali.perry1@gmail.com, ctcchien@nuvoton.com, kflin@nuvoton.com,
        Rob Herring <robh@kernel.org>
References: <20221216073141.3289309-1-milkfafa@gmail.com>
 <20221216073141.3289309-3-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221216073141.3289309-3-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 16/12/2022 08:31, Marvin Lin wrote:
> Add dt-bindings document for Nuvoton NPCM memory controller.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

So this is a 16th version but through this entire year you never Cced
the maintainers... You did not send a single version to the memory
controller maintainers.

I don't know why it is so big problem to use scripts/get_maintainers.pl.

> ---
>  .../memory-controllers/nuvoton,npcm-mc.yaml   | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml
> new file mode 100644
> index 000000000000..0e752a673453
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-mc.yaml

filename based on compatibles, so nuvoton,npcm-memory-controller.yaml

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +

No blank lines.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nuvoton,npcm-mc.yaml#



> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM Memory Controller
> +
> +maintainers:
> +  - Marvin Lin <kflin@nuvoton.com>
> +  - Stanley Chu <yschu@nuvoton.com>
> +
> +description: |
> +  The Nuvoton BMC SoC supports DDR4 memory with and without ECC (error
> +  correction check).
> +
> +  The memory controller supports single bit error correction, double bit
> +  error detection (in-line ECC in which a section (1/8th) of the memory
> +  device used to store data is used for ECC storage).
> +
> +  Note, the bootloader must configure ECC mode for the memory controller.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm750-memory-controller
> +      - nuvoton,npcm845-memory-controller
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
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
> +        #address-cells = <1>;
> +        #size-cells = <1>;

Why do you need this node in the example?

> +        mc: memory-controller@f0824000 {
> +            compatible = "nuvoton,npcm750-memory-controller";
> +            reg = <0xf0824000 0x1000>;
> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +    };

Best regards,
Krzysztof

