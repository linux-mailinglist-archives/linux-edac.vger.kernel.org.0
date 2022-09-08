Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D35B1979
	for <lists+linux-edac@lfdr.de>; Thu,  8 Sep 2022 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiIHJ7A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 8 Sep 2022 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiIHJ66 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 8 Sep 2022 05:58:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B16EE4DCE
        for <linux-edac@vger.kernel.org>; Thu,  8 Sep 2022 02:58:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id z25so26879447lfr.2
        for <linux-edac@vger.kernel.org>; Thu, 08 Sep 2022 02:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mGgTz1J985wOQ7/4ni4tOp0M5zo/7OMTnLwttaIHVEg=;
        b=RA9r7H6NxX7Fb79kxbBp/QSXm3U0ZozJxWhRKZ/WJcTBSAvmuhOSPCrF9zBzvD2+ML
         CjAGTEObRORY/YslobjTGOpkca7vEp8lZyfe/mQYUThCdJadkB6d0BJzoOY0Qs1ijZso
         9AoTbXStFSttLbrvgyFpl0mdB/klKjYjRRUPdJ9Gz51RfU//ZE1jQyHSt7LwijQFKgz/
         q8gmRld/z1JPnqMaNyfSKri1LHjAv7TaWBv6W/vGD+iZ81Q+3EasZBs5aVRxT45gY9A1
         AGCzLW8mWovDaqM7YodpneA4AWDiYYju7ZOwjI5MsGLq+5qIJMd5Y2jBRZwdG4rVzyVu
         IWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mGgTz1J985wOQ7/4ni4tOp0M5zo/7OMTnLwttaIHVEg=;
        b=oII+fFjeGn27jP5pvFx/xH/tzUM6ChCpN/DrFOkp3pFFzOS7gmkYOqMRKjgzms/Uh2
         yxmpfuq7mED+40hoc4052gqxwVqAjUgBVnO0/sk0FDtTwmXaoc5/WhwQ7yhk3VldNlm2
         gAwtEkpOseKZ92J/tea5Z16Gc140e8R6+TfO9uUH5HirFhx/OiqG1L3cXeb152uahqSp
         cR6gggRDDPJ1VhFL3ognFDvGjE8DDNzLcjTynKqip1wE1Yhjippa8ftRsyiFYLLYLCZq
         dG83XuBh5k/qD6GvWC+4ofirJu9H8NDAtU5wnJq55rPo4XsELBsry3AWNt1Y0FLUpicf
         WMvw==
X-Gm-Message-State: ACgBeo3Y8zcGIhtZKO41s+p3Gr5dw7bjZoJZSDczQOiBcg7xAH4Qwn77
        tOtasY6kdf/EevCGZ+t+qQ0DLw==
X-Google-Smtp-Source: AA6agR6CgZaTajebPQUOH5iqAoFXqxgOKthGiYBrugccy2VIqNTSCiEmbsu99H6J9ZujybyOrvMjCw==
X-Received: by 2002:a05:6512:131f:b0:494:5d2f:c34b with SMTP id x31-20020a056512131f00b004945d2fc34bmr2480212lfu.324.1662631133327;
        Thu, 08 Sep 2022 02:58:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d10-20020a056512368a00b0049876c1bb24sm288753lfs.225.2022.09.08.02.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:58:52 -0700 (PDT)
Message-ID: <d49dc1ca-af81-4c08-db80-35d994c6c3a2@linaro.org>
Date:   Thu, 8 Sep 2022 11:58:50 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220908094307.civtqiwxadas3ys3@mobilestation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 08/09/2022 11:46, Serge Semin wrote:
> On Mon, Sep 05, 2022 at 12:14:21PM +0200, Krzysztof Kozlowski wrote:
>> On 26/08/2022 11:54, Serge Semin wrote:
>>> On Tue, Aug 23, 2022 at 11:12:28AM +0300, Krzysztof Kozlowski wrote:
>>>> On 22/08/2022 22:19, Serge Semin wrote:
>>>>> Baikal-T1 DDR controller is based on the DW uMCTL2 DDRC IP-core v2.51a
>>>>> with up to DDR3 protocol capability and 32-bit data bus + 8-bit ECC. There
>>>>> are individual IRQs for each ECC and DFI events.The dedicated scrubber
>>>>
>>>
>>>> Missing space before "The".
>>>
>>> Ok. Thanks.
>>>
>>>>
>>>>> clock source is absent since it's fully synchronous to the core clock.
>>>>
>>>
>>>> You need allOf:if-then restricting this per variant.
>>>
>>> I really don't like the allOf-if-if-etc pattern because it gets to be
>>> very bulky if all the vendor-specific and generic platform
>>> peculiarities are placed in there. I am more keen of having a
>>> generic DT-schema which would be then allOf-ed by the vendor-specific
>>> device bindings. What do you think I'd provide such design in this
>>> case too?
>>
>> Sure, it would work.
>>
>>>
>>> But I'll need to move the compatible property definition to the
>>> "select" property. Like this:
>>>
>>> Documentation/devicetree/bindings/memory-controllers/snps,dw-umctl2-ddrc.yaml:
>>> +[...]
>>> +# Please create a separate DT-schema for your DW uMCTL2 DDR controller
>>> +# and make sure it's assigned with the vendor-specific compatible string.
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      oneOf:
>>> +        - deprecated: true
>>> +          description: Synopsys DW uMCTL2 DDR controller v3.80a
>>> +          const: snps,ddrc-3.80a
>>> +        - description: Synopsys DW uMCTL2 DDR controller
>>> +          const: snps,dw-umctl2-ddrc
>>> +        - description: Xilinx ZynqMP DDR controller v2.40a
>>> +          const: xlnx,zynqmp-ddrc-2.40a
>>> +  required:
>>> +    - compatible
>>
> 
>> Not entirely. If you need select, then add it with compatibles, but all
>> descriptions and deprecated are staying in properties.
> 
> Ok. But note in such case the compatible string constraints will get
> to be opened for any non-common string. Like this:
> 
> + properties:
> +   compatible:
> +     oneOf:
> +       - const: snps,ddrc-3.80a
> +       - {}

Not really. If you define here specific device compatibles in select,
they must be here as well.

> 
> It's required for the DT-schemas referencing the common one, otherwise
> they will fail DT-nodes evaluation due to the "compatible" property
> missing the vendor-specific string.

o you probably mix here purposes. Either you define common schema or
device specific one. If you define common, usually it does not enforce
any compatibles. You do not need select, no need for compatibles either,
although you can add above syntax if it is valid. If you write here
specific device bindings, then compatibles should be listed. Judging
from what you wrote it's neither this nor that...

Best regards,
Krzysztof
