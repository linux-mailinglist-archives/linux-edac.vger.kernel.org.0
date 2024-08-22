Return-Path: <linux-edac+bounces-1721-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBF095A892
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 02:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5028333C
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 00:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B9EEC7;
	Thu, 22 Aug 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S6CjJRkX"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3DEA3D;
	Thu, 22 Aug 2024 00:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724285291; cv=none; b=XhgiFLaY5LauY0UH6TEwy0xS6WJviUWEvL2vpB/KrFCYt3BdhY7N1vyKFY2X9yjMhXBkGCQhSTXqX7rq7gnZcLghPtnlw7iMU8CEOHvMFLx2E+UmPjtweKDiRcZffk/s2Gmt6Sh7dnwSLuksDhH+MxqFUbf0AJafgsw8yi8jvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724285291; c=relaxed/simple;
	bh=vgfOndwrjlpq8T9jckd7c4m1f+9iW2L/9WwWjTdusj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3LqrLDrI2sxYmeTXwWIpHX68mRgcKeOvQFn5lJ1USuaGKpiPSGxEyaR5bj58+4pH3NEhduq8t5Y1WRGZO5AZLMdyajEmHnZIMwJBu/6IWda/l++Rj50MY2tRhWZJ/Uad4ZWo4g9AxQSykOPXVYnqb1XHhXRCskjXzs71avDFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S6CjJRkX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724285289; x=1755821289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgfOndwrjlpq8T9jckd7c4m1f+9iW2L/9WwWjTdusj0=;
  b=S6CjJRkXw4AwC4v3aAg+4H/FVac3iNs9XSkUa2rAy0F1eUS100+tnG0G
   NsHlVHSW4/Y7jgriFYPitwz8fPHRz6uFuaslpARo9xTCcIAYX760WVbqI
   NgWAH0PKf0Kce9r3kCnQ4MwI4Z5PEASwHjimxu6raYqVB/1JyoS+w2RXf
   aL15N8Ow3sP2oWcyc+JXjZYEQxzuIUCGr/e3+Z7qRuSF9f0yzpuXQ4DLT
   PafrFGvDILPaEK1t+dDxVmn/fRmbHPzeSU6NlmBwFlD/MsSUHKgyn8umJ
   RSue/7yloLWehmSIT8RLwsAM3umu+lB+ce3OI+zFC7ztqvRCn5P01FLAj
   w==;
X-CSE-ConnectionGUID: eqD65my9Tcq29KqaCO0ZuQ==
X-CSE-MsgGUID: veKfKSiOQACdMFc0CgB+Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22842930"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22842930"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 17:08:08 -0700
X-CSE-ConnectionGUID: LZBuqbL4RZiT/6eseKCY6A==
X-CSE-MsgGUID: 6EjppWBSQliFO65ITpIXsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="84433107"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 17:08:05 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgvMx-000C4S-0O;
	Thu, 22 Aug 2024 00:08:03 +0000
Date: Thu, 22 Aug 2024 08:07:07 +0800
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
Message-ID: <202408220634.Irq2TUcL-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on ras/edac-for-next]
[also build test ERROR on robh/for-next linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhao-Qunqin/Loongarch-EDAC-driver-for-loongson-memory-controller/20240821-145127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240821064728.8642-2-zhaoqunqin%40loongson.cn
patch subject: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory controller
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20240822/202408220634.Irq2TUcL-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240822/202408220634.Irq2TUcL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408220634.Irq2TUcL-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/edac/loongson_edac.c: In function 'get_dimm_config':
>> drivers/edac/loongson_edac.c:90:16: error: implicit declaration of function 'EDAC_DIMM_PTR' [-Wimplicit-function-declaration]
      90 |         dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
         |                ^~~~~~~~~~~~~
>> drivers/edac/loongson_edac.c:90:14: error: assignment to 'struct dimm_info *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      90 |         dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
         |              ^
   drivers/edac/loongson_edac.c: At top level:
>> drivers/edac/loongson_edac.c:181:27: error: initialization of 'void (*)(struct platform_device *)' from incompatible pointer type 'int (*)(struct platform_device *)' [-Wincompatible-pointer-types]
     181 |         .remove         = loongson_edac_remove,
         |                           ^~~~~~~~~~~~~~~~~~~~
   drivers/edac/loongson_edac.c:181:27: note: (near initialization for 'loongson_edac_driver.<anonymous>.remove')


vim +/EDAC_DIMM_PTR +90 drivers/edac/loongson_edac.c

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
   101	static void loongson_pvt_init(struct mem_ctl_info *mci, u64 *vbase)
   102	{
   103		struct loongson_edac_pvt *pvt = mci->pvt_info;
   104	
   105		pvt->ecc_base = vbase;
   106		pvt->last_ce_count = loongson_read_ecc(mci);
   107	}
   108	
   109	static int loongson_edac_probe(struct platform_device *pdev)
   110	{
   111		struct resource *rs;
   112		struct mem_ctl_info *mci;
   113		struct edac_mc_layer layers[2];
   114		struct loongson_edac_pvt *pvt;
   115		u64 *vbase = NULL;
   116	
   117		rs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
   118		if (!rs)
   119			return -EINVAL;
   120		if (rs->start) {
   121			vbase = devm_ioremap(&pdev->dev, rs->start, resource_size(rs));
   122			if (!vbase)
   123				return -ENOMEM;
   124		}
   125	
   126		/* allocate a new MC control structure */
   127		layers[0].type = EDAC_MC_LAYER_CHANNEL;
   128		layers[0].size = 1;
   129		layers[0].is_virt_csrow = false;
   130		layers[1].type = EDAC_MC_LAYER_SLOT;
   131		layers[1].size = 1;
   132		layers[1].is_virt_csrow = true;
   133		mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
   134		if (mci == NULL)
   135			return -ENOMEM;
   136	
   137		edac_dbg(0, "MC: mci = %p\n", mci);
   138	
   139		mci->mc_idx = idx++;
   140		mci->mtype_cap = MEM_FLAG_RDDR4;
   141		mci->edac_ctl_cap = EDAC_FLAG_NONE;
   142		mci->edac_cap = EDAC_FLAG_NONE;
   143		mci->mod_name = "loongson_edac.c";
   144		mci->ctl_name = "loongson_edac_ctl";
   145		mci->dev_name = "loongson_edac_dev";
   146		mci->ctl_page_to_phys = NULL;
   147		mci->pdev = &pdev->dev;
   148		mci->error_desc.grain = 8;
   149		/* Set the function pointer to an actual operation function */
   150		mci->edac_check = loongson_edac_check;
   151	
   152		loongson_pvt_init(mci, vbase);
   153		get_dimm_config(mci);
   154	
   155		if (edac_mc_add_mc(mci)) {
   156			edac_dbg(0, "MC: failed edac_mc_add_mc()\n");
   157			edac_mc_free(mci);
   158		}
   159		return 0;
   160	}
   161	
   162	static int loongson_edac_remove(struct platform_device *pdev)
   163	{
   164		struct mem_ctl_info *mci = edac_mc_del_mc(&pdev->dev);
   165	
   166		if (mci) {
   167			edac_mc_free(mci);
   168			return 0;
   169		}
   170		return -ENODEV;
   171	}
   172	
   173	static const struct of_device_id loongson_edac_of_match[] = {
   174		{ .compatible = "loongson,ls-mc-edac", },
   175		{}
   176	};
   177	MODULE_DEVICE_TABLE(of, loongson_edac_of_match);
   178	
   179	static struct platform_driver loongson_edac_driver = {
   180		.probe		= loongson_edac_probe,
 > 181		.remove		= loongson_edac_remove,
   182		.driver		= {
   183			.name	= "ls-mc-edac",
   184			.owner = THIS_MODULE,
   185			.of_match_table = loongson_edac_of_match,
   186		},
   187	};
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

