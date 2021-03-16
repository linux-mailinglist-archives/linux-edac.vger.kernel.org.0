Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1FA33CEEA
	for <lists+linux-edac@lfdr.de>; Tue, 16 Mar 2021 08:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhCPHyt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 16 Mar 2021 03:54:49 -0400
Received: from mail.kingsoft.com ([114.255.44.146]:48402 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233264AbhCPHyi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 16 Mar 2021 03:54:38 -0400
X-AuditID: 0a580157-463ff70000021a79-b2-60505d65ded3
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id C7.B1.06777.56D50506; Tue, 16 Mar 2021 15:25:25 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 16 Mar
 2021 15:54:28 +0800
Date:   Tue, 16 Mar 2021 15:54:28 +0800
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
        "sunhao2@kingsoft.com" <sunhao2@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210316155428.15c665c2@alex-virtual-machine>
In-Reply-To: <20210316064215.GA23401@hori.linux.bs1.fc.nec.co.jp>
References: <20210304144524.795872d7@alex-virtual-machine>
        <20210304235720.GA215567@agluck-desk2.amr.corp.intel.com>
        <20210305093016.40c87375@alex-virtual-machine>
        <aee5176eafb54c88b19a5b2671d0a1fc@intel.com>
        <20210310141042.4db9ea29@alex-virtual-machine>
        <20210311085529.GA22268@hori.linux.bs1.fc.nec.co.jp>
        <db80e98d2b264e988596d0d7d7c8a776@intel.com>
        <20210312135531.72e33b35@alex-virtual-machine>
        <3900f518d1324c388be52cf81f5220e4@intel.com>
        <af80221baed940d8bcc643e3e7d40036@intel.com>
        <20210316064215.GA23401@hori.linux.bs1.fc.nec.co.jp>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooJsaG5BgcGK7pMWc9WvYLD5v+Mdm
        8XX9L2aLaRvFLS6camCyuLxrDpvFvTX/WS0uHVjAZHGx8QCjxZlpRRabN01ltnhz4R6LxY8N
        j1kdeD2+t/axeCze85LJY9OqTjaPTZ8msXu8O3eO3ePEjN8sHi+ubmTxeL/vKpvH5tPVHp83
        yXmcaPnCGsAdxWWTkpqTWZZapG+XwJUx5eU/9oJ/8hX7/rezNzAelexi5OSQEDCRWHRlOlsX
        IxeHkMB0JollW6czQzivGCV+/L7BDlLFIqAq0bShjwXEZgOyd92bxQpiiwgkSSye/ZUJpIFZ
        YAKrxLnvCxhBEsICXhJf7q8Fs3kFrCS6l3SxgdicAo4S727sY4XYsJlF4sWpC8wgCX4BMYne
        K/+ZIG6yl2jbsgiqWVDi5MwnYJuZBXQkTqw6xgxhy0tsfzsHzBYSUJQ4vOQXO0SvksSR7hls
        EHasxLJ5r1gnMArPQjJqFpJRs5CMWsDIvIqRpTg33XATIyQGw3cwzmv6qHeIkYmD8RCjBAez
        kgjvZx3fBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8IlEBCUIC6YklqdmpqQWpRTBZJg5OqQYm
        X+levz3LJ/P85+X6LKpkaXVjZ6vcwe2P5ZcrMtguVbT/sdDibv+OV5d0ZmzauujI+p1X2Pfe
        06xL5pm3dN1WdlsWNW2fVzbeZveCbpv+n/DjzN5X1pksHluv6R5LvrArtdMt93DBzLsdr5pm
        rO5+f5KlwSRYyPvVG5crnO/7Nl3ktC99vVl7+v88icUhUs48/nXCK9Xymi63XdX6FeUmfuOY
        0aneO7nf12T9SKmJkXI6aXjS50WST8X1XHuNm8w217bMPPPa4vApZzYX/dn2m0u6fL5eC34o
        9q2a027+tYu9xlc5FhwqvzbvuXWUQWPD8fPxbZ0intLTapV2ML0ufXXvuujR3Ej/D2/tqv+c
        U2Ipzkg01GIuKk4EAIJf78wwAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

> As you answered in another email, p->mce_vaddr is set only on KERNEL_COPYIN case,
> then if p->mce_vaddr is available also for generic SRAR MCE (I'm assuming that we are
> talking about issues on race between generic SRAR MCE not only for KERNEL_COPYIN case),
> that might be helpful, although it might be hard to implement.
> And I'm afraid that walking page table could find the wrong virtual address if a process
> have multiple entries to the single page. We could send multiple SIGBUSs for such case,
> but maybe that's not an optimal solution.

Yes, agree, I can't find one way to address this multiple entries case, to make sure we get
the exact correct virtual address.

But also I will post a v2 RFC patch for this issue for only discussion purpose!

Thanks!

> ----
> From 147449a97e2ea3420ac3523f13523f5d30a13614 Mon Sep 17 00:00:00 2001
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Date: Tue, 16 Mar 2021 14:22:21 +0900
> Subject: [PATCH] pagemap: expose hwpoison entry
> 
> not-signed-off-by-yet: Naoya Horiguchi <naoya.horiguchi@nec.com>
> ---
>  fs/proc/task_mmu.c      |  6 ++++++
>  include/linux/swapops.h | 12 ++++++++++++
>  tools/vm/page-types.c   |  5 ++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 602e3a52884d..08cea209bae7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1300,6 +1300,7 @@ struct pagemapread {
>  #define PM_PFRAME_MASK		GENMASK_ULL(PM_PFRAME_BITS - 1, 0)
>  #define PM_SOFT_DIRTY		BIT_ULL(55)
>  #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
> +#define PM_HWPOISON	       	BIT_ULL(60)
>  #define PM_FILE			BIT_ULL(61)
>  #define PM_SWAP			BIT_ULL(62)
>  #define PM_PRESENT		BIT_ULL(63)
> @@ -1385,6 +1386,11 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>  		if (is_migration_entry(entry))
>  			page = migration_entry_to_page(entry);
>  
> +		if (is_hwpoison_entry(entry)) {
> +			page = hwpoison_entry_to_page(entry);
> +			flags |= PM_HWPOISON;
> +		}
> +
>  		if (is_device_private_entry(entry))
>  			page = device_private_entry_to_page(entry);
>  	}
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d9b7c9132c2f..1b9dedbd06ab 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -323,6 +323,13 @@ static inline int is_hwpoison_entry(swp_entry_t entry)
>  	return swp_type(entry) == SWP_HWPOISON;
>  }
>  
> +static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> +{
> +	struct page *p = pfn_to_page(swp_offset(entry));
> +	WARN_ON(!PageHWPoison(p));
> +	return p;
> +}
> +
>  static inline void num_poisoned_pages_inc(void)
>  {
>  	atomic_long_inc(&num_poisoned_pages);
> @@ -345,6 +352,11 @@ static inline int is_hwpoison_entry(swp_entry_t swp)
>  	return 0;
>  }
>  
> +static inline struct page *hwpoison_entry_to_page(swp_entry_t entry)
> +{
> +	return NULL;
> +}
> +
>  static inline void num_poisoned_pages_inc(void)
>  {
>  }
> diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
> index 0517c744b04e..1160d5a14955 100644
> --- a/tools/vm/page-types.c
> +++ b/tools/vm/page-types.c
> @@ -53,6 +53,7 @@
>  #define PM_SWAP_OFFSET(x)	(((x) & PM_PFRAME_MASK) >> MAX_SWAPFILES_SHIFT)
>  #define PM_SOFT_DIRTY		(1ULL << 55)
>  #define PM_MMAP_EXCLUSIVE	(1ULL << 56)
> +#define PM_HWPOISON		(1ULL << 60)
>  #define PM_FILE			(1ULL << 61)
>  #define PM_SWAP			(1ULL << 62)
>  #define PM_PRESENT		(1ULL << 63)
> @@ -311,6 +312,8 @@ static unsigned long pagemap_pfn(uint64_t val)
>  
>  	if (val & PM_PRESENT)
>  		pfn = PM_PFRAME(val);
> +	else if (val & PM_HWPOISON)
> +		pfn = PM_SWAP_OFFSET(val);
>  	else
>  		pfn = 0;
>  
> @@ -742,7 +745,7 @@ static void walk_vma(unsigned long index, unsigned long count)
>  			pfn = pagemap_pfn(buf[i]);
>  			if (pfn)
>  				walk_pfn(index + i, pfn, 1, buf[i]);
> -			if (buf[i] & PM_SWAP)
> +			else if (buf[i] & PM_SWAP)
>  				walk_swap(index + i, buf[i]);
>  		}
>  



-- 
Thanks!
Aili Yao
