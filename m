Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB9D65C086
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbjACNPH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 08:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbjACNOq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 08:14:46 -0500
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CF811C19;
        Tue,  3 Jan 2023 05:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672751609; x=1704287609;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=AkuTz7f+/vPjlMAg5HgVT0vtlZ4LOxZWVmoCU56Z/2E=;
  b=CzWNKCPp7MbinPW0yxMbnv3YOtH0RG8rNaYosKZUKjbMUWU2rPwlE5gM
   3EcyzKgNgsvvZxUks1ULOgm9LRMWWM6oxOMCZGgzXvZa9hcPUG1rsJC0Q
   h4oCWPVXDx8jfy3eMAG/Ts47VBne3lM6/AaWu4wnKFBUW4ohgHJCP0shR
   0=;
X-IronPort-AV: E=Sophos;i="5.96,297,1665446400"; 
   d="scan'208";a="282837501"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:12:56 +0000
Received: from EX13D34EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-m6i4x-e651a362.us-east-1.amazon.com (Postfix) with ESMTPS id 682038313D;
        Tue,  3 Jan 2023 13:12:54 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D34EUA002.ant.amazon.com (10.43.165.215) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 3 Jan 2023 13:12:53 +0000
Received: from [192.168.14.109] (10.43.161.114) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Tue, 3 Jan 2023 13:12:50 +0000
Message-ID: <4c91989c-8b63-410b-e06f-99d99ddbb390@amazon.com>
Date:   Tue, 3 Jan 2023 15:12:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bp@alien8.de>
CC:     <talelshenhar@gmail.com>, <shellykz@amazon.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
 <4bd90224-d09a-1f21-92e6-51c967d68a39@amazon.com>
 <21c6dd41-3e6f-26c6-d6ca-25102e992c18@linaro.org>
 <567f14ef-7940-25c5-9323-c673b98e585a@amazon.com>
 <60d2899e-aed3-a98d-4f3e-8203918a23f9@linaro.org>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <60d2899e-aed3-a98d-4f3e-8203918a23f9@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.114]
X-ClientProxiedBy: EX13D45UWA002.ant.amazon.com (10.43.160.38) To
 EX19D001EUA003.ant.amazon.com (10.252.50.232)
X-Spam-Status: No, score=-15.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 1/2/2023 6:25 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 02/01/2023 17:21, Shenhar, Talel wrote:
>> On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>>> On 02/01/2023 14:44, Shenhar, Talel wrote:
>>>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>>>
>>>>>> Things we had in mind:
>>>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>>>> registers on both entity so if we do very specific multiple mapping this
>>>>>> shall be resolved)
>>>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>>>> (or use the reserve only for one of them)
>>>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>>>> to do both edac and refresh rate under drivers/memory
>>>>> None of these address the core problem - possibly inaccurate hardware
>>>>> description...
>>>> Can you elaborate on this inaccurate hardware description?
>>> I explained - using same IO address suggests you used Linux driver
>>> structure in your hardware description. I assume we talk here about
>>> Devicetree. If not, that's quite different case... then I guess ACPI,
>>> which I do not care - I am not it's maintainer.
>>>
>>>> Also, I'd like to write down my understanding of your response from above:
>>>>
>>>> it seems you see as possible solution both using different API that
>>>> allow overlapping (solution 2) and also for splitting the IO address
>>>> space to finer pieces to achieve full HW description (solution 1)
>>> No. Sorry, we probably talk about two different things.
>>>
>>> You started writing that you have a hardware described as one IO address
>>> space and now have a problem developing drivers for it.
>>>
>>> The driver model for this is entirely different problem than problem of
>>> accurate hardware description. Whether you described HW correct or not,
>>> I don't know. You did not provide any details here, like DTS or bindings
>>> (if we talk about Devicetree).
>>>
>>> Having multiple drivers using similar resources is already solved many
>>> times (MFD, syscon).
>>>
>>> Whether the solution is correct or not is one more (third) topic: poking
>>> to same IO address space from two different drivers is error-prone. This
>>> one is solvable with splitting IO address space.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> You are right.
>>
>> Let me elaborate on this.
>>
>> We will write down the hardware description via device tree.
>>
>> Then we will write the driver which will honor that binding.
>>
>> So the question is what is the best practice there assuming there is no
>> shared registers however there is overlapping.
> The correct solution is to describe hardware. The hardware is memory
> controller. There is no hardware called "scaller of memory controller".
> There is no hardware called "EDAC" because that's purely a Linux term.
>
> Your DTS should accurately describe the hardware, not drivers. Then
> drivers can do whatever they want with it - have safe, non-concurrent
> access or keep poking same registers and break things...

The way the HW shall be described in DT is tightly coupled to the way 
the drivers will work on mapping the IO addresses.

There are 3 ways to describe the HW as far as I see it from address 
point of view: (actually 2 as option 3 is not really sane)

1) one big chunk of registers

2) smaller chunk of registers aiming to have each chunk describe a 
subset of the HW capablity (e.g. RAS, e.g. Refresh-rate, ...)

3) describe each register with its name

Each option dictate how driver shall map the address space.


If option 1 is chosen, then we shall have 2 drivers with same reg 
description.

For that case, they can both remap the whole space or each one can try 
to map only the section it needs.

If option 2 is chosen, then each driver can use DT to know exactly what 
it needs to map and do it in safer manner.


>
>> e.g. the EDAC driver needs register 0,1,2,4,5 and refresh-rate needs
>> register 3.
> I don't think there is EDAC and "refresh-rate" hardwares. There is
> memory controller.
>
>> If we would only have EDAC driver than we would do IO address mapping
>> from 0 with size 5 (not caring mapping register 3 even that its not used).
>>
>> However, with the other driver (refresh rate) that need register 3 we am
>> facing a problem.
>>
>> So looking for the best solution here.
>>
>> I don't think this is a problem that is specific to drivers/edac and to
>> drivers/memory, however, due to the nature of those two libraries this
>> conflict is more expected.
> All these problems look like started from wrong hardware description, so
> not sure if it is worth fixing something where the basis is already not
> correct.
>
> Best regards,
> Krzysztof
>
