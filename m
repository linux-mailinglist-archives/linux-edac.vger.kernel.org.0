Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C77C660BF1
	for <lists+linux-edac@lfdr.de>; Sat,  7 Jan 2023 03:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjAGC1G (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Jan 2023 21:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGC1F (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Jan 2023 21:27:05 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38F3E0C3;
        Fri,  6 Jan 2023 18:27:02 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NpkWk0CjkzJq5H;
        Sat,  7 Jan 2023 10:22:58 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 10:27:00 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
 <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
 <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
 <SJ1PR11MB608346981E53D14BF37788FCFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <c89697aa-64c4-d65f-5f65-aa94c1de7e29@huawei.com>
Date:   Sat, 7 Jan 2023 10:27:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB608346981E53D14BF37788FCFCFB9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2023/1/7 1:42, Luck, Tony wrote:
>> Agree. A stack dump won't be helpful in this case. But I tend to keep the stack dump in case
>> it would be helpful and also make mce_panic() dumps the stack as expected. What do you think?
> 
> My #1 preference is to just get stack dumps from machine checks where the cause is known
> to be poison consumption by the kernel.
> 
> Patches to do this were posted in September 2022
> 
> https://lore.kernel.org/all/20220922195136.54575-1-tony.luck@intel.com/

[1]

> 
> Boris has applied part 1 (which was a cleanup). But discussion on part 2
> centered around why mce_panic() wasn't giving a full OOPs dump. That's
> now understood.
> 

Many thanks for your valuable information. [1] uses MCE_PANIC_STACKDUMP_SEVERITY to
pick the preferred ones and do a stack dump manually. But now stack dumps is done
via panic(), it seems there's no easy way to achieve #1 preference.

> 
> If I can't get my first preference ... then a stack dump for every machine check
> is better than no stack dumps at all. So a patch that enables the OOPs dump
> would be a good second choice.
> 
> I don't want to stick with the current behavior of no stack dumps.

As a first step, let's change the current behavior of no stack dumps first? And then,
we could try to achieve #1 preference if possible.

Thanks,
Miaohe Lin
