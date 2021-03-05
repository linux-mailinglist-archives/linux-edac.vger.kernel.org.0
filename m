Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3032F5BC
	for <lists+linux-edac@lfdr.de>; Fri,  5 Mar 2021 23:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCEWLr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 5 Mar 2021 17:11:47 -0500
Received: from mga14.intel.com ([192.55.52.115]:48047 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhCEWLq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 5 Mar 2021 17:11:46 -0500
IronPort-SDR: jg/iLv9z3FxslolcjtUkDfPDluwV41Liz9GV/Th3rSZO54FDUNACW/JwsGK2+kED3p1e0+HpnA
 9mUEkvYbiE2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="187089117"
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="187089117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 14:11:45 -0800
IronPort-SDR: ExbitkAEYQqWQoVoa0NIng5EvNximSf0JbDrTxOIH+eOpsAt4b6t+9/vyHTj9ZkSKRdwE2zWwf
 8ZxOGudfONng==
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="446396261"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 14:11:45 -0800
Date:   Fri, 5 Mar 2021 14:11:43 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Aili Yao <yaoaili@kingsoft.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
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
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
References: <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
 <20210303115710.2e9f8e23@alex-virtual-machine>
 <20210303163912.3d508e0f@alex-virtual-machine>
 <1a78e9abdc134e35a5efcbf6b2fd2263@intel.com>
 <20210304101653.546a9da1@alex-virtual-machine>
 <20210304121941.667047c3@alex-virtual-machine>
 <20210304144524.795872d7@alex-virtual-machine>
 <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
 <20210305093016.40c87375@alex-virtual-machine>
 <20210305093656.6c262b19@alex-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305093656.6c262b19@alex-virtual-machine>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This whole page table walking patch is trying to work around the
races caused by multiple calls to memory_failure() for the same
page.

Maybe better to just avoid the races.  The comment right above
memory_failure says:

 * Must run in process context (e.g. a work queue) with interrupts
 * enabled and no spinlocks hold.

So it should be safe to grab and hold a mutex.  See patch below.

-Tony

commit 8dd0dbe7d595e02647e9c2c76c03341a9f6bd7b9
Author: Tony Luck <tony.luck@intel.com>
Date:   Fri Mar 5 10:40:48 2021 -0800

    Use a mutex to avoid memory_failure() races

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
