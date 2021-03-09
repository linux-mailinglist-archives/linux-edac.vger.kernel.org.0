Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAC331CBB
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 03:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhCICEo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 21:04:44 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:13953 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhCICEd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Mar 2021 21:04:33 -0500
X-AuditID: 0a580155-1f5ff7000005482e-02-6046d0376853
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id EC.50.18478.730D6406; Tue,  9 Mar 2021 09:32:39 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 9 Mar 2021
 10:04:27 +0800
Date:   Tue, 9 Mar 2021 10:04:21 +0800
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
Subject: Re: [PATCH] mm/memory-failure: Use a mutex to avoid
 memory_failure() races
Message-ID: <20210309100421.3d09b6b1@alex-virtual-machine>
In-Reply-To: <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
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
        <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsXCFcGooGt+wS3BYHe/msWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJUxZeEmtoJe+Ypbb14wNjDulehi5OSQEDCR6P/8nrmL
        kYtDSGA6k8T6eyfYIJyXjBL7lpwEcjg4WARUJF4tqAJpYBNQldh1bxYriC0ioCZxafEDsGZm
        gdmsEqcmn2UGSQgLhEoc3PGPBcTmFbCSeLJlLyOIzSngJrFpwi+oBedYJNa8nQA2iV9ATKL3
        yn8miJPsJdq2LGKEaBaUODnzCdggZgEdiROrjjFD2PIS29/OAbOFBBQlDi/5xQ7RqyRxpHsG
        G4QdK7Fs3ivWCYzCs5CMmoVk1CwkoxYwMq9iZCnOTTfaxAiJwNAdjDOaPuodYmTiYDzEKMHB
        rCTC63fcLUGINyWxsiq1KD++qDQntfgQozQHi5I4795jrglCAumJJanZqakFqUUwWSYOTqkG
        puxzmd2SXl8n59Sc0fI1t8q881OOa72R6X6eSK45qdov6tg9VjW8ySr64mrDXyW2Yekxw+vT
        Klm3+1suj3z814oj4td3XcGHxe1X2eYzZhgYRFZdjJurIbxod+iClc5lUVPMbpU57X/lmPTh
        6/LXqYtcFpapPZ3OoOnyLfWlyK9jkmec5DSbVplWJx07MOHjWxHeU8t5r9rUnzcO+3y9xetc
        opdD9u3XC/3M8xtcL4pWHOK75VWbKzfztgK3nnjsitd6yj56s8Kb/t2qr2I0i/3gHfTS8kj2
        4ZLF3/zuil04/YVBq2ERK9dbmcRcw8Clp+w19r1S+X7OrWvBg9mN9rtvF/61nukb8Gjd54sP
        lFiKMxINtZiLihMBaYcR1C8DAAA=
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 8 Mar 2021 14:55:04 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> There can be races when multiple CPUs consume poison from the same
> page. The first into memory_failure() atomically sets the HWPoison
> page flag and begins hunting for tasks that map this page. Eventually
> it invalidates those mappings and may send a SIGBUS to the affected
> tasks.
> 
> But while all that work is going on, other CPUs see a "success"
> return code from memory_failure() and so they believe the error
> has been handled and continue executing.
> 
> Fix by wrapping most of the internal parts of memory_failure() in
> a mutex.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  mm/memory-failure.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 24210c9bd843..c1509f4b565e 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1381,6 +1381,8 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>  	return rc;
>  }
>  
> +static DEFINE_MUTEX(mf_mutex);
> +
>  /**
>   * memory_failure - Handle memory failure of a page.
>   * @pfn: Page Number of the corrupted page
> @@ -1424,12 +1426,18 @@ int memory_failure(unsigned long pfn, int flags)
>  		return -ENXIO;
>  	}
>  
> +	mutex_lock(&mf_mutex);
> +
>  try_again:
> -	if (PageHuge(p))
> -		return memory_failure_hugetlb(pfn, flags);
> +	if (PageHuge(p)) {
> +		res = memory_failure_hugetlb(pfn, flags);
> +		goto out2;
> +	}
> +
>  	if (TestSetPageHWPoison(p)) {
>  		pr_err("Memory failure: %#lx: already hardware poisoned\n",
>  			pfn);
> +		mutex_unlock(&mf_mutex);
>  		return 0;
>  	}
>  
> @@ -1463,9 +1471,11 @@ int memory_failure(unsigned long pfn, int flags)
>  				res = MF_FAILED;
>  			}
>  			action_result(pfn, MF_MSG_BUDDY, res);
> +			mutex_unlock(&mf_mutex);
>  			return res == MF_RECOVERED ? 0 : -EBUSY;
>  		} else {
>  			action_result(pfn, MF_MSG_KERNEL_HIGH_ORDER, MF_IGNORED);
> +			mutex_unlock(&mf_mutex);
>  			return -EBUSY;
>  		}
>  	}
> @@ -1473,6 +1483,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	if (PageTransHuge(hpage)) {
>  		if (try_to_split_thp_page(p, "Memory Failure") < 0) {
>  			action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
> +			mutex_unlock(&mf_mutex);
>  			return -EBUSY;
>  		}
>  		VM_BUG_ON_PAGE(!page_count(p), p);
> @@ -1517,6 +1528,7 @@ int memory_failure(unsigned long pfn, int flags)
>  		num_poisoned_pages_dec();
>  		unlock_page(p);
>  		put_page(p);
> +		mutex_unlock(&mf_mutex);
>  		return 0;
>  	}
>  	if (hwpoison_filter(p)) {
> @@ -1524,6 +1536,7 @@ int memory_failure(unsigned long pfn, int flags)
>  			num_poisoned_pages_dec();
>  		unlock_page(p);
>  		put_page(p);
> +		mutex_unlock(&mf_mutex);
>  		return 0;
>  	}
>  
> @@ -1559,6 +1572,8 @@ int memory_failure(unsigned long pfn, int flags)
>  	res = identify_page_state(pfn, p, page_flags);
>  out:
>  	unlock_page(p);
> +out2:
> +	mutex_unlock(&mf_mutex);
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(memory_failure);

If others are OK with this method, then I am OK too.
But I have two concerns, May you take into account:

1. The memory_failure with 0 return code for race condition, then the kill_me_maybe() goes into branch:
	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
		sync_core();
		return;
	}

while we place set_mce_nospec() here is for a reason, please see commit fd0e786d9d09024f67b.

2. When memory_failure return 0 and maybe return to user process, and it may re-execute the instruction triggering previous fault, this behavior
assume an implicit dependence that the related pte has been correctly set. or if not correctlily set, it will lead to infinite loop again.

-- 
Thanks!
Aili Yao
