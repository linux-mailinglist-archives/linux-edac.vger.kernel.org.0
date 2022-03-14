Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12084D7926
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 02:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiCNBw2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 21:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiCNBw1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 21:52:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732861BEBF;
        Sun, 13 Mar 2022 18:51:17 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KGzxT0WnwzfYyq;
        Mon, 14 Mar 2022 09:49:49 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 09:51:14 +0800
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
 <20220312074613.4798-2-linmiaohe@huawei.com>
 <20220313234100.GA3010057@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <86d13611-dcd2-7c1b-eed8-28f9349f6201@huawei.com>
Date:   Mon, 14 Mar 2022 09:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220313234100.GA3010057@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2022/3/14 7:41, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, Mar 12, 2022 at 03:46:11PM +0800, Miaohe Lin wrote:
>> There is a race window where we got the compound_head, the hugetlb page
>> could be freed to buddy, or even changed to another compound page just
>> before we try to get hwpoison page. Think about the below race window:
>>   CPU 1					  CPU 2
>>   memory_failure_hugetlb
>>   struct page *head = compound_head(p);
>> 					  hugetlb page might be freed to
>> 					  buddy, or even changed to another
>> 					  compound page.
>>
>>   get_hwpoison_page -- page is not what we want now...
>>
>> If this race happens, just bail out. Also MF_MSG_DIFFERENT_PAGE_SIZE is
>> introduced to record this event.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  include/linux/mm.h      |  1 +
>>  include/ras/ras_event.h |  1 +
>>  mm/memory-failure.c     | 12 ++++++++++++
>>  3 files changed, 14 insertions(+)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index c9bada4096ac..ef98cff2b253 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3253,6 +3253,7 @@ enum mf_action_page_type {
>>  	MF_MSG_BUDDY,
>>  	MF_MSG_DAX,
>>  	MF_MSG_UNSPLIT_THP,
>> +	MF_MSG_DIFFERENT_PAGE_SIZE,
>>  	MF_MSG_UNKNOWN,
>>  };
>>  
>> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
>> index d0337a41141c..1e694fd239b9 100644
>> --- a/include/ras/ras_event.h
>> +++ b/include/ras/ras_event.h
>> @@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
>>  	EM ( MF_MSG_BUDDY, "free buddy page" )				\
>>  	EM ( MF_MSG_DAX, "dax page" )					\
>>  	EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )			\
>> +	EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )	\
>>  	EMe ( MF_MSG_UNKNOWN, "unknown page" )
>>  
>>  /*
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 5444a8ef4867..dabecd87ad3f 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -733,6 +733,7 @@ static const char * const action_page_types[] = {
>>  	[MF_MSG_BUDDY]			= "free buddy page",
>>  	[MF_MSG_DAX]			= "dax page",
>>  	[MF_MSG_UNSPLIT_THP]		= "unsplit thp",
>> +	[MF_MSG_DIFFERENT_PAGE_SIZE]	= "different page size",
>>  	[MF_MSG_UNKNOWN]		= "unknown page",
>>  };
>>  
>> @@ -1534,6 +1535,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
>>  	}
>>  
>>  	lock_page(head);
>> +
>> +	/**
> 
> This comment section starting with '/**' is considered as kernel-doc comment,
> maybe that's not expected because it just describes an implementation detail.
> So normal comment section with '/*' would be better.
> 

I see. Will change to use "/*".

> Otherwise, looks good to me.
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Many thanks for review and comment.

> 
>> +	 * The page could have changed compound pages due to race window.
>> +	 * If this happens just bail out.
>> +	 */
>> +	if (!PageHuge(p) || compound_head(p) != head) {
>> +		action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
>> +		res = -EBUSY;
>> +		goto out;
>> +	}
>> +
>>  	page_flags = head->flags;
>>  
>>  	if (hwpoison_filter(p)) {
>> -- 
>> 2.23.0

