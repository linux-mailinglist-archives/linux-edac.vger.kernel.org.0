Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD30E657677
	for <lists+linux-edac@lfdr.de>; Wed, 28 Dec 2022 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiL1MeU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Dec 2022 07:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiL1Mdi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Dec 2022 07:33:38 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A7910553;
        Wed, 28 Dec 2022 04:33:33 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NhrSM4T6qz9t2Y;
        Wed, 28 Dec 2022 20:29:39 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 28 Dec 2022 20:33:32 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <bp@alien8.de>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Luck <tony.luck@intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <470ffd37-3f65-7ad1-71cb-a1d4547d8afa@huawei.com>
Message-ID: <8e91609c-2130-8acd-37c9-88277ea9ae39@huawei.com>
Date:   Wed, 28 Dec 2022 20:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <470ffd37-3f65-7ad1-71cb-a1d4547d8afa@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022/12/10 10:28, Miaohe Lin wrote:
> On 2022/12/3 0:37, Miaohe Lin wrote:
>> When machine check exception occurs, there is no stack-dumping now in
>> mce_panic(). It's because bust_spinlocks(1) is called prematurely so
>> oops_in_progress will be >= 2 when trying to call dump_stack() in
>> panic(). Thus dump_stack() won't be called as this is considered as
>> nested stack-dumping.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Friendly ping. ;)

Friendly ping after busy merge window. :)

> 
>> ---
>>  arch/x86/kernel/cpu/mce/core.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index 2c8ec5c71712..c40dad1a6749 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -254,7 +254,6 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>>  			wait_for_panic();
>>  		barrier();
>>  
>> -		bust_spinlocks(1);
>>  		console_verbose();
>>  	} else {
>>  		/* Don't log too much for fake panic */
>>
> 

