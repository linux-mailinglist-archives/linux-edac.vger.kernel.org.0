Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D884E331F58
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 07:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCIGi3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 9 Mar 2021 01:38:29 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:47002 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229701AbhCIGiJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Mar 2021 01:38:09 -0500
X-AuditID: 0a580155-1f5ff7000005482e-ee-60471059c018
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id C3.11.18478.95017406; Tue,  9 Mar 2021 14:06:17 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 14:38:06 +0800
Date:   Tue, 9 Mar 2021 14:38:06 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
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
Subject: Re: [PATCH] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210309143806.344fe894@alex-virtual-machine>
In-Reply-To: <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
References: <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <20210305093656.6c262b19@alex-virtual-machine>
        <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
        <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
        <3690ece2101d428fb9067fcd2a423ff8@intel.com>
        <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
        <20210309100421.3d09b6b1@alex-virtual-machine>
        <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCFcGooBsp4J5gcP68rsWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJXxeOZzloIvXBWfZu5la2C8wdHFyMkhIWAi0Xx+MQuI
        LSQwnUli7gnnLkYuIPslo8SU6y1sXYwcHCwCKhJTluqD1LAJqErsujeLFcQWEUiSWDz7KxNI
        PbPAfRaJHX/3MYEkhAVCJQ7u+Ac2lFfASqKzrw+sgVPAUeLS1DXMEAuusEjsffMarIhfQEyi
        98p/JoiL7CXatixihGgWlDg58wlYDbOApkTr9t/sELa2xLKFr5khrlaUOLzkFztEr5LEke4Z
        bBB2rMSyea9YJzAKz0IyahaSUbOQjFrAyLyKkaU4N91oEyMk/kJ3MM5o+qh3iJGJg/EQowQH
        s5IIr99xtwQh3pTEyqrUovz4otKc1OJDjNIcLErivHuPuSYICaQnlqRmp6YWpBbBZJk4OKUa
        mPR910cveZO8o7zr/P+zc5ZeM9J/W8huczvm/v2aJQ9jnz+8tVAtvpNnNsedv0vvyu47zKYj
        UPb2ZMXMu4FqEwwn1qrn9k27FD2zr0bx4BNehfOzS6T2O9zimCbzb16l+ObL5W2lWhsCxQKy
        O9clM7gELUlS9hc5pfvjjl/m+TAX/lUnn0gLv0hZYaihdvHljHoJtZrnbip3igWjmirYFJ1Y
        TUoCRESYbCqFru4M05I9MXHmIeNHf/dFmR+4wnLi2UJx1t9H23M5lOKFOKOOn2J149nl3uI6
        WfLlnNKbUbkPZVdvCE4O8Wb/oTxnf0/MaY0/HyZnXYhbzKGe/lQ+3eHZw6SVLGuruG7pS7gu
        V2Ipzkg01GIuKk4EAEBq0ssuAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 9 Mar 2021 06:04:41 +0000
HORIGUCHI NAOYA(堀口　直也) <naoya.horiguchi@nec.com> wrote:

> ...
> > 
> > If others are OK with this method, then I am OK too.
> > But I have two concerns, May you take into account:
> > 
> > 1. The memory_failure with 0 return code for race condition, then the kill_me_maybe() goes into branch:
> > 	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > 	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > 		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> > 		sync_core();
> > 		return;
> > 	}
> > 
> > while we place set_mce_nospec() here is for a reason, please see commit fd0e786d9d09024f67b.
> > 
> > 2. When memory_failure return 0 and maybe return to user process, and it may re-execute the instruction triggering previous fault, this behavior
> > assume an implicit dependence that the related pte has been correctly set. or if not correctlily set, it will lead to infinite loop again.  
> 
> These seem to be separate issues from memory_failure()'s concurrency issue,
> so I'm still expecting that your patch is to be merged. Maybe do you want
> to update it based on the discussion (if it's concluded)?
> 
> Thanks,
> Naoya Horiguchi

I have submitted a v2 patch, and please help review.

Thanks!
 
-- 
Thanks!
Aili Yao
