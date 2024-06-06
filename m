Return-Path: <linux-edac+bounces-1226-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1838FF380
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 19:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A511F234BF
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE59D198E90;
	Thu,  6 Jun 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZOpp7+g"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A8195B1E;
	Thu,  6 Jun 2024 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694169; cv=none; b=ANkrG1IrC425msTDV1ZOhgWpkwx+fbXJDNGbljsJtJ3xfecMSmKRrChOmzdXHpAhh9GqgxuduglC62Z2VXd92kXHbbyRUH0ij16jPZp1O9/arbBdKZZoOIv9B+hZpuwC/Im968/hbfjC/kKHMZCd4f6KCfBsY2T+pZyNOpN1FKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694169; c=relaxed/simple;
	bh=EmENuP/0WrhU+AYR+dKTRxH3d014P3mfyl5SZikIGcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzEB37FDIG23GAATLQGMYUv7iFzwd750Bl2YeFVBwB+9QdH1RGezEBue5UzEM65z7I5LZdgKPhnog5Nvhruz69bco/brwoKLH0O9Ru15hx3FIbM+zll52LIpmNZhBwHYjoSGiwXNik6h9/0Otu4Q+1S0Y0F/R981FMExP5GjUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZOpp7+g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717694168; x=1749230168;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EmENuP/0WrhU+AYR+dKTRxH3d014P3mfyl5SZikIGcY=;
  b=HZOpp7+gwUWmXTl9GSJBkp8LA/W6gumlksA+pGiyAv1yMmiZgFta5V8/
   8qRFQZbfxSG2NB7oYtsM2Q10XAJ+6+xwUjaIImunM28Qvsrnp5Zz4yAIp
   MtZym+aak3Fac/+hy336HNKW7uKPTN6EvyVNCib0tKeE6oiZHsPlxwILn
   T6raLrVkAeLbbhBRBllWjhLKoKJeB3B07iYlTYCXSLj/fLc9NYLzya8mU
   qQozJV2a8/dHRqTQzASWffmmYsAQO2Hs+3fsXIv7FfLO/oVVSJ/wjiAD/
   Lwx2bt83vLzS3tNnhkx5/ujRht/Odq/qNuhyY6jdwcpChG36Hkkf/gCkk
   g==;
X-CSE-ConnectionGUID: zhJ5kwVPQkqWsJ5LdZsV3Q==
X-CSE-MsgGUID: 4Fd6XVrFSdWzJfcsMvX/rQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="14189539"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="14189539"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 10:15:56 -0700
X-CSE-ConnectionGUID: rzJkR3G2QmGtO4Ya3jlk+g==
X-CSE-MsgGUID: XrpE4k2+Rxu7jkhYm1x1IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="42611051"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 06 Jun 2024 10:15:54 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFGiN-0003TE-1K;
	Thu, 06 Jun 2024 17:15:51 +0000
Date: Fri, 7 Jun 2024 01:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH v2 07/13] mm/memory-failure: simplify unneeded
 hwpoison_filter() variant
Message-ID: <202406070136.hGQwVbsv-lkp@intel.com>
References: <20240606063247.712575-8-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606063247.712575-8-linmiaohe@huawei.com>

Hi Miaohe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 19b8422c5bd56fb5e7085995801c6543a98bda1f]

url:    https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-memory-failure-simplify-put_ref_page/20240606-143939
base:   19b8422c5bd56fb5e7085995801c6543a98bda1f
patch link:    https://lore.kernel.org/r/20240606063247.712575-8-linmiaohe%40huawei.com
patch subject: [PATCH v2 07/13] mm/memory-failure: simplify unneeded hwpoison_filter() variant
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240607/202406070136.hGQwVbsv-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240607/202406070136.hGQwVbsv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406070136.hGQwVbsv-lkp@intel.com/

All errors (new ones prefixed by >>):

>> mm/memory-failure.c:299:19: error: static declaration of 'hwpoison_filter' follows non-static declaration
     299 | static inline int hwpoison_filter(struct page *p)
         |                   ^~~~~~~~~~~~~~~
   In file included from mm/memory-failure.c:64:
   mm/internal.h:1072:12: note: previous declaration of 'hwpoison_filter' with type 'int(struct page *)'
    1072 | extern int hwpoison_filter(struct page *p);
         |            ^~~~~~~~~~~~~~~


vim +/hwpoison_filter +299 mm/memory-failure.c

   280	
   281	int hwpoison_filter(struct page *p)
   282	{
   283		if (!hwpoison_filter_enable)
   284			return 0;
   285	
   286		if (hwpoison_filter_dev(p))
   287			return -EINVAL;
   288	
   289		if (hwpoison_filter_flags(p))
   290			return -EINVAL;
   291	
   292		if (hwpoison_filter_task(p))
   293			return -EINVAL;
   294	
   295		return 0;
   296	}
   297	EXPORT_SYMBOL_GPL(hwpoison_filter);
   298	#else
 > 299	static inline int hwpoison_filter(struct page *p)
   300	{
   301		return 0;
   302	}
   303	#endif
   304	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

