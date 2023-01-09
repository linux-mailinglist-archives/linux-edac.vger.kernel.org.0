Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826CC661EDF
	for <lists+linux-edac@lfdr.de>; Mon,  9 Jan 2023 07:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbjAIGzh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Jan 2023 01:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbjAIGzf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Jan 2023 01:55:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F012759;
        Sun,  8 Jan 2023 22:55:34 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Nr4RX0xFRznVDg;
        Mon,  9 Jan 2023 14:54:00 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 9 Jan 2023 14:54:58 +0800
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
 <c89697aa-64c4-d65f-5f65-aa94c1de7e29@huawei.com>
 <SJ1PR11MB60839243ADBEA755203CC352FCF99@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1e1bfb2a-5e20-626f-97f7-5ff4cf3d4d51@huawei.com>
 <SJ1PR11MB6083469C1A029CE6C121DF26FCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <44690ad8-1531-f6f3-9450-ef4d42ceec07@huawei.com>
Date:   Mon, 9 Jan 2023 14:54:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB6083469C1A029CE6C121DF26FCFE9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2023/1/9 12:45, Luck, Tony wrote:
>>> Maybe then I can look at some way to suppress the oops dump for the "useless"
>>> cases? Or perhaps at least add an extra message that stack dumps from arbitrary
>>> machine checks are rarely useful.
>>
>> IMHO the user will always expect a stack dump when system panic. I'm afraid that if these
>> "useless" cases are eliminated, it will cause user confused and trying to find what eats
>> the stack dump?
> 
> What about the "extra message" option?  Always print the full oops. but for ones from
> mce_panic() arrange somehow to add an extra bit of helpful text. Something like this:
> 
> 1) For poison consumption in kernel code:
> 
> "The reason for this panic is consumption of poisoned data by the kernel"
> 
> 2) For the general machine check case:
> 
> "The reason for this panic is a hardware detected error reported as a machine check.
>  Note that the stack and register dumps are likely useless to diagnose the root cause
>  of this panic."

It sounds like a good idea to me. Many thanks for your thought. And it's fine to squash my patch
to your provided thought. :)

Thanks,
Miaohe Lin
