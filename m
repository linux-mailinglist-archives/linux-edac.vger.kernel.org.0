Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A0670B2C5
	for <lists+linux-edac@lfdr.de>; Mon, 22 May 2023 03:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjEVB04 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 21 May 2023 21:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjEVB0z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 21 May 2023 21:26:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37991C1;
        Sun, 21 May 2023 18:26:54 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QPfs215rWzLmGq;
        Mon, 22 May 2023 09:25:26 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 09:26:51 +0800
Message-ID: <75d8452c-695b-b22a-30d0-15302cd072ef@huawei.com>
Date:   Mon, 22 May 2023 09:26:50 +0800
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
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <SJ1PR11MB6083194699B63B199A2B5199FC7C9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org



On 2023/5/20 0:17, Luck, Tony wrote:
>> For now, the MCE_IN_KERNEL_COPYIN flag is only set for EX_TYPE_COPY
>> and EX_TYPE_UACCESS when copy from user, and corrupted page is
>> isolated in this case, for MC-safe copy, memory_failure() is not
>> always called, some places, like __wp_page_copy_user, copy_subpage,
>> copy_user_gigantic_page and ksm_might_need_to_copy manually call
>> memory_failure_queue() to cope with such unhandled error pages,
>> recently coredump hwposion recovery support[1] is asked to do the
>> same thing, and there are some other already existed MC-safe copy
>> scenarios, eg, nvdimm, dm-writecache, dax, which has similar issue.
>>
>> The best way to fix them is set MCE_IN_KERNEL_COPYIN to MCE_SAFE
>> exception, then kill_me_never() will be queued to call memory_failure()
>> in do_machine_check() to isolate corrupted page, which avoid calling
>> memory_failure_queue() after every MC-safe copy return.
>>
>> [1] https://lkml.kernel.org/r/20230417045323.11054-1-wangkefeng.wang@huawei.com
> 
> Is this patch in addition to, or instead of, the earlier core dump patch?

This is an addition, in previous coredump patch, manually call 
memory_failure_queue()
to be asked to cope with corrupted page, and it is similar to your
"Copy-on-write poison recovery"[1], but after some discussion, I think
we could add MCE_IN_KERNEL_COPYIN to all MC-safe copy, which will
cope with corrupted page in the core do_machine_check() instead of
do it one-by-one.

The related patch is
normal page CoW [1]
huge page CoW [2]
coredump [3]
ksm might copy [4]

[1] d302c2398ba2 ("mm, hwpoison: when copy-on-write hits poison, take 
page offline")
a873dfe1032a ("mm, hwpoison: try to recover from copy-on write faults")

[2] 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage 
copy-on-write faults")

[3] 245f09226893 ("mm: hwpoison: coredump: support recovery from 
dump_user_range()")

[4] 6b970599e807 ("mm: hwpoison: support recovery from 
ksm_might_need_to_copy()")

All of them are in v6.4-rc1.

Thanks.
Kefeng

> 
> I'd like to run some tests. Can you point me a the precise set of patches
> that I should apply please?
> 
> -Tony
>   
