Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01937254B
	for <lists+linux-edac@lfdr.de>; Tue,  4 May 2021 07:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhEDFJI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 May 2021 01:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhEDFJH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 May 2021 01:09:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB1C061574;
        Mon,  3 May 2021 22:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=/l3ME+YyFSdYbM3W3a/AxJLnYEq4c0HL5DB1Few+tsY=; b=fnIuE8Usqiz+a4CZLKnOkXfjVJ
        L1km8jYZPUtgQgMylkarrD2aaff0nMK2iBLrcye228unywIpAk28B6ZRcp+n/0j5rIgXtKLrXrzhu
        9zFLC1afNQX2M+mCCRPoqQ/ujWWgiB85ACOVoji/gIzTvvtlQQEX1ashC0STdrMwE1s9OqskC6IBB
        GzQ97qD1RHNTxqpNq+7Vu38eN5uEP0zL0OLsdTsDZA8Sd3kM8XqO3oFBefCWmI0DYBWxYZnWPbSM5
        vEWAYh4teTS/J6fCCSuPTx9hCFbYqvOOSj/vAMjckWZvALOOUeEOXu/G+CxR/Bc0+ti3H6bi/Zej6
        D2EiXx0Q==;
Received: from [2601:1c0:6280:3f0::df68]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldnHp-00G88E-81; Tue, 04 May 2021 05:08:00 +0000
Subject: Re: [PATCH] EDAC: aspeed: print resource_size_t using %pa
To:     Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>, linux-aspeed@lists.ozlabs.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Stefan M Schaeckeler <sschaeck@cisco.com>,
        Borislav Petkov <bp@suse.de>, linux-edac@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>
References: <20210503163409.31944-1-rdunlap@infradead.org>
 <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <892dfd15-a8f7-9db9-86bb-9630e88e0e3c@infradead.org>
Date:   Mon, 3 May 2021 22:07:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 5/3/21 9:57 PM, Andrew Jeffery wrote:
> 
> 
> On Tue, 4 May 2021, at 02:04, Randy Dunlap wrote:
>> Fix build warnings for using "%x" to print resource_size_t in 2 places.
>> resource_size_t can be either of u32 or u64. We have a special format
>> "%pa" for printing a resource_size_t, which is the same as a phys_addr_t.
>> See Documentation/core-api/printk-formats.rst.
>>
>>   CC      drivers/edac/aspeed_edac.o
>> ../drivers/edac/aspeed_edac.c: In function 'init_csrows':
>> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
>> argument of type 'unsigned int', but argument 4 has type 
>> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
>> argument of type 'unsigned int', but argument 5 has type 
>> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>>
>> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Cc: Stefan Schaeckeler <sschaeck@cisco.com>
>> Cc: linux-edac@vger.kernel.org
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: linux-aspeed@lists.ozlabs.org
>> ---
>> Found in linux-next but applies to mainline.
> 
>>
>>  drivers/edac/aspeed_edac.c |    8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20210503.orig/drivers/edac/aspeed_edac.c
>> +++ linux-next-20210503/drivers/edac/aspeed_edac.c
>> @@ -234,6 +234,7 @@ static int init_csrows(struct mem_ctl_in
>>  	u32 nr_pages, dram_type;
>>  	struct dimm_info *dimm;
>>  	struct device_node *np;
>> +	resource_size_t rsize;
>>  	struct resource r;
>>  	u32 reg04;
>>  	int rc;
>> @@ -254,11 +255,12 @@ static int init_csrows(struct mem_ctl_in
>>  		return rc;
>>  	}
>>  
>> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>> -		r.start, resource_size(&r), PAGE_SHIFT);
>> +	rsize = resource_size(&r);
>> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
>> r.start=0x%pa, resource_size=0x%pa, PAGE_SHIFT macro=0x%x\n",
>> +		&r.start, &rsize, PAGE_SHIFT);
> 
> Arnd posted a fix a few days back that feels more intuitive, though 
> probably could have cleaned up the grammar:
> 
> https://lore.kernel.org/lkml/20210421135500.3518661-1-arnd@kernel.org/

Oh, that's fine. I just missed it. :(

thanks.
-- 
~Randy

