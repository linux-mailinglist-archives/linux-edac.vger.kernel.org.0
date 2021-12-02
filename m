Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8A5466488
	for <lists+linux-edac@lfdr.de>; Thu,  2 Dec 2021 14:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbhLBNfz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 08:35:55 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:52426 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230492AbhLBNfy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Dec 2021 08:35:54 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UzAdFCh_1638451948;
Received: from 30.240.117.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UzAdFCh_1638451948)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 21:32:29 +0800
Message-ID: <1c4594ad-7477-9597-a627-21217f66a4f9@linux.alibaba.com>
Date:   Thu, 2 Dec 2021 21:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] edac,ghes,cper: Add device to Memory Error Record
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     mchehab@kernel.org, bp@alien8.de, james.morse@arm.com,
        rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com
References: <20211130131648.85860-1-xueshuai@linux.alibaba.com>
 <YaZ3yiIBRj6qIg2h@agluck-desk2.amr.corp.intel.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <YaZ3yiIBRj6qIg2h@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi, Tony,

> This looks OK (same as code in drivers/firmware/efi/cper.c in the
> cper_mem_err_location() function. But that makes me wonder why there
> is near duplication of code in ghes_edac.c?
May it is a legacy issue.


> The cper.c code seems to be written defensively using scnprintf()
> instead of sprintf().  Could ghes_edac share the same code?
I think so, ghes_edac_report_mem_error in ghes_edac.c is Long Method
and have Duplicated Code with cper_mem_err_location,
cper_dimm_err_location, and cper_mem_err_type_str in
drivers/firmware/efi/cper.c.

I will send a new patch to rework ghes_edac_report_mem_error.

Cheers
Shuai

On 2021/12/1 AM3:13, Luck, Tony wrote:
> On Tue, Nov 30, 2021 at 09:16:48PM +0800, Shuai Xue wrote:
>> If Bit 7 of Validation Bits is valid, the device number of the memory
>> associated with errors should be reported to Memory Error Record.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>  drivers/edac/ghes_edac.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index a918ca93e4f7..cf98b270d6f7 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -378,6 +378,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  	if (mem_err->validation_bits & CPER_MEM_VALID_BANK_ADDRESS)
>>  		p += sprintf(p, "bank_address:%d ",
>>  			     mem_err->bank & CPER_MEM_BANK_ADDRESS_MASK);
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_DEVICE)
>> +		p += sprintf(p, "device:%d ", mem_err->device);
>>  	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
>>  		u32 row = mem_err->row;
>>  
> 
> This looks OK (same as code in drivers/firmware/efi/cper.c in the
> cper_mem_err_location() function. But that makes me wonder why there
> is near duplication of code in ghes_edac.c?
> 
> The cper.c code seems to be written defensively using scnprintf()
> instead of sprintf().  Could ghes_edac share the same code?
> 
> -Tony
> 
