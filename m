Return-Path: <linux-edac+bounces-1126-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C6D78CE82E
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 17:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F96281ED3
	for <lists+linux-edac@lfdr.de>; Fri, 24 May 2024 15:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3542712C539;
	Fri, 24 May 2024 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nSQF2Jj/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A274A18E;
	Fri, 24 May 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565135; cv=none; b=sRYYomWdSTUuUt4weuG6BHY9+9Q5YUfOXE0RuR4HaH/NpD6LKaTt1JYf6zvcvnfZaqZhr2Pnftx80+LJC5Kaq96uKad1q4hcaExkN367zOX/7yG7CdzeKIaHEfCkhZzv7fz8xnamAy+a7Q0Ia7zZCszz7rCSY63MfClMYfhWfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565135; c=relaxed/simple;
	bh=kYk06SxX57CYC24SFVq+/H0DxgP9yHPpH/MdNtWtWQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBRunFU/DCbnAY9Wl7iYUYZgXZ0sN9CtJbP+GD5a8nyLqbXzAoD6FfqAjhzZ0fi9+7AMKQkKXR5RU9IjOar3vC7EzU7RujdGuDxe2CPa4IZ8epjbg98rRtLpYsJHjVX3xbEwIFQV//UWx8vGALEjIkxxEyLT9SnvunhCN6FGD9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nSQF2Jj/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716565131; x=1748101131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kYk06SxX57CYC24SFVq+/H0DxgP9yHPpH/MdNtWtWQo=;
  b=nSQF2Jj/saQi5gQ2IJ/qpMjARgGijdZheTKKQJmp+uWMyhBqfnjKUYPh
   n73Y5f6q2cCVOFtjemPj5Hue4QY61cvfJd9BLIlhV40kuEgx6uqPi2O8S
   GyUxgk2kKE5bZrTxu53+Q+g+YfZBNNubtZe76iKHl1AhWqukIPanaeQQj
   uLMoDbTdNnpXWgO2XStYopF3PbZTH5XLL66Fyay6D8bA5XyScZUMUvour
   3oZ0s73noyvrATGHQClsgXr/zO6tc7QGpCOQqAfQtQfhZXGWEwk3dcnLX
   SaMl9GOl498qL6gg2u8jc4a2A3H++2KmumNFZkk+knBSlH4yYEGdb077C
   g==;
X-CSE-ConnectionGUID: 79sFvLq1RuOw6F2pDacs3w==
X-CSE-MsgGUID: Xc4lS0XRRrq4CuR45oVsqw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="23612196"
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="23612196"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 08:38:51 -0700
X-CSE-ConnectionGUID: F4JE8hhoSwWV0nyvY4TIjA==
X-CSE-MsgGUID: zZgUHyDDRDu5sL5pedVkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,185,1712646000"; 
   d="scan'208";a="38486302"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 24 May 2024 08:38:50 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAX0K-0005Yr-1K;
	Fri, 24 May 2024 15:38:48 +0000
Date: Fri, 24 May 2024 23:38:33 +0800
From: kernel test robot <lkp@intel.com>
To: Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
	tony.luck@intel.com, bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, nao.horiguchi@gmail.com,
	linmiaohe@huawei.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 07/13] mm/memory-failure: remove unneeded
 hwpoison_filter() variant
Message-ID: <202405242320.8nUwcaQN-lkp@intel.com>
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
config: i386-buildonly-randconfig-003-20240524 (https://download.01.org/0day-ci/archive/20240524/202405242320.8nUwcaQN-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240524/202405242320.8nUwcaQN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405242320.8nUwcaQN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: mm/memory-failure.o: in function `memory_failure':
>> memory-failure.c:(.text+0x2635): undefined reference to `hwpoison_filter'
>> ld: memory-failure.c:(.text+0x283d): undefined reference to `hwpoison_filter'
   ld: mm/memory-failure.o: in function `soft_offline_page':
   memory-failure.c:(.text+0x2e12): undefined reference to `hwpoison_filter'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

