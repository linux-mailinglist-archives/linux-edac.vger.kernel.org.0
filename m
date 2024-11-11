Return-Path: <linux-edac+bounces-2495-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8B9C3DE0
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 13:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16151B22C38
	for <lists+linux-edac@lfdr.de>; Mon, 11 Nov 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512F417C227;
	Mon, 11 Nov 2024 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ufns7pd4"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB84717C91;
	Mon, 11 Nov 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731326484; cv=none; b=Zsh52CxMhrBHmpy4pK6F3otfdSnGqDEl4wtSRsHOCfZLiohPig8MI/Abh/XVTs5JIgmV/0wnUCstR+vkrv0mMYpPtTOgTMfFE52kBs3Uk66LO6drzd7mfRUxnoWzloP2a+/L7Q59jC0ZbrPT9iOeRgxkYcu+rSKtW57L5QYAE/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731326484; c=relaxed/simple;
	bh=zVuvjtKAs+LjZH1OYuewCYgzwIIhVlFF6h3ovVOjueM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBqlhPMdKL43q10KgzfFBijdSieErjt3by9JtqFPRCjsIXtmVquCMNuDeODO5HloJCw7XSXNN8TITgS4xa7GWQEXu3J9rGjI0+eo6bYjFPlHS3by2eSu/xoNmZkOfHRmFmuLGY3/RKYFN4UMlKxmlUqidviPpHHCZ+zvTDYnWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ufns7pd4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731326483; x=1762862483;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVuvjtKAs+LjZH1OYuewCYgzwIIhVlFF6h3ovVOjueM=;
  b=Ufns7pd4OP0DNefefIumqxTm8QQpSUGZ78Zca4AWP6VNXVkwETXBXUFJ
   P192/UyLct6zxFJ43w1LUeIZHMy7aAy1kAVUozdOmO+1xUgvOZPZ6qnZh
   xuI3hMKtxkgaWSOcHUfbezGgzPurkgOrkUU3ZdRmzUowxzCYrCuPOnxUf
   GSCI6bb7GmKdgLIO5gWDKpLW1wiXxeiU7v/Wx6Qc3kW2L2a7TFDLAdw7Q
   Cj2wcmXCW65+vgw2vVV4NF/Qjdp1Nspq7eL3u0vD7gHkU89qRZCZYJxSW
   Z4Zq8wc53cOuJwJ4fT6drD6SV4lP4NRZ0XnXFwOGiXro8IKc/PTFayFyu
   A==;
X-CSE-ConnectionGUID: Z7nn/L/ITDaLvCZf/pFRkQ==
X-CSE-MsgGUID: d+22ClzqTDKRMUFgF8ZusQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31088993"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31088993"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 04:01:22 -0800
X-CSE-ConnectionGUID: rcCRq3O5TAKxfIenzt6Qsw==
X-CSE-MsgGUID: Vp/HE32DSgeoXzxisVcxYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="124453001"
Received: from lkp-server01.sh.intel.com (HELO dc8184e5aea1) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Nov 2024 04:01:19 -0800
Received: from kbuild by dc8184e5aea1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAT6a-0000G9-1N;
	Mon, 11 Nov 2024 12:01:16 +0000
Date: Mon, 11 Nov 2024 20:01:04 +0800
From: kernel test robot <lkp@intel.com>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, chenhuacai@kernel.org,
	bp@alien8.de
Cc: oe-kbuild-all@lists.linux.dev, linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@xen0n.name, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, loongarch@lists.linux.dev,
	Zhao Qunqin <zhaoqunqin@loongson.cn>
Subject: Re: [PATCH v7 2/2] EDAC: Add EDAC driver for loongson memory
 controller
Message-ID: <202411111918.lhNjQmXB-lkp@intel.com>
References: <20241111060939.5349-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111060939.5349-3-zhaoqunqin@loongson.cn>

Hi Zhao,

kernel test robot noticed the following build errors:

[auto build test ERROR on e14232afa94445e03fc3a0291b07a68f3408c120]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhao-Qunqin/dt-bindings-EDAC-for-ls3a5000-memory-controller/20241111-141155
base:   e14232afa94445e03fc3a0291b07a68f3408c120
patch link:    https://lore.kernel.org/r/20241111060939.5349-3-zhaoqunqin%40loongson.cn
patch subject: [PATCH v7 2/2] EDAC: Add EDAC driver for loongson memory controller
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20241111/202411111918.lhNjQmXB-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241111/202411111918.lhNjQmXB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411111918.lhNjQmXB-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/edac/loongson_edac.c: In function 'read_ecc':
>> drivers/edac/loongson_edac.c:28:15: error: implicit declaration of function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
      28 |         ecc = readq(pvt->ecc_base + ECC_CS_COUNT_REG);
         |               ^~~~~
         |               readl
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +28 drivers/edac/loongson_edac.c

    18	
    19	static int read_ecc(struct mem_ctl_info *mci)
    20	{
    21		struct loongson_edac_pvt *pvt = mci->pvt_info;
    22		u64 ecc;
    23		int cs;
    24	
    25		if (!pvt->ecc_base)
    26			return pvt->last_ce_count;
    27	
  > 28		ecc = readq(pvt->ecc_base + ECC_CS_COUNT_REG);
    29		/* cs0 -- cs3 */
    30		cs = ecc & 0xff;
    31		cs += (ecc >> 8) & 0xff;
    32		cs += (ecc >> 16) & 0xff;
    33		cs += (ecc >> 24) & 0xff;
    34	
    35		return cs;
    36	}
    37	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

