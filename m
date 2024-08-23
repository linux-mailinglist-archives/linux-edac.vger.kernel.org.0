Return-Path: <linux-edac+bounces-1726-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3216795C35F
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 04:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C219DB21C85
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2024 02:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA70824B4A;
	Fri, 23 Aug 2024 02:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBTLKsmj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A7020B33;
	Fri, 23 Aug 2024 02:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724380998; cv=none; b=M8dI+hJA0rXyrDt5iFfB65ZAhpjchT0RCpScXJhavj9vqu0EIIOAT7gFUwXrf++xafzxmJn9YS0eqDc2RrEyh54q2ZIKNFRqx4lqknqNcq4JnjyCU8kiNYyK6XaQV9wuHFQsTKaIg1jtJI1326bOlhPFl5pE3j/ZnjmBZMZ1mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724380998; c=relaxed/simple;
	bh=uP5IakzORudRLADCNa/D+ltxEuEvKGniLh27EekWsU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oa/laBael73GwQ9tWCNsPrgtiic/Ksp3I7OT27qmTM/myd/AykWdj7jTmV6zvsiVLueOdud7N2U3hQX/H6aLG90OqQzv1An9kq1wzU/GnZ7lho8XhaJbwF49XsWLKkE6Ic008y8ZyNOquCqabNV+uHUq7zLXWB9YlqGvsC/ALDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBTLKsmj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724380996; x=1755916996;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uP5IakzORudRLADCNa/D+ltxEuEvKGniLh27EekWsU8=;
  b=gBTLKsmj8PjPD+xNS+t9/TDT+DJkn79hkagrqINomjakX30QmSlNTKe6
   NMWRXsAWs/jAdlZX2O5GiH+n8U2mLQMXfFitP83HbPFi+6/SG5voERs+i
   c2RtG3o7dLgVG7ZnehTE1QqhQC0Ml5lmxV924PwoaDV7RJRdceANRjAUo
   EeEjrbImOxb4Z2tfmUuvuNNbLjF+Vk5DboA6clnGxQdnSmAUQKCEe88iy
   liUoCjRWU2cL+Y/Dbmffnoj8Oxw+AEcaT12kNdFk2e2N+qfk4zgNafPXJ
   +QZdO3Afh0TMSGzES/ezJGPW3OE/mmFI8LIyz/l8/wMu9cgDE2LwdfSje
   g==;
X-CSE-ConnectionGUID: f2A+RQw1Qs+sfD7/v2GPgA==
X-CSE-MsgGUID: cW6Zn8HTRoGRIHVBW9a10Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="33399132"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="33399132"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 19:43:15 -0700
X-CSE-ConnectionGUID: FZJsR5w5QVOE1ZQoxQVNlA==
X-CSE-MsgGUID: puxOFJv1Sqmw0BHB3GROnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="61509548"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 22 Aug 2024 19:43:12 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shKGb-000DOy-1P;
	Fri, 23 Aug 2024 02:43:09 +0000
Date: Fri, 23 Aug 2024 10:42:22 +0800
From: kernel test robot <lkp@intel.com>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org, zhaoqunqin <zhaoqunqin@loongson.cn>
Subject: Re: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory
 controller
Message-ID: <202408231055.okLH0uuC-lkp@intel.com>
References: <20240821064728.8642-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821064728.8642-2-zhaoqunqin@loongson.cn>

Hi Zhao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on robh/for-next linus/master v6.11-rc4 next-20240822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhao-Qunqin/Loongarch-EDAC-driver-for-loongson-memory-controller/20240821-145127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240821064728.8642-2-zhaoqunqin%40loongson.cn
patch subject: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory controller
config: loongarch-loongson3_defconfig (https://download.01.org/0day-ci/archive/20240823/202408231055.okLH0uuC-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240823/202408231055.okLH0uuC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408231055.okLH0uuC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/edac/loongson_edac.c: In function 'get_dimm_config':
   drivers/edac/loongson_edac.c:90:16: error: implicit declaration of function 'EDAC_DIMM_PTR' [-Werror=implicit-function-declaration]
      90 |         dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
         |                ^~~~~~~~~~~~~
>> drivers/edac/loongson_edac.c:90:14: warning: assignment to 'struct dimm_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      90 |         dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
         |              ^
   drivers/edac/loongson_edac.c: At top level:
   drivers/edac/loongson_edac.c:181:27: error: initialization of 'void (*)(struct platform_device *)' from incompatible pointer type 'int (*)(struct platform_device *)' [-Werror=incompatible-pointer-types]
     181 |         .remove         = loongson_edac_remove,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/edac/loongson_edac.c:181:27: note: (near initialization for 'loongson_edac_driver.<anonymous>.remove')
   cc1: some warnings being treated as errors


vim +90 drivers/edac/loongson_edac.c

    80	
    81	static int get_dimm_config(struct mem_ctl_info *mci)
    82	{
    83		u32 size, npages;
    84		struct dimm_info *dimm;
    85	
    86		/* size not used */
    87		size = -1;
    88		npages = MiB_TO_PAGES(size);
    89	
  > 90		dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
    91				0, 0, 0);
    92		dimm->nr_pages = npages;
    93		snprintf(dimm->label, sizeof(dimm->label),
    94				"MC#%uChannel#%u_DIMM#%u",
    95				mci->mc_idx, 0, 0);
    96		dimm->grain = 8;
    97	
    98		return 0;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

