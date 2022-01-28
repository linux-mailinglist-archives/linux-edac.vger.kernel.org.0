Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993394A0095
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 20:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350700AbiA1TCs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 14:02:48 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:34250 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiA1TCs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Jan 2022 14:02:48 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 3A01720747D5
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
 <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org> <YfQ3xUpLOPvDu5W+@zn.tnic>
 <ba83ca78-6a15-caf5-71ba-76d5b2b1b41d@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9f28d2de-5119-a7a6-9da7-08b2ce13f1a0@omp.ru>
Date:   Fri, 28 Jan 2022 22:02:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <ba83ca78-6a15-caf5-71ba-76d5b2b1b41d@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/28/22 9:53 PM, Sergey Shtylyov wrote:

>>>> The driver overrides the error codes returned by platform_get_irq() to
>>>> -ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
>>>> driver will fail the probe permanently instead of the deferred probing.
>>>> Switch to propagating the error codes upstream.
>>>>
>>>> Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
>>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>> ---
>>>>   drivers/edac/altera_edac.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>>>> index 3a6d2416cb0f..5dd29789f97d 100644
>>>> --- a/drivers/edac/altera_edac.c
>>>> +++ b/drivers/edac/altera_edac.c
>>>> @@ -350,7 +350,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
>>>>   	if (irq < 0) {
>>>>   		edac_printk(KERN_ERR, EDAC_MC,
>>>>   			    "No irq %d in DT\n", irq);
>>>> -		return -ENODEV;
>>>> +		return irq;
>>>>   	}
>>>>   	/* Arria10 has a 2nd IRQ */
>>>
>>>
>>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
>>
>> It sounds to me like we want this CC: stable@ too?
> 
>    I think the -stable people will pick it up based on the Fixes: tag. 
> 
>> If so, looking at
>>
>>   2043727c2882 ("driver core: platform: Make use of the helper function dev_err_probe()")
>>
>> that added that dev_err_probe() call, which was in Nov. 2021, which
> 
>    It didn't add anything new -- there was dev_err() there before that,
> added by 7723f4c5ecdb8d832f049f8483beb0d1081cedf6.
> 
>> would mean, even if stable, only 5.15 and not in all stable trees
>> judging by the Fixes: tag which is a patch from 3.17, i.e., 2014.
>>
>> Right?
> 
>    Mmm, platfrom_get_irq() started to return errors long ago, no? 

   Ah, you were wondering about returing -EPROBE_DEFER? It started to be returned
by the commit 9ec36cafe43bf835f8f29273597a5b0cbc8267ef several months before that...

MBR, Sergey
