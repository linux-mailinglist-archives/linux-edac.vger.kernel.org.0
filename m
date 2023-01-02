Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1696D65B501
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjABQVs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjABQVq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 11:21:46 -0500
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596F3D9E;
        Mon,  2 Jan 2023 08:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672676505; x=1704212505;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=kFjhkTg90WI6Z3PEiEQ8Zw/uVZUDfaNOtxLH4zuU6aw=;
  b=Wm9k+xJr8Ihce1EKGrTvkeAwmWJD8lOe+EYl5XOHBHQlfOUrxFh0l9kS
   U+rjt21BzmriXM/34MUC3nOQp049PNWXYrROE3X9J9nVMUF0mvib3qBAf
   YuwHgQhfcJgJDvyBj1vNB3YfX+UGMUWX4e9GPdDGFD7ZnoYOPv8JEDAzZ
   k=;
X-IronPort-AV: E=Sophos;i="5.96,294,1665446400"; 
   d="scan'208";a="1088655673"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 16:21:37 +0000
Received: from EX13D43EUA004.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-f253a3a3.us-west-2.amazon.com (Postfix) with ESMTPS id C76038006C;
        Mon,  2 Jan 2023 16:21:36 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D43EUA004.ant.amazon.com (10.43.165.156) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 2 Jan 2023 16:21:35 +0000
Received: from [192.168.7.187] (10.43.160.83) by EX19D001EUA003.ant.amazon.com
 (10.252.50.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Mon, 2 Jan 2023
 16:21:32 +0000
Message-ID: <567f14ef-7940-25c5-9323-c673b98e585a@amazon.com>
Date:   Mon, 2 Jan 2023 18:21:27 +0200
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
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <21c6dd41-3e6f-26c6-d6ca-25102e992c18@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.160.83]
X-ClientProxiedBy: EX13D28UWB003.ant.amazon.com (10.43.161.60) To
 EX19D001EUA003.ant.amazon.com (10.252.50.232)
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


On 1/2/2023 3:59 PM, Krzysztof Kozlowski wrote:
>
> On 02/01/2023 14:44, Shenhar, Talel wrote:
>> On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
>>>
>>> On 02/01/2023 13:17, Shenhar, Talel wrote:
>>>
>>>> Things we had in mind:
>>>> 1) map more specific region to avoid conflict (we don't need the same
>>>> registers on both entity so if we do very specific multiple mapping this
>>>> shall be resolved)
>>>> 2) use other kernel API for mapping that doesn't do request_mem_region
>>>> (or use the reserve only for one of them)
>>>> 3) have single driver (edac mc) handle also the refresh rate
>>>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>>>> to do both edac and refresh rate under drivers/memory
>>> None of these address the core problem - possibly inaccurate hardware
>>> description...
>> Can you elaborate on this inaccurate hardware description?
> I explained - using same IO address suggests you used Linux driver
> structure in your hardware description. I assume we talk here about
> Devicetree. If not, that's quite different case... then I guess ACPI,
> which I do not care - I am not it's maintainer.
>
>> Also, I'd like to write down my understanding of your response from above:
>>
>> it seems you see as possible solution both using different API that
>> allow overlapping (solution 2) and also for splitting the IO address
>> space to finer pieces to achieve full HW description (solution 1)
> No. Sorry, we probably talk about two different things.
>
> You started writing that you have a hardware described as one IO address
> space and now have a problem developing drivers for it.
>
> The driver model for this is entirely different problem than problem of
> accurate hardware description. Whether you described HW correct or not,
> I don't know. You did not provide any details here, like DTS or bindings
> (if we talk about Devicetree).
>
> Having multiple drivers using similar resources is already solved many
> times (MFD, syscon).
>
> Whether the solution is correct or not is one more (third) topic: poking
> to same IO address space from two different drivers is error-prone. This
> one is solvable with splitting IO address space.
>
> Best regards,
> Krzysztof


You are right.

Let me elaborate on this.

We will write down the hardware description via device tree.

Then we will write the driver which will honor that binding.

So the question is what is the best practice there assuming there is no 
shared registers however there is overlapping.

e.g. the EDAC driver needs register 0,1,2,4,5 and refresh-rate needs 
register 3.

If we would only have EDAC driver than we would do IO address mapping 
from 0 with size 5 (not caring mapping register 3 even that its not used).

However, with the other driver (refresh rate) that need register 3 we am 
facing a problem.

So looking for the best solution here.

I don't think this is a problem that is specific to drivers/edac and to 
drivers/memory, however, due to the nature of those two libraries this 
conflict is more expected.


>
