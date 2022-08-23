Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2635459D371
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 10:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiHWISf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243073AbiHWIQd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 04:16:33 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6E5E7F
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:11:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bn9so5233431ljb.6
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 01:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HFRkd6+GWv944FyJVUBe4iftku17LMXFRqWaLXS9n3M=;
        b=VpgaNmVgn5wH2Q3FQgcpkx4MnWNXe49SeT0FaMxhOY6HoTzKBanqTCO5Nw6LhAJN1v
         goPIrfr9lkaxbTliET0kVj90wVaBW/8I9h69rKgjYt4qsiH0pYrkM3UVUUmR0YM4F24P
         LtuLDE1QFEnbzD7XKrE27xq30DHCaolSr8MNW/uzY7l3CZgnXza1OcI2WtitBIirM3O9
         9IQh3wklF+kXvv3o1tqEt8XXnvZyqiuP7fqkRbdXtDk0hq4vHi37xNSR1UAT1S8Ac4gG
         s/5CFrQ5yh6D50x+r2jhlPwM64UzIVVyKFZ0kFUvzTtOJtdbORJ+2vscorSmZ6CDDsFb
         feaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HFRkd6+GWv944FyJVUBe4iftku17LMXFRqWaLXS9n3M=;
        b=OvYXLwhw8ycq1Bm+SfCY4TsEz+hYYGVU+HyT1uspvNMxfT/7eXhKo7DfN+aMy+xiRp
         lHZ9ZRKF6cxYgS/XuVtk17JcF1ze6DwpNd4U7xIZHPoI8+I/ky5VTeRcEvbQA/Oi3xEf
         xVRH0mNXIUysLgmafADKOA0e9Kfzw+pI3ZRtHP4NQrSn8G4PXS8ZWRZoj6TFS4IpjtmN
         Y0+yelqYxIgZIx+aUDUCPclAdJhYzb7Deyww5K662tv2tYFVxvX7pa/7A7B7UY0c2NPg
         fzwRk6AdPLzWQDU+1SOXdTDLo3iZTpBa7TL4MZt/XoxuzhfdesnJpMmBYMtDvZW0I0ct
         TlAw==
X-Gm-Message-State: ACgBeo0AGguXO6JJ6+p2lGaYys5UA04lD7jwRpZd+ipdNak4uY8b/rc+
        EaEY+9s7I29A7RvVnqw1g5VgoQ==
X-Google-Smtp-Source: AA6agR5C5yM6uJJzx86YW/mN+Cz8M71DBVNM97M0b2F9KrryMrLvw8XY4Pg6c2wwrKMPu9a+hv1Hsw==
X-Received: by 2002:a05:651c:2387:b0:261:de7f:f662 with SMTP id bk7-20020a05651c238700b00261de7ff662mr79352ljb.110.1661242270317;
        Tue, 23 Aug 2022 01:11:10 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id a16-20020a056512391000b0048aa9d67483sm2379557lfu.160.2022.08.23.01.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:11:09 -0700 (PDT)
Message-ID: <6a803554-bc1a-9f53-b7e2-7571fffea7e0@linaro.org>
Date:   Tue, 23 Aug 2022 11:11:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 01/13] dt-bindings: memory: snps: Extend schema with
 IRQs/resets/clocks props
Content-Language: en-US
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
 <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
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

On 22/08/2022 22:19, Serge Semin wrote:
> First of all the DW uMCTL2 DDRC IP-core supports the individual IRQ lines
> for each standard event: ECC Corrected Error, ECC Uncorrected Error, ECC
> Address Protection, Scrubber-Done signal, DFI Parity/CRC Error. It's
> possible that the platform engineers merge them up in the IRQ controller
> level. So let's add both configuration support to the DT-schema.
> 
> Secondly each IP-core interface is supplied with a clock source like APB
> reference clock, AXI-ports clock, main DDRC core reference clock and
> Scrubber low-power clock. In addition to that each clock domain can have a
> dedicated reset signal. Let's add the properties for at least the denoted
> clock sources and the corresponding reset controls.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  .../snps,dw-umctl2-ddrc.yaml                  | 65 +++++++++++++++++--
>  1 file changed, 60 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> index 787d91d64eee..8db92210cfe1 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml
> @@ -13,13 +13,13 @@ maintainers:
>  
>  description: |
>    Synopsys DesignWare Enhanced uMCTL2 DDR Memory Controller is cappable of

Typo in original text: capable

> -  working with DDR devices up to (LP)DDR4 protocol. It can be equipped
> +  working with DDR devices upporting to (LP)DDR4 protocol. It can be equipped

Typo - supporting?

>    with SEC/DEC ECC feature if DRAM data bus width is either 16-bits or
>    32-bits or 64-bits wide.
>  
> -  The ZynqMP DDR controller is based on the DW uMCTL2 v2.40a controller.
> -  It has an optional SEC/DEC ECC support in 64-bit and 32-bit bus width
> -  configurations.
> +  For instance the ZynqMP DDR controller is based on the DW uMCTL2 v2.40a
> +  controller. It has an optional SEC/DEC ECC support in 64-bit and 32-bit
> +  bus width configurations.

These changes do not look related to your patch, so split them.

>  
>  properties:
>    compatible:
> @@ -28,11 +28,55 @@ properties:
>        - xlnx,zynqmp-ddrc-2.40a
>  
>    interrupts:
> -    maxItems: 1
> +    description:
> +      DW uMCTL2 DDRC IP-core provides individual IRQ signal for each event":"
> +      ECC Corrected Error, ECC Uncorrected Error, ECC Address Protection,
> +      Scrubber-Done signal, DFI Parity/CRC Error. Some platforms may have the
> +      signals merged before they reach the IRQ controller or have some of them
> +      absent in case if the corresponding feature is unavailable/disabled.
> +    minItems: 1
> +    maxItems: 5

List has to be strictly ordered, so instead list and describe the
items... unless you are sure that any of these interrupt lines can be
merged into any other one?

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 5
> +    oneOf:
> +      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
> +        items:
> +          - const: ecc
> +      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
> +        items:
> +          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
>  
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    description:
> +      A standard set of the clock sources contains CSRs bus clock, AXI-ports
> +      reference clock, DDRC core clock, Scrubber standalone clock
> +      (synchronous to the DDRC clock).
> +    minItems: 1
> +    maxItems: 4

I expect list to be strictly defined, not flexible.

> +
> +  clock-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      enum: [ pclk, aclk, core, sbr ]
> +
> +  resets:
> +    description:
> +      Each clock domain can have separate reset signal.
> +    minItems: 1
> +    maxItems: 4
> +
> +  reset-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      enum: [ prst, arst, core, sbr ]

The same.

> +
>  required:
>    - compatible
>    - reg
> @@ -48,4 +92,15 @@ examples:
>        interrupt-parent = <&gic>;
>        interrupts = <0 112 4>;
>      };
> +  - |
> +    memory-controller@fd070000 {
> +      compatible = "snps,ddrc-3.80a";
> +      reg = <0x3d400000 0x400000>;
> +
> +      interrupts = <0 147 4>, <0 148 4>, <0 149 4>, <0 150 4>;

Use proper defines.

> +      interrupt-names = "ecc_ce", "ecc_ue", "ecc_sbr", "dfi_e";
> +
> +      clocks = <&rcu 0>, <&rcu 5>, <&rcu 6>, <&rcu 7>;
> +      clock-names = "pclk", "aclk", "core", "sbr";
> +    };
>  ...


Best regards,
Krzysztof
