Return-Path: <linux-edac+bounces-1838-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45AD972C7E
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1F41F228C8
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 08:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFA5186294;
	Tue, 10 Sep 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YyoHb1Gt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFD416F27E;
	Tue, 10 Sep 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958147; cv=none; b=DPVhV6QkN4uH+c0IrZCp2Wxj4/sE2fwhBljIvFC5JNMHPpU9MNfVAXJUTtTT4sPeArJYyAcsn+JqrZc6el6v1wHgu+lmLA2FXixPl/wkREkXgw2cL2+gvecO/vQznKJILKZMDhMheus43HCP3vbcT7Z66lJw/fgH6Yc7w+Z6l/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958147; c=relaxed/simple;
	bh=VUEzpoId+rSNfTQWbZ3INdjjRMEg1Y+yWOtO4ecrN60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKufLAFSeLGyVuxH1U9rakrhxCjEcja+dyKJoxhYB1w3vwOdgNdPJ0qC2W6tpSI7XpgC41ouVaTTBBjr18kbYmmNx80NMQqbQ5r0c1ESy4XWzxTXkXBiZvDqof2TefoqQyrLdznapgI7axz2xnsBIUrGqcMW9zUROZ2gR6CfgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YyoHb1Gt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725958146; x=1757494146;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VUEzpoId+rSNfTQWbZ3INdjjRMEg1Y+yWOtO4ecrN60=;
  b=YyoHb1GtO59uonoJ3xAvxHAb99DOCBG4pSLhWs7waar5i3ZMpKaomBSD
   YgGbshAlkq85sbpZZG6ko2AIyOb/rcDEOWpPOQCzmmEFplX/LpmQ7WHDD
   JCn4VMxdQFNcGjVjpL7avjVCjfF9pfvPgOYaRpahzNjBRa8Z1MMZgHiHl
   vl8iE73atdGbwKbJBdyzl9pTYfkjT4vVU6B3WV+WWDpnpNCGON1X5hFjy
   M7sQV1Qu3+XXO/jll2P0TmomZYoHITyUcl+Ru7K+M5/DmFm4Ao1dgom26
   3gGT+PTlVyOSwjNBwXv9tH1VPB6BSB8PMYLJeXStrUyAm1eIZpE/dt/aB
   w==;
X-CSE-ConnectionGUID: bPtd5ip4TdyQOdNsdL6OeA==
X-CSE-MsgGUID: Nl48Xg9NTPemBakiM34Hiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="50104042"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="50104042"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 01:49:05 -0700
X-CSE-ConnectionGUID: wZLhhrpcRrS2g/S4xn6koA==
X-CSE-MsgGUID: //rgL5seQ5GUTfP19ehAzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71924973"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 10 Sep 2024 01:49:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snwYU-0000Ig-1d;
	Tue, 10 Sep 2024 08:48:58 +0000
Date: Tue, 10 Sep 2024 16:48:54 +0800
From: kernel test robot <lkp@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v1 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Message-ID: <202409101604.VYS2JlHA-lkp@intel.com>
References: <20240909104349.3349-3-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909104349.3349-3-TonyWWang-oc@zhaoxin.com>

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on tip/master linus/master v6.11-rc7 next-20240909]
[cannot apply to tip/auto-latest]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-W-Wang-oc/x86-mce-Add-centaur-vendor-to-support-Zhaoxin-MCA/20240909-192507
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240909104349.3349-3-TonyWWang-oc%40zhaoxin.com
patch subject: [PATCH v1 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
config: x86_64-randconfig-123-20240910 (https://download.01.org/0day-ci/archive/20240910/202409101604.VYS2JlHA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101604.VYS2JlHA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101604.VYS2JlHA-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_init':
>> arch/x86/kernel/cpu/mce/internal.h:341: multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:341: first defined here
   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_clear':
>> arch/x86/kernel/cpu/mce/internal.h:342: multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:342: first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_init':
>> arch/x86/kernel/cpu/mce/internal.h:341: multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:341: first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_clear':
>> arch/x86/kernel/cpu/mce/internal.h:342: multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:342: first defined here
   ld: arch/x86/kernel/cpu/mce/intel.o: in function `mce_zhaoxin_feature_init':
>> arch/x86/kernel/cpu/mce/internal.h:341: multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:341: first defined here
   ld: arch/x86/kernel/cpu/mce/intel.o: in function `mce_zhaoxin_feature_clear':
>> arch/x86/kernel/cpu/mce/internal.h:342: multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:342: first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_init':
>> arch/x86/kernel/cpu/mce/internal.h:341: multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:341: first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_clear':
>> arch/x86/kernel/cpu/mce/internal.h:342: multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:342: first defined here
   ld: arch/x86/kernel/cpu/mce/dev-mcelog.o: in function `mce_zhaoxin_feature_init':
>> arch/x86/kernel/cpu/mce/internal.h:341: multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:341: first defined here
   ld: arch/x86/kernel/cpu/mce/dev-mcelog.o: in function `mce_zhaoxin_feature_clear':
>> arch/x86/kernel/cpu/mce/internal.h:342: multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:arch/x86/kernel/cpu/mce/internal.h:342: first defined here


vim +341 arch/x86/kernel/cpu/mce/internal.h

   335	
   336	extern void (*mc_poll_banks)(void);
   337	#ifdef CONFIG_X86_MCE_ZHAOXIN
   338	void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
   339	void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c);
   340	#else
 > 341	void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) {}
 > 342	void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c) {}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

