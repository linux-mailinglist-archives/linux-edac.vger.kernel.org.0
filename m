Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F8711D37
	for <lists+linux-edac@lfdr.de>; Fri, 26 May 2023 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjEZB5p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 25 May 2023 21:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEZB5p (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 25 May 2023 21:57:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98789E7;
        Thu, 25 May 2023 18:57:43 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QS7H93JvJzqSSc;
        Fri, 26 May 2023 09:53:09 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 09:57:41 +0800
Message-ID: <76b50214-fcf8-37fe-47c9-cfcaf7517048@huawei.com>
Date:   Fri, 26 May 2023 09:57:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <jane.chu@oracle.com>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
 <5570c23a-3b12-6685-cb0b-29fc1d58f541@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <5570c23a-3b12-6685-cb0b-29fc1d58f541@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/5/26 1:18, Dave Hansen wrote:
> On 5/7/23 19:22, Kefeng Wang wrote:
>> Both EX_TYPE_FAULT_MCE_SAFE and EX_TYPE_DEFAULT_MCE_SAFE exception
>> fixup types are used to identify fixups which allow in kernel #MC
>> recovery, that is the Machine Check Safe Copy.
>>
>> For now, the MCE_IN_KERNEL_COPYIN flag is only set for EX_TYPE_COPY
>> and EX_TYPE_UACCESS when copy from user, and corrupted page is
>> isolated in this case, for MC-safe copy, memory_failure() is not
>> always called, some places, like __wp_page_copy_user, copy_subpage,
>> copy_user_gigantic_page and ksm_might_need_to_copy manually call
>> memory_failure_queue() to cope with such unhandled error pages,
>> recently coredump hwposion recovery support[1] is asked to do the
>> same thing, and there are some other already existed MC-safe copy
>> scenarios, eg, nvdimm, dm-writecache, dax, which has similar issue.
> 
> That has to set some kind of record for run-on sentences.  Could you
> please try to rewrite this coherently?
> 
>> The best way to fix them is set MCE_IN_KERNEL_COPYIN to MCE_SAFE
>> exception, then kill_me_never() will be queued to call memory_failure()
>> in do_machine_check() to isolate corrupted page, which avoid calling
>> memory_failure_queue() after every MC-safe copy return.
> 
> Could you try to send a v2 of this with a clear problem statement?
> 

:( will try to make it more clear.

> What is the end user visible effect of the problem and of your solution?

The corrupted page won't be isolated for MC-safe copy scenario, and it 
could be accessed again by use application.
