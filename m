Return-Path: <linux-edac+bounces-1836-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52020972908
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 07:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EA1284859
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2024 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A863C16A955;
	Tue, 10 Sep 2024 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1s00zJF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5219BA42;
	Tue, 10 Sep 2024 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725947681; cv=none; b=MUaEeQgzvqnEABLKmFG6pskpWRJga/+R0Yil/STGoC3L9U97WQ5GPZuLjcKZ5rP8Y/Fgk6LQ+VO1WNT+UR1OQ4IbrJR2ktwFMLNSHG2aJrpCI0ptsADQlBspQWhJ5NOt1ukQh0cXnh3L6uS1WlSgYydJBPGlTAKRqErWJ+6/i+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725947681; c=relaxed/simple;
	bh=YoWqmzklplwSJWfbQ1gZFmNrdFr9caEIlCjWuwlnYpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5x4hHmfPeVc0TmUoGk+sO2FMHpLx18ATtPMaZyrAy2VNQElWqqFZRkavY1kDkYDjLVCqNFBLDtTm53JnUj+tWyT7FfaUYbcA8qNIRdXcLfwY9+wLAzpKJqb6zGjicWVySVKc6dhfqx/dURefepqPPyh1sjlH1mAv18KorZbR4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1s00zJF; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725947680; x=1757483680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YoWqmzklplwSJWfbQ1gZFmNrdFr9caEIlCjWuwlnYpI=;
  b=N1s00zJFQK8lDGH7MzYX+W0dU/4Xs6V2DVxjmP5+ak7W7F26GO8Ykpez
   pJAOtddbLn6Scbt7zkRq1f8yy/5cFh0cj6zvH6947CWrlNA0OkwdgskY5
   GNCCbuQ4uTskfUDyeirVxWAU7UmmIRUSfRx1+J1rrYk1xW33msxeKxqq7
   JrY3dRFI/0fLcIad8zP/86VP5VhEVL+qXsUWlhWSzgpDbpym4Al1nDjay
   0vq/oGMbWTGcA+uIgOWn1fXRU9urtSmpMVEWb8ERq8fc5oY+WolZsmN3Z
   DQc2iiDSxbII8A+4exYfcWJHgE+RasQ+1d8tvyYgjMkFh+YTcMQ36QKWH
   w==;
X-CSE-ConnectionGUID: 24e6EJTHSNWTaGdlgOkeiw==
X-CSE-MsgGUID: yYXYcAzjTw2918j6n7lNfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="42150631"
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="42150631"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 22:54:39 -0700
X-CSE-ConnectionGUID: vq6qM2ePRbiXkXBhz1gCTA==
X-CSE-MsgGUID: tpT0AFC9QVeomvw0K2O93w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,216,1719903600"; 
   d="scan'208";a="71036413"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2024 22:54:36 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sntph-00008I-2A;
	Tue, 10 Sep 2024 05:54:33 +0000
Date: Tue, 10 Sep 2024 13:53:53 +0800
From: kernel test robot <lkp@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, tony.luck@intel.com,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, Lyle Li <LyleLi@zhaoxin.com>
Subject: Re: [PATCH v1 3/3] x86/mce: Add CMCI storm switching support for
 Zhaoxin
Message-ID: <202409101353.K4jjCjRN-lkp@intel.com>
References: <20240909104349.3349-4-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909104349.3349-4-TonyWWang-oc@zhaoxin.com>

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
patch link:    https://lore.kernel.org/r/20240909104349.3349-4-TonyWWang-oc%40zhaoxin.com
patch subject: [PATCH v1 3/3] x86/mce: Add CMCI storm switching support for Zhaoxin
config: x86_64-buildonly-randconfig-001-20240910 (https://download.01.org/0day-ci/archive/20240910/202409101353.K4jjCjRN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240910/202409101353.K4jjCjRN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409101353.K4jjCjRN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_init':
   severity.c:(.text+0x2c0): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_feature_clear':
   severity.c:(.text+0x2f0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/severity.o: in function `mce_zhaoxin_handle_storm':
>> severity.c:(.text+0x320): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_init':
   genpool.c:(.text+0x10): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_feature_clear':
   genpool.c:(.text+0x40): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/genpool.o: in function `mce_zhaoxin_handle_storm':
   genpool.c:(.text+0x70): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here
   ld: arch/x86/kernel/cpu/mce/amd.o: in function `mce_zhaoxin_feature_init':
   amd.c:(.text+0x1730): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/amd.o: in function `mce_zhaoxin_feature_clear':
   amd.c:(.text+0x1760): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/amd.o: in function `mce_zhaoxin_handle_storm':
   amd.c:(.text+0x1790): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_init':
   threshold.c:(.text+0x70): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_feature_clear':
   threshold.c:(.text+0xa0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/threshold.o: in function `mce_zhaoxin_handle_storm':
   threshold.c:(.text+0xd0): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here
   ld: arch/x86/kernel/cpu/mce/inject.o: in function `mce_zhaoxin_feature_init':
   inject.c:(.text+0xd80): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/inject.o: in function `mce_zhaoxin_feature_clear':
   inject.c:(.text+0xdb0): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/inject.o: in function `mce_zhaoxin_handle_storm':
   inject.c:(.text+0xde0): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here
   ld: arch/x86/kernel/cpu/mce/apei.o: in function `mce_zhaoxin_feature_init':
   apei.c:(.text+0xf0): multiple definition of `mce_zhaoxin_feature_init'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1950): first defined here
   ld: arch/x86/kernel/cpu/mce/apei.o: in function `mce_zhaoxin_feature_clear':
   apei.c:(.text+0x120): multiple definition of `mce_zhaoxin_feature_clear'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x1980): first defined here
   ld: arch/x86/kernel/cpu/mce/apei.o: in function `mce_zhaoxin_handle_storm':
   apei.c:(.text+0x150): multiple definition of `mce_zhaoxin_handle_storm'; arch/x86/kernel/cpu/mce/core.o:core.c:(.text+0x19b0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

