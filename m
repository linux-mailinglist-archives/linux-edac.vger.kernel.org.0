Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A7E616DE1
	for <lists+linux-edac@lfdr.de>; Wed,  2 Nov 2022 20:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiKBTfp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 2 Nov 2022 15:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBTfn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 2 Nov 2022 15:35:43 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A951006
        for <linux-edac@vger.kernel.org>; Wed,  2 Nov 2022 12:35:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id s20so6062367qkg.5
        for <linux-edac@vger.kernel.org>; Wed, 02 Nov 2022 12:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7fpwX3iuP/zRSVMLX/z8sQpgHHvxDjtxeWt7bMXmDs=;
        b=rvZ9KYITMLxR7E/yjyqn+LP17JgRmLJCkK0UpwnSLrnF4iK18fwdGL5jP2OGh116f+
         jDUoI0PGmLm3lMxawo6pV2vKP+lgVUvpDwgBj0PMzX14z6BJ0pUfzjzREn8vzH6SEnqu
         Y3PlteDnTg7mm21e/arclTQhJIhiviYuy+ggt72IE6n9tDDaRITW6HLndQsrmLjUSqjV
         3N8wfRZfZSRSBVciPwZAyAIzYrXpjzalfKr1LA/CjiFSBCz+h4uCEHn1uKi9FXAi9rVL
         MQVIRWgTk3FP3br71z5ApEtL6Jz67w/+VmiZgxM3UvSMllFqHHklPqigGSP1nQ8JIdDt
         WFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7fpwX3iuP/zRSVMLX/z8sQpgHHvxDjtxeWt7bMXmDs=;
        b=tUdT2fX3sTVpyHGGhJLOOgOEwoa3Q4oSzh9vGAm3VuIaUG4quS1gaMag02CbSJIJ0k
         2TUNDw131TumyAAMYbWu8MUHXGBFdqjDy3h3kmd7q1c8z/otCvJW/WS1HO2hflGJ5A94
         ZMantjfAE9mD4uGJ9cMZE2Bfht5TlmnNqU2ym1O0NqKWQz1nqEc9ORnZACNUy22VdLBo
         5TtwsZne7GqeW77aI+nl+3DYEiAUGrmBJImt57kK4uS46WXlwmu1BQR6uEIE4cB7KkN8
         vcJ81/TtKfFpGe4NEMo5DI35QGsxSBHf0FCnAGncwy3d3JN8lvEM6MtujBHsKDzcfGZs
         7QEA==
X-Gm-Message-State: ACrzQf3zFtH4aMdAieAJ2jDnXLzQKRvfps/qmT0+JkPJUBfm78mfVEJG
        LNza0iLyD/CyuOYFsWcq/fi0pA==
X-Google-Smtp-Source: AMsMyM6jg4D/5LY2L+VXLIUJ0PGwphhTbwZZWoQAPfOpQNGXQrhOt0FEu6lXoVyOrgMvG/Y27GlT6A==
X-Received: by 2002:a05:620a:258a:b0:6cf:ca19:1ec2 with SMTP id x10-20020a05620a258a00b006cfca191ec2mr19410586qko.630.1667417741441;
        Wed, 02 Nov 2022 12:35:41 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:28d9:4790:bc16:cc93? ([2601:586:5000:570:28d9:4790:bc16:cc93])
        by smtp.gmail.com with ESMTPSA id j6-20020a05620a288600b006fa00941e9dsm8867292qkp.136.2022.11.02.12.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 12:35:40 -0700 (PDT)
Message-ID: <5520fc8b-e59f-d17b-33c8-5a6e869c6408@linaro.org>
Date:   Wed, 2 Nov 2022 15:35:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings: edac: Add bindings for Xilinx Versal
 EDAC for DDRMC
Content-Language: en-US
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        linux-edac@vger.kernel.org
Cc:     git@amd.com, devicetree@vger.kernel.org, michal.simek@xilinx.com,
        rric@kernel.org, james.morse@arm.com, tony.luck@intel.com,
        mchehab@kernel.org, bp@alien8.de, robh+dt@kernel.org
References: <20221102084608.28894-1-shubhrajyoti.datta@amd.com>
 <20221102084608.28894-2-shubhrajyoti.datta@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102084608.28894-2-shubhrajyoti.datta@amd.com>
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

On 02/11/2022 04:46, Shubhrajyoti Datta wrote:
> This patch adds device tree bindings for Xilinx Versal EDAC for DDR

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> controller.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  .../xlnx,versal-ddrmc-edac.yaml               | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> new file mode 100644
> index 000000000000..6717bc0f3be9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/xlnx,versal-ddrmc-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal DDRMC (Integrated DDR Memory Controller)
> +
> +maintainers:
> +  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +  - Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +
> +description:
> +  The integrated DDR Memory Controllers (DDRMCs) support both DDR4 and LPDDR4/
> +  4X memory interfaces. Versal DDR memory controller has an optional ECC support
> +  which correct single bit ECC errors and detect double bit ECC errors.
> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-ddrmc-edac

Drop "edac". That's a Linuxism.

> +
> +  reg:
> +    items:
> +      - description: DDR Memory Controller registers
> +      - description: NOC registers corresponding to DDR Memory Controller
> +
> +  reg-names:
> +    items:
> +      - const: ddrmc_base
> +      - const: ddrmc_noc_base

Drop redundant parts from names, so these could be "base" and "noc" or
"ddrmc" and "noc". Or anything a bit more reasonable...

Best regards,
Krzysztof

