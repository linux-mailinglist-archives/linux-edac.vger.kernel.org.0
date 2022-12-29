Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D572F658CBB
	for <lists+linux-edac@lfdr.de>; Thu, 29 Dec 2022 13:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiL2MeO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 07:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiL2MeI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 07:34:08 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7B21054C;
        Thu, 29 Dec 2022 04:33:58 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NjSTY2XcQzJqRk;
        Thu, 29 Dec 2022 20:32:49 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 29 Dec 2022 20:33:55 +0800
Subject: Re: [PATCH] mce: fix missing stack-dumping in mce_panic()
To:     Borislav Petkov <bp@alien8.de>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
References: <20221202163728.392509-1-linmiaohe@huawei.com>
 <SJ1PR11MB60830CE8C3F79C9531C8567AFC179@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <5cf492bf-9807-a091-6ac2-a953fce276da@huawei.com> <Y61/+V47qH/8OVxp@zn.tnic>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com>
Date:   Thu, 29 Dec 2022 20:33:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y61/+V47qH/8OVxp@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/12/29 19:54, Borislav Petkov wrote:
> On Sat, Dec 03, 2022 at 10:19:32AM +0800, Miaohe Lin wrote:
>> So I think it's better to have at least one stack dumps. Also what the commit
>> 6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops") and commit
>> 026ee1f66aaa ("panic: fix stack dump print on direct call to panic()") want
>> to do is avoiding nested stack-dumping to have the original oops data being
>> scrolled away on a 80x50 screen but to have *at least one backtraces*. So
>> this patch acts more like a BUGFIX to ensure having at least one backtraces
>> in mce_panic().
> 

Many thanks for your reply. :)

> So which commit broke this?
> 

I think it should be Fixes: 6e6f0a1f0fa6 ("panic: don't print redundant backtraces on oops")
as there's missing stack-dumping in mce_panic() since then. Should I resend the patch with
above Fixes tag attached?

> One of the two above or
> 
> 004429956b48 ("handle recursive calls to bust_spinlocks()")
> 
> or
> 
> d896a940ef4f ("x86, mce: remove oops_begin() use in 64bit machine check")
> 
> or...?
> 
> By looking at their dates, they're pretty much too old so that this can
> go to *all* stable kernels.

Yes, it should be a really old problem. And it seems it's unnoticed yet because mce should be a
really rare event and corresponding dump-stacking might not be that attractive at that time.

Thanks!
Miaohe Lin

