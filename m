Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10444D8ADA
	for <lists+linux-edac@lfdr.de>; Mon, 14 Mar 2022 18:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiCNRfj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Mar 2022 13:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbiCNRfj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 14 Mar 2022 13:35:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6BA6353;
        Mon, 14 Mar 2022 10:34:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e3so15256979pjm.5;
        Mon, 14 Mar 2022 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcHP8n4xtuNuolJ/LTK32L7lLsQLGVbj8PkneJtl+jA=;
        b=I02igLL//BGsHnk7q1Iu0tjDOAKFUc7OCqxNL7bkuq06fsHUQHIaSR1pzgk7SqFgAq
         Y4Hi1Xb5y6QuW6c1pu+nI109X+0KBIhFJMLsZEZfXZksr5YAAlSLVzzuKKrno1Mk4ikh
         g3piJjUiAasrUkQGFJ1zZ8YNm+QId+ZssW5GomynQ9PGNQzy21JXYegtH85bTREuhL7I
         /HAfztEvBTEqyedbbnxobKByArDB82xJuH9wmJA0d/PQ0UPJKbzB4p7mBwuCoX1+7U8F
         9BK3O/bf/R0CiO9ayj65XaUrxvtp0nC3yVWAVUzDkTA/fkah6qV5xm49zTEy1HyUqa3k
         V0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcHP8n4xtuNuolJ/LTK32L7lLsQLGVbj8PkneJtl+jA=;
        b=KuV+6xwVTxHbdslt3RK2cLlor1wbRGeD1gc4caB1jxj1nx0wFzMTrHhgGk6eYS944M
         n5YT5WGR/DDDpQ8zjqrF0reZX+VIG/VBRaP1evI8V9sJv04qGYUZwvNSDE3fY9xenqTt
         ZOYGhhJWIi6ny5JQMiT/r3x5F+KKM6M/YHz2MvUJswT5sD2JyxWqsF2vK6rg3b34k+ZK
         US6bzS9rNBLS1F5GBEuw0kBYCVW7IXm6tgoy6vUh020/mr7lZ0tN5yVfo/3OCeqnu0KB
         qoks2dl3yPXH3CeWwrfa2rL+PEH5OSaxgqnVf6WcfaXBFnV2iH1jN/6QW1dcNycfaVyE
         rjHg==
X-Gm-Message-State: AOAM532bwSOGfJmYD8PfMa3qPN2SZaFnidw/4xWRSPBFTIhyJdHiE47n
        wNI70V9O89ujR6H8Se9Q08ZpumxbPXIpwLrh6uGZ0SyX
X-Google-Smtp-Source: ABdhPJyXmcMDtH2qOdtDOufWlVuBQ+aJdiEMM8xw+FZt5o4ecpnj24p8rZJYBpCOqw5nFxE1WR//PxQ8S2E0ELNFEXY=
X-Received: by 2002:a17:903:124a:b0:151:99fe:1a10 with SMTP id
 u10-20020a170903124a00b0015199fe1a10mr24476612plh.87.1647279268835; Mon, 14
 Mar 2022 10:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220312074613.4798-1-linmiaohe@huawei.com> <20220312074613.4798-4-linmiaohe@huawei.com>
In-Reply-To: <20220312074613.4798-4-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 14 Mar 2022 10:34:17 -0700
Message-ID: <CAHbLzkp_7iJts8NfCFQdEQuvh-o7YFpU3Axc+6ZCx1ZcJB7z1g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/memory-failure.c: make non-LRU movable pages unhandlable
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, tony.luck@intel.com, bp@alien8.de,
        naoya.horiguchi@nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 11, 2022 at 11:47 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> We can not really handle non-LRU movable pages in memory failure. Typically
> they are balloon, zsmalloc, etc. Assuming we run into a base (4K) non-LRU
> movable page, we could reach as far as identify_page_state(), it should not
> fall into any category except me_unknown. For the non-LRU compound movable
> pages, they could be taken for transhuge pages but it's unexpected to split
> non-LRU  movable pages using split_huge_page_to_list in memory_failure. So
> we could just simply make non-LRU  movable pages unhandlable to avoid these
> possible nasty cases.
>
> Suggested-by: Yang Shi <shy828301@gmail.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/memory-failure.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 2ff7dd2078c4..ba621c6823ed 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1177,12 +1177,18 @@ void ClearPageHWPoisonTakenOff(struct page *page)
>   * does not return true for hugetlb or device memory pages, so it's assumed
>   * to be called only in the context where we never have such pages.
>   */
> -static inline bool HWPoisonHandlable(struct page *page)
> +static inline bool HWPoisonHandlable(struct page *page, unsigned long flags)
>  {
> -       return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
> +       bool movable = false;
> +
> +       /* Soft offline could mirgate non-LRU movable pages */
> +       if ((flags & MF_SOFT_OFFLINE) && __PageMovable(page))
> +               movable = true;
> +
> +       return movable || PageLRU(page) || is_free_buddy_page(page);
>  }
>
> -static int __get_hwpoison_page(struct page *page)
> +static int __get_hwpoison_page(struct page *page, unsigned long flags)
>  {
>         struct page *head = compound_head(page);
>         int ret = 0;
> @@ -1197,7 +1203,7 @@ static int __get_hwpoison_page(struct page *page)
>          * for any unsupported type of page in order to reduce the risk of
>          * unexpected races caused by taking a page refcount.
>          */
> -       if (!HWPoisonHandlable(head))
> +       if (!HWPoisonHandlable(head, flags))
>                 return -EBUSY;
>
>         if (get_page_unless_zero(head)) {
> @@ -1222,7 +1228,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>
>  try_again:
>         if (!count_increased) {
> -               ret = __get_hwpoison_page(p);
> +               ret = __get_hwpoison_page(p, flags);
>                 if (!ret) {
>                         if (page_count(p)) {
>                                 /* We raced with an allocation, retry. */
> @@ -1250,7 +1256,7 @@ static int get_any_page(struct page *p, unsigned long flags)
>                 }
>         }
>
> -       if (PageHuge(p) || HWPoisonHandlable(p)) {
> +       if (PageHuge(p) || HWPoisonHandlable(p, flags)) {
>                 ret = 1;
>         } else {
>                 /*
> @@ -2308,7 +2314,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>
>  retry:
>         get_online_mems();
> -       ret = get_hwpoison_page(page, flags);
> +       ret = get_hwpoison_page(page, flags | MF_SOFT_OFFLINE);
>         put_online_mems();
>
>         if (ret > 0) {
> --
> 2.23.0
>
