Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8D65C161
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 15:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjACODC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 09:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjACODB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 09:03:01 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16653101DE
        for <linux-edac@vger.kernel.org>; Tue,  3 Jan 2023 06:03:00 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f34so45730555lfv.10
        for <linux-edac@vger.kernel.org>; Tue, 03 Jan 2023 06:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4gZS4jGp4zpe92VwBkSX8G5zkaPc/Xr80j1aYaSNRfA=;
        b=Qmp9z2gb6fecrZ9W/rg/tRzSDEkzcHt2ZqiZHI+x9a3kTHQWaUo2R7dtO8sF+W8UEY
         s2lVya1xPfvsRLlcaAkdQQiWiWIZD+/2/5+pb9aCX9odPxsa1mWY82RErybkB2zPnFA/
         ne4TpNo5iU0Ch09Xu6C8U0J+xvXg9cXSbCyWs36yA6ew4zJfCo3ql1wzPCYbwGLbgMOi
         qTdIRriD3zs2uvoSCFuAQi3FNdsPiOpkVBosLvhbVzQCTcdgHdjSn1Y8pEONS0JBQbpX
         P+dQ32TuN0sT0qpwvyZrfyn9qxFR3EsA3w6Ktfe0Xwo993JeCIPOm8bBHpeZcN0X/nRc
         ulcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4gZS4jGp4zpe92VwBkSX8G5zkaPc/Xr80j1aYaSNRfA=;
        b=lLBugTdOXGcUQox3CctRRhrx2+7jz6fjg2d5/M31Z5HpkO5OQ7DXjAnyAq9ekbwf6u
         D2a+J1hhsU7TxwqnfHx86lWKJnltrqpjVUI0lEt+3i2cgyR/OZX6ZnjqcCsUvX1M5FJo
         vjhb/tVJ08xPAzdFEO3Je5LzRFKyKasQMFMOxiWw6vrW+GnpTLWdfi7IQihgh5XYRBzR
         mzH87TUxcougovoktUmnbs33o5i5CAFdZV3ruqEPjtWtq/p5SBkqoMW0bntC0xMr5cCs
         Izi4urrOY7AJO1bpXRLqGshTDFR+9anG8w2ABCmU4dwbbHVaKJkckbbGAePD0pKA18mU
         qnCw==
X-Gm-Message-State: AFqh2koQDhoVjb59yzN6r6yMF07lEElv2WcFjVl8x/67cRlF2+3ebn/L
        35y0qhsak08AdoAuSRVETITeJD/+Um2y2I+M
X-Google-Smtp-Source: AMrXdXvGAdds7fPsKx8kLEEj/lUANjZ/SYJ+yOa5GLEXI33xmbnOKjluBW4oeQmsclqjFNl+YpZ0Tw==
X-Received: by 2002:a05:6512:2628:b0:4cb:35dd:e58d with SMTP id bt40-20020a056512262800b004cb35dde58dmr2573605lfb.10.1672754577608;
        Tue, 03 Jan 2023 06:02:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id v11-20020ac258eb000000b004aa0870b5e5sm4854130lfo.147.2023.01.03.06.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 06:02:56 -0800 (PST)
Message-ID: <0e8a118d-82a8-3370-968c-830d6b58dfa1@linaro.org>
Date:   Tue, 3 Jan 2023 15:02:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR
 Controller
Content-Language: en-US
To:     "Shenhar, Talel" <talel@amazon.com>, bp@alien8.de
Cc:     talelshenhar@gmail.com, shellykz@amazon.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
 <4bd90224-d09a-1f21-92e6-51c967d68a39@amazon.com>
 <21c6dd41-3e6f-26c6-d6ca-25102e992c18@linaro.org>
 <567f14ef-7940-25c5-9323-c673b98e585a@amazon.com>
 <60d2899e-aed3-a98d-4f3e-8203918a23f9@linaro.org>
 <4c91989c-8b63-410b-e06f-99d99ddbb390@amazon.com>
 <a15335d1-fc08-a507-2365-6a14ff6154f6@linaro.org>
 <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 03/01/2023 14:47, Shenhar, Talel wrote:
> 
> On 1/3/2023 3:23 PM, Krzysztof Kozlowski wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On 03/01/2023 14:12, Shenhar, Talel wrote:
>>> On 1/2/2023 6:25 PM, Krzysztof Kozlowski wrote:
>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>>
>>>>
>>>>
>>>> On 02/01/2023 17:21, Shenhar, Talel wrote:
>>>>> On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>>>>>> On 02/01/2023 14:44, Shenhar, Talel wrote:
>>>>>>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>>>>>>
>>>>>>>>> Things we had in mind:
>>>>>>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>>>>>>> registers on both entity so if we do very specific multiple mapping this
>>>>>>>>> shall be resolved)
>>>>>>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>>>>>>> (or use the reserve only for one of them)
>>>>>>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>>>>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>>>>>>> to do both edac and refresh rate under drivers/memory
>>>>>>>> None of these address the core problem - possibly inaccurate hardware
>>>>>>>> description...
>>>>>>> Can you elaborate on this inaccurate hardware description?
>>>>>> I explained - using same IO address suggests you used Linux driver
>>>>>> structure in your hardware description. I assume we talk here about
>>>>>> Devicetree. If not, that's quite different case... then I guess ACPI,
>>>>>> which I do not care - I am not it's maintainer.
>>>>>>
>>>>>>> Also, I'd like to write down my understanding of your response from above:
>>>>>>>
>>>>>>> it seems you see as possible solution both using different API that
>>>>>>> allow overlapping (solution 2) and also for splitting the IO address
>>>>>>> space to finer pieces to achieve full HW description (solution 1)
>>>>>> No. Sorry, we probably talk about two different things.
>>>>>>
>>>>>> You started writing that you have a hardware described as one IO address
>>>>>> space and now have a problem developing drivers for it.
>>>>>>
>>>>>> The driver model for this is entirely different problem than problem of
>>>>>> accurate hardware description. Whether you described HW correct or not,
>>>>>> I don't know. You did not provide any details here, like DTS or bindings
>>>>>> (if we talk about Devicetree).
>>>>>>
>>>>>> Having multiple drivers using similar resources is already solved many
>>>>>> times (MFD, syscon).
>>>>>>
>>>>>> Whether the solution is correct or not is one more (third) topic: poking
>>>>>> to same IO address space from two different drivers is error-prone. This
>>>>>> one is solvable with splitting IO address space.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>> You are right.
>>>>>
>>>>> Let me elaborate on this.
>>>>>
>>>>> We will write down the hardware description via device tree.
>>>>>
>>>>> Then we will write the driver which will honor that binding.
>>>>>
>>>>> So the question is what is the best practice there assuming there is no
>>>>> shared registers however there is overlapping.
>>>> The correct solution is to describe hardware. The hardware is memory
>>>> controller. There is no hardware called "scaller of memory controller".
>>>> There is no hardware called "EDAC" because that's purely a Linux term.
>>>>
>>>> Your DTS should accurately describe the hardware, not drivers. Then
>>>> drivers can do whatever they want with it - have safe, non-concurrent
>>>> access or keep poking same registers and break things...
>>> The way the HW shall be described in DT is tightly coupled to the way
>>> the drivers will work on mapping the IO addresses.
>> No, that's not true and such DT description will get probably Rob's or
>> mine comments. The HW shall be described without tying to one, specific
>> driver implementation. Otherwise why do you make it tightly coupled to
>> Linux, but ignore BSD, firmware and bootloaders?
>>
>> Don't tightly couple DT with your drivers.
> 
> But of course its true :)
> 
> binding document define the reg property for drivers that do registers 
> access.
> 
> If you define it one way or the other that shall change the driver 
> mapping policy/method.

Read again my message. Binding is not coupled with drivers. Binding is
coupled with hardware because it describes the DTS written for hardware,
not for drivers.

I did not say that binding will not affect the drivers. I said that
design of binding is somehow independent (at least partially) from
drivers and once you answer to question "how the hardware looks?"
several problems dissapear. You create here some questions and problems
because you have inaccurate hardware description (e.g. two devices -
some fake "EDAC" and frequency scaler device...).

> 
>>
>>> There are 3 ways to describe the HW as far as I see it from address
>>> point of view: (actually 2 as option 3 is not really sane)
>>>
>>> 1) one big chunk of registers
>>>
>>> 2) smaller chunk of registers aiming to have each chunk describe a
>>> subset of the HW capablity (e.g. RAS, e.g. Refresh-rate, ...)
>>>
>>> 3) describe each register with its name
>>>
>>> Each option dictate how driver shall map the address space.
>> Again, the driver does not matter. You have one device, describe
>> properly one device. DT is not to describe drivers.
> 
> The way drivers are being probed is based on compatible found in DT.
> 
> So you only get one platform driver probe per device described in DT.

No, that's not true. I also gave you hints to solve it - MFD, simple-mfd
etc.

> 
> If we have single device described in DT then we won't have two distinct 
> platform drivers getting probe.

No, again not true. You can have infinite number of drivers getting
probed as result of one device node in DTS.

> 
> (We could not have them platform driver and have them as regular module 
> which go and look "manually" for that device... but that looks too hacky).
> 
> 
> As we do consider two distinct drivers the idea was to have two devices 
> described in DT. One gets the registers subset it want while the other 
> get the registers it want.

I repeated it many, many times. Describe the hardware. Now you again
ignore all my comments and mention that you need two devices because you
have two drivers.

I repeated it way too many times, so the last:
Most likely you have one hardware, so there is one device in DTS.
Describe in DTS the hardware, not the driver model/binding/problems you
have.

> 
> 
> So how would you have the DT described and how would driver/s look like 
> for cases that the unit registers are split interchangeably?

What do you mean by "split interchangeably"? I understood there is *one*
hardware device, not two. One memory controller. Do you want to say you
have two independent memory controllers for the same IO address space?

Anyway, reviewing real patches takes priority of reviewing imaginary
solutions, so please send patches. Otherwise it's end of discussion to
me. If you still have questions, please go back to what I repeated many
times - describe hardware in DT, not the drivers.

Best regards,
Krzysztof

