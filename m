Return-Path: <linux-edac+bounces-1835-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A557E9726C1
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 03:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32BD41F244AE
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 01:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551C13AA4E;
	Tue, 10 Sep 2024 01:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRR4ZCo6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F14139D15;
	Tue, 10 Sep 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725933343; cv=none; b=RoBynX33l/CP6p+Bp9FY/f9hrp3BeGpbS6k3Bbq2IprrBXiAncSxTrzDKZLuF9c2dt4PjY/57aEP/5l6d/GwDcftRJKXwCoeXl6xDYyjflgt0S3qF8ZB2vdxhH51TVYEc97gc73oBxN52WztyN9eLLCyXp4hliG+KZyApEGAkb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725933343; c=relaxed/simple;
	bh=WXIYwvgCCcY15YOPnK6S4GVJJNWqZ9kOmG05udu4AcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qInFIVwEKdZziCWcFAbFDDcT0xLdx1igxZCvUDSaW3YY2tK+MZvL7vZ4ndOcUhCkGhMgwlfQezpTbM1wqsRs57lM/pURW2vfC4ZxaJWE5by727EfnX8MgMAidFqPl/vW8YqNfO9z2PJt/K0vgYCmy/ifeDOk5rEtPITdX0v7/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QRR4ZCo6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725933342; x=1757469342;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WXIYwvgCCcY15YOPnK6S4GVJJNWqZ9kOmG05udu4AcI=;
  b=QRR4ZCo6xIRc2utOZC/GTNuyrsKCuFMDjTrGA80MZ4cXMQmYAt4k4EqQ
   GdRivITuS9XXdEe0pIYYj/qo5bOb7btysW+7Py81wahJ9j1XVhgcKTstO
   Vtdbyq4PmaYGzby/nHxg8YzGKE1xrUkefFeYYD1S9HKuS/1oav2VsPl9r
   LY9la0ANgVJnNTp3m59puJK9vqV3WEDUXGGXlUiwB1oZNwHIoAEcC4zcg
   uzGyHgzVgDUeA6w9an2CN2DzX7wGCt8TEC6MbnuWkXs01h4Dc/VYf/8HW
   26eX9U0HV1zLL5tlU8dWwmPppjaVSKWyl0WJasEkzJTVhfJRlF51ZodbB
   w==;
X-CSE-ConnectionGUID: 1duy5YunS8GLbu0+39NWIQ==
X-CSE-MsgGUID: Xbu0PlMzQ7eetFrmi1WgUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="24851648"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="24851648"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 18:55:41 -0700
X-CSE-ConnectionGUID: cf0cPxM3QJ6R/2dkNPzv5A==
X-CSE-MsgGUID: OfslnRUBRv+oEfKRhDFFqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="71471852"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Sep 2024 18:55:37 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1snq6R-000FTc-0k;
	Tue, 10 Sep 2024 01:55:35 +0000
Date: Tue, 10 Sep 2024 09:54:39 +0800
From: kernel test robot <lkp@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v1 2/3] x86/mce: Add zhaoxin.c to support Zhaoxin MCA
Message-ID: <202409100925.oZtxKGQi-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-001-20240910 (https://download.01.org/0day-ci/archive/20240910/202409100925.oZtxKGQi-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409100925.oZtxKGQi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409100925.oZtxKGQi-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_init':
>> severity.c:(.text+0x2c0): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_clear':
>> severity.c:(.text+0x2f0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_init':
   genpool.c:(.text+0x10): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_clear':
   genpool.c:(.text+0x40): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/amd.o: in function `mce_zhaoxin_feature_init':
   amd.c:(.text+0x1730): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/amd.o: in function `mce_zhaoxin_feature_clear':
   amd.c:(.text+0x1760): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_init':
   threshold.c:(.text+0x70): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_clear':
   threshold.c:(.text+0xa0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/inject.o: in function `mce_zhaoxin_feature_init':
   inject.c:(.text+0xd80): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/inject.o: in function `mce_zhaoxin_feature_clear':
   inject.c:(.text+0xdb0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/apei.o: in function `mce_zhaoxin_feature_init':
   apei.c:(.text+0xf0): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/apei.o: in function `mce_zhaoxin_feature_clear':
   apei.c:(.text+0x120): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

