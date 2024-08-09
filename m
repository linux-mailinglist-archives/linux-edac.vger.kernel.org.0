Return-Path: <linux-edac+bounces-1634-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A9B94CB6A
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 09:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74012833AA
	for <lists+linux-edac@lfdr.de>; Fri,  9 Aug 2024 07:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6494D12FB34;
	Fri,  9 Aug 2024 07:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOFDssak"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC742A80;
	Fri,  9 Aug 2024 07:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188771; cv=none; b=T79afxSi8yBPPbInFDzt1VO3+mfopc4lL2k2QQLE6HDrt/9zJplhQh5Hwocr2JxwncupKrg1TLtTyWzuHq6Axmna/uCtoEOhWrH5llno/hsFP/PwsOERgMWKJlbaga/70bqdrQM3Dc8/c9R30q1lQPQbIOqgAPyCbU/cZbG65KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188771; c=relaxed/simple;
	bh=q16F2qKsOS0dAho75gsyC/MFvUgBI5EVWzyJK9e+9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUGtoxyBDvblYqOPWpZYvHPncyNDKZYzJAodWq5+9ZQ7nvz7tlMu4AxhelbUbbGNLqiYSoWzR8a7XZJeE+1/0LwK4KatJ8ZL8u5ukThW38OMBXWQWpYblqtyiiLbKwvMyve7iz8pXttUax6EFUfBTvfq/MfNZ1tn4fYXo/vU6i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOFDssak; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723188769; x=1754724769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q16F2qKsOS0dAho75gsyC/MFvUgBI5EVWzyJK9e+9vU=;
  b=VOFDssakRzxd3iWQrqd8tHMYPvFAx5eBrJNdC9mvyL0RRBddh9d+shaY
   5ytUr3nvAohMg96UzPj+Sh+z0FsA/lvmXF3fbYB7WzVQU1CdEH7rd9tZO
   1TixLViJIL3bfmX091s3Sf8wKK0HjvfvV751sOPF99OSg6Rqh+7+4R9O0
   xkJdTNJV+GTX5NjYzFjJAz4Z/HHud8DAlb4NQecvewIWXh6fjCKGOpQ3d
   HTXIHm9c5WoK6x6cb5pDlqQQdED4ssx+GulW/sF581Mv9BdBXM+StfIDg
   a7iWuYso00D0fP3cCcOopRN767wjYOePhEWN+9B+nbBNMzIOxlGw28MlY
   A==;
X-CSE-ConnectionGUID: ME6pr8ylS669tyBhJAK+Sw==
X-CSE-MsgGUID: FSDpvqcgSECu7CZOny5YgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="21525835"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="21525835"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 00:32:48 -0700
X-CSE-ConnectionGUID: CeylR7OiT+uTHe0gWTttbg==
X-CSE-MsgGUID: XxnakVIFRlyPYLBcRJahJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57444327"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 09 Aug 2024 00:32:43 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scK72-0007H4-1p;
	Fri, 09 Aug 2024 07:32:38 +0000
Date: Fri, 9 Aug 2024 15:31:43 +0800
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
Message-ID: <202408091537.p9RKx1R2-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on cxl/next linus/master v6.11-rc2 next-20240809]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Shiyang-Ruan/cxl-core-introduce-device-reporting-poison-hanlding/20240809-013658
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240808151328.707869-3-ruansy.fnst%40fujitsu.com
patch subject: [PATCH v4 2/2] cxl: avoid duplicated report from MCE & device
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240809/202408091537.p9RKx1R2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240809/202408091537.p9RKx1R2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408091537.p9RKx1R2-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/cxl/core/mbox.c:8:
>> arch/x86/include/asm/mce.h:219:43: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     219 | static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
         |                                           ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:220:44: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     220 | static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
         |                                            ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:240:50: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     240 | static inline void mce_intel_feature_init(struct cpuinfo_x86 *c) { }
         |                                                  ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:241:51: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     241 | static inline void mce_intel_feature_clear(struct cpuinfo_x86 *c) { }
         |                                                   ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:248:26: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     248 | int mce_available(struct cpuinfo_x86 *c);
         |                          ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:355:48: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     355 | static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)          { }
         |                                                ^~~~~~~~~~~
   arch/x86/include/asm/mce.h:358:50: warning: 'struct cpuinfo_x86' declared inside parameter list will not be visible outside of this definition or declaration
     358 | static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)        { return mce_amd_feature_init(c); }
         |                                                  ^~~~~~~~~~~
   arch/x86/include/asm/mce.h: In function 'mce_hygon_feature_init':
>> arch/x86/include/asm/mce.h:358:103: error: passing argument 1 of 'mce_amd_feature_init' from incompatible pointer type [-Werror=incompatible-pointer-types]
     358 | static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)        { return mce_amd_feature_init(c); }
         |                                                                                                       ^
         |                                                                                                       |
         |                                                                                                       struct cpuinfo_x86 *
   arch/x86/include/asm/mce.h:355:61: note: expected 'struct cpuinfo_x86 *' but argument is of type 'struct cpuinfo_x86 *'
     355 | static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)          { }
         |                                         ~~~~~~~~~~~~~~~~~~~~^
   In file included from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/key.h:14,
                    from include/linux/security.h:27,
                    from drivers/cxl/core/mbox.c:3:
   drivers/cxl/core/mbox.c: In function 'cxl_handle_mce':
>> arch/x86/include/asm/mce.h:94:58: error: 'struct cpuinfo_um' has no member named 'x86_phys_bits'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                                          ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
      25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
         |                 ^~~~~~~~~~~~~~
   include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/mce.h:94:33: note: in expansion of macro 'GENMASK_ULL'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                 ^~~~~~~~~~~
   drivers/cxl/core/mbox.c:1553:27: note: in expansion of macro 'MCI_ADDR_PHYSADDR'
    1553 |         hpa = mce->addr & MCI_ADDR_PHYSADDR;
         |                           ^~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/mce.h:94:58: error: 'struct cpuinfo_um' has no member named 'x86_phys_bits'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                                          ^
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/mce.h:94:33: note: in expansion of macro 'GENMASK_ULL'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                 ^~~~~~~~~~~
   drivers/cxl/core/mbox.c:1553:27: note: in expansion of macro 'MCI_ADDR_PHYSADDR'
    1553 |         hpa = mce->addr & MCI_ADDR_PHYSADDR;
         |                           ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:24:28: error: first argument to '__builtin_choose_expr' not a constant
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |                            ^~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                              ^
   include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/mce.h:94:33: note: in expansion of macro 'GENMASK_ULL'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                 ^~~~~~~~~~~
   drivers/cxl/core/mbox.c:1553:27: note: in expansion of macro 'MCI_ADDR_PHYSADDR'
    1553 |         hpa = mce->addr & MCI_ADDR_PHYSADDR;
         |                           ^~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/bits.h:24:10: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
      24 |         (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
         |          ^~~~~~~~~~~~~~~~~
   include/linux/bits.h:37:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
      37 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK_ULL(h, l))
         |          ^~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/mce.h:94:33: note: in expansion of macro 'GENMASK_ULL'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                 ^~~~~~~~~~~
   drivers/cxl/core/mbox.c:1553:27: note: in expansion of macro 'MCI_ADDR_PHYSADDR'
    1553 |         hpa = mce->addr & MCI_ADDR_PHYSADDR;
         |                           ^~~~~~~~~~~~~~~~~
   In file included from include/linux/bits.h:7,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/rcupdate.h:27,
                    from include/linux/rbtree.h:24,
                    from include/linux/key.h:15:
>> arch/x86/include/asm/mce.h:94:58: error: 'struct cpuinfo_um' has no member named 'x86_phys_bits'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                                          ^
   include/uapi/linux/bits.h:13:52: note: in definition of macro '__GENMASK_ULL'
      13 |          (~_ULL(0) >> (__BITS_PER_LONG_LONG - 1 - (h))))
         |                                                    ^
   arch/x86/include/asm/mce.h:94:33: note: in expansion of macro 'GENMASK_ULL'
      94 | #define MCI_ADDR_PHYSADDR       GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
         |                                 ^~~~~~~~~~~
   drivers/cxl/core/mbox.c:1553:27: note: in expansion of macro 'MCI_ADDR_PHYSADDR'
    1553 |         hpa = mce->addr & MCI_ADDR_PHYSADDR;
         |                           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mce_amd_feature_init +358 arch/x86/include/asm/mce.h

4a24d80b8c3e9f arch/x86/include/asm/mce.h Smita Koralahalli         2020-11-19  210  
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  211  #ifdef CONFIG_X86_MCE
a2202aa29289db arch/x86/include/asm/mce.h Yong Wang                 2009-11-10  212  int mcheck_init(void);
5e09954a9acc3b arch/x86/include/asm/mce.h Borislav Petkov           2009-10-16  213  void mcheck_cpu_init(struct cpuinfo_x86 *c);
8838eb6c0bf3b6 arch/x86/include/asm/mce.h Ashok Raj                 2015-08-12  214  void mcheck_cpu_clear(struct cpuinfo_x86 *c);
4a24d80b8c3e9f arch/x86/include/asm/mce.h Smita Koralahalli         2020-11-19  215  int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
4a24d80b8c3e9f arch/x86/include/asm/mce.h Smita Koralahalli         2020-11-19  216  			       u64 lapic_id);
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  217  #else
a2202aa29289db arch/x86/include/asm/mce.h Yong Wang                 2009-11-10  218  static inline int mcheck_init(void) { return 0; }
5e09954a9acc3b arch/x86/include/asm/mce.h Borislav Petkov           2009-10-16 @219  static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
8838eb6c0bf3b6 arch/x86/include/asm/mce.h Ashok Raj                 2015-08-12  220  static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
4a24d80b8c3e9f arch/x86/include/asm/mce.h Smita Koralahalli         2020-11-19  221  static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
4a24d80b8c3e9f arch/x86/include/asm/mce.h Smita Koralahalli         2020-11-19  222  					     u64 lapic_id) { return -EINVAL; }
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  223  #endif
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  224  
b5f2fa4ea00a17 arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  225  void mce_setup(struct mce *m);
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  226  void mce_log(struct mce *m);
d6126ef5f31ca5 arch/x86/include/asm/mce.h Greg Kroah-Hartman        2012-01-26  227  DECLARE_PER_CPU(struct device *, mce_device);
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  228  
a0bc32b3cacf19 arch/x86/include/asm/mce.h Akshay Gupta              2020-08-28  229  /* Maximum number of MCA banks per CPU. */
a0bc32b3cacf19 arch/x86/include/asm/mce.h Akshay Gupta              2020-08-28  230  #define MAX_NR_BANKS 64
41fdff322e26c4 arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  231  
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  232  #ifdef CONFIG_X86_MCE_INTEL
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  233  void mce_intel_feature_init(struct cpuinfo_x86 *c);
8838eb6c0bf3b6 arch/x86/include/asm/mce.h Ashok Raj                 2015-08-12  234  void mce_intel_feature_clear(struct cpuinfo_x86 *c);
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  235  void cmci_clear(void);
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  236  void cmci_reenable(void);
7a0c819d28f5c9 arch/x86/include/asm/mce.h Srivatsa S. Bhat          2013-03-20  237  void cmci_rediscover(void);
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  238  void cmci_recheck(void);
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  239  #else
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  240  static inline void mce_intel_feature_init(struct cpuinfo_x86 *c) { }
8838eb6c0bf3b6 arch/x86/include/asm/mce.h Ashok Raj                 2015-08-12  241  static inline void mce_intel_feature_clear(struct cpuinfo_x86 *c) { }
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  242  static inline void cmci_clear(void) {}
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  243  static inline void cmci_reenable(void) {}
7a0c819d28f5c9 arch/x86/include/asm/mce.h Srivatsa S. Bhat          2013-03-20  244  static inline void cmci_rediscover(void) {}
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  245  static inline void cmci_recheck(void) {}
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  246  #endif
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  247  
38736072d45488 arch/x86/include/asm/mce.h H. Peter Anvin            2009-05-28  248  int mce_available(struct cpuinfo_x86 *c);
2d1f406139ec20 arch/x86/include/asm/mce.h Borislav Petkov           2017-05-19  249  bool mce_is_memory_error(struct mce *m);
5d96c9342c23ee arch/x86/include/asm/mce.h Vishal Verma              2018-10-25  250  bool mce_is_correctable(struct mce *m);
1bae0cfe4a171c arch/x86/include/asm/mce.h Yazen Ghannam             2023-06-13  251  bool mce_usable_address(struct mce *m);
88ccbedd9ca85d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  252  
01ca79f1411eae arch/x86/include/asm/mce.h Andi Kleen                2009-05-27  253  DECLARE_PER_CPU(unsigned, mce_exception_count);
ca84f69697da0f arch/x86/include/asm/mce.h Andi Kleen                2009-05-27  254  DECLARE_PER_CPU(unsigned, mce_poll_count);
01ca79f1411eae arch/x86/include/asm/mce.h Andi Kleen                2009-05-27  255  
ee031c31d6381d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  256  typedef DECLARE_BITMAP(mce_banks_t, MAX_NR_BANKS);
ee031c31d6381d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  257  DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
ee031c31d6381d arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  258  
b79109c3bbcf52 arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  259  enum mcp_flags {
3f2f0680d1161d arch/x86/include/asm/mce.h Borislav Petkov           2015-01-13  260  	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
3f2f0680d1161d arch/x86/include/asm/mce.h Borislav Petkov           2015-01-13  261  	MCP_UC		= BIT(1),	/* log uncorrected errors */
3f2f0680d1161d arch/x86/include/asm/mce.h Borislav Petkov           2015-01-13  262  	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
3bff147b187d5d arch/x86/include/asm/mce.h Borislav Petkov           2021-08-23  263  	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
b79109c3bbcf52 arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  264  };
5b9d292ea87c83 arch/x86/include/asm/mce.h Yazen Ghannam             2024-05-23  265  
5b9d292ea87c83 arch/x86/include/asm/mce.h Yazen Ghannam             2024-05-23  266  void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
b79109c3bbcf52 arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  267  
9ff36ee9668ff4 arch/x86/include/asm/mce.h Andi Kleen                2009-05-27  268  int mce_notify_irq(void);
e2f430291fe23a include/asm-x86/mce.h      Thomas Gleixner           2007-10-17  269  
ea149b36c7f511 arch/x86/include/asm/mce.h Andi Kleen                2009-04-29  270  DECLARE_PER_CPU(struct mce, injectm);
66f5ddf30a59f8 arch/x86/include/asm/mce.h Tony Luck                 2011-11-03  271  
c3d1fb567a634d arch/x86/include/asm/mce.h Naveen N Rao              2013-07-01  272  /* Disable CMCI/polling for MCA bank claimed by firmware */
c3d1fb567a634d arch/x86/include/asm/mce.h Naveen N Rao              2013-07-01  273  extern void mce_disable_bank(int bank);
c3d1fb567a634d arch/x86/include/asm/mce.h Naveen N Rao              2013-07-01  274  
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  275  /*
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  276   * Exception handler
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  277   */
8cd501c1facc15 arch/x86/include/asm/mce.h Thomas Gleixner           2020-02-25  278  void do_machine_check(struct pt_regs *pt_regs);
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  279  
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  280  /*
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  281   * Threshold handler
58995d2d58e8e5 arch/x86/include/asm/mce.h Hidetoshi Seto            2009-06-15  282   */
b276268631af3a arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  283  extern void (*mce_threshold_vector)(void);
b276268631af3a arch/x86/include/asm/mce.h Andi Kleen                2009-02-12  284  
24fd78a81f6d3f arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2015-05-06  285  /* Deferred error interrupt handler */
24fd78a81f6d3f arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2015-05-06  286  extern void (*deferred_error_int_vector)(void);
24fd78a81f6d3f arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2015-05-06  287  
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  288  /*
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  289   * Used by APEI to report memory error via /dev/mcelog
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  290   */
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  291  
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  292  struct cper_sec_mem_err;
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  293  extern void apei_mce_report_mem_error(int corrected,
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  294  				      struct cper_sec_mem_err *mem_err);
d334a49113a4a3 arch/x86/include/asm/mce.h Huang Ying                2010-05-18  295  
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  296  /*
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  297   * Enumerate new IP types and HWID values in AMD processors which support
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  298   * Scalable MCA.
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  299   */
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  300  #ifdef CONFIG_X86_MCE_AMD
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  301  
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  302  /* These may be used by multiple smca_hwid_mcatypes */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  303  enum smca_bank_types {
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  304  	SMCA_LS = 0,	/* Load Store */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  305  	SMCA_LS_V2,
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  306  	SMCA_IF,	/* Instruction Fetch */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  307  	SMCA_L2_CACHE,	/* L2 Cache */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  308  	SMCA_DE,	/* Decoder Unit */
68627a697c1959 arch/x86/include/asm/mce.h Yazen Ghannam             2018-02-21  309  	SMCA_RESERVED,	/* Reserved */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  310  	SMCA_EX,	/* Execution Unit */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  311  	SMCA_FP,	/* Floating Point */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  312  	SMCA_L3_CACHE,	/* L3 Cache */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  313  	SMCA_CS,	/* Coherent Slave */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  314  	SMCA_CS_V2,
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  315  	SMCA_PIE,	/* Power, Interrupts, etc. */
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  316  	SMCA_UMC,	/* Unified Memory Controller */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  317  	SMCA_UMC_V2,
47b744ea5e3cf8 arch/x86/include/asm/mce.h Muralidhara M K           2023-11-02  318  	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  319  	SMCA_PB,	/* Parameter Block */
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  320  	SMCA_PSP,	/* Platform Security Processor */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  321  	SMCA_PSP_V2,
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  322  	SMCA_SMU,	/* System Management Unit */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  323  	SMCA_SMU_V2,
cbfa447edd6a38 arch/x86/include/asm/mce.h Yazen Ghannam             2019-02-01  324  	SMCA_MP5,	/* Microprocessor 5 Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  325  	SMCA_MPDMA,	/* MPDMA Unit */
cbfa447edd6a38 arch/x86/include/asm/mce.h Yazen Ghannam             2019-02-01  326  	SMCA_NBIO,	/* Northbridge IO Unit */
cbfa447edd6a38 arch/x86/include/asm/mce.h Yazen Ghannam             2019-02-01  327  	SMCA_PCIE,	/* PCI Express Unit */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  328  	SMCA_PCIE_V2,
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  329  	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  330  	SMCA_NBIF,	/* NBIF Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  331  	SMCA_SHUB,	/* System HUB Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  332  	SMCA_SATA,	/* SATA Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  333  	SMCA_USB,	/* USB Unit */
47b744ea5e3cf8 arch/x86/include/asm/mce.h Muralidhara M K           2023-11-02  334  	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
47b744ea5e3cf8 arch/x86/include/asm/mce.h Muralidhara M K           2023-11-02  335  	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  336  	SMCA_GMI_PCS,	/* GMI PCS Unit */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  337  	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
94a311ce248e0b arch/x86/include/asm/mce.h Muralidhara M K           2021-05-26  338  	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
5176a93ab27aef arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  339  	SMCA_GMI_PHY,	/* GMI PHY Unit */
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  340  	N_SMCA_BANK_TYPES
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  341  };
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  342  
c6708d50f166be arch/x86/include/asm/mce.h Yazen Ghannam             2017-12-18  343  extern bool amd_mce_is_memory_error(struct mce *m);
e71c3978d6f976 arch/x86/include/asm/mce.h Linus Torvalds            2016-12-12  344  
4d7b02d58c4000 arch/x86/include/asm/mce.h Sebastian Andrzej Siewior 2016-11-10  345  extern int mce_threshold_create_device(unsigned int cpu);
4d7b02d58c4000 arch/x86/include/asm/mce.h Sebastian Andrzej Siewior 2016-11-10  346  extern int mce_threshold_remove_device(unsigned int cpu);
e71c3978d6f976 arch/x86/include/asm/mce.h Linus Torvalds            2016-12-12  347  
9308fd4074551f arch/x86/include/asm/mce.h Yazen Ghannam             2019-03-22  348  void mce_amd_feature_init(struct cpuinfo_x86 *c);
91f75eb481cfae arch/x86/include/asm/mce.h Yazen Ghannam             2021-12-16  349  enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
4d7b02d58c4000 arch/x86/include/asm/mce.h Sebastian Andrzej Siewior 2016-11-10  350  #else
5896820e0aa325 arch/x86/include/asm/mce.h Yazen Ghannam             2016-09-12  351  
4d7b02d58c4000 arch/x86/include/asm/mce.h Sebastian Andrzej Siewior 2016-11-10  352  static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
4d7b02d58c4000 arch/x86/include/asm/mce.h Sebastian Andrzej Siewior 2016-11-10  353  static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0; };
c6708d50f166be arch/x86/include/asm/mce.h Yazen Ghannam             2017-12-18  354  static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
9308fd4074551f arch/x86/include/asm/mce.h Yazen Ghannam             2019-03-22  355  static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  356  #endif
be0aec23bf4624 arch/x86/include/asm/mce.h Aravind Gopalakrishnan    2016-03-07  357  
9308fd4074551f arch/x86/include/asm/mce.h Yazen Ghannam             2019-03-22 @358  static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
e9c2a283e7d9d4 arch/x86/include/asm/mce.h Arnd Bergmann             2023-05-16  359  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

