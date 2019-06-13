Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB7C44842
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 19:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbfFMRGY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 13:06:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729676AbfFMRGY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 13:06:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDC54367;
        Thu, 13 Jun 2019 10:06:23 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 143DD3F694;
        Thu, 13 Jun 2019 10:06:22 -0700 (PDT)
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        Toshi Kani <toshi.kani@hpe.com>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
Date:   Thu, 13 Jun 2019 18:06:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612043410.GE32652@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Boris,

On 12/06/2019 05:34, Borislav Petkov wrote:
> On Wed, May 29, 2019 at 04:22:32PM +0100, James Morse wrote:
>> ghes_edac_report_mem_error() attempts to calculate the 'grain' or
>> granule affected by the error from the firmware-provided 'physical address
>> mask'. This mask tells us which bits of the physical address are valid.
>>
>> The current calculation:
>> | e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
>> will always cause the top bits to be set as they are cleared by &,
>> then set again by ~. For a hypervisor reporting its page-size as the
>> region affected by the error:
>> | {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
>> | {1}[Hardware Error]:   physical_address_mask: 0xfffffffffffff000
>> | {1}[Hardware Error]:   error_type: 6, master abort
>> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
>> | grain:-61441 syndrome:0x0 - status(0x0000000000000001): reserved)
>>
>> Here the grain has been miscalculated as the hypervisor reported a 4K
>> size granule, due to its page size, whereas the guest kernel uses 64K.
>> This gives us e->grain of 0xffffffffffff0fff
>>
>> Fix this, calculating grain_bits directly from ~physical_address_mask,
>> and setting e->grain from that. In the same example we now get:
>> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
>> | grain:4096 syndrome:0x0 - status(0x0000000000000001): reserved)


>> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
>> index 49396bf6ad88..fac96ff45b7e 100644
>> --- a/drivers/edac/ghes_edac.c
>> +++ b/drivers/edac/ghes_edac.c
>> @@ -202,8 +202,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  	struct mem_ctl_info *mci;
>>  	struct ghes_edac_pvt *pvt = ghes_pvt;
>>  	unsigned long flags;
>> +	u8 grain_bits = 0;
>>  	char *p;
>> -	u8 grain_bits;
>>  
>>  	if (!pvt)
>>  		return;
>> @@ -318,8 +318,10 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>>  	}
>>  
>>  	/* Error grain */
>> -	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
>> -		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
>> +	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK) {
>> +		grain_bits = fls_long(~mem_err->physical_addr_mask);
>> +		e->grain = 1UL<<grain_bits;
> 
> Do we need to set that e->grain at all?

edac_raw_mc_handle_error() prints it out,


> I mean, we set it now so that grain_bits can be computed but since
> you're doing that directly...

We could replace edac_raw_mc_handle_error()'s use of e->grain with e->grain_bits, which
would also make Robert's life easier when trying to merge those paths, but that's a more
invasive change.

I did did it like this to make it the minimum change if it was going as a fix. If we're
confident that no-one has-noticed/cared this can be papered over as part of Robert's
series, otherwise it will conflict.


Thanks,

James
