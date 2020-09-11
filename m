Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64281265B15
	for <lists+linux-edac@lfdr.de>; Fri, 11 Sep 2020 10:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKIFv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Sep 2020 04:05:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbgIKIFq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 11 Sep 2020 04:05:46 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8762F3D7A56EBE70361F;
        Fri, 11 Sep 2020 16:05:42 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.16) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 16:05:41 +0800
Subject: Re: [PATCH] EDAC/mc_sysfs: add missing newlines when printing
 'max(dimm)_location'
To:     Borislav Petkov <bp@alien8.de>
CC:     <mchehab@kernel.org>, <tony.luck@intel.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1599207563-41819-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200910110012.GD8357@zn.tnic>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <ab222053-d4e5-eb0b-a7a3-e8158cac1b88@huawei.com>
Date:   Fri, 11 Sep 2020 16:05:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200910110012.GD8357@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2020/9/10 19:00, Borislav Petkov wrote:
> On Fri, Sep 04, 2020 at 04:19:23PM +0800, Xiongfeng Wang wrote:
>> When I cat 'max_location' and 'dimm_location' by sysfs, it displays as
>> follows. It's better to add a newline for easy reading.
>>
>> [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
>> memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
>> memory 0 [root@localhost /]#
> 
> Please use this commit message for your next version:
> 
> EDAC/mc_sysfs: Add missing newlines when printing {max,dimm}_location
> 
> Reading those sysfs entries gives:
> 
>   [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/max_location
>   memory 3 [root@localhost /]# cat /sys/devices/system/edac/mc/mc0/dimm0/dimm_location
>   memory 0 [root@localhost /]#
> 
> Add newlines after the value it prints for better readability.

Thanks for your advice. I will add it in the next version.

> 
>> @@ -821,6 +825,7 @@ static ssize_t mci_max_location_show(struct device *dev,
>>  			     edac_layer_name[mci->layers[i].type],
>>  			     mci->layers[i].size - 1);
>>  	}
>> +	p += sprintf(p, "\n");
> 
> No size checking here?

I can check if it's larger than PAGE_SIZE.

Thanks,
Xiongfeng

> 

