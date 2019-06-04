Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F8F34E86
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 19:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFDRPy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 13:15:54 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48372 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbfFDRPy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 13:15:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A091780D;
        Tue,  4 Jun 2019 10:15:53 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A7C43F5AF;
        Tue,  4 Jun 2019 10:15:52 -0700 (PDT)
Subject: Re: [PATCH 11/21] EDAC, ghes: Unify trace_mc_event() code with
 edac_mc driver
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-12-rrichter@marvell.com>
 <37d47356-a40b-2739-10df-f5ab83fa2b36@arm.com>
 <20190603131005.e23lovwyvii53vzo@rric.localdomain>
From:   James Morse <james.morse@arm.com>
Message-ID: <1fac170a-f461-a779-9e82-5b4a0fa2c154@arm.com>
Date:   Tue, 4 Jun 2019 18:15:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603131005.e23lovwyvii53vzo@rric.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 03/06/2019 14:10, Robert Richter wrote:
> On 29.05.19 16:12:38, James Morse wrote:
>> On 29/05/2019 09:44, Robert Richter wrote:
>>> Almost duplicate code, remove it.
>>
>>> Note: there is a difference in the calculation of the grain_bits,
>>> using the edac_mc's version here.
>>
>> But is it the right thing to do?
>>
>> Is this an off-by-one bug being papered over as some cleanup?
>> If so could you post a separate fix that can be picked up for an rc.
>>
>> Do Marvell have firmware that populates this field?
>>
>> ...
>>
>> Unless the argument is no one cares about this...
>>
>> >From ghes_edac_report_mem_error():
>> |	/* Error grain */
>> |	if (mem_err->validation_bits & CPER_MEM_VALID_PA_MASK)
>> |		e->grain = ~(mem_err->physical_addr_mask & ~PAGE_MASK);
>>
>> Fishy, why would the kernel page-size be relevant here?
> 
> That looked broken to me too, I did not put to much effort in fixing
> the grain yet. So I just took the edac_mc version first in the
> assumption, that one is working.

(Ah, it would have been good to note this in the commit-message)


> It looks like the intention here is to limit the grain to the page
> size.
I'm not convinced that makes sense. If some architecture let you configure the page-size,
(as arm64 does), and your hypervisor had a bigger page-size, then any hardware fault would
be rounded up to hypervisor's page-size.

The kernel's page-size has very little to do with the error, it only matters for when we
go unmapping stuff in memory_failure().


> But right, the calculation is wrong here. I am also going to
> reply to your patch you sent on this.

Thanks!


>> If physical_addr_mask were the same as PAGE_MASK this wouldn't this always give ~0?
>> (masking logic like this always does my head in)
>>
>> /me gives it ago:
>> | {1}[Hardware Error]:   physical_address: 0x00000000deadbeef
>> | {1}[Hardware Error]:   physical_address_mask: 0xffffffffffff0000
>> | {1}[Hardware Error]:   error_type: 6, master abort
>> | EDAC MC0: 1 CE Master abort on unknown label ( page:0xdead offset:0xbeef
>> | grain:-1 syndrome:0x0 - status(0x0000000000000001): reserved)
>>
>> That 'grain:-1' is because the calculated e->grain was an unlikely 0xffffffffffffffff.
>> Patch incoming, if you could test it on your platform that'd be great.
>>
>> I don't think ghes_edac.c wants this '+1'.
> 
> The +1 looks odd to me also for the edac_mc driver, but I need to take
> a closer look here as well as some logs suggest the grain is
> calculated correctly.

My theory on this is that ghes_edac.c is generating a grain like 0x1000, fls() does the
right thing. Other edac drivers are generating a grain like 0xfff to describe the same
size, fls() is now off-by-one, hence the addition.
I don't have a platform where I can trigger any other edac driver to test this though.

The way round this would be to put the grain_bits in struct edac_raw_error_desc so that
ghes_edac.c can calculate it directly.


Thanks,

James
