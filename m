Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3760B5A66C8
	for <lists+linux-edac@lfdr.de>; Tue, 30 Aug 2022 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiH3PCC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 30 Aug 2022 11:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiH3PCB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 30 Aug 2022 11:02:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25383107C61
        for <linux-edac@vger.kernel.org>; Tue, 30 Aug 2022 08:02:00 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z29so7348068lfb.13
        for <linux-edac@vger.kernel.org>; Tue, 30 Aug 2022 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=vAQhC6sRUDhKjqRWeiE247SQ82Lv+OkFR1WrPTQjkcs=;
        b=EGk0e3Rdu3KRJsoAEPep+jUDfvENxlUTd5ht2qcN8qj/atK2WcVCgRYM80nUX/mO43
         7PaL2sMYBDsMR58YgFFh4YzbAVGiagMqFEAkpiAlPCgOrD/PI8DNO6ZK9YUjJ5O0IQ0f
         S/IZdkbAWbrk0yE+aRgAdtPV/OnRtuAI/SY2aC637yodEteGUH6jsJGiAQJdvyoJMggE
         2x0P1m1rbA512TellLunCUZpgHKFzYCuGnMD3sfPQ7oIR/dPBhoh+w1jB1RH7JHbLVJW
         PfHNZgvvcbqDrm6FIRtRFpFLSUF7uYVugnodj2FWPNPBp4J/8m1MygoAGS2HXUEroqh0
         N0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=vAQhC6sRUDhKjqRWeiE247SQ82Lv+OkFR1WrPTQjkcs=;
        b=TRnNYJ8fy54QO0eE1zplZKbkcCfOaphbWBfK6RYTbZ/w7OgPHQxh/ty8+DQeVc8aYd
         Kdq2kghyscXOl3VtdpIWswLa9XC11zCfmvh90uF8Ltar4HZeuYBBu2UdSNSVuoeh2ED7
         DjYn9FLKA3aZJ+E5VDHHO+OWfd9xrPLZCfKg2gCRku5bsK+chgap5dsvU6JkyqAZqKtO
         6KzQPk3c9cd4REhPJGfpHYCqaL2HqCz0VjMV4BRNRq9ftg8bqLpDMjSfjjNb6Ji5FIPD
         KmVLJCXoivfwpG9MVn+UvJ7+ALx+GiO7ytLemp53SovXbomTgJ+RXtTXHfsNMwQytCQi
         ORWg==
X-Gm-Message-State: ACgBeo2rZgFeiUKN0Ws+XUBYZp5nswByj0O4VDMGxKyRs+uW7BaW6MiX
        mw5RzJIi6LqrhABokN6SP4BwCz11w7t9gSet
X-Google-Smtp-Source: AA6agR5i7pCzZPQ6g/Em71Ie9JOOQ0sghbZ9CABKEEvmPbaw4YT76PJ933F50vI+A3NC6iw3k/vWog==
X-Received: by 2002:a19:dc4a:0:b0:493:e21:b77d with SMTP id f10-20020a19dc4a000000b004930e21b77dmr7542663lfj.580.1661871718516;
        Tue, 30 Aug 2022 08:01:58 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id f6-20020a056512360600b0049288e0bd61sm1647696lfs.58.2022.08.30.08.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:01:57 -0700 (PDT)
Message-ID: <3bb4b2c9-de07-f981-14bd-02c58c9fad35@linaro.org>
Date:   Tue, 30 Aug 2022 18:01:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/13] dt-bindings: memory: snps: Extend schema with
 IRQs/resets/clocks props
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
 <20220822191957.28546-2-Sergey.Semin@baikalelectronics.ru>
 <6a803554-bc1a-9f53-b7e2-7571fffea7e0@linaro.org>
 <20220826084726.7ra7342pa33bci5h@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220826084726.7ra7342pa33bci5h@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 26/08/2022 11:47, Serge Semin wrote:

>>
>>> +
>>> +  interrupt-names:
>>> +    minItems: 1
>>> +    maxItems: 5
>>> +    oneOf:
>>> +      - description: Common ECC CE/UE/Scrubber/DFI Errors IRQ
>>> +        items:
>>> +          - const: ecc
>>> +      - description: Individual ECC CE/UE/Scrubber/DFI Errors IRQs
>>> +        items:
>>> +          enum: [ ecc_ce, ecc_ue, ecc_ap, ecc_sbr, dfi_e ]
>>>  
>>>    reg:
>>>      maxItems: 1
>>>  
>>> +  clocks:
>>> +    description:
>>> +      A standard set of the clock sources contains CSRs bus clock, AXI-ports
>>> +      reference clock, DDRC core clock, Scrubber standalone clock
>>> +      (synchronous to the DDRC clock).
>>> +    minItems: 1
>>> +    maxItems: 4
>>
> 
>> I expect list to be strictly defined, not flexible.
> 
> Some of the clock sources might be absent or tied up to another one
> (for instance pclk, aclk and sbr can be clocked from a single core
> clock source). It depends on the IP-core synthesize parameters.

Yet still your device has clock lines - clock inputs, right? Therefore
still 4 clocks will be going there or you want to say that the pin is
not connected (or pulled down)?

> 
>>
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    maxItems: 4
>>> +    items:
>>> +      enum: [ pclk, aclk, core, sbr ]
>>> +
>>> +  resets:
>>> +    description:
>>> +      Each clock domain can have separate reset signal.
>>> +    minItems: 1
>>> +    maxItems: 4
>>> +
>>> +  reset-names:
>>> +    minItems: 1
>>> +    maxItems: 4
>>> +    items:
>>> +      enum: [ prst, arst, core, sbr ]
>>
> 
>> The same.
> 
> The same as for the clock.
> 
>>
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -48,4 +92,15 @@ examples:
>>>        interrupt-parent = <&gic>;
>>>        interrupts = <0 112 4>;
>>>      };
>>> +  - |
>>> +    memory-controller@fd070000 {
>>> +      compatible = "snps,ddrc-3.80a";
>>> +      reg = <0x3d400000 0x400000>;
>>> +
>>> +      interrupts = <0 147 4>, <0 148 4>, <0 149 4>, <0 150 4>;
>>
> 
>> Use proper defines.
> 
> What do you mean? Which defines do you think would be proper? If you
> meant the IRQ DT-bindings macros, then what difference does it make
> for a generic device in the DT-binding example? 

The macros/defines representing these numbers.


> Note since the device
> is defined as generic it can be placed on different platforms with
> different interrupt controller requirements. So what do you mean by
> "proper" in this case?

Proper means text instead of hard-coded number. This piece of code has
meaning in a specific context, because you used interrupts matching some
specific interrupt controllers. In that controller context, the "4" has
a meaning. Just like "0". You cannot say that this piece of code is
interrupt-controller-independent, because it is not. 4 has meaning.

If you want it to be independent, drop all the flags... If you use flags
from a specific implementation, then use proper defines matching them,
not hard-coded numbers.

Best regards,
Krzysztof
