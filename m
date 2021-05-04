Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B060372539
	for <lists+linux-edac@lfdr.de>; Tue,  4 May 2021 06:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhEDE6S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 May 2021 00:58:18 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:46269 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229724AbhEDE6S (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 May 2021 00:58:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 69C2F1CEF;
        Tue,  4 May 2021 00:57:23 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Tue, 04 May 2021 00:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=SsZnSIMoGPyH7u6t6vj4jPYRyQ5gfYi
        BhdMheE37CI8=; b=CyYE9dLZ48XgkfdVejydQeVfPPZ5IkyIXJZ2jgMVP2UObdh
        vXML/5aSrkZdRoqi3I19JIJ9Asp40be+yPRh0GuAfbrUCHKkTfiH7hi9It5GSOTO
        uvhx3SYEQJbZq5S6wr6SJNzxhpyaW5Xn3bTA6ZZUwTOhNEOeJmBouuby+EtJr2Hv
        +ccaqJcqT8aAiF+bsKjo+ymyr8v46mz6NBFk2aX1N0+bgxrHk+2zvUtsc8y81duu
        5o66kz0QpsYR7Td2cggnO91qijo7G4hTkG1xMZfHCJsUFqbx44jVBbxQNTNwFnyZ
        0oqEXgL0ypL1g7og4ygUMv4j/mywBah4uSUd7/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SsZnSI
        MoGPyH7u6t6vj4jPYRyQ5gfYiBhdMheE37CI8=; b=CE9RxnUrjtUnZC2LT1930B
        uCDXqKXShB8bX3WNw9LolnKOEf7EO4V48MkGrQ74+9J5atrAS0tKFXGK+/mQKb/e
        1qsIlxgyqvj/ANcx9R/wgZw24bkRSUs57i0kQkhAzEPHGn3BippwCSsTz4UXxaDs
        fCC/x7Gqh9mI7IyCBETdYEsghfMZ2nSex4ypbJsPEPWFBRe8bX0DXMqSPOKYcSmd
        HBh0aMa6OCVeLnpnWqrHCwk5neyWdQBLMrMdTBJP7kgwKR7oqXyvQsU5ZTDQ/V4a
        MbjzlnNU1zEthSsiL+VPN4Kyabc/4B6mYVTccHlkKgL+3Vo6LxLe/ftQ/j+zjlSQ
        ==
X-ME-Sender: <xms:MdSQYH58tcURsx7VerhqqNUz6xdqm7s9V0f4GK9AMHaQvDWL_cZoEQ>
    <xme:MdSQYM5RPYz4P7X-GybvBBxSjHxN91wgwgdqQvdjoQGXSXtAMsCKvOoV3KuzA_fnk
    pmGGAGOk1chSYj5Yw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefhedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepvefgvdevfeelfeejgeegfeevjeejhfdvtdeffeejgeetueelgfekudek
    teeiteejnecuffhomhgrihhnpehrshhtrdgttgdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegr
    jhdrihgurdgruh
X-ME-Proxy: <xmx:MdSQYOdA49JK3hy--HJlzc5JGuFU41tjBPPcyWXrN6C5cI381DecCA>
    <xmx:MdSQYIKY6WK6KCLto0aLEqwls8XdREFkgVMoCx8MI8EELEKaiLED9Q>
    <xmx:MdSQYLJ_loxPstTw4puNre7Edw_2b5OGPK_GiWWYq2DvnmNBzsDIsQ>
    <xmx:M9SQYC8xkJJAvEpOKcfM8bMy0jgEExp2xGQijjRLPdrxb0nz5Wy7Mny7TF0>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A20EA00079; Tue,  4 May 2021 00:57:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-442-g5daca166b9-fm-20210428.001-g5daca166
Mime-Version: 1.0
Message-Id: <e899781c-304c-4494-a544-e3950e928e55@www.fastmail.com>
In-Reply-To: <20210503163409.31944-1-rdunlap@infradead.org>
References: <20210503163409.31944-1-rdunlap@infradead.org>
Date:   Tue, 04 May 2021 14:27:01 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "kbuild test robot" <lkp@intel.com>, linux-aspeed@lists.ozlabs.org,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Stefan M Schaeckeler" <sschaeck@cisco.com>,
        "Borislav Petkov" <bp@suse.de>, linux-edac@vger.kernel.org,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH] EDAC: aspeed: print resource_size_t using %pa
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On Tue, 4 May 2021, at 02:04, Randy Dunlap wrote:
> Fix build warnings for using "%x" to print resource_size_t in 2 places.
> resource_size_t can be either of u32 or u64. We have a special format
> "%pa" for printing a resource_size_t, which is the same as a phys_addr_t.
> See Documentation/core-api/printk-formats.rst.
> 
>   CC      drivers/edac/aspeed_edac.o
> ../drivers/edac/aspeed_edac.c: In function 'init_csrows':
> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
> argument of type 'unsigned int', but argument 4 has type 
> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> ../drivers/edac/aspeed_edac.c:257:21: warning: format '%x' expects 
> argument of type 'unsigned int', but argument 5 has type 
> 'resource_size_t' {aka 'long long unsigned int'} [-Wformat=]
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
>   257 |  dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> 
> Fixes: 9b7e6242ee4e ("EDAC, aspeed: Add an Aspeed AST2500 EDAC driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Troy Lee <troy_lee@aspeedtech.com>
> Cc: Stefan Schaeckeler <sschaeck@cisco.com>
> Cc: linux-edac@vger.kernel.org
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: linux-aspeed@lists.ozlabs.org
> ---
> Found in linux-next but applies to mainline.

> 
>  drivers/edac/aspeed_edac.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- linux-next-20210503.orig/drivers/edac/aspeed_edac.c
> +++ linux-next-20210503/drivers/edac/aspeed_edac.c
> @@ -234,6 +234,7 @@ static int init_csrows(struct mem_ctl_in
>  	u32 nr_pages, dram_type;
>  	struct dimm_info *dimm;
>  	struct device_node *np;
> +	resource_size_t rsize;
>  	struct resource r;
>  	u32 reg04;
>  	int rc;
> @@ -254,11 +255,12 @@ static int init_csrows(struct mem_ctl_in
>  		return rc;
>  	}
>  
> -	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%x, resource_size=0x%x, PAGE_SHIFT macro=0x%x\n",
> -		r.start, resource_size(&r), PAGE_SHIFT);
> +	rsize = resource_size(&r);
> +	dev_dbg(mci->pdev, "dt: /memory node resources: first page 
> r.start=0x%pa, resource_size=0x%pa, PAGE_SHIFT macro=0x%x\n",
> +		&r.start, &rsize, PAGE_SHIFT);

Arnd posted a fix a few days back that feels more intuitive, though 
probably could have cleaned up the grammar:

https://lore.kernel.org/lkml/20210421135500.3518661-1-arnd@kernel.org/

Andrew
