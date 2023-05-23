Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3070D08C
	for <lists+linux-edac@lfdr.de>; Tue, 23 May 2023 03:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjEWBe6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 May 2023 21:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbjEWBey (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 May 2023 21:34:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A849B92;
        Mon, 22 May 2023 18:34:52 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QQGwG6MzRz18Ldb;
        Tue, 23 May 2023 09:30:22 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 09:34:49 +0800
Message-ID: <0d3aeb09-5bc9-31bd-4f84-675ebddd9f03@huawei.com>
Date:   Tue, 23 May 2023 09:34:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
 <d13b2730-bc20-3e32-a6c0-44c525ca9f0b@huawei.com>
 <SJ1PR11MB6083194699B63B199A2B5199FC7C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <75d8452c-695b-b22a-30d0-15302cd072ef@huawei.com>
 <SJ1PR11MB608309996658741A534D39D6FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <SJ1PR11MB608309996658741A534D39D6FC439@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/5/23 2:02, Luck, Tony wrote:
>>> Is this patch in addition to, or instead of, the earlier core dump patch?
>>
>> This is an addition, in previous coredump patch, manually call
>> memory_failure_queue()
>> to be asked to cope with corrupted page, and it is similar to your
>> "Copy-on-write poison recovery"[1], but after some discussion, I think
>> we could add MCE_IN_KERNEL_COPYIN to all MC-safe copy, which will
>> cope with corrupted page in the core do_machine_check() instead of
>> do it one-by-one.
> 
> Thanks for the context. I see how this all fits together now).
> 
> Your patch looks good.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Thanks for your confirm.

> 
> -Tony
> 
> One small observation from testing. I injected to an application which consumed
> the poisoned data and was sent a SIGBUS.
> 
> Kernel did not crash (hurrah!)

Yes, no crash is always great.

> 
> Console log said:
> 
> [  417.610930] mce: [Hardware Error]: Machine check events logged
> [  417.618372] Memory failure: 0x89167f: recovery action for dirty LRU page: Recovered
> ... EDAC messages
> [  423.666918] MCE: Killing testprog:4770 due to hardware memory corruption fault at 7f8eccf35000
> 
> A core file was generated and saved in /var/lib/systemd/coredump
> 
> But my shell (/bin/bash) only said:
> 
> Bus error
> 
> not
> 
> Bus error (core dumped)

No sure about the effect, but since there is kernel message and mcelog,
it seems that there is no big deal for the different :)

> 
> -Tony
>   
