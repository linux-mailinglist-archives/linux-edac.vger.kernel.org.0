Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA1E65C117
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 14:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbjACNrk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 08:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjACNrj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 08:47:39 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092201117B;
        Tue,  3 Jan 2023 05:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672753658; x=1704289658;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=z/UwGeS4Qy0UO208RYamxd2niqrEHeNx9gY0U0Cd3yU=;
  b=sG4bJXmd/fZfzkHCS7+X4Zg63lnHrqrk9d9H5Jbu/ez69kWZtSOO51/X
   5EsM/mPovEi04pTaQqsx16CDGxQEmXc5r5VFJ5MiYMiRgnUePFIWaUDUa
   5c141IV96kIhfHHOH4hT75Ne56DVDeBTcsYBNE0M1r5w5bptqmrcEGCMt
   Q=;
X-IronPort-AV: E=Sophos;i="5.96,297,1665446400"; 
   d="scan'208";a="279051729"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 13:47:33 +0000
Received: from EX13D42EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id DAD88A2CE8;
        Tue,  3 Jan 2023 13:47:30 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D42EUA002.ant.amazon.com (10.43.165.185) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 3 Jan 2023 13:47:29 +0000
Received: from [192.168.14.109] (10.43.161.114) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Tue, 3 Jan 2023 13:47:26 +0000
Message-ID: <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
Date:   Tue, 3 Jan 2023 15:47:22 +0200
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
 <4c91989c-8b63-410b-e06f-99d99ddbb390@amazon.com>
 <a15335d1-fc08-a507-2365-6a14ff6154f6@linaro.org>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <a15335d1-fc08-a507-2365-6a14ff6154f6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.114]
X-ClientProxiedBy: EX13D45UWA001.ant.amazon.com (10.43.160.91) To
 EX19D001EUA003.ant.amazon.com (10.252.50.232)
X-Spam-Status: No, score=-15.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 1/3/2023 3:23 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 03/01/2023 14:12, Shenhar, Talel wrote:
>> On 1/2/2023 6:25 PM, Krzysztof Kozlowski wrote:
>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>>>
>>>
>>>
>>> On 02/01/2023 17:21, Shenhar, Talel wrote:
>>>> On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>>>>> On 02/01/2023 14:44, Shenhar, Talel wrote:
>>>>>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>>>>>
>>>>>>>> Things we had in mind:
>>>>>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>>>>>> registers on both entity so if we do very specific multiple mapping this
>>>>>>>> shall be resolved)
>>>>>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>>>>>> (or use the reserve only for one of them)
>>>>>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>>>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>>>>>> to do both edac and refresh rate under drivers/memory
>>>>>>> None of these address the core problem - possibly inaccurate hardware
>>>>>>> description...
>>>>>> Can you elaborate on this inaccurate hardware description?
>>>>> I explained - using same IO address suggests you used Linux driver
>>>>> structure in your hardware description. I assume we talk here about
>>>>> Devicetree. If not, that's quite different case... then I guess ACPI,
>>>>> which I do not care - I am not it's maintainer.
>>>>>
>>>>>> Also, I'd like to write down my understanding of your response from above:
>>>>>>
>>>>>> it seems you see as possible solution both using different API that
>>>>>> allow overlapping (solution 2) and also for splitting the IO address
>>>>>> space to finer pieces to achieve full HW description (solution 1)
>>>>> No. Sorry, we probably talk about two different things.
>>>>>
>>>>> You started writing that you have a hardware described as one IO address
>>>>> space and now have a problem developing drivers for it.
>>>>>
>>>>> The driver model for this is entirely different problem than problem of
>>>>> accurate hardware description. Whether you described HW correct or not,
>>>>> I don't know. You did not provide any details here, like DTS or bindings
>>>>> (if we talk about Devicetree).
>>>>>
>>>>> Having multiple drivers using similar resources is already solved many
>>>>> times (MFD, syscon).
>>>>>
>>>>> Whether the solution is correct or not is one more (third) topic: poking
>>>>> to same IO address space from two different drivers is error-prone. This
>>>>> one is solvable with splitting IO address space.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>> You are right.
>>>>
>>>> Let me elaborate on this.
>>>>
>>>> We will write down the hardware description via device tree.
>>>>
>>>> Then we will write the driver which will honor that binding.
>>>>
>>>> So the question is what is the best practice there assuming there is no
>>>> shared registers however there is overlapping.
>>> The correct solution is to describe hardware. The hardware is memory
>>> controller. There is no hardware called "scaller of memory controller".
>>> There is no hardware called "EDAC" because that's purely a Linux term.
>>>
>>> Your DTS should accurately describe the hardware, not drivers. Then
>>> drivers can do whatever they want with it - have safe, non-concurrent
>>> access or keep poking same registers and break things...
>> The way the HW shall be described in DT is tightly coupled to the way
>> the drivers will work on mapping the IO addresses.
> No, that's not true and such DT description will get probably Rob's or
> mine comments. The HW shall be described without tying to one, specific
> driver implementation. Otherwise why do you make it tightly coupled to
> Linux, but ignore BSD, firmware and bootloaders?
>
> Don't tightly couple DT with your drivers.

But of course its true :)

binding document define the reg property for drivers that do registers 
access.

If you define it one way or the other that shall change the driver 
mapping policy/method.

>
>> There are 3 ways to describe the HW as far as I see it from address
>> point of view: (actually 2 as option 3 is not really sane)
>>
>> 1) one big chunk of registers
>>
>> 2) smaller chunk of registers aiming to have each chunk describe a
>> subset of the HW capablity (e.g. RAS, e.g. Refresh-rate, ...)
>>
>> 3) describe each register with its name
>>
>> Each option dictate how driver shall map the address space.
> Again, the driver does not matter. You have one device, describe
> properly one device. DT is not to describe drivers.

The way drivers are being probed is based on compatible found in DT.

So you only get one platform driver probe per device described in DT.

If we have single device described in DT then we won't have two distinct 
platform drivers getting probe.

(We could not have them platform driver and have them as regular module 
which go and look "manually" for that device... but that looks too hacky).


As we do consider two distinct drivers the idea was to have two devices 
described in DT. One gets the registers subset it want while the other 
get the registers it want.


So how would you have the DT described and how would driver/s look like 
for cases that the unit registers are split interchangeably?

>
> You did not Cc relevant here mailing addresses (DT and Rob), so this
> discussion might miss their feedback.
>
> How the drivers map IO address space is independent question and should
> not determine the hardware description. You want to say that hardware
> changes depending on OS? One OS means hardware is like that and on other
> OS it's different?
>
>>
>> If option 1 is chosen, then we shall have 2 drivers with same reg
>> description.
> Drivers are not related to DT bindings and DTS. Two different things.
>
>> For that case, they can both remap the whole space or each one can try
>> to map only the section it needs.
>>
>> If option 2 is chosen, then each driver can use DT to know exactly what
>> it needs to map and do it in safer manner.
>
>
>
> Best regards,
> Krzysztof
>
