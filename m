Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3965B50E
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 17:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjABQ0A (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 11:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbjABQZa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 11:25:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D49D9E
        for <linux-edac@vger.kernel.org>; Mon,  2 Jan 2023 08:25:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bq39so34396904lfb.0
        for <linux-edac@vger.kernel.org>; Mon, 02 Jan 2023 08:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCwebXWXkrMQ13JeeM+iArGWaEZiPUi0wYVUo7hFptg=;
        b=AYZhyIf0Ijda3w83Yvv1quXMyDHCcTFeOd4hmKjjPcuy5Bxk/DJqwWBHBAPedcMvVc
         XlABwbkXPU6HHaO/wi3hZsJnsUlxe9uBVqiRiZLqwBa1vx6oEyZaF1higTnUvGe7PuLv
         yvLe7z8+9mReXDRpaSxeTxCiwlJ+WuxPF9YaZe2qbqnUMjajlwUyzw7EKy0agTgnZXws
         c7HXXZHoIOUaNag8yrbRFuamyD4tHtY5LyLytS1IRERCQ87ufoHr9XFcmcHj0jdPnp8D
         fap3Dd/kzmbEjm62PQLRotFF+nM9XWR+n+fIdq6s8BfDqckSHLmjN8VnvIrkYdizhGyG
         BQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCwebXWXkrMQ13JeeM+iArGWaEZiPUi0wYVUo7hFptg=;
        b=MzxIO7KHdRwruJwCyj//UfbPpAm2oSsPYQ1urDgrU9KhwsOmrViQlDunGuFRaPUevz
         EyF4FTGytLLrEmXOXiK747D4gHE2S6h5RVK2xwcni/a3v/PZ1uGQu6Ua26+3391NDsT1
         ZJPNSKwJA4bvWjXuZ8hn8/AM+K271l59RmGLF54u9kWkXoyK9b0IxR6nZ4yNxOEhQBf7
         4R1/FbVccP/Up+9yciMpbQyaR6Gh5WPs+oriak/HZiGsw67ItfV39hj1NtIARpyb+DvE
         NOx3IOWrRHt1vHynnDSMDNrnoKRWtStAKkk2KZKDfTQyQdnWZhT0IUH/41Gx9ie6usRT
         iOng==
X-Gm-Message-State: AFqh2kqRzYioHLW6QIW//NVoXuUWPIR0+29vaCBfB3RLeEiIJFjD9QdK
        hbeyT0FVsrgkd5qNhY3du2PJfg==
X-Google-Smtp-Source: AMrXdXsaCYJK9sCYGbd2yKAmU3AzaHCauQM8dFQuNo8yFwgzLbNKIlCiLnoga3i0KDxyZtL8ks3wrQ==
X-Received: by 2002:a05:6512:1597:b0:4b6:f4bb:e53f with SMTP id bp23-20020a056512159700b004b6f4bbe53fmr12505234lfb.60.1672676727459;
        Mon, 02 Jan 2023 08:25:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w37-20020a0565120b2500b004cb2e3089a7sm993647lfu.38.2023.01.02.08.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:25:26 -0800 (PST)
Message-ID: <60d2899e-aed3-a98d-4f3e-8203918a23f9@linaro.org>
Date:   Mon, 2 Jan 2023 17:25:25 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <567f14ef-7940-25c5-9323-c673b98e585a@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 02/01/2023 17:21, Shenhar, Talel wrote:
> 
> On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>>
>> On 02/01/2023 14:44, Shenhar, Talel wrote:
>>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>>
>>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>>
>>>>> Things we had in mind:
>>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>>> registers on both entity so if we do very specific multiple mapping this
>>>>> shall be resolved)
>>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>>> (or use the reserve only for one of them)
>>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>>> to do both edac and refresh rate under drivers/memory
>>>> None of these address the core problem - possibly inaccurate hardware
>>>> description...
>>> Can you elaborate on this inaccurate hardware description?
>> I explained - using same IO address suggests you used Linux driver
>> structure in your hardware description. I assume we talk here about
>> Devicetree. If not, that's quite different case... then I guess ACPI,
>> which I do not care - I am not it's maintainer.
>>
>>> Also, I'd like to write down my understanding of your response from above:
>>>
>>> it seems you see as possible solution both using different API that
>>> allow overlapping (solution 2) and also for splitting the IO address
>>> space to finer pieces to achieve full HW description (solution 1)
>> No. Sorry, we probably talk about two different things.
>>
>> You started writing that you have a hardware described as one IO address
>> space and now have a problem developing drivers for it.
>>
>> The driver model for this is entirely different problem than problem of
>> accurate hardware description. Whether you described HW correct or not,
>> I don't know. You did not provide any details here, like DTS or bindings
>> (if we talk about Devicetree).
>>
>> Having multiple drivers using similar resources is already solved many
>> times (MFD, syscon).
>>
>> Whether the solution is correct or not is one more (third) topic: poking
>> to same IO address space from two different drivers is error-prone. This
>> one is solvable with splitting IO address space.
>>
>> Best regards,
>> Krzysztof
> 
> 
> You are right.
> 
> Let me elaborate on this.
> 
> We will write down the hardware description via device tree.
> 
> Then we will write the driver which will honor that binding.
> 
> So the question is what is the best practice there assuming there is no 
> shared registers however there is overlapping.

The correct solution is to describe hardware. The hardware is memory
controller. There is no hardware called "scaller of memory controller".
There is no hardware called "EDAC" because that's purely a Linux term.

Your DTS should accurately describe the hardware, not drivers. Then
drivers can do whatever they want with it - have safe, non-concurrent
access or keep poking same registers and break things...

> 
> e.g. the EDAC driver needs register 0,1,2,4,5 and refresh-rate needs 
> register 3.

I don't think there is EDAC and "refresh-rate" hardwares. There is
memory controller.

> 
> If we would only have EDAC driver than we would do IO address mapping 
> from 0 with size 5 (not caring mapping register 3 even that its not used).
> 
> However, with the other driver (refresh rate) that need register 3 we am 
> facing a problem.
> 
> So looking for the best solution here.
> 
> I don't think this is a problem that is specific to drivers/edac and to 
> drivers/memory, however, due to the nature of those two libraries this 
> conflict is more expected.

All these problems look like started from wrong hardware description, so
not sure if it is worth fixing something where the basis is already not
correct.

Best regards,
Krzysztof

