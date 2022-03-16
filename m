Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491CE4DACB0
	for <lists+linux-edac@lfdr.de>; Wed, 16 Mar 2022 09:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354618AbiCPIm6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354628AbiCPImv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 04:42:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EEB64BD7;
        Wed, 16 Mar 2022 01:41:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJNsx5W84z1GCPY;
        Wed, 16 Mar 2022 16:36:37 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:41:35 +0800
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     Yang Shi <shy828301@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
 <91661cd4-e9be-959f-8b6a-da257a00a879@oracle.com>
 <9826152a-8a83-76a8-ded8-47d185aac0a8@huawei.com>
 <CAHbLzkrg=nQGm=sLnYriZJNZ3QznW5_Ktx6x7cWzV+9QJnRE4w@mail.gmail.com>
 <a3a2ee10-95a5-6624-7846-54e21319c444@huawei.com>
 <20220316083046.GB3840907@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dbb50d2a-214b-000f-00c7-1678a24dfdaf@huawei.com>
Date:   Wed, 16 Mar 2022 16:41:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220316083046.GB3840907@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022/3/16 16:30, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Wed, Mar 16, 2022 at 04:18:30PM +0800, Miaohe Lin wrote:
>> On 2022/3/16 2:19, Yang Shi wrote:
>>> On Tue, Mar 15, 2022 at 7:19 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> ...
>>>>
>>>>
>>>> Many thanks for comment.
>>>> I assume that Naoya's patch "mm/hwpoison: set PageHWPoison after taking page lock
>>>> in memory_failure_hugetlb()" would set the PageHWPoison after the above check.
>>>> So I think the below operation is not needed as PageHWPoison is not set yet.
>>>> Does this makes sense for you?
>>>
>>> I'm wondering if it might be better and helpful for review to squash
>>> this patch with Naoya's patch together? It seems we always missed the
>>> other part when reviewing the patches.
>>>
>>
>> Sounds like a good idea. This would make the reviewer's life easier. I'm fine if
>> this patch is squashed into Naoya's patch altogether. But we might have to consult
>> the opinion from Naoya.
> 
> I'm fine with the squashing, so I'll send v4.

Many thanks for doing this.

So I'll send v3 later to fix the "stale commit id" in the commit log of the [PATCH v2 2/3]
mm/memory-failure.c: avoid calling invalidate_inode_page() with unexpected pages.

Thanks.

> 
> Thanks,
> Naoya Horiguchi
> 

