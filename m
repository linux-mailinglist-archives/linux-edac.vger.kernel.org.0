Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D874D9CB2
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 14:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348841AbiCON4l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240836AbiCON4l (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 09:56:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59F53E0A;
        Tue, 15 Mar 2022 06:55:28 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KHvyb6DSCzfZ2D;
        Tue, 15 Mar 2022 21:53:59 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Mar 2022 21:55:26 +0800
Subject: Re: [PATCH v2 2/3] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBICjloIDlj6Mg55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>,
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
 <8aa7cdd9-8104-2fea-879d-61519f6489d1@huawei.com>
 <20220314025034.GA3061370@hori.linux.bs1.fc.nec.co.jp>
 <219aeec6-5ff6-5101-8192-13b9f761e7c9@huawei.com>
 <20220314164510.acf6157930122583808375e1@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b4b1d52b-22e6-f97b-28c8-5922a859042b@huawei.com>
Date:   Tue, 15 Mar 2022 21:55:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220314164510.acf6157930122583808375e1@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 2022/3/15 7:45, Andrew Morton wrote:
> On Mon, 14 Mar 2022 10:59:40 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> On 2022/3/14 10:50, HORIGUCHI NAOYA(堀口 直也) wrote:
>>> On Mon, Mar 14, 2022 at 09:58:49AM +0800, Miaohe Lin wrote:
>>>> On 2022/3/14 7:41, HORIGUCHI NAOYA(堀口 直也) wrote:
>>>>> On Sat, Mar 12, 2022 at 03:46:12PM +0800, Miaohe Lin wrote:
>>>>>> Since commit 042c4f32323b ("mm/truncate: Inline invalidate_complete_page()
>>>>>
>>>>> This commit ID does not exist in mainline (or in the latest mmotm?),
>>>>> so you can't use it in patch description.  Could you update this part?
>>>>>
>>>>
>>>> This commit is in the mmotm but not in mainline yet:
>>>>
>>>> commit 042c4f32323beb28146c658202d3e69899e4f245
>>>> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> Date:   Sat Feb 12 15:27:42 2022 -0500
>>>>
>>>>     mm/truncate: Inline invalidate_complete_page() into its one caller
>>>>
>>>>     invalidate_inode_page() is the only caller of invalidate_complete_page()
>>>>     and inlining it reveals that the first check is unnecessary (because we
>>>>     hold the page locked, and we just retrieved the mapping from the page).
>>>>     Actually, it does make a difference, in that tail pages no longer fail
>>>>     at this check, so it's now possible to remove a tail page from a mapping.
>>>>
>>>>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>>>>     Reviewed-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>> Am I "not" supposed to use this commit id as it's not "stable" now?
>>>
>>> No, it's not stable yet. In whatever way you get the above commit (I guess
>>> you get it from https://github.com/hnaz/linux-mm), all acked mm-related
>>> patches are sent to Linus by Andrew *by email*, so the eventual commit IDs
>>> should be determined when they are applied to mainline.
>>>
>>
>> Many thanks for your explanation. (I get this commit id from linux-next tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git)
>> So I should remember always to get the commit id from mainline.
> 
> It's likely that this commit ID will be the same once Matthew's patch
> goes into mainline.
> 
> But this is why we include the patch title ("mm/truncate: Inline ...")
> when identifying commits.  Sometimes stuff happens...

I remember I used the stale commit id once in my past patch. I made
this mistake again. Sorry about it. :(

> .
> 

