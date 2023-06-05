Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F5E72239E
	for <lists+linux-edac@lfdr.de>; Mon,  5 Jun 2023 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFEKfN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 5 Jun 2023 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjFEKex (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 5 Jun 2023 06:34:53 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B55F2;
        Mon,  5 Jun 2023 03:34:35 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QZVLC1G74zLmVv;
        Mon,  5 Jun 2023 18:32:51 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 18:34:31 +0800
Message-ID: <772e9939-47e4-3c09-d7a0-7952639ad853@huawei.com>
Date:   Mon, 5 Jun 2023 18:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2] x86/mce: set MCE_IN_KERNEL_COPYIN for all MC-Safe Copy
To:     Borislav Petkov <bp@alien8.de>, "Luck, Tony" <tony.luck@intel.com>
CC:     "Song, Youquan" <youquan.song@intel.com>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "chu, jane" <jane.chu@oracle.com>
References: <20230526063242.133656-1-wangkefeng.wang@huawei.com>
 <20230526070952.GAZHBbQNAWZJP6tOXv@nazgul.local>
 <e816734d-e6f5-b990-c86d-ac7d5f1c94c0@huawei.com>
 <fa272c15-9f7c-df9c-41dd-bffc19acbf85@huawei.com>
 <SJ1PR11MB6083343FF74CAB54FC2B916AFC4EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230602160138.GDZHoSYsWoPAinMszk@fat_crate.local>
Content-Language: en-US
In-Reply-To: <20230602160138.GDZHoSYsWoPAinMszk@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2023/6/3 0:01, Borislav Petkov wrote:
> On Fri, Jun 02, 2023 at 03:12:30PM +0000, Luck, Tony wrote:
>>> As mentioned above, I am focus on copy_mc_XXX calling, it will
>>> abort if the exception fires when accessing the source, and we
>>> want to isolate the corrupted src page, maybe we could a new flag
>>> to indicate this scenario, the *Final Goals* is to let core
>>> do_machine_check to deal with the corrupted src page.
>>
>> A new flag seems like a good direction.
> 
> Before anything happens here, the fate of the now unused EX_TYPE_COPY
> needs to be decided first. Then new stuff.

EX_TYPE_COPY is actually not related EX_TYPE_DEFAULT_MCE_SAFE, but we 
could recheck it again, it seems that mce recover from copy from user
is broken now. Maybe change _ASM_EXTABLE_UA to _ASM_EXTABLE_CPY in
copy_user_64.S again as commit[1] did before.

Thank you for the advice.

[1] 278b917f8cb9 x86/mce: Add _ASM_EXTABLE_CPY for copy user access


> 
> Thx.
> 
