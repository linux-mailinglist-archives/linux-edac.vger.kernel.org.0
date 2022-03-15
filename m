Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8D4DA238
	for <lists+linux-edac@lfdr.de>; Tue, 15 Mar 2022 19:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbiCOSVR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Mar 2022 14:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiCOSVR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Mar 2022 14:21:17 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8656E593AD;
        Tue, 15 Mar 2022 11:20:04 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l8so329908pfu.1;
        Tue, 15 Mar 2022 11:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sZqFM1DdTzKMCe7Ik7jL3tVTyC3fc1mknILd/ebsH/s=;
        b=izMD0CGKS3jC9MlY/JKtkSPhr4TH1HycOYlSrgJ024KfcfBa0iPn9+1hOmAjbcZtnp
         jcyR7rbtlY7Ssx00HZf2a16nEcBMtDIExvhKhn5S9tzgiHM3R2Uhfs7vUgLb8vmmh8GW
         o9RBuoaHGRo4CG3QFEs9wpmdMfcPTp8higjj2l1S270WLvV0S2rhR/QfCM1EaBqMEshk
         505wMwXBd6jplWh0+3lS9lU5DeIQe9Z+zTZfOjxzzZmJH3bBR9RDfNOlhXVX8+cW6BuD
         L/JgBVLxYiogZnKqmH/vIWiCYSG9d9Z/McTcMUzuLusHLtWZlQNB2vcGvZwLQVrB+ZPB
         W8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sZqFM1DdTzKMCe7Ik7jL3tVTyC3fc1mknILd/ebsH/s=;
        b=is8NDzotDFXqiqc1AH5f5mPKIqB06CsbDvGC66ceByx/98HDHuy0JyCFaZm7JsOdzV
         Nib36ZF3CkJ9kbxQTBM+ZspEGvVNDhtBI2nyB4CVJ1oMDT0xVdosc6iMvNGaAEarcnJ4
         qEuqRs4POzbHPCUnwkf8SiSIYTPkHFe7xooqpK7br96U/e12w5pm9cFdsMCvGIrRiufn
         TGoO9K3X76rdlJ91Lira9tGcvUD0W3W/7bDezf0jQjJouAS38F12arzDjBkrHd2EeDNe
         wmYw4U0cyZu0Ac8otM5q7WUjKf7aYOvMnQs2y0PmE2kbjf8pl5eApEWp8aFGL8qkl+1m
         s5NQ==
X-Gm-Message-State: AOAM531Z2X9IevLx2IB8UeueX21WzNW6O3xBuoIFYRIV6q++SrXNagZC
        +iesGJqamNF5jlz3MexqVOGTfZbgk+0DYO81gT8=
X-Google-Smtp-Source: ABdhPJxxVuedUSYl+kFkW9kUsJpAyx04kp6BlSZDwIXYON4pKE+lZFdn+gvYQck89RjyNQ8OUPIoiP5GUiqvxPq52a4=
X-Received: by 2002:a63:fd01:0:b0:381:31b7:8bc5 with SMTP id
 d1-20020a63fd01000000b0038131b78bc5mr11746462pgh.206.1647368404061; Tue, 15
 Mar 2022 11:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220312074613.4798-1-linmiaohe@huawei.com> <20220312074613.4798-2-linmiaohe@huawei.com>
 <91661cd4-e9be-959f-8b6a-da257a00a879@oracle.com> <9826152a-8a83-76a8-ded8-47d185aac0a8@huawei.com>
In-Reply-To: <9826152a-8a83-76a8-ded8-47d185aac0a8@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 15 Mar 2022 11:19:52 -0700
Message-ID: <CAHbLzkrg=nQGm=sLnYriZJNZ3QznW5_Ktx6x7cWzV+9QJnRE4w@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure.c: fix race with changing page
 compound again
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, akpm@linux-foundation.org,
        tony.luck@intel.com, bp@alien8.de
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

On Tue, Mar 15, 2022 at 7:19 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/3/15 2:20, Mike Kravetz wrote:
> > On 3/11/22 23:46, Miaohe Lin wrote:
> >> There is a race window where we got the compound_head, the hugetlb page
> >> could be freed to buddy, or even changed to another compound page just
> >> before we try to get hwpoison page. Think about the below race window:
> >>   CPU 1                                        CPU 2
> >>   memory_failure_hugetlb
> >>   struct page *head = compound_head(p);
> >>                                        hugetlb page might be freed to
> >>                                        buddy, or even changed to another
> >>                                        compound page.
> >>
> >>   get_hwpoison_page -- page is not what we want now...
> >>
> >> If this race happens, just bail out. Also MF_MSG_DIFFERENT_PAGE_SIZE is
> >> introduced to record this event.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  include/linux/mm.h      |  1 +
> >>  include/ras/ras_event.h |  1 +
> >>  mm/memory-failure.c     | 12 ++++++++++++
> >>  3 files changed, 14 insertions(+)
> >>
> >> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >> index c9bada4096ac..ef98cff2b253 100644
> >> --- a/include/linux/mm.h
> >> +++ b/include/linux/mm.h
> >> @@ -3253,6 +3253,7 @@ enum mf_action_page_type {
> >>      MF_MSG_BUDDY,
> >>      MF_MSG_DAX,
> >>      MF_MSG_UNSPLIT_THP,
> >> +    MF_MSG_DIFFERENT_PAGE_SIZE,
> >>      MF_MSG_UNKNOWN,
> >>  };
> >>
> >> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> >> index d0337a41141c..1e694fd239b9 100644
> >> --- a/include/ras/ras_event.h
> >> +++ b/include/ras/ras_event.h
> >> @@ -374,6 +374,7 @@ TRACE_EVENT(aer_event,
> >>      EM ( MF_MSG_BUDDY, "free buddy page" )                          \
> >>      EM ( MF_MSG_DAX, "dax page" )                                   \
> >>      EM ( MF_MSG_UNSPLIT_THP, "unsplit thp" )                        \
> >> +    EM ( MF_MSG_DIFFERENT_PAGE_SIZE, "different page size" )        \
> >>      EMe ( MF_MSG_UNKNOWN, "unknown page" )
> >>
> >>  /*
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 5444a8ef4867..dabecd87ad3f 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -733,6 +733,7 @@ static const char * const action_page_types[] = {
> >>      [MF_MSG_BUDDY]                  = "free buddy page",
> >>      [MF_MSG_DAX]                    = "dax page",
> >>      [MF_MSG_UNSPLIT_THP]            = "unsplit thp",
> >> +    [MF_MSG_DIFFERENT_PAGE_SIZE]    = "different page size",
> >>      [MF_MSG_UNKNOWN]                = "unknown page",
> >>  };
> >>
> >> @@ -1534,6 +1535,17 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
> >>      }
> >>
> >>      lock_page(head);
> >> +
> >> +    /**
> >> +     * The page could have changed compound pages due to race window.
> >> +     * If this happens just bail out.
> >> +     */
> >> +    if (!PageHuge(p) || compound_head(p) != head) {
> >> +            action_result(pfn, MF_MSG_DIFFERENT_PAGE_SIZE, MF_IGNORED);
> >> +            res = -EBUSY;
> >
> > We have discussed this race in other versions of the patch.  When we encounter
> > the race, we have likely marked poison on the wrong page.  Correct?
> >
>
> Many thanks for comment.
> I assume that Naoya's patch "mm/hwpoison: set PageHWPoison after taking page lock
> in memory_failure_hugetlb()" would set the PageHWPoison after the above check.
> So I think the below operation is not needed as PageHWPoison is not set yet.
> Does this makes sense for you?

I'm wondering if it might be better and helpful for review to squash
this patch with Naoya's patch together? It seems we always missed the
other part when reviewing the patches.

>
> Thanks.
>
> > Instead of printing a "different page size", would it be better to perhaps:
> > - Print a message that wrong page may be marked for poison?
> > - Clear the poison flag in the "head page" previously set?
> >
>
