Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67F7331A7A
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 23:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhCHWzd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 17:55:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:47552 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230070AbhCHWzG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Mar 2021 17:55:06 -0500
IronPort-SDR: u5FvrUpMBY+glSji7AYiaKv0IuFBy/159IaXnZPBZgFo328mbpgHpRRtkUiuaDPiwGAAqNqb6w
 8F4502+Lj0EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249497618"
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="249497618"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 14:55:06 -0800
IronPort-SDR: oQApYD2RhFTBNoUxIwaYGlt9r/UtUis8L6rQ9q+cmeRxxjcoj0h5t6gU/8ypfCnWW20R0xZrEP
 zs1ToNjAKFUQ==
X-IronPort-AV: E=Sophos;i="5.81,233,1610438400"; 
   d="scan'208";a="409476776"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 14:55:05 -0800
Date:   Mon, 8 Mar 2021 14:55:04 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Aili Yao <yaoaili@kingsoft.com>,
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: [PATCH] mm/memory-failure: Use a mutex to avoid memory_failure()
 races
Message-ID: <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
References: <20210304101653.546a9da1@alex-virtual-machine>
 <20210304121941.667047c3@alex-virtual-machine>
 <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

There can be races when multiple CPUs consume poison from the same
page. The first into memory_failure() atomically sets the HWPoison
page flag and begins hunting for tasks that map this page. Eventually
it invalidates those mappings and may send a SIGBUS to the affected
tasks.

But while all that work is going on, other CPUs see a "success"
return code from memory_failure() and so they believe the error
has been handled and continue executing.

Fix by wrapping most of the internal parts of memory_failure() in
a mutex.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 mm/memory-failure.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 24210c9bd843..c1509f4b565e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	return rc;
 }
 
+static DEFINE_MUTEX(mf_mutex);
+
 /**
  * memory_failure - Handle memory failure of a page.
  * @pfn: Page Number of the corrupted page
@@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
 		return -ENXIO;
 	}
 
+	mutex_lock(&mf_mutex);
+
 try_again:
-	if (PageHuge(p))
-		return memory_failure_hugetlb(pfn, flags);
+	if (PageHuge(p)) {
+		res = memory_failure_hugetlb(pfn, flags);
+		goto out2;
+	}
+
 	if (TestSetPageHWPoison(p)) {
 		pr_err("Memory failure: %#lx: already hardware poisoned\n",
 			pfn);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 
@@ -1463,9 +1471,11 @@ int memory_failure(unsigned long pfn, int flags)
 				res = MF_FAILED;
 			}
 			action_result(pfn, MF_MSG_BUDDY, res);
+			mutex_unlock(&mf_mutex);
 			return res == MF_RECOVERED ? 0 : -EBUSY;
 		} else {
 			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
+			mutex_unlock(&mf_mutex);
 			return -EBUSY;
 		}
 	}
@@ -1473,6 +1483,7 @@ int memory_failure(unsigned long pfn, int flags)
 	if (PageTransHuge(hpage)) {
 		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
 			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
+			mutex_unlock(&mf_mutex);
 			return -EBUSY;
 		}
 		VM_BUG_ON_PAGE(!page_count(p), p);
@@ -1517,6 +1528,7 @@ int memory_failure(unsigned long pfn, int flags)
 		num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 	if (hwpoison_filter(p)) {
@@ -1524,6 +1536,7 @@ int memory_failure(unsigned long pfn, int flags)
 			num_poisoned_pages_dec();
 		unlock_page(p);
 		put_page(p);
+		mutex_unlock(&mf_mutex);
 		return 0;
 	}
 
@@ -1559,6 +1572,8 @@ int memory_failure(unsigned long pfn, int flags)
 	res = identify_page_state(pfn, p, page_flags);
 out:
 	unlock_page(p);
+out2:
+	mutex_unlock(&mf_mutex);
 	return res;
 }
 EXPORT_SYMBOL_GPL(memory_failure);
-- 
2.29.2

