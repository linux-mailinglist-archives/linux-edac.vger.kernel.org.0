Return-Path: <linux-edac+bounces-1130-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9D98CEDAD
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 04:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8811C2230E
	for <lists+linux-edac@lfdr.de>; Sat, 25 May 2024 02:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63055139F;
	Sat, 25 May 2024 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzB1IYI6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3111877;
	Sat, 25 May 2024 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716604766; cv=none; b=WZpPdSxPsuqd03r9/OkH8XZq2CEMdxghMkGgIAdoxsj7E22tGp1dWqKGsPzbidsbp1/8mkcijigJGCTuctKwLzERT2WSXnVMUS3M2v8tlm4VvsXOFm3OCvNrdv6mpDrqvGPZQQnNXh67yD9ZNkKFhuy6zMbbj3fXiBWzbnFoN7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716604766; c=relaxed/simple;
	bh=rkOH6L+W7aZnSSaSuMD+3YpBPBhp6pBQvLG8T6pSwuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJZjGVeenmjopbDPKw/jaS7YlQqiySCr2Y0+DzMHtIUKlFrlIoW3U8nfcy3IorZORzXqkBVRul5XuejWOdfOmrhI0zrNQlrLhitCplbxx5v5dw8e0pgrJlE0GdnWEvTokqF39jQb2XeblNgxqC3FcFKpNs91R53ZB9jnsJe2OSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzB1IYI6; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716604763; x=1748140763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rkOH6L+W7aZnSSaSuMD+3YpBPBhp6pBQvLG8T6pSwuM=;
  b=HzB1IYI6dShtXSwpzD2dvU+GAzg8XbWXUN5kfzNO1XvigUH5CxoXyfXA
   zWJgN0dbsM8bnSyl1SiFBQLdzJNwya/UiZcqYTyDihzXVEfKjVIWnmMMw
   u5WGmyndDFgxcPCYef7i9fUTCdDHBKUzZ4SdJkUe5q34cRqk8cGRdH0L4
   RBcWAYhtrsxOBgEMgFvyhMbLqCn9GwAgQCMstol/06B5cFJIYsUJcGKy/
   rJEi0uMz1NWnxx/OHhFxzq8UQjuNTVsWBXaKB9LBdYm9wD9ArMrMrwU7B
   oDqcy3CjSgS2FhA7Q94XSxxRLkUGTdZfwWHdaLXRgSyXhsVLoZKg8FyAM
   Q==;
X-CSE-ConnectionGUID: zJD90U/ETImhFvJg5pGGcA==
X-CSE-MsgGUID: g/QO7xpMTfSbXFppT1pJzw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="30528694"
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="30528694"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 19:39:22 -0700
X-CSE-ConnectionGUID: NZrcuIz0SDGNS4WCv5LMJQ==
X-CSE-MsgGUID: PRuO5gB3SiCkY3R4WW3hnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,187,1712646000"; 
   d="scan'208";a="39181932"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 24 May 2024 19:39:20 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAhJV-0006Nn-1W;
	Sat, 25 May 2024 02:39:17 +0000
Date: Sat, 25 May 2024 10:39:09 +0800
From: kernel test robot <lkp@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 10/13] mm/memory-failure: move some function declarations
 into internal.h
Message-ID: <202405251049.hxjwX7zO-lkp@intel.com>
References: <20240524091310.1430048-11-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240524091310.1430048-11-linmiaohe@huawei.com>

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
patch link:    https://lore.kernel.org/r/20240524091310.1430048-11-linmiaohe%40huawei.com
patch subject: [PATCH 10/13] mm/memory-failure: move some function declarations into internal.h
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20240525/202405251049.hxjwX7zO-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405251049.hxjwX7zO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405251049.hxjwX7zO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vfio/vfio_iommu_spapr_tce.c: In function 'tce_page_is_contained':
>> drivers/vfio/vfio_iommu_spapr_tce.c:195:16: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
     195 |         return page_shift(compound_head(page)) >= it_page_shift;
         |                ^~~~~~~~~~
         |                page_size
   cc1: some warnings being treated as errors
--
   arch/powerpc/mm/book3s64/iommu_api.c: In function 'mm_iommu_do_alloc':
>> arch/powerpc/mm/book3s64/iommu_api.c:155:45: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
     155 |                                 pageshift = page_shift(compound_head(page));
         |                                             ^~~~~~~~~~
         |                                             page_size
   cc1: some warnings being treated as errors
--
   drivers/net/ethernet/ibm/ehea/ehea_qmr.c: In function 'ehea_is_hugepage':
>> drivers/net/ethernet/ibm/ehea/ehea_qmr.c:676:13: error: implicit declaration of function 'page_shift'; did you mean 'page_size'? [-Werror=implicit-function-declaration]
     676 |         if (page_shift(pfn_to_page(pfn)) != EHEA_HUGEPAGESHIFT)
         |             ^~~~~~~~~~
         |             page_size
   cc1: some warnings being treated as errors


vim +195 drivers/vfio/vfio_iommu_spapr_tce.c

2157e7b82f3b81 Alexey Kardashevskiy    2015-06-05  179  
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  180  static bool tce_page_is_contained(struct mm_struct *mm, unsigned long hpa,
94ad9338109fe9 Matthew Wilcox (Oracle  2019-09-23  181) 		unsigned int it_page_shift)
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  182  {
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  183  	struct page *page;
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  184  	unsigned long size = 0;
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  185  
94ad9338109fe9 Matthew Wilcox (Oracle  2019-09-23  186) 	if (mm_iommu_is_devmem(mm, hpa, it_page_shift, &size))
94ad9338109fe9 Matthew Wilcox (Oracle  2019-09-23  187) 		return size == (1UL << it_page_shift);
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  188  
c10c21efa4bcca Alexey Kardashevskiy    2018-12-19  189  	page = pfn_to_page(hpa >> PAGE_SHIFT);
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  190  	/*
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  191  	 * Check that the TCE table granularity is not bigger than the size of
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  192  	 * a page we just found. Otherwise the hardware can get access to
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  193  	 * a bigger memory chunk that it should.
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  194  	 */
94ad9338109fe9 Matthew Wilcox (Oracle  2019-09-23 @195) 	return page_shift(compound_head(page)) >= it_page_shift;
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  196  }
e432bc7e15d802 Alexey Kardashevskiy    2015-06-05  197  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

