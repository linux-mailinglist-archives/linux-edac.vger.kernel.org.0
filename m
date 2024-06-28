Return-Path: <linux-edac+bounces-1433-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7591BBF0
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD231C21AF7
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7D7154420;
	Fri, 28 Jun 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MigDMdci"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41601487EB;
	Fri, 28 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719568395; cv=none; b=kjgbp6+qv41Q0pWWJK+NnFLcfMxpxPolHLO5fOtP537oSg53R5dkl0U0AljAm6NYwUc+Wvg7gyv2w5qHwmaqZR9TyBQaE+DfcExiIMGaxmHAHpzIE4KPiO48/I4xaFkk88ZzrpN/we+4kA5AFcAcBkC3txWRlzrzOnfl+lZUYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719568395; c=relaxed/simple;
	bh=42lpn0gsgP3WHsGwcnPSpiBlf1XrAVONaMmX2JlfO0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EEEXSKH2ilrWX2PXlIoeDEC4+r8VuhZOQgZqOUsq036ou6Tcus1QHq/5gKpMDMFO99pf18I5X+hynPHCVzOUIyKmTLVkqkPF9uARCVm2TzYSKkKXkKe2I6u6DiO5jV0oRa6Qqk8mzhiGm7adnxmlWo9yB3+fW9E0zQBN+1ypSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MigDMdci; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719568394; x=1751104394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=42lpn0gsgP3WHsGwcnPSpiBlf1XrAVONaMmX2JlfO0w=;
  b=MigDMdciueyNgNKKw/0+7F3HF+vD+9Gs1KlvNXNVknRiQjPdF/ibBgSO
   6rebnx3tqrIsBqQNcqQuoYcDu9PftHW1T8CbocsdD+NcwP3KuPFaodIr7
   Zc+ctCc+pua3/SvXXc2VxE31zGAtSJLDOP8hK8Jyzyhqa3DSOBNhz1pIL
   qVmJhPdKRm7g1sWTyfxJEf2t3Sw8iH1x5t1QWIy/H9NSY7BosIilXvT57
   B4OpkBeu/coBG0+YGjxppFW9N+cv5+Au7WzkhgKeXcLzZ4KE+z53SujtW
   m82nBLgc7FgD8B2O8C1WSZQ2+jcYM9dD20YTDs+XmIyq+JTEQjDTY7caP
   Q==;
X-CSE-ConnectionGUID: HLqjqv+HQ9eIZ78ADDl7Ow==
X-CSE-MsgGUID: v4AauS4PTcmeG49C5tKFAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16482504"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16482504"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 02:53:13 -0700
X-CSE-ConnectionGUID: 2mcIUEDRSHm0axZST7dXNQ==
X-CSE-MsgGUID: UD1R3oihQIyw27l1d6rduQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45342508"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 28 Jun 2024 02:53:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN8Hw-000Gxi-25;
	Fri, 28 Jun 2024 09:53:04 +0000
Date: Fri, 28 Jun 2024 17:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-media@vger.kernel.org, Shengwei Luo <luoshengwei@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>, Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tony Luck <tony.luck@intel.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	Will Deacon <will@kernel.org>, Xie XiuQi <xiexiuqi@huawei.com>,
	linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jason Tian <jason@os.amperecomputing.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 2/2] RAS: Report all ARM processor CPER information to
 userspace
Message-ID: <202406281751.Wuf4JcIZ-lkp@intel.com>
References: <eed2c4a4fbbb71226ca1944bc7e319bfa9f8aec0.1719471257.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eed2c4a4fbbb71226ca1944bc7e319bfa9f8aec0.1719471257.git.mchehab+huawei@kernel.org>

Hi Mauro,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mauro-Carvalho-Chehab/RAS-ACPI-APEI-add-conditional-compilation-to-ARM-error-report-functions/20240627-225843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/eed2c4a4fbbb71226ca1944bc7e319bfa9f8aec0.1719471257.git.mchehab%2Bhuawei%40kernel.org
patch subject: [PATCH 2/2] RAS: Report all ARM processor CPER information to userspace
config: arm64-randconfig-003-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281751.Wuf4JcIZ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 326ba38a991250a8587a399a260b0f7af2c9166a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281751.Wuf4JcIZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281751.Wuf4JcIZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ras/ras.c:46:
   In file included from include/ras/ras_event.h:12:
   In file included from include/linux/pci.h:1650:
   In file included from include/linux/dmapool.h:14:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/ras/ras.c:73:10: error: incompatible pointer types assigning to 'u8 *' (aka 'unsigned char *') from 'struct cper_arm_ctx_info *' [-Werror,-Wincompatible-pointer-types]
      73 |         ctx_err = ctx_info;
         |                 ^ ~~~~~~~~
   1 warning and 1 error generated.


vim +73 drivers/ras/ras.c

    54	
    55	void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
    56	{
    57	#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
    58		struct cper_arm_err_info *err_info;
    59		struct cper_arm_ctx_info *ctx_info;
    60		u8 *ven_err_data;
    61		u32 ctx_len = 0;
    62		int n, sz, cpu;
    63		s32 vsei_len;
    64		u32 pei_len;
    65		u8 *pei_err;
    66		u8 *ctx_err;
    67	
    68		pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
    69		pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
    70	
    71		err_info = (struct cper_arm_err_info *)(err + 1);
    72		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
  > 73		ctx_err = ctx_info;
    74		for (n = 0; n < err->context_info_num; n++) {
    75			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
    76			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
    77			ctx_len += sz;
    78		}
    79	
    80		vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
    81						  pei_len + ctx_len);
    82		if (vsei_len < 0) {
    83			pr_warn(FW_BUG
    84				"section length: %d\n", err->section_length);
    85			pr_warn(FW_BUG
    86				"section length is too small\n");
    87			pr_warn(FW_BUG
    88				"firmware-generated error record is incorrect\n");
    89			vsei_len = 0;
    90		}
    91		ven_err_data = (u8 *)ctx_info;
    92	
    93		cpu = GET_LOGICAL_INDEX(err->mpidr);
    94		/* when return value is invalid, set cpu index to -1 */
    95		if (cpu < 0)
    96			cpu = -1;
    97	
    98		trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
    99				ven_err_data, (u32)vsei_len, sev, cpu);
   100	#endif
   101	}
   102	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

