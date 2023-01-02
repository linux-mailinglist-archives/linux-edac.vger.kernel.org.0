Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820F65B4EA
	for <lists+linux-edac@lfdr.de>; Mon,  2 Jan 2023 17:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbjABQOn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 Jan 2023 11:14:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbjABQOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 Jan 2023 11:14:20 -0500
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68EBB1E2;
        Mon,  2 Jan 2023 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1672676058; x=1704212058;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=A2tP1wvEiHpAcn43VYSqZt6nblvt6ZRHnS+yzv0PKys=;
  b=GTu3KOEZPQ572uxKgS9MHluxATv1g1s7CwTQf6vEXBQE/Kgwhz/TltMu
   KqsPwNdvZovxwn4Sa4sGAgFQRihmpU4qHFuUFoIzmVc2PrMmvMtk6ja2/
   eDz/fj6JxmUq1gCdV8HnFtmmdd2d+bKKxLB6vSFUSyplHBbSrpwQLVo4l
   w=;
X-IronPort-AV: E=Sophos;i="5.96,294,1665446400"; 
   d="scan'208";a="278794352"
Subject: Re: RFC on drivers/memory vs drivers/edac memory mapping for DDR Controller
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 16:14:14 +0000
Received: from EX13D50EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 82A67C3624;
        Mon,  2 Jan 2023 16:14:13 +0000 (UTC)
Received: from EX19D001EUA003.ant.amazon.com (10.252.50.232) by
 EX13D50EUA001.ant.amazon.com (10.43.165.232) with Microsoft SMTP Server (TLS)
 id 15.0.1497.42; Mon, 2 Jan 2023 16:14:12 +0000
Received: from [192.168.7.187] (10.43.160.83) by EX19D001EUA003.ant.amazon.com
 (10.252.50.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.7; Mon, 2 Jan 2023
 16:14:09 +0000
Message-ID: <4d5eead4-c5f6-f852-9e77-35177887ad22@amazon.com>
Date:   Mon, 2 Jan 2023 18:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     Borislav Petkov <bp@alien8.de>
CC:     <krzysztof.kozlowski@linaro.org>, <talelshenhar@gmail.com>,
        <shellykz@amazon.com>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <2511c7aa-8ce6-a803-a1ea-6121df79c677@amazon.com>
 <Y7LfhB5IrLcFzPOi@zn.tnic>
Content-Language: en-US
From:   "Shenhar, Talel" <talel@amazon.com>
In-Reply-To: <Y7LfhB5IrLcFzPOi@zn.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.83]
X-ClientProxiedBy: EX13D28UWB001.ant.amazon.com (10.43.161.98) To
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


On 1/2/2023 3:43 PM, Borislav Petkov wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
>
>
>
> On Mon, Jan 02, 2023 at 02:17:24PM +0200, Shenhar, Talel wrote:
>> * We want to introduce driver that reads DDR controller RAS register and
>> notify for ECC errors by using EDAC MC API found in drivers/edac.
>> * We also want to have a capability to dynamically change DDR refresh rate
>> based on thermal values (best to be done in drivers/memory ?).
> Is there any particular reason to want to report the errors through EDAC?
>
> Or can't you simply read the RAS register in your memory driver and dump error
> info from there so that you have a single driver that does it all?

Doesn't it go against the MC EDAC concept...?

Reinventing the wheel is something that usually doesn't end well. (I 
could probably list them but guess that as the EDAC maintainer you can 
do it better than me :)  )

I would probably consider the other way around - take the refresh-rate 
driver inside the MC driver as the refresh-rate does not use any 
"memory" framework under drivers/memory.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
