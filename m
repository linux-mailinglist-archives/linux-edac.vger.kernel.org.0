Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13DF65F952
	for <lists+linux-edac@lfdr.de>; Fri,  6 Jan 2023 02:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjAFB5S (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 5 Jan 2023 20:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjAFB5R (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 5 Jan 2023 20:57:17 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0C13D75;
        Thu,  5 Jan 2023 17:57:15 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Np5z35QDhzJrFL;
        Fri,  6 Jan 2023 09:55:59 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 09:57:12 +0800
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
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b63056f9-0709-736b-ea5b-5e903410cb1d@huawei.com>
Date:   Fri, 6 Jan 2023 09:57:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <SJ1PR11MB60831AB2202FF0C3CF99EF1DFCF49@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2023/1/4 5:12, Luck, Tony wrote:
>>> I guess the original issue that commit was fixing is to save that
>>> redundant oops message but Tony seems to want to see it now and I'm not
>>> sure how much we care about 80x50 screens nowadays... :-)
> 

Many thanks for your thought. :)

> I want a stack dump for the specific case of a recoverable machine check caused by
> poison consumption in kernel code that doesn't have an extable[] entry for a recovery
> path. That's a potential candidate for future kernel change to make that recoverable

Sure, in this case a stack dump will be really helpful. We can gather these stack dumps
and try to make the most frequent machine check scene recoverable.

> (if the code path seems common enough to warrant the churn), and there is some
> plausible way for s/w to "recover").
> 
> For most other machine checks the dump is very likely useless. E.g. some CPU core stalled
> so that the system generates a broadcast machine check because instructions are not
> being retired on that CPU core. In this case the machine check "monarch" is almost certainly
> some innocent bystander that was executing normally. Stack dump from that CPU is going
> to tell you nothing about the machine check.

Agree. A stack dump won't be helpful in this case. But I tend to keep the stack dump in case
it would be helpful and also make mce_panic() dumps the stack as expected. What do you think?

Thanks,
Miaohe Lin
