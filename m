Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1306BBBF9
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 21:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfIWTCP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 15:02:15 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:22927 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfIWTCM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 Sep 2019 15:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1569265331; x=1600801331;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=edoxei+VeoQ0qZS0KuVRC+9conUDklvtkXU0Qp38ebA=;
  b=lFZYtP9T4DGTzqWCraEsJicJ+k1KcbAVCY5Tg0a8ltl8lmtJ+nBjxqUD
   ASHQP3Rav2ui/Tt0rw1eckTEGRqQANqMH9OG89d88QATBXVUnVJtKhBDp
   hVyaO4bL2QFeoyK2S6a5nqmPB16MmUnuvjqDBAYX0FzyjnmrlLvjY0L3B
   g=;
X-IronPort-AV: E=Sophos;i="5.64,541,1559520000"; 
   d="scan'208";a="786840485"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Sep 2019 19:01:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id B5B15A20B7;
        Mon, 23 Sep 2019 19:01:45 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:01:44 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Sep 2019 19:01:43 +0000
Received: from [10.85.96.103] (10.85.96.103) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Sep 2019 19:01:40 +0000
Subject: Re: [PATCH v3 1/2] edac: Add an API for edac device to report for
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
References: <20190919171713.8060-1-hhhawa@amazon.com>
 <20190919171713.8060-2-hhhawa@amazon.com>
 <20190920064155.f3xeqzobiud5hvxf@rric.localdomain>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <3d607fc4-73a1-cde7-51bf-31d807b1f438@amazon.com>
Date:   Mon, 23 Sep 2019 22:01:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920064155.f3xeqzobiud5hvxf@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 9/20/2019 9:42 AM, Robert Richter wrote:
> On 19.09.19 18:17:12, Hanna Hawa wrote:
>> Add an API for EDAC device to report multiple errors with same type.
>>
>> Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
> 
> With the change below it looks good to me:
> 
> Acked-by: Robert Richter <rrichter@marvell.com>

Thanks

> 
> Thanks,
> 
> -Robert
> 
>> ---
>>   drivers/edac/edac_device.c | 62 ++++++++++++++++++++++++++------------
>>   drivers/edac/edac_device.h | 40 ++++++++++++++++++++++++
>>   2 files changed, 82 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/edac/edac_device.c b/drivers/edac/edac_device.c
>> index 65cf2b9355c4..866934f2bcb0 100644
>> --- a/drivers/edac/edac_device.c
>> +++ b/drivers/edac/edac_device.c
>> @@ -555,12 +555,16 @@ static inline int edac_device_get_panic_on_ue(struct edac_device_ctl_info
>>   	return edac_dev->panic_on_ue;
>>   }
>>   
>> -void edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> -			int inst_nr, int block_nr, const char *msg)
>> +void __edac_device_handle_ce(struct edac_device_ctl_info *edac_dev,
>> +			     unsigned int count, int inst_nr, int block_nr,
>> +			     const char *msg)
>>   {
>>   	struct edac_device_instance *instance;
>>   	struct edac_device_block *block = NULL;
>>   
>> +	if (!count)
>> +		return;
>> +
> 
> Those checks should be moved to the *_count() variants of both
> functions.

Will be moved to the inline functions.

> 
> [...]
> 
>> +static inline void edac_device_handle_ce_count(struct edac_device_ctl_info *edac_dev,
>> +					       unsigned int count, int inst_nr,
>> +					       int block_nr, const char *msg)
>> +{
> 
> 	if (count)
> 		...
> 
>> +	__edac_device_handle_ce(edac_dev, count, inst_nr, block_nr, msg);
>> +}
>> +
>> +static inline void edac_device_handle_ue_count(struct edac_device_ctl_info *edac_dev,
>> +					       unsigned int count, int inst_nr,
>> +					       int block_nr, const char *msg)
>> +{
> 
> Here too.
> 
>> +	__edac_device_handle_ue(edac_dev, count, inst_nr, block_nr, msg);
>> +}

Thanks,
Hanna
