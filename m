Return-Path: <linux-edac+bounces-3298-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8152AA55E2A
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 04:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65E7188EB98
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 03:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007B918DB1C;
	Fri,  7 Mar 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAQA3cXd"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F6154433;
	Fri,  7 Mar 2025 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741317524; cv=none; b=cH1f5Vu6ZpFrk4+Tu+c++0Ao8XIV4iALTT7Sz3O+3kgHQdchUctjXTrZ/32UhSmIUaJj0vYukoWeTKJbUbLdp50XgHlhlcDnc//8XWHih6XjkSe6Bh/0cn0sxwOjibx7TPHGFssCi7Ox5MHDmUUOYDPtU0oXLv34dP76kZvONFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741317524; c=relaxed/simple;
	bh=AqSMa8//pzHQ9mnL+CjQgM8fc8wx7B1+SyGC0Muu/bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec2tT0KLXLrAnLGcaIsYF8jzrx9dNZpuOfRm12xhZm4TV3R6Xc8QebuHFngLUHM7YDtlrGxmck3YTCLCylYvcYm6I3N9MsghOAN4GcGP+53vPLjwptJOrHq6/ZYSV2QegNByUjukwB6aSKXwOJvZ23wRFOGEObPDKHXY+qwJ+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAQA3cXd; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741317523; x=1772853523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AqSMa8//pzHQ9mnL+CjQgM8fc8wx7B1+SyGC0Muu/bY=;
  b=PAQA3cXdKqMYNlfFX/j5HDlu9rerdaMyZyyxfIN4k+JsOg2OtdnGCrlc
   yPS2yC2ChFVPHRnAG/RKjTcCdgAXmqGftiJv5JmbJrQ+SA+5A0pO5aHye
   VblgKrODknkF6ArS4TyB75PvLPOs5CKeJeW2IIB76j2lZiSqRVn7kOxvM
   lNR79dBUAvxxQeo5Nb6w6l3baHOpeQZNKS33LZh9Qt219wr9e8LHqaniP
   8lb090wqYJC+ujUyelRGh5JGtiFfTl0aDqehd0+89C+RDs//+Kj9QDLUd
   eNhoeqcF+rTwSCOBvsIjSiGtDNrxTZDarS6yx/e9+q462dFeJ3pQGcB7A
   A==;
X-CSE-ConnectionGUID: 2WQzB1OpTKqcPOYiQH444w==
X-CSE-MsgGUID: Utcjt1ECSLq7Jek4ghR5nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="29937384"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="29937384"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:18:43 -0800
X-CSE-ConnectionGUID: wta3WuZJQrKl6l0iODaFEQ==
X-CSE-MsgGUID: 1bTw2xscT9GVMo0dh9wXYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="123798504"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 06 Mar 2025 19:18:37 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqOEN-000O9y-1B;
	Fri, 07 Mar 2025 03:18:35 +0000
Date: Fri, 7 Mar 2025 11:17:43 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com,
	bp@alien8.de, peterz@infradead.org, catalin.marinas@arm.com,
	yazen.ghannam@amd.com, akpm@linux-foundation.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Message-ID: <202503071154.xQpKARjN-lkp@intel.com>
References: <20250306021031.5538-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306021031.5538-2-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/x86-mce-Use-is_copy_from_user-to-determine-copy-from-user-context/20250306-101505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250306021031.5538-2-xueshuai%40linux.alibaba.com
patch subject: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine copy-from-user context
config: i386-buildonly-randconfig-002-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071154.xQpKARjN-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071154.xQpKARjN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071154.xQpKARjN-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/kernel/cpu/mce/severity.c:16:
   In file included from arch/x86/include/asm/traps.h:6:
   In file included from include/linux/kprobes.h:28:
   In file included from include/linux/ftrace.h:13:
   In file included from include/linux/kallsyms.h:13:
   In file included from include/linux/mm.h:2321:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> arch/x86/kernel/cpu/mce/severity.c:305:25: error: expected ';' after return statement
     305 |                 return IN_KERNEL_RECOV
         |                                       ^
         |                                       ;
   1 warning and 1 error generated.


vim +305 arch/x86/kernel/cpu/mce/severity.c

   274	
   275	/*
   276	 * If mcgstatus indicated that ip/cs on the stack were
   277	 * no good, then "m->cs" will be zero and we will have
   278	 * to assume the worst case (IN_KERNEL) as we actually
   279	 * have no idea what we were executing when the machine
   280	 * check hit.
   281	 * If we do have a good "m->cs" (or a faked one in the
   282	 * case we were executing in VM86 mode) we can use it to
   283	 * distinguish an exception taken in user from from one
   284	 * taken in the kernel.
   285	 */
   286	static noinstr int error_context(struct mce *m, struct pt_regs *regs)
   287	{
   288		int fixup_type;
   289		bool copy_user;
   290	
   291		if ((m->cs & 3) == 3)
   292			return IN_USER;
   293	
   294		if (!mc_recoverable(m->mcgstatus))
   295			return IN_KERNEL;
   296	
   297		/* Allow instrumentation around external facilities usage. */
   298		instrumentation_begin();
   299		fixup_type = ex_get_fixup_type(m->ip);
   300		copy_user  = is_copy_from_user(regs);
   301		instrumentation_end();
   302	
   303		if (copy_user) {
   304			m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
 > 305			return IN_KERNEL_RECOV
   306		}
   307	
   308		switch (fixup_type) {
   309		case EX_TYPE_FAULT_MCE_SAFE:
   310		case EX_TYPE_DEFAULT_MCE_SAFE:
   311			m->kflags |= MCE_IN_KERNEL_RECOV;
   312			return IN_KERNEL_RECOV;
   313	
   314		default:
   315			return IN_KERNEL;
   316		}
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

