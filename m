Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B0BBBBF5
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbfIWTBb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:01:31 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:43357 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfIWTBb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Sep 2019 15:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569265290; x=1600801290;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=yVPjcoNicqfT+qIZ1pcZCZib/k3G0SANGz5ufDaKTSs=;
  b=kcF0FIbAjUv7UmqXIu0+tcaTbhga/AJT25pdg1CMUCmEiq7sjNWsJDxD
   ilNwRGbtL9C8EPPzQtHdyk5xz8wPpd1Nu5++/EsjCAtMrXVY4o3jSiFjV
   cxBTCMiMk5wpOjwfV06c5malcy/4/fTFgEBpduFrFziQAvqW/U7oelnzu
   8=;
X-IronPort-AV: E=Sophos;i="5.64,541,1559520000"; 
   d="scan'208";a="752652630"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 23 Sep 2019 19:01:28 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 3511BA2BCD;
        Mon, 23 Sep 2019 19:01:25 +0000 (UTC)
Received: from EX13D21UWA001.ant.amazon.com (10.43.160.154) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:01:25 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D21UWA001.ant.amazon.com (10.43.160.154) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:01:25 +0000
Received: from [10.85.96.103] (10.85.96.103) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Sep 2019 19:01:21 +0000
Subject: Re: [PATCH v3 2/2] edac: move edac_device_handle_*() API functions to
 header
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
References: <20190919171713.8060-1-hhhawa@amazon.com>
 <20190919171713.8060-3-hhhawa@amazon.com>
 <20190920064937.owwv5n663kwmnbb7@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <b0442e2c-a7c7-cbfc-9b0a-24b97d1356c9@amazon.com>
Date:   Mon, 23 Sep 2019 22:01:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920064937.owwv5n663kwmnbb7@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/20/2019 9:49 AM, Robert Richter wrote:
> On 19.09.19 18:17:13, Hanna Hawa wrote:
>> Move edac_device_handle_*() functions from source file to header file as
>> inline funtcion that use the new API with single error.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> 
> With the changes below it looks good to me:
> 
> Acked-by: Robert Richter <rrichter@marvell.com>
> 
> Thanks,
> 
> -Robert
> 
>> diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
>> index 30dc5f5979c8..796ea134a691 100644
>> --- a/drivers/edac/edac_device.h
>> +++ b/drivers/edac/edac_device.h
>> @@ -285,29 +285,6 @@ extern int edac_device_add_device(struct edac_device_ctl_info *edac_dev);
>>    */
>>   extern struct edac_device_ctl_info *edac_device_del_device(struct device *dev);
>>   
>> -/**
>> - * edac_device_handle_ue():
>> - *	perform a common output and handling of an 'edac_dev' UE event
>> - *
>> - * @edac_dev: pointer to struct &edac_device_ctl_info
>> - * @inst_nr: number of the instance where the UE error happened
>> - * @block_nr: number of the block where the UE error happened
>> - * @msg: message to be printed
>> - */
>> -extern void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> -				int inst_nr, int block_nr, const char *msg);
>> -/**
>> - * edac_device_handle_ce():
>> - *	perform a common output and handling of an 'edac_dev' CE event
>> - *
>> - * @edac_dev: pointer to struct &edac_device_ctl_info
>> - * @inst_nr: number of the instance where the CE error happened
>> - * @block_nr: number of the block where the CE error happened
>> - * @msg: message to be printed
>> - */
>> -extern void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> -				int inst_nr, int block_nr, const char *msg);
>> -
> 
> Just put in the inline replacement here.

I'll re-arrange the functions in patches 1/2 and put the 
*edac_device_handle_* functions here instead of end of file.

> 
>>   /**
>>    * edac_device_alloc_index: Allocate a unique device index number
>>    *
>> @@ -357,4 +334,18 @@ static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac
>>   {
>>   	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
>>   }
>> +
>> +static inline void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +					 int inst_nr, int block_nr,
> 
> No need for this linebreak.

It'll be more than 80 characters.

> 
>> +					 const char *msg)
>> +{
>> +	__edac_device_handle_ce(edac_dev, 1, inst_nr, block_nr, msg);
>> +}
>> +
>> +static inline void edac_device_handle_ue(struct edac_device_ctl_info *edac_dev,
>> +					 int inst_nr, int block_nr,
> 
> Same here.
> 
>> +					 const char *msg)
>> +{
>> +	__edac_device_handle_ue(edac_dev, 1, inst_nr, block_nr, msg);
>> +}
>>   #endif
>> -- 
>> 2.17.1
>>
