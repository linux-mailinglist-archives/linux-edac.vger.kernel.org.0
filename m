Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3F659417
	for <lists+linux-edac@lfdr.de>; Fri, 30 Dec 2022 02:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiL3B4u (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Dec 2022 20:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiL3B4s (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Dec 2022 20:56:48 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7611C04;
        Thu, 29 Dec 2022 17:56:47 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NjpHf0QJCzmWyC;
        Fri, 30 Dec 2022 09:55:26 +0800 (CST)
Received: from [10.174.151.185] (10.174.151.185) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 09:56:44 +0800
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
 <1e97c11d-99b6-c06f-b67f-c56ba6653d27@huawei.com> <Y62NVThhnGtnj71u@zn.tnic>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <276c9e6b-d647-6f7f-7bd1-c1f45ca23261@huawei.com>
Date:   Fri, 30 Dec 2022 09:56:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <Y62NVThhnGtnj71u@zn.tnic>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/12/29 20:51, Borislav Petkov wrote:
> On Thu, Dec 29, 2022 at 08:33:55PM +0800, Miaohe Lin wrote:
>> I think
> 
> You think or you know?

The problem code logic exists since that time.

> 
> I'm assuming reverting 6e6f0a1f0fa6 shows the MCE panic?

Yes, that's right.

> 
> I guess the original issue that commit was fixing is to save that
> redundant oops message but Tony seems to want to see it now and I'm not
> sure how much we care about 80x50 screens nowadays... :-)

80x50 screens should be really uncommon now. But avoiding redundant oops message
should always save our time. ;)

Thanks,
Miaohe Lin

