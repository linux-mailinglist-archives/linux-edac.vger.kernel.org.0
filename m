Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC9F65B2D9
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 14:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbjABNo6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjABNo6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 08:44:58 -0500
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F1463EA;
        Mon,  2 Jan 2023 05:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672667097; x=1704203097;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=zzbeXhV68/mjX9Y04gKO12WzDpwgCtCqGRiwtYbgNX8=;
  b=A3zKEEaYKEd6typiqkCj3qd+LKD96XNIZc6MyF86HQpdgjJrZ+ZhuT7t
   KjtVLrrrmTH849vs64MPqTNjugXXeM4NZS+2Mucb4zsYP9fntosHyaFAP
   WcaJln6wf5AVrObxzklJ+GYDQyEngyRfPAbZyGUAmUzn8YfrJ07icg0bZ
   A=;
X-IronPort-AV: E=Sophos;i="5.96,294,1665446400"; 
   d="scan'208";a="252217987"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 13:44:52 +0000
Received: from EX13D31EUA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1d-m6i4x-d7759ebe.us-east-1.amazon.com (Postfix) with ESMTPS id BDCC04303B;
        Mon,  2 Jan 2023 13:44:49 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D31EUA002.ant.amazon.com (10.43.165.238) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 2 Jan 2023 13:44:48 +0000
Received: from [192.168.7.187] (10.43.162.56) by EX19D001EUA003.ant.amazon.com
 (10.252.50.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Mon, 2 Jan 2023
 13:44:45 +0000
Message-ID: <4bd90224-d09a-1f21-92e6-51c967d68a39@amazon.com>
Date:   Mon, 2 Jan 2023 15:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <bp@alien8.de>
CC:     <talel@amazon.com>, <talelshenhar@gmail.com>,
        <shellykz@amazon.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <8b844f3a-e9b0-28d5-200a-611fe3068bc0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.162.56]
X-ClientProxiedBy: EX13D34UWC004.ant.amazon.com (10.43.162.155) To
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


On 1/2/2023 2:47 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 02/01/2023 13:17, Shenhar, Talel wrote:
>> Hi,
>>
>> Want to consult on a topic that involve both drivers/memory and
>> drivers/edac.
>>
>> * We want to introduce driver that reads DDR controller RAS register and
>> notify for ECC errors by using EDAC MC API found in drivers/edac.
>> * We also want to have a capability to dynamically change DDR refresh
>> rate based on thermal values (best to be done in drivers/memory ?).
>>
>> The pain point here is that both capabilities are controlled from the
>> DDR controller.
>> This create issue while using
>> devm_platform_ioremap_resource*->devm_request_mem_region which prevent
>> two mapping of same area.
> This could be avoided but the true problem is that you have two devices
> for same memory mapping. Devicetree does not allow it and it points to
> some wrong hardware representation in DTS.
>
>> It seems to be expected problem as we have 2 "framework" (edac and
>> memory) split while both aim for same HW unit.
>> What is the recommended way to face such conflicts?
> You now mix Devicetree and Linux drivers. You can have same IO address
> space used by multiple drivers, even though it is not always good
> approach (concurrent and conflicting change of same settings).
>
> HW description is irrelevant to this.
>
>> We had several concept in mind but would love to get your point of view
>> first.
> Describe hardware accurately and completely. This solves all the
> problems, doesn't it? Linux drivers do not depend on it and you can make
> it differently.

Describing the hardware accurately and completely means to have multiple 
reg property in the device-tree, right?

That way we will split the HW description to smaller bits rather then 
just big "ddrc", and that shall allow us to have two drivers and each 
one will get its own share of the split, right?

That was the intent of solution 1 below.

>
>> Things we had in mind:
>> 1) map more specific region to avoid conflict (we don't need the same
>> registers on both entity so if we do very specific multiple mapping this
>> shall be resolved)
>> 2) use other kernel API for mapping that doesn't do request_mem_region
>> (or use the reserve only for one of them)
>> 3) have single driver (edac mc) handle also the refresh rate
>> 4) export edac_mc.h and have the drivers/memory have all the needed code
>> to do both edac and refresh rate under drivers/memory
> None of these address the core problem - possibly inaccurate hardware
> description...

Can you elaborate on this inaccurate hardware description?

Also, I'd like to write down my understanding of your response from above:

it seems you see as possible solution both using different API that 
allow overlapping (solution 2) and also for splitting the IO address 
space to finer pieces to achieve full HW description (solution 1)

>
> Best regards,
> Krzysztof
>
