Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6A720D94
	for <lists+linux-edac@lfdr.de>; Sat,  3 Jun 2023 05:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFCDRO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Jun 2023 23:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFCDRM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Jun 2023 23:17:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E26ABD;
        Fri,  2 Jun 2023 20:17:11 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QY4fz02sYz18Lk5;
        Sat,  3 Jun 2023 11:12:27 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 11:17:08 +0800
Subject: Re: [PATCH] x86/mce: remove unused mce_vaddr
To:     Alison Schofield <alison.schofield@intel.com>
CC:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230528113545.650533-1-linmiaohe@huawei.com>
 <ZHZLjRPSYCOYjkBo@aschofie-mobl2>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6f36b268-0717-1bb4-6f78-53758a88c04a@huawei.com>
Date:   Sat, 3 Jun 2023 11:17:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <ZHZLjRPSYCOYjkBo@aschofie-mobl2>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2023/5/31 3:16, Alison Schofield wrote:
> On Sun, May 28, 2023 at 07:35:45PM +0800, Miaohe Lin wrote:
>> Since commit a6e3cf70b772 ("x86/mce: Change to not send SIGBUS error during
>> copy from user"), mce_vaddr is not used anymore. Remove it and clean up the
>> relevant code.
> 
> Hi Miaohe,
> 
> Not so sure that the 'clean up' part is useful. See below.
> 
> 
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  arch/x86/kernel/cpu/mce/severity.c | 7 +------
>>  include/linux/sched.h              | 1 -
>>  2 files changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
>> index c4477162c07d..0acc0039de81 100644
>> --- a/arch/x86/kernel/cpu/mce/severity.c
>> +++ b/arch/x86/kernel/cpu/mce/severity.c
>> @@ -252,12 +252,7 @@ static bool is_copy_from_user(struct pt_regs *regs)
>>  		return false;
>>  	}
>>  
>> -	if (fault_in_kernel_space(addr))
>> -		return false;
>> -
>> -	current->mce_vaddr = (void __user *)addr;
>> -
>> -	return true;
>> +	return !fault_in_kernel_space(addr);
>>  }
> 
> 
> Refactoring the return is unnecessary and seems less readable.
> How about removing the assignment, and leaving the rest, as is:
> 
> diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
> index c4477162c07d..1c03221ddcb1 100644
> --- a/arch/x86/kernel/cpu/mce/severity.c
> +++ b/arch/x86/kernel/cpu/mce/severity.c
> @@ -255,8 +255,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
>         if (fault_in_kernel_space(addr))
>                 return false;
>  
> -       current->mce_vaddr = (void __user *)addr;
> -
>         return true;
>  }
> 

Sounds good to me. Will do it in v2. Thanks for your advice.
