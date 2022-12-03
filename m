Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BF4641336
	for <lists+linux-edac@lfdr.de>; Sat,  3 Dec 2022 03:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiLCCTi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Dec 2022 21:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiLCCTg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 2 Dec 2022 21:19:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DFA85F2;
        Fri,  2 Dec 2022 18:19:36 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NPD1D0QTWzqSfQ;
        Sat,  3 Dec 2022 10:15:28 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 3 Dec 2022 10:19:33 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com>
Date:   Sat, 3 Dec 2022 10:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022/12/2 22:44, Luck, Tony wrote:
>> When machine check exception occurs, there is no stack-dumping now in
>> mce_panic(). It's because bust_spinlocks(1) is called prematurely so
>> oops_in_progress will be >= 2 when trying to call dump_stack() in
>> panic(). Thus dump_stack() won't be called as this is considered as
>> nested stack-dumping.
> 

Many thanks for your quick reply. :)

> I had an earlier patch series to just dump from "interesting" machine checks
> (I think the interesting ones are when the kernel hit poison in code that hadn't
> been tagged in the extable as recoverable)
> 
> https://lore.kernel.org/all/20220922195136.54575-1-tony.luck@intel.com/

[1]

> 
> Discussion on that fizzled out.
> 
> Thanks for tracking down why panic() didn't provide a stack dump.
> 
> I'm still of the opinion that stack dumps from machine checks aren't
> generally useful. But I'd rather have extra stack dumps than no stack
> dumps at all.

As you mentioned in [1]:
"""
In order to ease the hunt for additional code flows where machine check
errors can be recovered it is useful to know, for example, why the
kernel was copying a page.
"""

So I think it's better to have at least one stack dumps. Also what the commit
6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops") and commit
026ee1f66aaa ("panic: fix stack dump print on direct call to panic()") want
to do is avoiding nested stack-dumping to have the original oops data being
scrolled away on a 80x50 screen but to have *at least one backtraces*. So
this patch acts more like a BUGFIX to ensure having at least one backtraces
in mce_panic(). What's your thought, Luck?

Thanks,
Miaohe Lin
