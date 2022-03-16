Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3714DAC54
	for <lists+linux-edac@lfdr.de>; Wed, 16 Mar 2022 09:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354473AbiCPITt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Mar 2022 04:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347658AbiCPITs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 16 Mar 2022 04:19:48 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64433C48D;
        Wed, 16 Mar 2022 01:18:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJNMK5x1Wz1GCWr;
        Wed, 16 Mar 2022 16:13:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Mar 2022 16:18:31 +0800
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
To:     Yang Shi <shy828301@gmail.com>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
 <91661cd4-e9be-959f-8b6a-da257a00a879@oracle.com>
 <9826152a-8a83-76a8-ded8-47d185aac0a8@huawei.com>
 <CAHbLzkrg=nQGm=sLnYriZJNZ3QznW5_Ktx6x7cWzV+9QJnRE4w@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a3a2ee10-95a5-6624-7846-54e21319c444@huawei.com>
Date:   Wed, 16 Mar 2022 16:18:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHbLzkrg=nQGm=sLnYriZJNZ3QznW5_Ktx6x7cWzV+9QJnRE4w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

On 2022/3/16 2:19, Yang Shi wrote:
> On Tue, Mar 15, 2022 at 7:19 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> On 2022/3/15 2:20, Mike Kravetz wrote:
>>> On 3/11/22 23:46, Miaohe Lin wrote:
>>>> There is a race window where we got the compound_head, the hugetlb page
>>>> could be freed to buddy, or even changed to another compound page just
>>>> before we try to get hwpoison page. Think about the below race window:
>>>>   CPU 1                                        CPU 2
>>>>   memory_failure_hugetlb
>>>>   struct page *head = compound_head(p);
>>>>                                        hugetlb page might be freed to
>>>>                                        buddy, or even changed to another
>>>>                                        compound page.
>>>>
>>>>   get_hwpoison_page -- page is not what we want now...
>>>>
>>>> If this race happens, just bail out. Also MF_MSG_DIFFERENT_PAGE_SIZE is
>>>> introduced to record this event.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> ---
>>>>  include/linux/mm.h      |  1 +
>>>>  include/ras/ras_event.h |  1 +
>>>>  mm/memory-failure.c     | 12 ++++++++++++
>>>>  3 files changed, 14 insertions(+)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index c9bada4096ac..ef98cff2b253 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -3253,6 +3253,7 @@ enum mf_action_page_type {
>>>>      MF_MSG_BUDDY,
>>>>      MF_MSG_DAX,
>>>>      MF_MSG_UNSPLIT_THP,
>>>> +    MF_MSG_DIFFERENT_PAGE_SIZE,
>>>>      MF_MSG_UNKNOWN,
>>>>  };
>>>>
>>>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>>>> index d0337a41141c..1e694fd239b9 100644
>>>> --- a/include/ras/ras_event.h
>>>> +++ b/include/ras/ras_event.h
>>>> @@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
>>>>      EM ( MF_MSG_BUDDY, "free buddy page" )                          \
>>>>      EM ( MF_MSG_DAX, "dax page" )                                   \
>>>>      EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
>>>> +    EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )        \
>>>>      EMe ( MF_MSG_UNKNOWN, "unknown page" )
>>>>
>>>>  /*
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 5444a8ef4867..dabecd87ad3f 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -733,6 +733,7 @@ static const char * const action_page_types[] = {
>>>>      [MF_MSG_BUDDY]                  = "free buddy page",
>>>>      [MF_MSG_DAX]                    = "dax page",
>>>>      [MF_MSG_UNSPLIT_THP]            = "unsplit thp",
>>>> +    [MF_MSG_DIFFERENT_PAGE_SIZE]    = "different page size",
>>>>      [MF_MSG_UNKNOWN]                = "unknown page",
>>>>  };
>>>>
>>>> @@ -1534,6 +1535,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>>>      }
>>>>
>>>>      lock_page(head);
>>>> +
>>>> +    /**
>>>> +     * The page could have changed compound pages due to race window.
>>>> +     * If this happens just bail out.
>>>> +     */
>>>> +    if (!PageHuge(p) || compound_head(p) != head) {
>>>> +            action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
>>>> +            res = -EBUSY;
>>>
>>> We have discussed this race in other versions of the patch.  When we encounter
>>> the race, we have likely marked poison on the wrong page.  Correct?
>>>
>>
>> Many thanks for comment.
>> I assume that Naoya's patch "mm/hwpoison: set PageHWPoison after taking page lock
>> in memory_failure_hugetlb()" would set the PageHWPoison after the above check.
>> So I think the below operation is not needed as PageHWPoison is not set yet.
>> Does this makes sense for you?
> 
> I'm wondering if it might be better and helpful for review to squash
> this patch with Naoya's patch together? It seems we always missed the
> other part when reviewing the patches.
> 

Sounds like a good idea. This would make the reviewer's life easier. I'm fine if
this patch is squashed into Naoya's patch altogether. But we might have to consult
the opinion from Naoya.

Thanks.

>>
>> Thanks.
>>
>>> Instead of printing a "different page size", would it be better to perhaps:
>>> - Print a message that wrong page may be marked for poison?
>>> - Clear the poison flag in the "head page" previously set?
>>>
>>
> .
> 

