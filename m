Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B63D31A319F
	for <lists+linux-edac@lfdr.de>; Thu,  9 Apr 2020 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgDIJP7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Apr 2020 05:15:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59188 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIJP7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Apr 2020 05:15:59 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8A1E04C48F3BE4C6B697;
        Thu,  9 Apr 2020 17:15:55 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.195) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 17:15:53 +0800
Subject: Re: [PATCH] EDAC, xgene: remove set but not used 'address'
To:     Robert Richter <rrichter@marvell.com>
CC:     <khuong@os.amperecomputing.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200409085237.46642-1-yanaijie@huawei.com>
 <20200409091016.d3uohmt2o3zwhmro@rric.localdomain>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1185c697-026d-74c9-3f67-e95bebdc4c00@huawei.com>
Date:   Thu, 9 Apr 2020 17:15:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200409091016.d3uohmt2o3zwhmro@rric.localdomain>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.195]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



在 2020/4/9 17:10, Robert Richter 写道:
> On 09.04.20 16:52:37, Jason Yan wrote:
>> Fix the following gcc warning:
>>
>> drivers/edac/xgene_edac.c:1486:7: warning: variable ‘address’ set but
>> not used [-Wunused-but-set-variable]
>>     u32 address;
>>         ^~~~~~~
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/edac/xgene_edac.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
>> index e4a1032ba0b5..e5e0fbdeca29 100644
>> --- a/drivers/edac/xgene_edac.c
>> +++ b/drivers/edac/xgene_edac.c
>> @@ -1483,13 +1483,11 @@ static void xgene_edac_rb_report(struct edac_device_ctl_info *edac_dev)
>>   		return;
>>   	if (reg & STICKYERR_MASK) {
>>   		bool write;
>> -		u32 address;
>>   
>>   		dev_err(edac_dev->dev, "IOB bus access error(s)\n");
>>   		if (regmap_read(ctx->edac->rb_map, RBEIR, &reg))
>>   			return;
>>   		write = reg & WRITE_ACCESS_MASK ? 1 : 0;
>> -		address = RBERRADDR_RD(reg);
> 
> Please also remove that unused macro.
> 

OK, thanks.

Jason

> Thanks,
> 
> -Robert
> 
>>   		if (reg & AGENT_OFFLINE_ERR_MASK)
>>   			dev_err(edac_dev->dev,
>>   				"IOB bus %s access to offline agent error\n",
>> -- 
>> 2.17.2
>>
> 

