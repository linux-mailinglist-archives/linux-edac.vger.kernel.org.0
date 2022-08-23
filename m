Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259DA59E669
	for <lists+linux-edac@lfdr.de>; Tue, 23 Aug 2022 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiHWP4N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Aug 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbiHWPzw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Aug 2022 11:55:52 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE62D853E
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 05:04:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w23so8156611ljj.7
        for <linux-edac@vger.kernel.org>; Tue, 23 Aug 2022 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=O8FPHaZfTg/TEA31wr+y1tUHeMkbz9XCI04s1v+29yo=;
        b=fBlgndsgf2tJleUkIm12w72Px5hYQovnrzCV2s+HPuFAzqPGxr36gAgjsNMiblTELC
         ZpOGkPpZvZnflFxPohV9x4fSAk8J98OA8JjSWYoN98urEtA8i4Iq6v27lBTlq9S109Yv
         2NCNU96eihiM3AavhBwfuhDCGpLbukenQXcEW2Tzx3wwaRMvZS7xXMrneasan24v75q3
         cqfcJDE87UxdXculuH9xmT21GhQnK5esdZuUJVnVvsr8xZ3a9vLGZJnMpyWSeuYbVpgo
         Cu5xsL5Mh0rcQq9vVyck5MFRfKpdOe8WAA20P5xVq9swh5ZIM0hoTh8dhyGDBMmR1eaE
         tung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=O8FPHaZfTg/TEA31wr+y1tUHeMkbz9XCI04s1v+29yo=;
        b=GB3bwQh+KFRFsX0qwX5JwyZRDVp/kTZgkDq9byN3clEnV4iRJG/sFh+3OTLpR+iom1
         RCXTgp/eNoF1JnsKQH40/LqPyWVso6kgEzsx4db9ioNPeDbWEDmdEK+8dFM6eGsjghFl
         r1fWQ4WiXmVi85ootsaMknLf078cpHKvqxrSrClAJEMqMyaLk6FidHmPf3mpBjNzu+Eq
         U5k5gPCKGTWhMIu/5wzpesggb9yXvXqSPDdw1GYEKkyaON1+ZBdn+KfhCecefBirs0dR
         Mbd8fw7JbUVRmAXsaMHkXiaEtmELjS9P9mcPM1MMv0+nb0SNq6JPGw0wTlWdC84ODlw3
         /QHg==
X-Gm-Message-State: ACgBeo2s8EjkS8T+lw5zBYnK0zP6A3perzpgQR+N7oX5N2jqGFtrfLia
        sFG+U0ezX/2TjIkfhrv9NTy/8fKu/Z7af/yu
X-Google-Smtp-Source: AA6agR5BTIY7aA7vEdDkBl9g9KrHvH99v2U8Zh5QOUJdyu9dEGvte5GD7JS56y4UUhacanN/2E72Og==
X-Received: by 2002:a2e:a989:0:b0:261:b21c:7b29 with SMTP id x9-20020a2ea989000000b00261b21c7b29mr6978109ljq.128.1661256233632;
        Tue, 23 Aug 2022 05:03:53 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
        by smtp.gmail.com with ESMTPSA id u6-20020ac258c6000000b00492dd9343basm1336661lfo.119.2022.08.23.05.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:03:53 -0700 (PDT)
Message-ID: <6661dcc1-cc93-efbb-b248-0d93f681a1bf@linaro.org>
Date:   Tue, 23 Aug 2022 15:03:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 16/20] dt-bindings: memory: snps: Detach Zynq DDRC
 controller support
Content-Language: en-US
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
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
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
 <20220822190730.27277-17-Sergey.Semin@baikalelectronics.ru>
 <a5a15749-1047-74ea-831e-54d27a6d6cdf@linaro.org>
 <20220823083243.aovlgu22j7uv73qv@mobilestation>
 <166c0198-17c4-3b19-77fe-632d65f17cb0@linaro.org>
 <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823114516.4mcufkbmzy5gjdcr@mobilestation>
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

On 23/08/2022 14:45, Serge Semin wrote:
> On Tue, Aug 23, 2022 at 11:44:16AM +0300, Krzysztof Kozlowski wrote:
>> On 23/08/2022 11:32, Serge Semin wrote:
>>> On Tue, Aug 23, 2022 at 11:17:23AM +0300, Krzysztof Kozlowski wrote:
>>>> On 22/08/2022 22:07, Serge Semin wrote:
>>>>> The Zynq A05 DDRC controller has nothing in common with DW uMCTL2 DDRC:
>>>>> the CSRs layout is absolutely different and it doesn't has IRQ unlike DW
>>>>> uMCTL2 DDR controller of all versions (v1.x, v2.x and v3.x). Thus there is
>>>>> no any reason to have these controllers described by the same bindings.
>>>>> Thus let's split them up.
>>>>>
>>>>> While at it rename the original Synopsys uMCTL2 DT-schema file to a more
>>>>> descriptive - snps,dw-umctl2-ddrc.yaml and add a more detailed title and
>>>>> description of the device bindings.
>>>>
>>>
> 
>>>> Filename should be based on compatible, so if renaming then
>>>> snps,ddrc-3.80a.yaml or snps,ddrc.yaml... which leads to original
>>>> filename anyway. Therefore nack for rename.
> 
> Original name was synopsys,ddrc-ecc.yaml which doesn't match any of
> the compatible strings. 
> 
>>>
>>> New requirement? I've submitted not a single patch to the DT-bindings
>>> sources and didn't get any comment from Rob about that. 
>>
> 
>> This is not a new requirement. It has been since some time and Rob gave
>> such reviews.
>>
>> https://lore.kernel.org/linux-devicetree/YlhkwvGdcf4ozTzG@robh.at.kernel.org/
> 
> April 2022. So it's new. It would be nice to have it defined somewhere
> in docs (writing-bindings.rst?). So does the compatibles order (this
> was surprising to me too).
> 
>>
>> For devices with multiple compatibles that's a bit tricky, but assuming
>> the bindings describe both original design from Synopsys and it's
>> implementations, then something closer to Synopsys makes sense.
> 
> The closest name would be snps,dw-umctl2-ddrc.yaml. snps,ddrc is too
> generic especially for the IP-cores vendor. It doesn't have a
> reference to the actual IP-core the device in subject is based on.

You are aware that in such case mistake is not in the file name but in
the compatible?

> 
>>
>>
>>> In addition
>>> There are DT bindings with names different from what is defined in the
>>> compatible name. Moreover there are tons of bindings with various
>>> compatible names. What name to choose then? Finally the current name
>>> is too generic to use for actual DW uMCTL2 DDRC controller.
>>
> 
>> There are thousands of bugs, inconsistencies, naming differences in
>> kernel. I don't find these as arguments to repeat the practice...so the
>> bindings file name should be based on the compatible.
> 
> Did I ask for an exception? I justified why the renaming was necessary. You
> said it goes against the practice of having the DT-schema named as the
> device compatible strings and just nacked. But above in this message you said
> 
>> "assuming the bindings describe both original design from Synopsys
>> and it's implementations, then something closer to Synopsys makes sense"
> 
> What I suggest makes more sense than some abstract Synopsys DDRC,
> which may refer to a Synopsys DDR controller other than the subject
> one. So I see two solutions here:
> 1. Adding a new generic compatible string like "snps,dw-umctl2-ddrc"
> and deprecate the "snps,ddrc-3.80a". 

This might be good idea, although unfortunately replacing compatibles
takes quite a lot of time if you do not want to break any out-of-tree
users (read: other users of bindings).


> It gets to be even more justified
> seeing the Synopsys IP-core version has been exported in the device
> CSRs since IP-core v3.20a. So having the version attached to the
> compatible string was absolutely redundant.

The version might have sense in a way to differentiate from some older
versions, pre 3.20a. The binding was probably incomplete anyway.


> 2. Just deprecate the generic compatible string, the new compatible
> devices will be supposed to use a vendor-specific compatible strings,
> but still rename the DT-bindings file. This makes sense since the
> current generic name isn't quiet well structured. It' prefix-part is
> too generic and at the same time it refers to a device reversion for
> no much reason.

You mean disallow entirely "snps,ddrc-3.80a" and expect everyone to use
device/implementation specific compatible? I guess this depends whether
this custom block can be used without vendor specific addons. For
several other DW blocks we expect to have the generic snsp fallback and
this generic fallback can be used alone in Linux (pcie-designware-plat.c
binds to it).

Here the Linux driver also binds to generic synopsys compatible, so I
would assume it has a meaning and use case on its own.

> 
> What do you think?
> 
> * Note I've got it you'd prefer the renaming being performed in a
> separate patch.

The rename could be in the split patch as here, but then I assume the
rename part to be detected by git and be a pure rename. However:
1. The git did not mark it as rename (you might need to use custom
arguments to -M/-B/-C),
2. There were also changes in the process (allOf:if:then).


Best regards,
Krzysztof
