Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1175975B39
	for <lists+linux-edac@lfdr.de>; Fri, 26 Jul 2019 01:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfGYX1E (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 Jul 2019 19:27:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:56731 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfGYX1D (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 25 Jul 2019 19:27:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2019 16:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,308,1559545200"; 
   d="scan'208";a="194036500"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2019 16:27:03 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2] EDAC, altera: Move Stratix10 SDRAM ECC to peripheral
To:     James Morse <james.morse@arm.com>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1562956123-23640-1-git-send-email-thor.thayer@linux.intel.com>
 <eb7a1e75-2de9-cb60-bf8f-77cd1e71255f@arm.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <e88c9dd7-13af-4696-c5c1-653aaa13e805@linux.intel.com>
Date:   Thu, 25 Jul 2019 18:29:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <eb7a1e75-2de9-cb60-bf8f-77cd1e71255f@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

On 7/25/19 7:46 AM, James Morse wrote:
> Hi Thor,
> 
> On 12/07/2019 19:28, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> ARM32 SoCFPGAs had separate IRQs for SDRAM. ARM64 SoCFPGAs
>> send all DBEs to SError so filtering by source is necessary.
>>
>> The Stratix10 SDRAM ECC is a better match with the generic
>> Altera peripheral ECC framework because the linked list can
>> be searched to find the ECC block offset and printout
>> the DBE Address.
> 
> 
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index c2e693e34d43..09a80b53acea 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
> 
>> @@ -2231,13 +2275,15 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
>>   		    of_device_is_compatible(child, "altr,socfpga-dma-ecc") ||
>>   		    of_device_is_compatible(child, "altr,socfpga-usb-ecc") ||
>>   		    of_device_is_compatible(child, "altr,socfpga-qspi-ecc") ||
>> +#ifdef CONFIG_EDAC_ALTERA_SDRAM
>> +		    of_device_is_compatible(child, "altr,sdram-edac-s10") ||
>> +#endif
>>   		    of_device_is_compatible(child, "altr,socfpga-sdmmc-ecc"))
> 
> I'm just curious: This list looks suspiciously like the altr_edac_a10_device_of_match[]
> list. Is there a reason it can't use of_match_device() here?
> 
Good point. Yes, it does look very much like the match list. Although 
of_match_device() doesn't fit with the available parameters (device 
pointer), your question prompted me to look closer and I noticed 
of_match_node() is perfect.

I'll create a version 3 with this change.

Thanks for reviewing!

>>   
>>   			altr_edac_a10_device_add(edac, child);
>>   
>>   #ifdef CONFIG_EDAC_ALTERA_SDRAM
>> -		else if ((of_device_is_compatible(child, "altr,sdram-edac-a10")) ||
>> -			 (of_device_is_compatible(child, "altr,sdram-edac-s10")))
>> +		else if (of_device_is_compatible(child, "altr,sdram-edac-a10"))
>>   			of_platform_populate(pdev->dev.of_node,
>>   					     altr_sdram_ctrl_of_match,
>>   					     NULL, &pdev->dev);
> 
> 
> Acked-by: James Morse <james.morse@arm.com>
> 
> 
> Thanks,
> 
> James
> 

