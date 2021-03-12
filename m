Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0EF338597
	for <lists+linux-edac@lfdr.de>; Fri, 12 Mar 2021 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhCLFzs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 Mar 2021 00:55:48 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:47713 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231252AbhCLFzf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 Mar 2021 00:55:35 -0500
X-AuditID: 0a580157-47bff70000021a79-77-604afba1e5a5
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id EF.E9.06777.1ABFA406; Fri, 12 Mar 2021 13:26:57 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 12 Mar
 2021 13:55:31 +0800
Date:   Fri, 12 Mar 2021 13:55:31 +0800
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
        <yaoaili@kingsoft.com>, <sunhao2@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210312135531.72e33b35@alex-virtual-machine>
In-Reply-To: <db80e98d2b264e988596d0d7d7c8a776@intel.com>
References: <20210303115710.2e9f8e23@alex-virtual-machine>
        <20210303163912.3d508e0f@alex-virtual-machine>
        <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
        <20210304101653.546a9da1@alex-virtual-machine>
        <20210304121941.667047c3@alex-virtual-machine>
        <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
        <20210310141042.4db9ea29@alex-virtual-machine>
        <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
        <db80e98d2b264e988596d0d7d7c8a776@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooLvwt1eCwf3DyhZz1q9hs/i84R+b
        xdf1v5gtpm0Ut7hwqoHJ4vKuOWwW99b8Z7W4dGABk8XFxgOMFmemFVls3jSV2eLNhXssFj82
        PGZ14PX43trH4rF4z0smj02rOtk8Nn2axO7x7tw5do8TM36zeLy4upHF4/2+q2wem09Xe3ze
        JOdxouULawB3FJdNSmpOZllqkb5dAlfGimkX2Ap+cFZMu/KFpYHxOXsXIyeHhICJxISja5i7
        GLk4hASmM0mce/aQEcJ5xSix690DRpAqFgFViX8d05hBbDYge9e9WawgtoiAmsSlxQ/AupkF
        NrNKXDg3nwkkISzgJfHl/lqwZl4BK4nD63eAxTkFLCUuXFvPDrHhAYvE/sZdYHfwC4hJ9F75
        zwRxk71E25ZFUM2CEidnPmEBsZkFdCROrDrGDGHLS2x/OwfMFhJQlDi85BfUP0oSR7pnsEHY
        sRLL5r1incAoPAvJqFlIRs1CMmoBI/MqRpbi3HTDTYyQGAzfwTiv6aPeIUYmDsZDjBIczEoi
        vBdeeiUI8aYkVlalFuXHF5XmpBYfYpTmYFES571c4ZkgJJCeWJKanZpakFoEk2Xi4JRqYJr5
        KySsx6PbcbHNzkXPz/9YlP96ye26T+mna/3fJW6Zv+qvtiqHcsFxufmPDra6KgVUWOZfaa5u
        7FPSPdF0UlZbv7n+upro3hiLksdzA9+suiO0mK10mpRDiOXfxbkaUjM4BT00J2sopf3+dZ7V
        jMXsrKvmLP3DddsCdCSXyxplrTHtY19z1OYKt+jJDReYth14zP821s9JaaGi+oamhZOuTW2L
        SzwaXJm47IH3Tp2+JctmuwddPnPi4Q3+F397lu9gut7ytVdvYpzMW9HN99dsmPnr8baFl9i0
        3p8sNOvQsf2+zur2PYtGNt6OBC1V50brjjPJUS86M8r7PnmUr8k99avadu6KrIkNq9ZYRSux
        FGckGmoxFxUnAgCzo2enMAMAAA==
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 11 Mar 2021 17:05:53 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > I guess that p->mce_vaddr stores the virtual address of the error here.
> > If so, sending SIGBUS with the address looks enough as we do now, so why
> > do you walk page table to find the error virtual address?  
> 
> p->mce_vaddr only has the virtual address for the COPYIN case. In that code
> path we decode the kernel instruction that hit the fault in order to find the virtual
> address. That's easy because:
> 
> 1) The kernel RIP is known to be good (can't page fault etc. on kernel address).
> 2) There are only a half dozen instructions used by the kernel for get_user() or
>      copy_from_user().
> 
> When the machine check happens during user execution accessing poison data
> we only have the physical address (from MCi_ADDR).
> 
> -Tony

Sorry to interrupt as I am really confused here:
If it's a copyin case, has the page been mapped for the current process?
will memory_failure() find it and unmap it? if succeed, then the current will be
signaled with correct vaddr and shift?

Maybe the mce_vaddr is set correctly, but we may lost the correct page shift?

And for copyin case, we don't need to call set_mce_nospec()?

-- 
Thanks!
Aili Yao
