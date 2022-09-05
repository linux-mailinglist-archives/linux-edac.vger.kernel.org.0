Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBFF5ACFCD
	for <lists+linux-edac@lfdr.de>; Mon,  5 Sep 2022 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiIEKQV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Sep 2022 06:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237709AbiIEKQE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Sep 2022 06:16:04 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E70B9D
        for <linux-edac@vger.kernel.org>; Mon,  5 Sep 2022 03:14:25 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bx38so8694354ljb.10
        for <linux-edac@vger.kernel.org>; Mon, 05 Sep 2022 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=krr00gq+2rnnQjH2jiDEWmx4uGy3f7Je/Uzv5Nqwo9w=;
        b=mwaIK5ucn4NK+Emo4I4RNSP1OMgJjPAaZkgPI3hgHJCCTZ57pDEdIghsHLA4ob2pVz
         fFG4DNOJAG50HsaiGoG2bEZEj36GRNNjqjxs36+pJfqMbomer3i83S6HPkhFzrQnRXWj
         x9Tu425Of/dPX4NXWV/3M6zftLrzDebI2zELrjMDuLF+N/a3WV7sLsV5eedFhSwCQQLS
         kNkMc58C4a+iKeXiSnvVKjknTcVAnD5NBM9AdbqGEGAKeyOXVVa1iQ5R/Dffz5Ch8YNY
         Um2ZwaojYKOQM/oG/gEObStXDB5F8zS4m2E3JdCExsMLf5MpQt5uyahpe3mLfySt80L1
         MrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=krr00gq+2rnnQjH2jiDEWmx4uGy3f7Je/Uzv5Nqwo9w=;
        b=RKeDQ99QMAx72c2cUc1JK16L4vbWmtCZadaA8G0RgeCdfiTrlqqSNS6di+3ZUeM4j7
         C5QY9ZBDsTeD0vuBVfJVJSDPF9rWi4KbZjLRYnqPmyqStRVlFY0IUPNgT+NS261+EBKH
         TjLkIwmsxIYRt4eFwbofdYMzypmZw4/IC5AMC36ACug04le/yDytKMVjGgcMHcIXH+Jd
         SJ9jHI7q/KVctep6ahn5zKSMMD3daDqOi7VO6N8HbZKvme3wOYrKV6N+IAf4IVkxeuwz
         XiJvekgKsVy6ennfYBKLai6chZ40Sz1Z5+LuW+DMAeJkg5RmWsEGqXrdK9rr34jOMpSr
         WubQ==
X-Gm-Message-State: ACgBeo1LdotzUzm1DUZBc0ZoOTiS1ZCc1jCTPeDqLSY6dbLcoXQFiWJf
        ELDMqanzwKBdsKX/qVAiBO6ObA==
X-Google-Smtp-Source: AA6agR5Tinz3xo5jyO3I/Zhphm/crNPOKhfBViyw+9BkJpLbm7ZmZ00WF7qaieTcY+4S8GnLTFbEqg==
X-Received: by 2002:a2e:a9a0:0:b0:268:5e62:acfb with SMTP id x32-20020a2ea9a0000000b002685e62acfbmr7929456ljq.326.1662372863427;
        Mon, 05 Sep 2022 03:14:23 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y10-20020a05651c106a00b0025e42f8e771sm1353110ljm.34.2022.09.05.03.14.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 03:14:22 -0700 (PDT)
Message-ID: <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
Date:   Mon, 5 Sep 2022 12:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 02/13] dt-bindings: memory: snps: Add Baikal-T1 DDRC
 support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Manish Narani <manish.narani@xilinx.com>,
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
 <20220822191957.28546-3-Sergey.Semin@baikalelectronics.ru>
 <0bda4ff9-fc08-77f2-0e06-7469dcaec6d8@linaro.org>
 <20220826095447.qxfvty6xq4tufe75@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826095447.qxfvty6xq4tufe75@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/08/2022 11:54, Serge Semin wrote:
> On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
>> On 22/08/2022 22:19, Serge Semin wrote:
>>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
>>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
>>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
>>
> 
>> Missing space before "The".
> 
> Ok. Thanks.
> 
>>
>>> clock source is absent since it's fully synchronous to the core clock.
>>
> 
>> You need allOf:if-then restricting this per variant.
> 
> I really don't like the allOf-if-if-etc pattern because it gets to be
> very bulky if all the vendor-specific and generic platform
> peculiarities are placed in there. I am more keen of having a
> generic DT-schema which would be then allOf-ed by the vendor-specific
> device bindings. What do you think I'd provide such design in this
> case too?

Sure, it would work.

> 
> But I'll need to move the compatible property definition to the
> "select" property. Like this:
> 
> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
> +[...]
> +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
> +# and make sure it's assigned with the vendor-specific compatible string.
> +select:
> +  properties:
> +    compatible:
> +      oneOf:
> +        - deprecated: true
> +          description: Synopsys DW uMCTL2 DDR controller v3.80a
> +          const: snps,ddrc-3.80a
> +        - description: Synopsys DW uMCTL2 DDR controller
> +          const: snps,dw-umctl2-ddrc
> +        - description: Xilinx ZynqMP DDR controller v2.40a
> +          const: xlnx,zynqmp-ddrc-2.40a
> +  required:
> +    - compatible

Not entirely. If you need select, then add it with compatibles, but all
descriptions and deprecated are staying in properties.


> +
> +properties:
> +  compatible: true
> +[...]
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: true
> 
> After that the "snps,dw-umctl2-ddrc.yaml" schema can be referenced in the
> allOf composition. Like this:
> 
> Documentation/devicetree/bindings/memory-controllers/baikal,bt1-ddrc.yaml:
> +[...]
> +allOf:
> +  - $ref: /schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml#
> +[...]
> 
> At the same time the generic DT-schema will be used to evaluate the
> "snps,ddrc-3.80a", "snps,dw-umctl2-ddrc" and "xlnx,zynqmp-ddrc-2.40a"
> device nodes as before. What do you think about that?
> 
> One big positive side of this that even though the generic schema
> can't define the IRQ/resets/clocks phandlers order because various
> platforms may have different external signals setup, the
> vendor-specific schema can and should. So I'll be able to describe the
> Baikal-T1 DDRC specific properties (clocks, clock-names, interrupts,
> interrupt-names, etc) in much more details including the reference
> signals order what you asked in the previous patch review.

It's ok. You need then second schema for your device, because something
must end with additional/unevaluatedProperties false.

Best regards,
Krzysztof
