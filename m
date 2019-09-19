Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C8EB73FD
	for <lists+linux-edac@lfdr.de>; Thu, 19 Sep 2019 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbfISHYb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Sep 2019 03:24:31 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:33808 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbfISHYa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Sep 2019 03:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568877870; x=1600413870;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=cDQXeztJkbOYpb7Pna6W7vbY9Ot8FUoLg5+7af6dXbA=;
  b=g1bytpOZZL7etmGnh/hBhv3Ex3J9YCVfk0oQCHnicKvP9bxd9FrA6tbS
   u1yN6f76FRyYjy9fZMbxkZ1TkwC/9PJTPhV23JEa36OcKrVXs0rzySHS0
   pmghMsDvC4x5I4EzO7nUzU2UufjHQRmfO7c76lNsO+EjRN05pCUmkFQG+
   g=;
X-IronPort-AV: E=Sophos;i="5.64,522,1559520000"; 
   d="scan'208";a="751550593"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Sep 2019 07:24:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 4F66CA208D;
        Thu, 19 Sep 2019 07:24:27 +0000 (UTC)
Received: from EX13D13UWB001.ant.amazon.com (10.43.161.156) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 07:24:27 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB001.ant.amazon.com (10.43.161.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 19 Sep 2019 07:24:26 +0000
Received: from [10.107.3.20] (10.107.3.20) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Thu, 19 Sep 2019 07:24:23 +0000
Subject: Re: [PATCH v2 1/2] edac: Add an API for edac device to report for
 multiple errors
To:     Robert Richter <rrichter@marvell.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>,
        "benh@amazon.com" <benh@amazon.com>,
        "ronenk@amazon.com" <ronenk@amazon.com>,
        "talel@amazon.com" <talel@amazon.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "hanochu@amazon.com" <hanochu@amazon.com>
References: <20190912145305.21008-1-hhhawa@amazon.com>
 <20190912145305.21008-2-hhhawa@amazon.com>
 <20190919063334.x2rfk33swyjqur3q@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <722df1dd-b91b-bf65-b398-3e3d6ab3a59b@amazon.com>
Date:   Thu, 19 Sep 2019 10:24:21 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190919063334.x2rfk33swyjqur3q@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/19/2019 9:33 AM, Robert Richter wrote:
> On 12.09.19 15:53:04, Hanna Hawa wrote:
>> Add an API for EDAC device to report multiple errors with same type.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
>> ---
>>   drivers/edac/edac_device.c | 91 ++++++++++++++++++++++++++++++++++++++
>>   drivers/edac/edac_device.h | 40 +++++++++++++++++
>>   2 files changed, 131 insertions(+)
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index 65cf2b9355c4..78ac44103acc 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -643,3 +643,94 @@ void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>>   			block ? block->name : "N/A", msg);
>>   }
>>   EXPORT_SYMBOL_GPL(edac_device_handle_ue);
>> +
>> +void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +			     unsigned int count, int inst_nr, int block_nr,
>> +			     const char *msg)
>> +{
> 
> Please do not add a copy here, instead modify the existing function
> and share the code with both, old and new functions.

Will be fixed.

> 
> Thanks,
> 
> -Robert
> 
