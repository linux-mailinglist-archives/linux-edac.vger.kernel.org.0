Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B4665B304
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 14:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjABN7U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 08:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjABN7N (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 08:59:13 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DDD658A
        for <linux-edac@vger.kernel.org>; Mon,  2 Jan 2023 05:59:10 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id z26so41656206lfu.8
        for <linux-edac@vger.kernel.org>; Mon, 02 Jan 2023 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYUw4Ow/UYF3HeKOgD5K67nNVV6dcsvzhajlvBseawk=;
        b=fLakEGh+EuC4FktCd11+6EbqiUlz9zYovZEBDMewyaZfCYkBPaeEvfFsR1sU3zHD2n
         otJumu/l7IPQR5vblfN1EElLgocHKRZAaRTzzG3xX+YIPM9FW2nqVedLUk/5hxp3TnSg
         aRnqDZWzP2QHk1jpnG41eBGddhV3lOP/6HrMwEpmpQzs4pDipVX+27zZRJ0ClntbkFAc
         milZ3xwFQyzb/abtq7fmv3B/CwPQmjqI4twPSYuZMLYJtURV36Wdym64Mp9dB/kpTBye
         G8rYfn08DQkP5ck8shYdLkoB343oEXoZnRT/r8PtFSaqdpx8RDE/Kxkyo5A+Bqn373OR
         2hbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CYUw4Ow/UYF3HeKOgD5K67nNVV6dcsvzhajlvBseawk=;
        b=L8Novmc81uRvEYfE96+9dwvKzBvsml2yc64HaOIiCXfM9oGK741UirZVW52xnVov4M
         uO7nPbGXzr25qx+sEsslV8iNZfxvatF/0kj9xnieg/A95cV6qQgzuJqGy1ujBdX4mGg4
         JoLLEXoY1t9W89sP9JHAaHiAHEDHz7SeOQinx5aO7qgwZqGgfePwaZL6sJmse6vhrCzf
         h20uPNVQdaqgL7qfvB6opaIRsOzJDbBpBYwdmsfjqbN1KK6nCctDlqcY9GeffDvsDkox
         1sWxdTmWChL58D7FhMGDZVCYobeTiPrGWP866BIlOvmh2XYRx2aFTCIj630B10UhhAZr
         3r9Q==
X-Gm-Message-State: AFqh2kr7U+23LKv9BirFZK2zPGp18I0Xyi1f7KqX1jZh8V4YqWCxi4J9
        WrvlhLTCwLr015sgC6MuM2caxA==
X-Google-Smtp-Source: AMrXdXvt47iRm5eGMaxejAQ2r6gZrvDKE4wOMaN78STYhja4LDlre8j80VkD3jebySE40a6UVh1Ciw==
X-Received: by 2002:a05:6512:3fa7:b0:4b5:cda:44cf with SMTP id x39-20020a0565123fa700b004b50cda44cfmr13845049lfa.67.1672667948935;
        Mon, 02 Jan 2023 05:59:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id l9-20020a056512110900b004cb2a786cc6sm1137967lfg.105.2023.01.02.05.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 05:59:08 -0800 (PST)
Message-ID: <21c6dd41-3e6f-26c6-d6ca-25102e992c18@linaro.org>
Date:   Mon, 2 Jan 2023 14:59:07 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4bd90224-d09a-1f21-92e6-51c967d68a39@amazon.com>
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

On 02/01/2023 14:44, Shenhar, Talel wrote:
> 
> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>
>>
>>
>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>> Hi,
>>>
>>> Want to consult on a topic that involve both drivers/memory and
>>> drivers/edac.
>>>
>>> * We want to introduce driver that reads DDR controller RAS register and
>>> notify for ECC errors by using EDAC MC API found in drivers/edac.
>>> * We also want to have a capability to dynamically change DDR refresh
>>> rate based on thermal values (best to be done in drivers/memory ?).
>>>
>>> The pain point here is that both capabilities are controlled from the
>>> DDR controller.
>>> This create issue while using
>>> devm_platform_ioremap_resource*->devm_request_mem_region which prevent
>>> two mapping of same area.
>> This could be avoided but the true problem is that you have two devices
>> for same memory mapping. Devicetree does not allow it and it points to
>> some wrong hardware representation in DTS.
>>
>>> It seems to be expected problem as we have 2 "framework" (edac and
>>> memory) split while both aim for same HW unit.
>>> What is the recommended way to face such conflicts?
>> You now mix Devicetree and Linux drivers. You can have same IO address
>> space used by multiple drivers, even though it is not always good
>> approach (concurrent and conflicting change of same settings).
>>
>> HW description is irrelevant to this.
>>
>>> We had several concept in mind but would love to get your point of view
>>> first.
>> Describe hardware accurately and completely. This solves all the
>> problems, doesn't it? Linux drivers do not depend on it and you can make
>> it differently.
> 
> Describing the hardware accurately and completely means to have multiple 
> reg property in the device-tree, right?

Not necessarily. It means to describe the devices, the hardware, not
drivers.

> 
> That way we will split the HW description to smaller bits rather then 
> just big "ddrc", and that shall allow us to have two drivers and each 
> one will get its own share of the split, right?

Not necessarily. If you have one hardware, why would you split it? It's
only one memory controller, not two.

> That was the intent of solution 1 below.
> 
>>
>>> Things we had in mind:
>>> 1) map more specific region to avoid conflict (we don't need the same
>>> registers on both entity so if we do very specific multiple mapping this
>>> shall be resolved)
>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>> (or use the reserve only for one of them)
>>> 3) have single driver (edac mc) handle also the refresh rate
>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>> to do both edac and refresh rate under drivers/memory
>> None of these address the core problem - possibly inaccurate hardware
>> description...
> 
> Can you elaborate on this inaccurate hardware description?

I explained - using same IO address suggests you used Linux driver
structure in your hardware description. I assume we talk here about
Devicetree. If not, that's quite different case... then I guess ACPI,
which I do not care - I am not it's maintainer.

> Also, I'd like to write down my understanding of your response from above:
> 
> it seems you see as possible solution both using different API that 
> allow overlapping (solution 2) and also for splitting the IO address 
> space to finer pieces to achieve full HW description (solution 1)

No. Sorry, we probably talk about two different things.

You started writing that you have a hardware described as one IO address
space and now have a problem developing drivers for it.

The driver model for this is entirely different problem than problem of
accurate hardware description. Whether you described HW correct or not,
I don't know. You did not provide any details here, like DTS or bindings
(if we talk about Devicetree).

Having multiple drivers using similar resources is already solved many
times (MFD, syscon).

Whether the solution is correct or not is one more (third) topic: poking
to same IO address space from two different drivers is error-prone. This
one is solvable with splitting IO address space.

Best regards,
Krzysztof

