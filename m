Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56BF331F52
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 07:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCIGgP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Mar 2021 01:36:15 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:47000 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229688AbhCIGfn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 9 Mar 2021 01:35:43 -0500
X-AuditID: 0a580157-47bff70000021a79-0c-604710991148
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id D3.96.06777.99017406; Tue,  9 Mar 2021 14:07:21 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 14:35:35 +0800
Date:   Tue, 9 Mar 2021 14:35:34 +0800
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
Subject: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210309143534.6c1a8ec5@alex-virtual-machine>
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
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsXCFcGooDtTwD3B4ONbI4s569ewWXze8I/N
        4uv6X8wW0zaKW1w41cBkcXnXHDaLe2v+s1pcOrCAyeJi4wFGizPTiiw2b5rKbPHmwj0Wix8b
        HrM68Hp8b+1j8Vi85yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPF5c3cji8X7fVTaPzaerPT5v
        kvM40fKFNYA7issmJTUnsyy1SN8ugSvj2oqbLAX3hCrWvnBtYLzF18XIySEhYCLRfXkeaxcj
        F4eQwHQmiYaVm9khnJeMEvN7zjGDVLEIqEh8bZnOBmKzCahK7Lo3ixXEFhFIklg8+ysTSAOz
        wH0WiR1/9wE5HBzCAp4SB3oUQWp4BawkWvYdYwexOQUcJS5NXcMMseAKi8TeN69ZQBL8AmIS
        vVf+M0GcZC/RtmURI0SzoMTJmU/AapgFdCROrDrGDGHLS2x/OwfMFhJQlDi85Bc7RK+SxJHu
        GWwQdqzEsnmvWCcwCs9CMmoWklGzkIxawMi8ipGlODfdcBMjJP7CdzDOa/qod4iRiYPxEKME
        B7OSCK/fcbcEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwtx10ThATSE0tSs1NTC1KLYLJMHJxS
        DUxlQoceMrVIHfjEtNIgc0ay2Wd/lnmM/YIHnuvMbm3LvH9q87xls+3LnRbe770m2fyr//ny
        V7/Krk3znPZtXfl5M532yY2hfyt2VzMareQrvf7rFMfdmwclNyx8nTPrwYuSwI/91hyneTbO
        WWEvdVB+ocGbcyHdx5JnZx6fNPOzyqekFHnZjD+7yp+vkn368ALT1ypWWbbMkiuvrBo4i1qi
        AovD7vUUXg2dEp7i2p2zbsEfE1Uvt/exX+WeWX9lCZ+hNsv1fNZTFXkx7c0z1UxfbpgetuhL
        6ydRodyTyz/UW036cX/F2u/hIncW/ztrtGPDVysemQNzZrzXO/9+wYwVhhzSfW1Hjn3dm6ET
        svb8QiWW4oxEQy3mouJEAIh1PCguAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When the page is already poisoned, another memory_failure() call in the
same page now return 0, meaning OK. For nested memory mce handling, this
behavior may lead to mce looping, Example:

1.When LCME is enabled, and there are two processes A && B running on
different core X && Y separately, which will access one same page, then
the page corrupted when process A access it, a MCE will be rasied to
core X and the error process is just underway.

2.Then B access the page and trigger another MCE to core Y, it will also
do error process, it will see TestSetPageHWPoison be true, and 0 is
returned.

3.The kill_me_maybe will check the return:

1244 static void kill_me_maybe(struct callback_head *cb)
1245 {

1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
p->mce_whole_page);
1257                 sync_core();
1258                 return;
1259         }

1267 }

4. The error process for B will end, and may nothing happened if
kill-early is not set, The process B will re-excute instruction and get
into mce again and then loop happens. And also the set_mce_nospec()
here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").

For other cases which care the return value of memory_failure() should
check why they want to process a memory error which have already been
processed. This behavior seems reasonable.

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..b6bc77460ee1 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1228,7 +1228,7 @@ static int memory_failure_hugetlb(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(head)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 		       pfn);
-		return 0;
+		return -EBUSY;
 	}
 
 	num_poisoned_pages_inc();
@@ -1430,7 +1430,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
-		return 0;
+		return -EBUSY;
 	}
 
 	orig_head = hpage = compound_head(p);
-- 
2.25.1
