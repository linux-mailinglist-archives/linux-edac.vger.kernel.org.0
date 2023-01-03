Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4588065C0B7
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 14:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjACNXQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 08:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjACNXO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 08:23:14 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780581005A
        for <linux-edac@vger.kernel.org>; Tue,  3 Jan 2023 05:23:13 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id x11so7421422ljh.12
        for <linux-edac@vger.kernel.org>; Tue, 03 Jan 2023 05:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S9jqpPbKN3vLrz//PNtRoKHjimVJyn2iNVTP/1F8XtQ=;
        b=nDmlgxbF9MBDZZnFae13gQDk61Rdv2jzrWtXcCaaTtCvrkYOaDZ+QsB9uo2mQR7aaV
         gtGyWvTHKeGI566rnLnH66AT8KTqibaD25YIRF/Zra4GbpZJprjOKtCmXrkE6ZblDyzL
         /rP9U6CFwvn2mnjNF52mBZcnBsD+71xVez8AAOzfSYI+B/r9U6QJEURHOs65HXsZj09p
         qMGyrQ8seJLP/MXkDFr11Kq3tljPpUhymaVDNqx9s6Up3pHi1oKv8fFmb0zuLGnfwE7l
         HSaSZGdaWxZSox1bGspXcfZsJhhUFW5K13L9+I1i2IZsDlhetW6XXKSFFznyNZAdA4DY
         O1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9jqpPbKN3vLrz//PNtRoKHjimVJyn2iNVTP/1F8XtQ=;
        b=s08AfkyKha8qWZXdLJyNeeX5CQZ5Ks104kxURkQCl0QkB2BEiGIg5rqijGUqdpTU6O
         gPGZ646MJbIHNNBWcd4Z7RwIWoUhBp31r7EPtDP3J5GuUmMkG0k8McKKlXYwzi5Y3sF9
         ISrjbS+HHOO1tSFhn4eAhGmkYKh5JxAar1j0BHmpQ65PWTF+YM0CC03AC00/LasEhSMr
         wk5M3iEiP7DLkMu2tZ3KsVh9xW9wmyoQ/zkqvQw5WmsGRHd/jYe5vd9mfLv8UIxd6M6m
         TBKgmpZ57fGWdSL89sCFU12IxcwhIUoPYwkpk3mi2vwjiTvkVEA0T+WxQlD9i4L0zNwB
         6c/g==
X-Gm-Message-State: AFqh2ko3rSC18Y7eMA5N+InLR90NdxXLuld5URle4tga7mR+bY259Xs2
        0M0cfWecVTRAz51M2g/uErso9g==
X-Google-Smtp-Source: AMrXdXu9HCpVEsRwLYrzMTE6eMeSKHv9geXHO8SeBxivTKNuOVYBq6s77dWm8ZGYqDucabYWCEWz9g==
X-Received: by 2002:a2e:b531:0:b0:27f:c774:1369 with SMTP id z17-20020a2eb531000000b0027fc7741369mr9286128ljm.7.1672752191789;
        Tue, 03 Jan 2023 05:23:11 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q10-20020a2eb4aa000000b0027fd72dd6a1sm1489435ljm.70.2023.01.03.05.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:23:10 -0800 (PST)
Message-ID: <a15335d1-fc08-a507-2365-6a14ff6154f6@linaro.org>
Date:   Tue, 3 Jan 2023 14:23:08 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c91989c-8b63-410b-e06f-99d99ddbb390@amazon.com>
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

On 03/01/2023 14:12, Shenhar, Talel wrote:
> 
> On 1/2/2023 6:25 PM, Krzysztof Kozlowski wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On 02/01/2023 17:21, Shenhar, Talel wrote:
>>> On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>>>> On 02/01/2023 14:44, Shenhar, Talel wrote:
>>>>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>>>>
>>>>>>> Things we had in mind:
>>>>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>>>>> registers on both entity so if we do very specific multiple mapping this
>>>>>>> shall be resolved)
>>>>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>>>>> (or use the reserve only for one of them)
>>>>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>>>>> to do both edac and refresh rate under drivers/memory
>>>>>> None of these address the core problem - possibly inaccurate hardware
>>>>>> description...
>>>>> Can you elaborate on this inaccurate hardware description?
>>>> I explained - using same IO address suggests you used Linux driver
>>>> structure in your hardware description. I assume we talk here about
>>>> Devicetree. If not, that's quite different case... then I guess ACPI,
>>>> which I do not care - I am not it's maintainer.
>>>>
>>>>> Also, I'd like to write down my understanding of your response from above:
>>>>>
>>>>> it seems you see as possible solution both using different API that
>>>>> allow overlapping (solution 2) and also for splitting the IO address
>>>>> space to finer pieces to achieve full HW description (solution 1)
>>>> No. Sorry, we probably talk about two different things.
>>>>
>>>> You started writing that you have a hardware described as one IO address
>>>> space and now have a problem developing drivers for it.
>>>>
>>>> The driver model for this is entirely different problem than problem of
>>>> accurate hardware description. Whether you described HW correct or not,
>>>> I don't know. You did not provide any details here, like DTS or bindings
>>>> (if we talk about Devicetree).
>>>>
>>>> Having multiple drivers using similar resources is already solved many
>>>> times (MFD, syscon).
>>>>
>>>> Whether the solution is correct or not is one more (third) topic: poking
>>>> to same IO address space from two different drivers is error-prone. This
>>>> one is solvable with splitting IO address space.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> You are right.
>>>
>>> Let me elaborate on this.
>>>
>>> We will write down the hardware description via device tree.
>>>
>>> Then we will write the driver which will honor that binding.
>>>
>>> So the question is what is the best practice there assuming there is no
>>> shared registers however there is overlapping.
>> The correct solution is to describe hardware. The hardware is memory
>> controller. There is no hardware called "scaller of memory controller".
>> There is no hardware called "EDAC" because that's purely a Linux term.
>>
>> Your DTS should accurately describe the hardware, not drivers. Then
>> drivers can do whatever they want with it - have safe, non-concurrent
>> access or keep poking same registers and break things...
> 
> The way the HW shall be described in DT is tightly coupled to the way 
> the drivers will work on mapping the IO addresses.

No, that's not true and such DT description will get probably Rob's or
mine comments. The HW shall be described without tying to one, specific
driver implementation. Otherwise why do you make it tightly coupled to
Linux, but ignore BSD, firmware and bootloaders?

Don't tightly couple DT with your drivers.

> 
> There are 3 ways to describe the HW as far as I see it from address 
> point of view: (actually 2 as option 3 is not really sane)
> 
> 1) one big chunk of registers
> 
> 2) smaller chunk of registers aiming to have each chunk describe a 
> subset of the HW capablity (e.g. RAS, e.g. Refresh-rate, ...)
> 
> 3) describe each register with its name
> 
> Each option dictate how driver shall map the address space.

Again, the driver does not matter. You have one device, describe
properly one device. DT is not to describe drivers.

You did not Cc relevant here mailing addresses (DT and Rob), so this
discussion might miss their feedback.

How the drivers map IO address space is independent question and should
not determine the hardware description. You want to say that hardware
changes depending on OS? One OS means hardware is like that and on other
OS it's different?

> 
> 
> If option 1 is chosen, then we shall have 2 drivers with same reg 
> description.

Drivers are not related to DT bindings and DTS. Two different things.

> 
> For that case, they can both remap the whole space or each one can try 
> to map only the section it needs.
> 
> If option 2 is chosen, then each driver can use DT to know exactly what 
> it needs to map and do it in safer manner.




Best regards,
Krzysztof

