Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30945B223A
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiIHP3I (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 11:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbiIHP2h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 11:28:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55611F10F6
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 08:27:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id q21so14100464lfo.0
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 08:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=GLjz+jpxG6Z7GkqektuPsextgrhLY3boxm/7UAEJFuA=;
        b=QHTpkOmqk5aefGB0YRTIi1kYEfHygKIBs0Yc0X5PRfk+F3aMYgR+Pa/PYZVi3IKxNC
         wA0nD8KdZhrW+a2eZIL3W1eqa8kVZiHJARMivg5dCKezawXBx92F0hhWYufzZQ9M5+kc
         Itefl9kO7mj1vCLme/vnSERV0H75w8AM0/i4Hi9sRvQD9ta+s3Rz4qTF/c2vp2f67YeR
         s94NUHl15tkuaoJP1QHxP6q5n2AjEoUuj9PfjxAWMV+k5897FsRwPK+o9Wd1iF/47ZMw
         gpZfEGXW0n9r7V3NiuM3fHDbP8snko9defPl9omZFkasYj+Oa+cwi5lR4DISYPmIpPCF
         Tflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=GLjz+jpxG6Z7GkqektuPsextgrhLY3boxm/7UAEJFuA=;
        b=gR292VuUH3eLs9ipm5onUPeVRTs4psjce4/QVUn7E0P2vBeSUiYcgFYJg51Um3Ousj
         cT6l1Q7HxmBVyGhMCFqzS6w1cBDyMHYzjPRD4egilW2LJ3K0rjNJae3uYxGcsp5O3xAg
         Ak2KjVc6IQQKPuF2te7QPa+UMRwa2Y3O2NkfdbpBinUHJ6hLiax+f1NLGN4SiQNTHBfY
         GFWS38/crY7HoFxKjjL1UL1YcIp/Topi0VGkzAo2slWuivgU+l3ZOfAfxU6O52AAV8+i
         nO3XF1wuY6ZbxsbYu+RX7g4lAp2W1g9svuznR7CPL5qNEFrlYsCCU236vkutu8UHN9F2
         jEiQ==
X-Gm-Message-State: ACgBeo2flVHBgXuE2dMW90tLe+h2hcxeEjRH6ROf1t8HjQjIiFMXeks6
        swS80690JutTEU2jbpwXn5S7qg==
X-Google-Smtp-Source: AA6agR5LCDCevtBAKAGsypnxhGaBTyqQTZ0V+JmHdmWALJfREkwM6Z98qFbmv5jEqbCK/UwQ1uhNgA==
X-Received: by 2002:a05:6512:10c1:b0:492:a27d:ff44 with SMTP id k1-20020a05651210c100b00492a27dff44mr2706443lfg.405.1662650851914;
        Thu, 08 Sep 2022 08:27:31 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v23-20020ac258f7000000b00497a5a91763sm1178497lfo.12.2022.09.08.08.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 08:27:31 -0700 (PDT)
Message-ID: <e81492b1-7fe3-ca79-e0cf-b562c8d67c68@linaro.org>
Date:   Thu, 8 Sep 2022 17:27:30 +0200
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
 <36b2b6d9-9ab4-a4bc-6476-bd5b5d3ef77e@linaro.org>
 <20220908094307.civtqiwxadas3ys3@mobilestation>
 <d49dc1ca-af81-4c08-db80-35d994c6c3a2@linaro.org>
 <20220908150806.oj7d5inifofvtiqk@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908150806.oj7d5inifofvtiqk@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 08/09/2022 17:08, Serge Semin wrote:
> On Thu, Sep 08, 2022 at 11:58:50AM +0200, Krzysztof Kozlowski wrote:
>> On 08/09/2022 11:46, Serge Semin wrote:
>>> On Mon, Sep 05, 2022 at 12:14:21PM +0200, Krzysztof Kozlowski wrote:
>>>> On 26/08/2022 11:54, Serge Semin wrote:
>>>>> On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
>>>>>> On 22/08/2022 22:19, Serge Semin wrote:
>>>>>>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
>>>>>>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
>>>>>>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
>>>>>>
>>>>>
>>>>>> Missing space before "The".
>>>>>
>>>>> Ok. Thanks.
>>>>>
>>>>>>
>>>>>>> clock source is absent since it's fully synchronous to the core clock.
>>>>>>
>>>>>
>>>>>> You need allOf:if-then restricting this per variant.
>>>>>
>>>>> I really don't like the allOf-if-if-etc pattern because it gets to be
>>>>> very bulky if all the vendor-specific and generic platform
>>>>> peculiarities are placed in there. I am more keen of having a
>>>>> generic DT-schema which would be then allOf-ed by the vendor-specific
>>>>> device bindings. What do you think I'd provide such design in this
>>>>> case too?
>>>>
>>>> Sure, it would work.
>>>>
>>>>>
>>>>> But I'll need to move the compatible property definition to the
>>>>> "select" property. Like this:
>>>>>
>>>>> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
>>>>> +[...]
>>>>> +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
>>>>> +# and make sure it's assigned with the vendor-specific compatible string.
>>>>> +select:
>>>>> +  properties:
>>>>> +    compatible:
>>>>> +      oneOf:
>>>>> +        - deprecated: true
>>>>> +          description: Synopsys DW uMCTL2 DDR controller v3.80a
>>>>> +          const: snps,ddrc-3.80a
>>>>> +        - description: Synopsys DW uMCTL2 DDR controller
>>>>> +          const: snps,dw-umctl2-ddrc
>>>>> +        - description: Xilinx ZynqMP DDR controller v2.40a
>>>>> +          const: xlnx,zynqmp-ddrc-2.40a
>>>>> +  required:
>>>>> +    - compatible
>>>>
>>>
>>>> Not entirely. If you need select, then add it with compatibles, but all
>>>> descriptions and deprecated are staying in properties.
>>>
>>> Ok. But note in such case the compatible string constraints will get
>>> to be opened for any non-common string. Like this:
>>>
>>> + properties:
>>> +   compatible:
>>> +     oneOf:
>>> +       - const: snps,ddrc-3.80a
>>> +       - {}
>>
>> Not really. If you define here specific device compatibles in select,
>> they must be here as well.
>>
>>>
>>> It's required for the DT-schemas referencing the common one, otherwise
>>> they will fail DT-nodes evaluation due to the "compatible" property
>>> missing the vendor-specific string.
>>
> 
>> o you probably mix here purposes. Either you define common schema or
>> device specific one. If you define common, usually it does not enforce
>> any compatibles. You do not need select, no need for compatibles either,
>> although you can add above syntax if it is valid. If you write here
>> specific device bindings, then compatibles should be listed. Judging
>> from what you wrote it's neither this nor that...
> 
> My idea was to provide both the common DT-schema and the
> vendor-specific ones. But the later one would refer to the common
> schema in the framework of the "allOf:" composition. Like this:
> 
> snps,dw-umctl2-ddrc.yaml:
> + [...]
> + select:
> +   properties:
> +     compatible:
> +       enum:
> +         - snps,ddrc-3.80a
> + [...]
> + properties:
> +   compatible:
> +     oneOf:
> +       - const: snps,ddrc-3.80a
> +       - {}

This is not the approach snps,dwc3.yaml is doing. It is closer to
snps,dw-pcie.yaml, but that one ends with additionalProperties:true so
it is expected to be constrained by something else.

You can choose either way, but what you wrote before looked different -
basically loosing the compatibles documentation.

> +   interrupts:
> +   [...]
> +   interrupt-names:
> +   [...]
> + additionalProperties: false
> + [...]
> 
> baikal,bt1-ddrc.yaml:
> + [...]
> + allOf:
> +   - "schemas/memory-controllers/snps,dw-umctl2-ddrc.yaml:#"
> + [...]
> + unevaluateProperties: false
> + [...]
> 
> Thus the common schema as before would provide the widest set of the
> properties and their constraints, while the vendor-specific one would
> be !obligated! to follow the common schema conventions, but provide a
> more specific set of the properties and constraints. A similar
> approach is implemented for instance in the DW USB3 DT-schemas, but
> with the generic compatible string fallback. In this case we don't
> need the fallback string, but in order for the common schema being
> applicable for both the common and vendor-specific DT-nodes the
> compatible property constraints need to be designed as is provided in
> the example above.

Anyway, it's getting complicated so I am not sure about which option now
we discuss. You cannot have deprecated entries in select and compatibles
described there, without describing them in properties.

> 
> Alternatively we can split the snps,dw-umctl2-ddrc.yaml schema up into
> the two ones:
> snps,dw-umctl2-ddrc-common.yaml
> and
> snps,dw-umctl2-ddrc.yaml
> So the first schema would contain all the common properties definition
> and would be only used for being referenced in the particular device
> DT-bindings (select: false). The snps,dw-umctl2-ddrc.yaml and
> vendor-specific DT-schemas would just have it "allOf:"ed.
> 
> Personally I'd prefer the design pattern with the always-true
> compatible property constraint as in the example above since it seems
> easier to maintain than having the common and generic device
> DT-schemas.
> 
> Note having a common DT-schema and a vendor-specific one referencing
> the common schema is very much useful practice for the devices based
> on the same IP-core. Vendor-device driver authors tend to create their
> own bindings for the same clocks/resets/phys/etc thus making the
> drivers much harder to maintain (for a bright example see what has
> been done for the DW PCIe RP/EP IP-core). The worst part of it is that
> ones the DT-bindings interface is implemented it can't be changed
> since the kernel needs to be backward compatible with the DT-sources
> compiled before. So the main goal of the common DT-schema is to fix
> the common DT interface and make sure the new vendor-specific device
> drivers would at least consider either to follow the IP-core DT
> convention or to widen it up if required.


Best regards,
Krzysztof
