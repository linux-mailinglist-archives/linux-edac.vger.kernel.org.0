Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4CD70F501
	for <lists+linux-edac@lfdr.de>; Wed, 24 May 2023 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjEXLXl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 24 May 2023 07:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234708AbjEXLXk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 24 May 2023 07:23:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157518B;
        Wed, 24 May 2023 04:23:36 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QR80Z1wvvzLmG5;
        Wed, 24 May 2023 19:22:06 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 19:23:33 +0800
Message-ID: <c5107413-3714-8aef-fa24-c0f46d705d68@huawei.com>
Date:   Wed, 24 May 2023 19:23:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <jane.chu@oracle.com>
References: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230508022233.13890-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Hi x86/mm maintainers, could you pick this up as it has be reviewed
by Naoya and Tony, many thanks.

On 2023/5/8 10:22, Kefeng Wang wrote:
> Both EX_TYPE_FAULT_MCE_SAFE and EX_TYPE_DEFAULT_MCE_SAFE exception
> fixup types are used to identify fixups which allow in kernel #MC
> recovery, that is the Machine Check Safe Copy.
> 
> For now, the MCE_IN_KERNEL_COPYIN flag is only set for EX_TYPE_COPY
> and EX_TYPE_UACCESS when copy from user, and corrupted page is
> isolated in this case, for MC-safe copy, memory_failure() is not
> always called, some places, like __wp_page_copy_user, copy_subpage,
> copy_user_gigantic_page and ksm_might_need_to_copy manually call
> memory_failure_queue() to cope with such unhandled error pages,
> recently coredump hwposion recovery support[1] is asked to do the
> same thing, and there are some other already existed MC-safe copy
> scenarios, eg, nvdimm, dm-writecache, dax, which has similar issue.
> 
> The best way to fix them is set MCE_IN_KERNEL_COPYIN to MCE_SAFE
> exception, then kill_me_never() will be queued to call memory_failure()
> in do_machine_check() to isolate corrupted page, which avoid calling
> memory_failure_queue() after every MC-safe copy return.
> 
> [1] https://lkml.kernel.org/r/20230417045323.11054-1-wangkefeng.wang@huawei.com
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
