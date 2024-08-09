Return-Path: <linux-edac+bounces-1637-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E89C94CF7D
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 13:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B32A1C21294
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 11:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B3D193085;
	Fri,  9 Aug 2024 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZaJbiXj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1D192B8F;
	Fri,  9 Aug 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204118; cv=none; b=UxY4RbHlnrHewbhJijDDzjQFAilEdJiCF0URffqbavJbZOuM+yxJWJKWwsu6A0iTnoYCOJXbn1OuQFP5dzRra63bthqe04bjJdM94qmg3sep6eu13+UHZq85RlyS53e7AeojXBK87An0e/zePX+HUdGnQahwHQf+nT3oCQld/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204118; c=relaxed/simple;
	bh=xzbTSU7hvjS4ZqdqP09hBUAYcDwniEeE/J0sXofj5Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMutysqi8hnGRYIdSOpb9+dKzZZBkDP1hW3owacyXBe+LPvWAJijfxLhTNKKZq8UZTUL3/jAtoiUEccGnC0OBg2nhL0z7EjT4B2ZJvrBYozX+aV0wbjPLBYkKK98o66JXFKyVZ1rkvRRi0QFdPzTq3HMmEQsFXKw6He45V2Kj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZaJbiXj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723204116; x=1754740116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xzbTSU7hvjS4ZqdqP09hBUAYcDwniEeE/J0sXofj5Hs=;
  b=CZaJbiXj0KnyEEKbazp2+CgxXAtMGqi/0XItqfuH2DIvavF6p5PO9WkD
   EPK/p9wlXoaICFyJGUskxz9dI0LxPpqHpewa+OSjPG8476WHkkiMeN3cw
   xlHoJ+3mgSx5w8lBLTmhk8j6b5FzFu/xTKfS/2VE3u7FvxhkJgcClfeks
   ILhjt82NkZ7u9VBlwGbOA82hls61+sJgidnwlevlINrgwI3V80CrepL5y
   AsMEQdh14XfYemzrFXGCIEO5vJ7Jd8IvNnooTXXkD9klFgWMmdgawh5yG
   rbyWflFFkDD1iVqxsqkgomchDJ6XOnVEAG01agf+NU9konnOvF646k/qi
   Q==;
X-CSE-ConnectionGUID: xXtUAkH9SaK+FAJ72rISpg==
X-CSE-MsgGUID: PI5u7VaxTnaRAR1PW2FJ0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21548723"
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="21548723"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 04:48:35 -0700
X-CSE-ConnectionGUID: GmvAt9TMShyFFtIoHfNpOg==
X-CSE-MsgGUID: 9XXBcAUVSH6fAeMx6zhw7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,276,1716274800"; 
   d="scan'208";a="62500435"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 09 Aug 2024 04:48:30 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scO6d-0007u6-2v;
	Fri, 09 Aug 2024 11:48:28 +0000
Date: Fri, 9 Aug 2024 19:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, dan.j.williams@intel.com,
	vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
	alison.schofield@intel.com
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, dave.jiang@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com, james.morse@arm.com,
	linmiaohe@huawei.com, mchehab@kernel.org, nao.horiguchi@gmail.com,
	rric@kernel.org, tony.luck@intel.com, ruansy.fnst@fujitsu.com
Subject: Re: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
Message-ID: <202408091914.TFbjPuNQ-lkp@intel.com>
References: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808151328.707869-3-ruansy.fnst@fujitsu.com>

Hi Shiyang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on cxl/next linus/master v6.11-rc2 next-20240809]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/cxl-core-introduce-device-reporting-poison-hanlding/20240809-013658
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240808151328.707869-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
config: x86_64-randconfig-121-20240809 (https://download.01.org/0day-ci/archive/20240809/202408091914.TFbjPuNQ-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408091914.TFbjPuNQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408091914.TFbjPuNQ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1465:1: sparse: sparse: symbol 'cxl_mce_records' was not declared. Should it be static?
   drivers/cxl/core/mbox.c: note: in included file (through include/linux/gfp.h, include/linux/xarray.h, include/linux/list_lru.h, ...):
   include/linux/mmzone.h:2018:40: sparse: sparse: self-comparison always evaluates to false

vim +/cxl_mce_records +1465 drivers/cxl/core/mbox.c

  1464	
> 1465	DEFINE_XARRAY(cxl_mce_records);
  1466	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

