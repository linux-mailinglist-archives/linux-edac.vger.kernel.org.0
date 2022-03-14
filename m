Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712F44D908E
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 00:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiCNXqY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 19:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237573AbiCNXqX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 19:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B023150B;
        Mon, 14 Mar 2022 16:45:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 695BE61496;
        Mon, 14 Mar 2022 23:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77506C340E9;
        Mon, 14 Mar 2022 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647301511;
        bh=Ju1DAPlgw5FMTla0jTg/jmHE1lxJHJq05Tdwhdan2zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mOxloHx09cAsu6h0FKCFCiYZ5LpSNzc3AOEJI2K7Vmi8GcHtOOB9OWytTJCfQXMYL
         +jcxJFn60wOin2XjByEPaMvqw3VIYp9Hk+pSuJaYOJoyg6TKZ+byey1CwtrMkk5QgW
         38ZGi7NjNUsz4mCXhYjRJtw2+D/WLeJKVBf2a1Ac=
Date:   Mon, 14 Mar 2022 16:45:10 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     HORIGUCHI =?UTF-8?B?TkFPWUE=?= (=?UTF-8?B?5aCA5Y+jIOebtOS5nw==?=) 
        <naoya.horiguchi@nec.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mm/memory-failure.c: avoid calling
 invalidate_inode_page() with unexpected pages
Message-Id: <20220314164510.acf6157930122583808375e1@linux-foundation.org>
In-Reply-To: <219aeec6-5ff6-5101-8192-13b9f761e7c9@huawei.com>
References: <20220312074613.4798-1-linmiaohe@huawei.com>
        <20220312074613.4798-3-linmiaohe@huawei.com>
        <20220313234157.GB3010057@hori.linux.bs1.fc.nec.co.jp>
        <8aa7cdd9-8104-2fea-879d-61519f6489d1@huawei.com>
        <20220314025034.GA3061370@hori.linux.bs1.fc.nec.co.jp>
        <219aeec6-5ff6-5101-8192-13b9f761e7c9@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 14 Mar 2022 10:59:40 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/3/14 10:50, HORIGUCHI NAOYA(堀口 直也) wrote:
> > On Mon, Mar 14, 2022 at 09:58:49AM +0800, Miaohe Lin wrote:
> >> On 2022/3/14 7:41, HORIGUCHI NAOYA(堀口 直也) wrote:
> >>> On Sat, Mar 12, 2022 at 03:46:12PM +0800, Miaohe Lin wrote:
> >>>> Since commit 042c4f32323b ("mm/truncate: Inline invalidate_complete_page()
> >>>
> >>> This commit ID does not exist in mainline (or in the latest mmotm?),
> >>> so you can't use it in patch description.  Could you update this part?
> >>>
> >>
> >> This commit is in the mmotm but not in mainline yet:
> >>
> >> commit 042c4f32323beb28146c658202d3e69899e4f245
> >> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> >> Date:   Sat Feb 12 15:27:42 2022 -0500
> >>
> >>     mm/truncate: Inline invalidate_complete_page() into its one caller
> >>
> >>     invalidate_inode_page() is the only caller of invalidate_complete_page()
> >>     and inlining it reveals that the first check is unnecessary (because we
> >>     hold the page locked, and we just retrieved the mapping from the page).
> >>     Actually, it does make a difference, in that tail pages no longer fail
> >>     at this check, so it's now possible to remove a tail page from a mapping.
> >>
> >>     Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>     Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> >>     Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>
> >> Am I "not" supposed to use this commit id as it's not "stable" now?
> > 
> > No, it's not stable yet. In whatever way you get the above commit (I guess
> > you get it from https://github.com/hnaz/linux-mm), all acked mm-related
> > patches are sent to Linus by Andrew *by email*, so the eventual commit IDs
> > should be determined when they are applied to mainline.
> > 
> 
> Many thanks for your explanation. (I get this commit id from linux-next tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git)
> So I should remember always to get the commit id from mainline.

It's likely that this commit ID will be the same once Matthew's patch
goes into mainline.

But this is why we include the patch title ("mm/truncate: Inline ...")
when identifying commits.  Sometimes stuff happens...
