Return-Path: <linux-edac+bounces-1655-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22258953EFD
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 03:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B57282063
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312831E502;
	Fri, 16 Aug 2024 01:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfK2bovy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571729CF0;
	Fri, 16 Aug 2024 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772440; cv=none; b=iaszb6pNvNvIqJmWs3ZvYLF2iSSj+m7Y2sofbGHXlsEgrTawqODP5ZsIbCC1nl5eZgvfVtZMcBRrMnlnivdBakpNfrRN+HHWUdZkicZyIu1LQFXb84Zons6YvznugqIK3jv39PEyGNCMkBrJubKZAf8iy4U9u3xp7tBn4Tt/ZB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772440; c=relaxed/simple;
	bh=TxVgBYYWN/3kYg/XenduJ5cBNArWEosbc8sM/EqhRJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3s2VFsbTzKm07f7zTBYd/xy8Ns5auV+0nWISQSczFWeePPCgRT91V3BWN8zF1/QE/bqOTwT0VFLQlHHb/ASlu5JtNhT/3OoHUiYmIgO2eJm1oAwnCj0UeXnmTKCgHxRWnJDL8lZi3m+6k8DncJo2wdO/EWDcQMKg5UudZS++O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfK2bovy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723772438; x=1755308438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TxVgBYYWN/3kYg/XenduJ5cBNArWEosbc8sM/EqhRJc=;
  b=VfK2bovyIuxFifgrg0zmfIhg5w+KBZvm0NQPTiurfBF3pDfpVuvGx2xf
   thizQhnmpJoSKJ6UwqD365G/WYQMvNYRC0iXuwrl1rv5mJ0FRq9K7XfUF
   8X+qsvvg1WsY5uYKqFZiR8pQhIaYBXSsVyYjmG4NHYEsJ9kdmNL6rMnzS
   fE1RDthfKtdHrAg8TDTJ3AbyugI/opQKUNzmU8xR0JAVMI931JRxSB2h1
   UqF5qwN/0KXsy47tbCgVDinAL8UPm5sBFTnpSswrfogYSaycrpQLnNqgL
   FsFyL4002h+rXSi09LmoOpVT9RVRK6GwhMUoU75h1MWoUuq5w3qqHqPGx
   g==;
X-CSE-ConnectionGUID: 8Hbfl3WMQkOxtqEDWx7RmQ==
X-CSE-MsgGUID: oqsrwJXGTt+4GP7NMMglSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="32730631"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="32730631"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 18:40:38 -0700
X-CSE-ConnectionGUID: sfn6/XgtQKCUHNIjJxz2xA==
X-CSE-MsgGUID: MgntSaxjQ0+PbFVhh0EtkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="64472928"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Aug 2024 18:40:33 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1selx8-0005mw-2T;
	Fri, 16 Aug 2024 01:40:30 +0000
Date: Fri, 16 Aug 2024 09:39:48 +0800
From: kernel test robot <lkp@intel.com>
To: Ma Ke <make24@iscas.ac.cn>, kristo@kernel.org, bp@alien8.de,
	tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, akpm@linux-foundation.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ma Ke <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v4 RESEND] EDAC/ti: Fix possible null pointer dereference
 in _emif_get_id()
Message-ID: <202408160935.A6QFliqt-lkp@intel.com>
References: <20240815014511.147065-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815014511.147065-1-make24@iscas.ac.cn>

Hi Ma,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on linus/master v6.11-rc3 next-20240815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-Ke/EDAC-ti-Fix-possible-null-pointer-dereference-in-_emif_get_id/20240815-094801
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240815014511.147065-1-make24%40iscas.ac.cn
patch subject: [PATCH v4 RESEND] EDAC/ti: Fix possible null pointer dereference in _emif_get_id()
config: arm-randconfig-002-20240816 (https://download.01.org/0day-ci/archive/20240816/202408160935.A6QFliqt-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240816/202408160935.A6QFliqt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408160935.A6QFliqt-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/edac/ti_edac.c:28:
   In file included from drivers/edac/edac_module.h:15:
   In file included from drivers/edac/edac_mc.h:30:
   In file included from include/linux/pci.h:1646:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2228:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/edac/ti_edac.c:214:14: warning: result of comparison of constant 18446744073709551615 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     214 |         if (my_addr == OF_BAD_ADDR)
         |             ~~~~~~~ ^  ~~~~~~~~~~~
   drivers/edac/ti_edac.c:226:12: warning: result of comparison of constant 18446744073709551615 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
     226 |                 if (addr == OF_BAD_ADDR)
         |                     ~~~~ ^  ~~~~~~~~~~~
   3 warnings generated.


vim +214 drivers/edac/ti_edac.c

   201	
   202	static int _emif_get_id(struct device_node *node)
   203	{
   204		struct device_node *np;
   205		const __be32 *addrp;
   206		u32 addr, my_addr;
   207		int my_id = 0;
   208	
   209		addrp = of_get_address(node, 0, NULL, NULL);
   210		if (!addrp)
   211			return -EINVAL;
   212	
   213		my_addr = (u32)of_translate_address(node, addrp);
 > 214		if (my_addr == OF_BAD_ADDR)
   215			return -EINVAL;
   216	
   217		for_each_matching_node(np, ti_edac_of_match) {
   218			if (np == node)
   219				continue;
   220	
   221			addrp = of_get_address(np, 0, NULL, NULL);
   222			if (!addrp)
   223				return -EINVAL;
   224	
   225			addr = (u32)of_translate_address(np, addrp);
   226			if (addr == OF_BAD_ADDR)
   227				return -EINVAL;
   228	
   229			edac_printk(KERN_INFO, EDAC_MOD_NAME,
   230				    "addr=%x, my_addr=%x\n",
   231				    addr, my_addr);
   232	
   233			if (addr < my_addr)
   234				my_id++;
   235		}
   236	
   237		return my_id;
   238	}
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

