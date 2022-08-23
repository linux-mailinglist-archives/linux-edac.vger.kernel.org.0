Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924E859E6FA
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 18:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244484AbiHWQWz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236144AbiHWQWh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 12:22:37 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD98814F6F9
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 05:46:35 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id x10so13406783ljq.4
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 05:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=7vkbXTvEIxbamOzsPAlGZ18SKerzAATRGx48coFp9Wg=;
        b=l5rKdPLdrKNmWz0BuIx5srFeLQYtPJCncEBzmf732FKCQHG1Tc2h5SoAWxHbFwRWqw
         V6gAvZKEe6vcz0E2JCvMSKBfJWQ56xD/lib/nApBuoYRpYtQqIHYrD2HHFbewsIKhgX2
         ezOgZLmABxQd2gdesxFpeXIxq37TxapUObiaB4/R9AB0gtJ/iNoqSkof+JI84ihhiR6A
         A+Cj3Y194a+cs9HBaY1VoGvLA0ls4wvHQFz+oECN3JZ8yx/fcsS8zi2Sv/FcsP8C1XSd
         d/Hrgv16iUHPBapIlIJbjEvueUfb3BVYG1lQzNwHNNe11okQDh2ellT1XY73dHmlzr7h
         g05g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=7vkbXTvEIxbamOzsPAlGZ18SKerzAATRGx48coFp9Wg=;
        b=dBdiMJdW+8mLAXcIdzEGN6s9U/IN8nFm7+zHWwIPbyy7dFdWrJZmB7le1/KQd0Oy7B
         SO3XCac1xgo0W5oRCKhP2YvMY+72ohOUSf5h9OiviXBQECN2EuIOzNaiTaGoEDnAdlMx
         yJoWs8mnrj8vnh5Mf+i1gnELKxYZDwfd8v2LzclkSB66Lk9GKAeMW2dbC7omZDQBWA8c
         XkaD8gCXILimJR1oiY3ptxanWsdujb4MB1FoOmKUA/Vtg1s5sV325oIR4j/n0WJ1cwYL
         rhrQrh1Huvy8F+mT5Br9ntz2UBY+7XGpm/d9mv7b9GITCy/+eyA+3yC0qvDglgJPWc9f
         JYMA==
X-Gm-Message-State: ACgBeo3DYM6p1xx2lB/+XKutFZ8K/6xb+DWJ4vht4PAlIdnssyD0JwDk
        XJYrdQbFOP1olPvWHyhQfY0PXA==
X-Google-Smtp-Source: AA6agR5SszPK3XHuOtFzT/k6vG6kVjVdUaiPFlhBDCHwPoFxRVvMVwXQz0HMrHgJlmvjrajPesHbTw==
X-Received: by 2002:a2e:a552:0:b0:25e:6fa1:a6c4 with SMTP id e18-20020a2ea552000000b0025e6fa1a6c4mr6557211ljn.90.1661258793251;
        Tue, 23 Aug 2022 05:46:33 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id h16-20020a2e5310000000b0025e5cd1620fsm2355736ljb.57.2022.08.23.05.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:46:32 -0700 (PDT)
Message-ID: <52fa28d6-4d48-bd0c-40e6-4f8855c4eac8@linaro.org>
Date:   Tue, 23 Aug 2022 15:46:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <20220822115821.3907-1-sai.krishna.potthuri@amd.com>
 <20220822115821.3907-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822115821.3907-2-sai.krishna.potthuri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 22/08/2022 14:58, Sai Krishna Potthuri wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add bindings for Xilinx ZynqMP OCM controller.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> ---
>  .../bindings/edac/xlnx,zynqmp-ocmc.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
> new file mode 100644
> index 000000000000..6389fcb7ed69
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/xlnx,zynqmp-ocmc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/xlnx,zynqmp-ocmc.yaml#

Filename should be based on compatible, so xlnx,zynqmp-ocmc-1.0.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Zynqmp OCM(On-Chip Memory) Controller

So this is a memory controller, then please put the bindings in the
memory-controllers directory.

> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +
> +description: |
> +  The OCM supports 64-bit wide ECC functionality to detect multi-bit errors
> +  and recover from a single-bit memory fault.On a write, if all bytes are
> +  being written, the ECC is generated and written into the ECC RAM along with
> +  the write-data that is written into the data RAM. If one or more bytes are
> +  not written, then the read operation results in an correctable error or
> +  uncorrectable error.
> +
> +properties:
> +  compatible:
> +    const: xlnx,zynqmp-ocmc-1.0
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
> +unevaluatedProperties: false

Instead this should be:
additionalProperties: false

> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    memory-controller@ff960000 {
> +      compatible = "xlnx,zynqmp-ocmc-1.0";
> +      reg = <0xff960000 0x1000>;
> +      interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;

What does 0 stand for? I commented about it already.


> +    };


Best regards,
Krzysztof
