Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FBC32CB4E
	for <lists+linux-edac@lfdr.de>; Thu,  4 Mar 2021 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhCDEU4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Mar 2021 23:20:56 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:13116 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhCDEUZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 3 Mar 2021 23:20:25 -0500
X-AuditID: 0a580155-6fbff700000550c6-2c-6040589268fb
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 73.82.20678.29850406; Thu,  4 Mar 2021 11:48:34 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 4 Mar 2021
 12:19:42 +0800
Date:   Thu, 4 Mar 2021 12:19:41 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210304121941.667047c3@alex-virtual-machine>
In-Reply-To: <20210304101653.546a9da1@alex-virtual-machine>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
        <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
        <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooDspwiHB4NhVSYs569ewWXze8I/N
        4uv6X8wW0zaKW1w41cBkcXnXHDaLe2v+s1pcOrCAyeJi4wFGizPTiiw2b5rKbPHmwj0Wix8b
        HrM68Hp8b+1j8Vi85yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPF5c3cji8X7fVTaPzaerPT5v
        kvM40fKFNYA7issmJTUnsyy1SN8ugSvjzbdepoLvIhUztr1nbmDcw9fFyMkhIWAicXfCO8Yu
        Ri4OIYHpTBInbixjgnBeMkpMefCTCaSKRUBFor37IjOIzSagKrHr3ixWEFtEQE3i0uIHzCAN
        zAKzWSVOTT4LViQs4CXx5f5aRhCbV8BKYkXnYrAGTgFriUudvewQG86wSmxdvxmsgV9ATKL3
        yn8miJvsJdq2LIJqFpQ4OfMJC4jNLKAjcWLVMWYIW15i+9s5YLaQgKLE4SW/2CF6lSSOdM9g
        g7BjJZbNe8U6gVF4FpJRs5CMmoVk1AJG5lWMLMW56UabGCExGLqDcUbTR71DjEwcjIcYJTiY
        lUR4xV/aJgjxpiRWVqUW5ccXleakFh9ilOZgURLnnbrVJEFIID2xJDU7NbUgtQgmy8TBKdXA
        FCW3eqVdQk1akQV/x5cF6yX3ihzbbPhv/sWXvz7b6OZ3HK3QcgsuZIg+/+624rpKb6dtcunb
        VDZfPC68k/Wkuf7Phu4LRu/bJUNsWdncLLoOfTnw2fGhTgGLjKlUy7UT/Wd33l2p1DDjUglD
        dnF+0L/q+X+mvg9q32ZWWnrQZMszMwtl+50m5wwFdl6IX5e55K7PxQefOJdxaFf0LXZc7M7C
        w9irF1upkrBNoPmf9D4HF/ZH30LdfDUfTpiyVrj3jQWvR/eZp9Y+ruVd+hrd3/iv8UkF74jy
        yd4TxVklffsDc6yDDQ+n2XIbka7GlQxfpntXd6XpXHN/mye2O+zTQ9bFNgsYL7/4+TNiq6QS
        S3FGoqEWc1FxIgDh9yT2MAMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 4 Mar 2021 10:16:53 +0800
Aili Yao <yaoaili@kingsoft.com> wrote:

> On Wed, 3 Mar 2021 15:41:35 +0000
> "Luck, Tony" <tony.luck@intel.com> wrote:
> 
> > > For error address with sigbus, i think this is not an issue resulted by the patch i post, before my patch, the issue is already there.
> > > I don't find a realizable way to get the correct address for same reason --- we don't know whether the page mapping is there or not when
> > > we got to kill_me_maybe(), in some case, we may get it, but there are a lot of parallel issue need to consider, and if failed we have to fallback
> > > to the error brach again, remaining current code may be an easy option;    
> > 
> > My RFC patch from yesterday removes the uncertainty about whether the page is there or not. After it walks the page
> > tables we know that the poison page isn't mapped (note that patch is RFC for a reason ... I'm 90% sure that it should
> > do a bit more that just clear the PRESENT bit).
> > 
> > So perhaps memory_failure() has queued a SIGBUS for this task, if so, we take it when we return from kill_me_maybe()

And when this happen, the process will receive an SIGBUS with AO level, is it proper as not an AR?

> > If not, we will return to user mode and re-execute the failing instruction ... but because the page is unmapped we will take a #PF  
> 
> Got this, I have some error thoughts here.
> 
> 
> > The x86 page fault handler will see that the page for this physical address is marked HWPOISON, and it will send the SIGBUS
> > (just like it does if the page had been removed by an earlier UCNA/SRAO error).  
> 
> if your methods works, should it be like this?
> 
> 1582                         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
> 1583                         if (PageHuge(page)) {
> 1584                                 hugetlb_count_sub(compound_nr(page), mm);
> 1585                                 set_huge_swap_pte_at(mm, address,
> 1586                                                      pvmw.pte, pteval,
> 1587                                                      vma_mmu_pagesize(vma));
> 1588                         } else {
> 1589                                 dec_mm_counter(mm, mm_counter(page));
> 1590                                 set_pte_at(mm, address, pvmw.pte, pteval);
> 1591                         }
> 
> the page fault check if it's a poison page using is_hwpoison_entry(),
> 

And if it works, does we need some locking mechanism before we call walk_page_range();
if we lock, does we need to process the blocking interrupted error as other places will do?

-- 
Thanks!
Aili Yao
