Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D45202372
	for <lists+linux-edac@lfdr.de>; Sat, 20 Jun 2020 13:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgFTL5f (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 20 Jun 2020 07:57:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59020 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727983AbgFTL5f (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 20 Jun 2020 07:57:35 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 63542E4FDC602A1B3583;
        Sat, 20 Jun 2020 19:57:33 +0800 (CST)
Received: from [10.166.214.20] (10.166.214.20) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sat, 20 Jun 2020 19:57:25 +0800
From:   lvying <lvying6@huawei.com>
Subject: Re: [PATCH 1/2] rasdaemon: add rbtree support for page record
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <guanyalong@huawei.com>,
        <wuyun.wu@huawei.com>, <tanxiaofei@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
 <1590740663-6664-2-git-send-email-lvying6@huawei.com>
 <20200529142433.1cdcb3c8@coco.lan>
Message-ID: <7c8263e8-0f8f-c4eb-ea20-100aabe24477@huawei.com>
Date:   Sat, 20 Jun 2020 19:57:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200529142433.1cdcb3c8@coco.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.214.20]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

>> diff --git a/Makefile.am b/Makefile.am
>> index 843b538..2ff742d 100644
>> --- a/Makefile.am
>> +++ b/Makefile.am
>> @@ -17,7 +17,7 @@ all-local: $(SYSTEMD_SERVICES)
>>   
>>   sbin_PROGRAMS = rasdaemon
>>   rasdaemon_SOURCES = rasdaemon.c ras-events.c ras-mc-handler.c \
>> -		    bitfield.c
>> +		    bitfield.c rbtree.c
> 
> I would move the change at Makefile.am to the next patch.
> 
> As I'll comment there, I'd like to have a separate configure
> option for each feature provided by the rasdaemon.
> 
> So, I would like to see something like:
> 
> 	if WITH_PG_RECORD
> 	   rasdaemon_SOURCES += rbtree.c ras-page-isolation.c
> 	endif
> 
> at the Makefile.am (after applying both patches)
> 
Ok, I will add a configure option(WITH_MEMORY_CE_PFA) to the 
configure.ac to isolate this feature. This modification will be moved to 
next patch.



-- 
Thanks!
Lv Ying
