Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518CC3957EA
	for <lists+linux-edac@lfdr.de>; Mon, 31 May 2021 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhEaJRi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 May 2021 05:17:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2798 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhEaJRh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 31 May 2021 05:17:37 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FtqKJ0XYDzWq51;
        Mon, 31 May 2021 17:11:16 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 17:15:56 +0800
Received: from [127.0.0.1] (10.174.177.72) by dggpemm500006.china.huawei.com
 (7.185.36.236) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 31 May
 2021 17:15:55 +0800
Subject: Re: [PATCH 1/1] EDAC, mpc85xx: Fix error return code in two functions
To:     Borislav Petkov <bp@alien8.de>
CC:     Johannes Thumshirn <morbidrsa@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Doug Thompson <dougthompson@xmission.com>,
        Dave Jiang <djiang@mvista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210528032637.9231-1-thunder.leizhen@huawei.com>
 <YLSg/8REPQoX8HL7@zn.tnic>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <daec460d-754c-d904-f81c-91bdfaccefad@huawei.com>
Date:   Mon, 31 May 2021 17:15:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <YLSg/8REPQoX8HL7@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2021/5/31 16:40, Borislav Petkov wrote:
> On Fri, May 28, 2021 at 11:26:37AM +0800, Zhen Lei wrote:
>> Fix to return -EFAULT from the error handling case instead of 0, as done
>> elsewhere in its function.
>>
>> Fixes: a9a753d53204 ("drivers-edac: add freescale mpc85xx driver")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/edac/mpc85xx_edac.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
>> index 67f7bc3fe5b3..b2eaa62c9412 100644
>> --- a/drivers/edac/mpc85xx_edac.c
>> +++ b/drivers/edac/mpc85xx_edac.c
>> @@ -248,6 +248,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
>>  
>>  	if (edac_pci_add_device(pci, pdata->edac_idx) > 0) {
>>  		edac_dbg(3, "failed edac_pci_add_device()\n");
>> +		res = -EFAULT;
> 
>>  		goto err;
>>  	}
>>  
>> @@ -552,6 +553,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
>>  
>>  	if (edac_device_add_device(edac_dev) > 0) {
>>  		edac_dbg(3, "failed edac_device_add_device()\n");
>> +		res = -EFAULT;
>>  		goto err;
>>  	}
>>  
>> -- 
> 
> EFAULT means
> 
> #define EFAULT          14      /* Bad address */
> 
> Does it make sense to you when the probe function returns a "bad
> address" upon failure to add a device?
> 
> hint 1: you might wanna audit how the other drivers are calling this for
> better ideas.

So how about change to -ENODEV?

> 
> hint 2: while doing hint 1, you might find some more broken cases which
> you could fix too.

OK, I will find and fix all of them. Thanks for your hint.

> 
> Thx.
> 

