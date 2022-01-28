Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309FF4A006F
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 19:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239575AbiA1SxJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 13:53:09 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:33944 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiA1SxI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 28 Jan 2022 13:53:08 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru B971D205E7BF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
To:     Borislav Petkov <bp@alien8.de>, Dinh Nguyen <dinguyen@kernel.org>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
 <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org> <YfQ3xUpLOPvDu5W+@zn.tnic>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <ba83ca78-6a15-caf5-71ba-76d5b2b1b41d@omp.ru>
Date:   Fri, 28 Jan 2022 21:53:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YfQ3xUpLOPvDu5W+@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 1/28/22 9:36 PM, Borislav Petkov wrote:

>>> The driver overrides the error codes returned by platform_get_irq() to
>>> -ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
>>> driver will fail the probe permanently instead of the deferred probing.
>>> Switch to propagating the error codes upstream.
>>>
>>> Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> ---
>>>   drivers/edac/altera_edac.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>>> index 3a6d2416cb0f..5dd29789f97d 100644
>>> --- a/drivers/edac/altera_edac.c
>>> +++ b/drivers/edac/altera_edac.c
>>> @@ -350,7 +350,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
>>>   	if (irq < 0) {
>>>   		edac_printk(KERN_ERR, EDAC_MC,
>>>   			    "No irq %d in DT\n", irq);
>>> -		return -ENODEV;
>>> +		return irq;
>>>   	}
>>>   	/* Arria10 has a 2nd IRQ */
>>
>>
>> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> 
> It sounds to me like we want this CC: stable@ too?

   I think the -stable people will pick it up based on the Fixes: tag. 

> If so, looking at
> 
>   2043727c2882 ("driver core: platform: Make use of the helper function dev_err_probe()")
> 
> that added that dev_err_probe() call, which was in Nov. 2021, which

   It didn't add anything new -- there was dev_err() there before that,
added by 7723f4c5ecdb8d832f049f8483beb0d1081cedf6.

> would mean, even if stable, only 5.15 and not in all stable trees
> judging by the Fixes: tag which is a patch from 3.17, i.e., 2014.
> 
> Right?

   Mmm, platfrom_get_irq() started to return errors long ago, no? 

MBR, Sergey
