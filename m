Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C04D7935
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 02:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiCNCAB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 13 Mar 2022 22:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCNCAB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 13 Mar 2022 22:00:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC82019E;
        Sun, 13 Mar 2022 18:58:51 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KH02C0TBDz1GCQ7;
        Mon, 14 Mar 2022 09:53:55 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 14 Mar 2022 09:58:49 +0800
Subject: Re: [PATCH v2 2/3] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
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
 <20220312074613.4798-3-linmiaohe@huawei.com>
 <20220313234157.GB3010057@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8aa7cdd9-8104-2fea-879d-61519f6489d1@huawei.com>
Date:   Mon, 14 Mar 2022 09:58:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220313234157.GB3010057@hori.linux.bs1.fc.nec.co.jp>
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
> On Sat, Mar 12, 2022 at 03:46:12PM +0800, Miaohe Lin wrote:
>> Since commit 042c4f32323b ("mm/truncate: Inline invalidate_complete_page()
> 
> This commit ID does not exist in mainline (or in the latest mmotm?),
> so you can't use it in patch description.  Could you update this part?
> 

This commit is in the mmotm but not in mainline yet:

commit 042c4f32323beb28146c658202d3e69899e4f245
Author: Matthew Wilcox (Oracle) <willy@infradead.org>
Date:   Sat Feb 12 15:27:42 2022 -0500

    mm/truncate: Inline invalidate_complete_page() into its one caller

    invalidate_inode_page() is the only caller of invalidate_complete_page()
    and inlining it reveals that the first check is unnecessary (because we
    hold the page locked, and we just retrieved the mapping from the page).
    Actually, it does make a difference, in that tail pages no longer fail
    at this check, so it's now possible to remove a tail page from a mapping.

    Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
    Reviewed-by: John Hubbard <jhubbard@nvidia.com>
    Reviewed-by: Christoph Hellwig <hch@lst.de>


Am I "not" supposed to use this commit id as it's not "stable" now?

Will update this part in next version. Many thanks.

> Thanks,
> Naoya Horiguchi
> 
>> into its one caller"), invalidate_inode_page() can invalidate the pages in
>> the swap cache because the check of page->mapping != mapping is removed.
>> But invalidate_inode_page() is not expected to deal with the pages in swap
>> cache. Also non-lru movable page can reach here too. They're not page cache
>> pages. Skip these pages by checking PageSwapCache and PageLRU.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/memory-failure.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index dabecd87ad3f..2ff7dd2078c4 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2190,7 +2190,7 @@ static int __soft_offline_page(struct page *page)
>>  		return 0;
>>  	}
>>  
>> -	if (!PageHuge(page))
>> +	if (!PageHuge(page) && PageLRU(page) && !PageSwapCache(page))
>>  		/*
>>  		 * Try to invalidate first. This should work for
>>  		 * non dirty unmapped page cache pages.
>> -- 
>> 2.23.0

