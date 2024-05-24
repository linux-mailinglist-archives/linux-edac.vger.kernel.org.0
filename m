Return-Path: <linux-edac+bounces-1127-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191198CE863
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 18:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCD1C21388
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 16:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9080812E1FE;
	Fri, 24 May 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVbzhpcm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C0912C488;
	Fri, 24 May 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716566431; cv=none; b=NtJw4zM6YpZRE8WWcwkJoeFq6iSa2/bvNljOszy6QGt3AKbpiQ/wYARHAbpdj6IjQBv8Uit2foUOeUMlIA3nqLlWrR9RuvoJErDg1vokriTPbf9W3KUB2dDscjLnFaNR2OoYCmXLrrAa8yFeetK/hjnIwaRgjmBUxXbG+IaojTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716566431; c=relaxed/simple;
	bh=cIkbosX3WAgkpupjWKvUxqpqI35ry0vgf/GaC4+aR9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRLJ2J7IMZpWpb+20Q3OKHk9TMvPHL8tZ5zplMJeXryc2p+/bLNW6QuZdMDcqEFzqXpCnfkpZY2XriAfuhvByNcoHQIMmZZijVOdbT5T2t7Jdb3PXPRO4HAmWmlz0xYvQ9N6ftnAqvYywtnqdsX/7SbTc7uD/ivLjq/zU/3FNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVbzhpcm; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716566429; x=1748102429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cIkbosX3WAgkpupjWKvUxqpqI35ry0vgf/GaC4+aR9Y=;
  b=GVbzhpcmTow9gJ1veSxSPnZEnhIb3jpha028NAF8dKNzpwnS5Sgb5q15
   IJpMhw+Sl3Q2vVRn+yLcGf/PhaNFRVRfXSlMFRt2iZYnp80wFz5W7F4NB
   JWzpn6KhfnwyQoXkFMB9KesK2AfO9+MbftkUt6LKDS+LFGuxBqokjl0XU
   aRqG3eTcExRAEbsW1jhUgpe2mVPNMDuy7lRjdcYpjzug7xm65MfimRkFT
   xTF7/UD9KSPbhpANh6yNMcC/oqawcrhDjSi4JEoYK7UVM/O/UXtdbuviE
   a3J+Q90B6j5JRGF+fVpLjrkfiXyjrvYCoaj54XqPXgQ+hCNSOMcGIKzpr
   A==;
X-CSE-ConnectionGUID: XfHwGAVWTj+ZTXpAs87F7w==
X-CSE-MsgGUID: LqdOxGN1Qzmb8y6yv7iC/A==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="23614791"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="23614791"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 09:00:28 -0700
X-CSE-ConnectionGUID: glhMuJ8BRzKyS4JocldrYg==
X-CSE-MsgGUID: GlAbNeCwTTW2ihAl+Szi2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="71478838"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 May 2024 09:00:26 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAXLC-0005a9-31;
	Fri, 24 May 2024 16:00:22 +0000
Date: Fri, 24 May 2024 23:59:43 +0800
From: kernel test robot <lkp@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 07/13] mm/memory-failure: remove unneeded
 hwpoison_filter() variant
Message-ID: <202405242336.o1NEOrln-lkp@intel.com>
References: <20240524091310.1430048-8-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524091310.1430048-8-linmiaohe@huawei.com>

Hi Miaohe,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master next-20240523]
[cannot apply to v6.9]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-memory-failure-simplify-put_ref_page/20240524-171903
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20240524091310.1430048-8-linmiaohe%40huawei.com
patch subject: [PATCH 07/13] mm/memory-failure: remove unneeded hwpoison_filter() variant
config: i386-randconfig-005-20240524 (https://download.01.org/0day-ci/archive/20240524/202405242336.o1NEOrln-lkp@intel.com/config)
compiler: gcc-11 (Ubuntu 11.4.0-4ubuntu1) 11.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405242336.o1NEOrln-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405242336.o1NEOrln-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/memory-failure.o: in function `try_memory_failure_hugetlb':
>> mm/memory-failure.c:2098:(.text+0x28a8): undefined reference to `hwpoison_filter'
   ld: mm/memory-failure.o: in function `memory_failure':
   mm/memory-failure.c:2321:(.text+0x2a98): undefined reference to `hwpoison_filter'
   ld: mm/memory-failure.o: in function `soft_offline_page':
   mm/memory-failure.c:2841:(.text+0x3217): undefined reference to `hwpoison_filter'


vim +2098 mm/memory-failure.c

405ce051236cc6 Naoya Horiguchi         2022-04-21  2057  
405ce051236cc6 Naoya Horiguchi         2022-04-21  2058  /*
405ce051236cc6 Naoya Horiguchi         2022-04-21  2059   * Taking refcount of hugetlb pages needs extra care about race conditions
405ce051236cc6 Naoya Horiguchi         2022-04-21  2060   * with basic operations like hugepage allocation/free/demotion.
405ce051236cc6 Naoya Horiguchi         2022-04-21  2061   * So some of prechecks for hwpoison (pinning, and testing/setting
405ce051236cc6 Naoya Horiguchi         2022-04-21  2062   * PageHWPoison) should be done in single hugetlb_lock range.
405ce051236cc6 Naoya Horiguchi         2022-04-21  2063   */
405ce051236cc6 Naoya Horiguchi         2022-04-21  2064  static int try_memory_failure_hugetlb(unsigned long pfn, int flags, int *hugetlb)
0348d2ebec9b00 Naoya Horiguchi         2017-07-10  2065  {
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2066  	int res;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2067  	struct page *p = pfn_to_page(pfn);
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2068  	struct folio *folio;
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2069  	unsigned long page_flags;
e591ef7d96d6ea Naoya Horiguchi         2022-10-24  2070  	bool migratable_cleared = false;
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2071  
405ce051236cc6 Naoya Horiguchi         2022-04-21  2072  	*hugetlb = 1;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2073  retry:
e591ef7d96d6ea Naoya Horiguchi         2022-10-24  2074  	res = get_huge_page_for_hwpoison(pfn, flags, &migratable_cleared);
405ce051236cc6 Naoya Horiguchi         2022-04-21  2075  	if (res == 2) { /* fallback to normal page handling */
405ce051236cc6 Naoya Horiguchi         2022-04-21  2076  		*hugetlb = 0;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2077  		return 0;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2078  	} else if (res == -EHWPOISON) {
96f96763de26d6 Kefeng Wang             2022-07-26  2079  		pr_err("%#lx: already hardware poisoned\n", pfn);
405ce051236cc6 Naoya Horiguchi         2022-04-21  2080  		if (flags & MF_ACTION_REQUIRED) {
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2081  			folio = page_folio(p);
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2082  			res = kill_accessing_process(current, folio_pfn(folio), flags);
38fe2f81155c0e Jane Chu                2024-05-21  2083  			action_result(pfn, MF_MSG_ALREADY_POISONED, MF_FAILED);
38fe2f81155c0e Jane Chu                2024-05-21  2084  			return res;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2085  		}
405ce051236cc6 Naoya Horiguchi         2022-04-21  2086  		return res;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2087  	} else if (res == -EBUSY) {
38f6d29397ccb9 Naoya Horiguchi         2022-07-14  2088  		if (!(flags & MF_NO_RETRY)) {
38f6d29397ccb9 Naoya Horiguchi         2022-07-14  2089  			flags |= MF_NO_RETRY;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2090  			goto retry;
405ce051236cc6 Naoya Horiguchi         2022-04-21  2091  		}
38fe2f81155c0e Jane Chu                2024-05-21  2092  		return action_result(pfn, MF_MSG_GET_HWPOISON, MF_IGNORED);
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2093  	}
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2094  
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2095  	folio = page_folio(p);
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2096  	folio_lock(folio);
405ce051236cc6 Naoya Horiguchi         2022-04-21  2097  
e37e7b0b3bd52e Naoya Horiguchi         2021-12-24 @2098  	if (hwpoison_filter(p)) {
2ff6cecee669bf Sidhartha Kumar         2023-01-12  2099  		folio_clear_hugetlb_hwpoison(folio);
e591ef7d96d6ea Naoya Horiguchi         2022-10-24  2100  		if (migratable_cleared)
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2101  			folio_set_hugetlb_migratable(folio);
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2102  		folio_unlock(folio);
f36a5543a74883 Miaohe Lin              2022-08-18  2103  		if (res == 1)
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2104  			folio_put(folio);
f36a5543a74883 Miaohe Lin              2022-08-18  2105  		return -EOPNOTSUPP;
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2106  	}
405ce051236cc6 Naoya Horiguchi         2022-04-21  2107  
405ce051236cc6 Naoya Horiguchi         2022-04-21  2108  	/*
405ce051236cc6 Naoya Horiguchi         2022-04-21  2109  	 * Handling free hugepage.  The possible race with hugepage allocation
405ce051236cc6 Naoya Horiguchi         2022-04-21  2110  	 * or demotion can be prevented by PageHWPoison flag.
405ce051236cc6 Naoya Horiguchi         2022-04-21  2111  	 */
405ce051236cc6 Naoya Horiguchi         2022-04-21  2112  	if (res == 0) {
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2113  		folio_unlock(folio);
f40962a5b0bca2 Miaohe Lin              2024-05-23  2114  		if (__page_handle_poison(p) > 0) {
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2115  			page_ref_inc(p);
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2116  			res = MF_RECOVERED;
ceaf8fbea79a85 Naoya Horiguchi         2022-07-14  2117  		} else {
ceaf8fbea79a85 Naoya Horiguchi         2022-07-14  2118  			res = MF_FAILED;
a8b2c2ce89d4e0 Oscar Salvador          2020-12-14  2119  		}
b66d00dfebe79e Kefeng Wang             2022-10-21  2120  		return action_result(pfn, MF_MSG_FREE_HUGE, res);
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2121  	}
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2122  
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2123  	page_flags = folio->flags;
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2124  
03468a0f52893b Matthew Wilcox (Oracle  2024-04-12  2125) 	if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
bc1cfde1946752 Sidhartha Kumar         2023-01-12  2126  		folio_unlock(folio);
38fe2f81155c0e Jane Chu                2024-05-21  2127  		return action_result(pfn, MF_MSG_UNMAP_FAILED, MF_FAILED);
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2128  	}
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2129  
ea6d0630100b28 Naoya Horiguchi         2021-06-24  2130  	return identify_page_state(pfn, p, page_flags);
761ad8d7c7b548 Naoya Horiguchi         2017-07-10  2131  }
00cc790e003693 Shiyang Ruan            2022-06-03  2132  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

