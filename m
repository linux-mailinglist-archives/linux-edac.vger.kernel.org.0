Return-Path: <linux-edac+bounces-1424-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDA91B661
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 07:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F504B23E7F
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 05:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675646453;
	Fri, 28 Jun 2024 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwt+1Ngt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F673C08A;
	Fri, 28 Jun 2024 05:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553318; cv=none; b=WEkd6ctvnb0Y7rOyrmLu+mr22lKfqbYSgBPPvbub95u7JqkzjhT6AhiCyOL3esuTNcO7jHGilrzM5jKb4XZ7H0ZEHbMlPpxwH1DhlhftpQ6Fp2DJ8E5/VtxhS9RSUGL7yEimwWu6g/JdsIFEhjFaEqNXDFtYhZ9Z1iHHP0IeX3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553318; c=relaxed/simple;
	bh=csJqhxOzCeto3DBvtcGzR+6z5HcyLrbiBa9C1wvpq5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6hBtaNETB1hy52BusXdbHSJoz9d/nWaP4Ap61uUYfzz9lw9DqY8qCDS9jPhTK89Nz+ZtX13iAdxgslpp53yQu6XBalDAmLYpEyP4dtG2U3YV0gooImW65Dhq8RJ2KtALzm6whRjuRP235KYET454D+ByXTf8SdkvXOdLQTmm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwt+1Ngt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719553317; x=1751089317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=csJqhxOzCeto3DBvtcGzR+6z5HcyLrbiBa9C1wvpq5c=;
  b=Cwt+1NgtGmQlLrFr8ljqqsB4IXEOqH68k9flA9Ao2lJvD7kv9t7ai5+S
   RjGdRhnjunKJdn75iva06wPc2JG/I9T7vbIWJWcUn67C+vMO1MTO1Tc4R
   bsa4ERy3TwNyCj2xdqzRx5Nvqlo5G4pFysEcHeMnXziKBoFipIl19LDTP
   MjS26YEi7E3aXOPEntsIYRyzAj8uTnnpgDDaPcmkNEaM6sx3tABemSYAE
   B0S7mYLeq34gRe1zVyEqJvUOtuL+DwiT5PUJkBGINLiOIvohkrC9gezCQ
   xzo6pIjSd/ipXAV3PwbO5aBi7ff7eer016hoxYHka3m8In8k1SA1GIuhy
   A==;
X-CSE-ConnectionGUID: WVyxPPIFRZGstV5YKH4MmA==
X-CSE-MsgGUID: ifCWdn+QQ+SdzR/9M2f6DQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16602534"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16602534"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:41:56 -0700
X-CSE-ConnectionGUID: 9FcuFt56QNinwr1mxyaTnw==
X-CSE-MsgGUID: suthwj7KRoCiMxuLu2BjKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="44514689"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 27 Jun 2024 22:41:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN4Mn-000GqH-1g;
	Fri, 28 Jun 2024 05:41:49 +0000
Date: Fri, 28 Jun 2024 13:41:28 +0800
From: kernel test robot <lkp@intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Shengwei Luo <luoshengwei@huawei.com>,
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
Message-ID: <202406281339.b9yJADtu-lkp@intel.com>
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
config: arm64-randconfig-002-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281339.b9yJADtu-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281339.b9yJADtu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281339.b9yJADtu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ras/ras.c: In function 'log_arm_hw_error':
>> drivers/ras/ras.c:73:17: error: assignment to 'u8 *' {aka 'unsigned char *'} from incompatible pointer type 'struct cper_arm_ctx_info *' [-Werror=incompatible-pointer-types]
      73 |         ctx_err = ctx_info;
         |                 ^
   cc1: some warnings being treated as errors


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

