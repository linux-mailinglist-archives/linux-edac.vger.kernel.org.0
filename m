Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA2A65C203
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jan 2023 15:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjACOee (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 3 Jan 2023 09:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjACOe3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 3 Jan 2023 09:34:29 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC1EE36;
        Tue,  3 Jan 2023 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672756468; x=1704292468;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=i1lPUCFojlYIYbMOHocJhr6H9ebKcpdRjDcv/yl/BGU=;
  b=Gb/6ETlCvU7ixVImNhsxz9oWDTZORe3dvn6Ijya7e/V+7tdnzWcC9FWx
   7dArxyhwfl/xTlh/gW4SaC8NnTTPJ9IF6c/k8+ZLwFMDKKAxVjewOaWDW
   +YOCEGYqZlkRQYubhTg5knzujJL3vS380Yp1eqLW2KCyef59XyBWjfZP9
   s=;
X-IronPort-AV: E=Sophos;i="5.96,297,1665446400"; 
   d="scan'208";a="167314138"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 14:34:13 +0000
Received: from EX13D40EUA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id C1E1E610F4;
        Tue,  3 Jan 2023 14:34:11 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D40EUA002.ant.amazon.com (10.43.165.195) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Tue, 3 Jan 2023 14:34:10 +0000
Received: from [192.168.14.109] (10.43.161.114) by
 EX19D001EUA003.ant.amazon.com (10.252.50.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7;
 Tue, 3 Jan 2023 14:34:07 +0000
Message-ID: <7cc4d012-1382-204c-5ba5-73bdf6dae2d5@amazon.com>
Date:   Tue, 3 Jan 2023 16:34:02 +0200
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
 <07109746-6fba-8c66-069b-b5982f460d76@amazon.com>
 <add4e548-c7cd-741d-90e5-5c7c9ec7284f@linaro.org>
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <add4e548-c7cd-741d-90e5-5c7c9ec7284f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.161.114]
X-ClientProxiedBy: EX13D41UWB002.ant.amazon.com (10.43.161.109) To
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


On 1/3/2023 4:24 PM, Krzysztof Kozlowski wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On 03/01/2023 14:47, Shenhar, Talel wrote:
>> So how would you have the DT described and how would driver/s look like
>> for cases that the unit registers are split interchangeably?
>>
>>> You did not Cc relevant here mailing addresses (DT and Rob), so this
>>> discussion might miss their feedback.
>>>
>>> How the drivers map IO address space is independent question and should
>>> not determine the hardware description. You want to say that hardware
>>> changes depending on OS? One OS means hardware is like that and on other
>>> OS it's different?
> BTW, you nicely skipped points of my email which are a bit
> inconvenient,e.g. how you want to tie DTS and bindings to one specific
> driver implementation and ignore the rest...

Sorry missed that.

Rob would probably be relevant for this topic as well, however, I didn't 
want to focus on DT for this topic.

Seems your question is what I am actually asking...

However your answer keep getting back to do "full hardware description 
in dt and that it doesn't relate to driver" but does not give concrete 
response hence I fail to get the answer or direction I am looking for.

The solution I previously gave show different possibility for describing 
the HW and the impact on the drivers and wonder what is the best path.


For now I think this is the path I shall take which is option 1:

"1) map more specific region to avoid conflict (we don't need the same 
registers on both entity so if we do very specific multiple mapping this 
shall be resolved)"

Which seems to be what you are trying to say by give more complete HW 
description.


>
> Best regards,
> Krzysztof
>
