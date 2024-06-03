Return-Path: <linux-edac+bounces-1164-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DBB8D80DA
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 13:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FBF1C2115E
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B099784A23;
	Mon,  3 Jun 2024 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="je2tT8Uv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D231A77109
	for <linux-edac@vger.kernel.org>; Mon,  3 Jun 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717413466; cv=none; b=rQyMQWZtXMCi77XRMWsY2dxU88nl9iQ5hhHBLZWcEuPLdSKlNiuadAxOdS97KkdmHVkZ/451a8khcbuJQZqmMfG9IaTS3y+WxwaH1P74DUgZIolkgwm2cy4m2UUD0oQotX31PLy32xcr3vC2nGxD0Wg0VBmtlzuzXCN1Hj3iKAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717413466; c=relaxed/simple;
	bh=nrXznC7FKj+qMqeNwBFEzSsxRpZPZIHhbagU8WQ6TJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScnLBsvqOBILaIthqJhwRJsyCjXRo79oExtVTMSA5UeNf70E1rxq1pd5j6AuAsJL1rnqsZdpMbNb0LNL0+APDSEjqfNDlAeDQueAwsQusqadqyLYEMav6O7UrQNo6FHzcaGkfzI7Gz2vqymGEt4qe+tDvGnRgK5W4NC+msxvLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=je2tT8Uv; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717413465; x=1748949465;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nrXznC7FKj+qMqeNwBFEzSsxRpZPZIHhbagU8WQ6TJs=;
  b=je2tT8UvRXDz4yVIGhKJb17z4rLHgeBR35z7ddmbqFxVToLj7jHZEPxl
   WUO+kUG4R9ldWyv0+7b6tk5eRnFioHJdzKRtROXLhLU5zZTW42hIAEJdd
   BTbs/oSqsWu2xzyQztKSPqbHyNPjxZV1AZB/5fzaeDzYCUX09Ntxg3KbY
   X2V7ZGf38eY6LUxopAHXNznsWxksA+8dN3wdeRXnWdFhBxhOnXkyV0TIo
   6TIJGBZBJh62u2rv0Q10XRSQc9CcCuCnrniNdwkFjSdRmTlP9mB+OeDdB
   9dTRbLblpgBvglB12xCTcJv7DbHqExvqpK0XCylyyM+A5nTPO0rm3bzVZ
   w==;
X-CSE-ConnectionGUID: laD5MIYPRPKKRK2k7Qh63A==
X-CSE-MsgGUID: tNr426UyQleKWOjEjC44Xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14087027"
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="14087027"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 04:17:44 -0700
X-CSE-ConnectionGUID: thO/l+UcSl2KgT7kI3dEcw==
X-CSE-MsgGUID: wLn/iXe8QKGog6cZyINkHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,211,1712646000"; 
   d="scan'208";a="41938420"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 03 Jun 2024 04:17:42 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sE5h5-000LSl-0H;
	Mon, 03 Jun 2024 11:17:39 +0000
Date: Mon, 3 Jun 2024 19:16:52 +0800
From: kernel test robot <lkp@intel.com>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	linux-edac@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, git@amd.com, rric@kernel.org,
	bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH] EDAC/synopsys: Fix the injection of the errors
Message-ID: <202406031857.80s6OP7c-lkp@intel.com>
References: <20240603051638.22332-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603051638.22332-1-shubhrajyoti.datta@amd.com>

Hi Shubhrajyoti,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.10-rc2 next-20240603]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shubhrajyoti-Datta/EDAC-synopsys-Fix-the-injection-of-the-errors/20240603-131853
base:   linus/master
patch link:    https://lore.kernel.org/r/20240603051638.22332-1-shubhrajyoti.datta%40amd.com
patch subject: [PATCH] EDAC/synopsys: Fix the injection of the errors
config: arm64-randconfig-001-20240603 (https://download.01.org/0day-ci/archive/20240603/202406031857.80s6OP7c-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240603/202406031857.80s6OP7c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406031857.80s6OP7c-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/edac/synopsys_edac.c: In function 'zynqmp_get_mem_info':
>> drivers/edac/synopsys_edac.c:419:27: error: 'struct synps_edac_priv' has no member named 'poison_addr'
     419 |         linear_addr = priv->poison_addr;
         |                           ^~


vim +419 drivers/edac/synopsys_edac.c

   407	
   408	/**
   409	 * zynqmp_get_mem_info - Get the current memory info.
   410	 * @priv:	DDR memory controller private instance data.
   411	 *
   412	 * Return: host interface address.
   413	 */
   414	static ulong zynqmp_get_mem_info(struct synps_edac_priv *priv)
   415	{
   416		ulong hif_addr = 0;
   417		ulong linear_addr;
   418	
 > 419		linear_addr = priv->poison_addr;
   420		if (linear_addr >= SZ_32G)
   421			linear_addr = linear_addr - SZ_32G + SZ_2G;
   422		hif_addr = linear_addr >> 3;
   423		return hif_addr;
   424	}
   425	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

