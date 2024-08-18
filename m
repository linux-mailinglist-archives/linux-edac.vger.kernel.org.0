Return-Path: <linux-edac+bounces-1677-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C5955BDE
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 09:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6601F21606
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E917591;
	Sun, 18 Aug 2024 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CLSJmjFa"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C01754B;
	Sun, 18 Aug 2024 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723967593; cv=none; b=SNr29rBo4CsMCtqJ/I8XjPE6nlDlqQKwXGdDr6rX56v2XU9G4ym+vEl/CvS7R/LTyECDxXMQPfJJ5FrrqttoJ9G7plY5I5gQoDwcfXPPh5wd9QJERsgTbShYYWIIXRUXVszhzx+95Iy9wko9E8dSTvrMjwr9A8WpGvdOmtUxytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723967593; c=relaxed/simple;
	bh=JYl0nnbGctAnVjtJkBWj5fgYH+THsGUlIZRbI9paeoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWZr+jzpO2N4L8+IRU+9f86WV6WYxvZsVGvUMWIghgnVHAfK3he7b3f6YVFcwZbImsOU179jKkU9pXDxa6PIIgWB+TvmycrKHgj692DdeWj1cADUTHf8gsDSBLDuMCCMozf6yqwELXILktrI2tu3p6C7XpL6z8n4Ai3qssXfSbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CLSJmjFa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723967591; x=1755503591;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JYl0nnbGctAnVjtJkBWj5fgYH+THsGUlIZRbI9paeoc=;
  b=CLSJmjFaQ4c/hlQEiy6DPsAkHVNDTOV+DpNe0LfS/ZcOg+CLFELs5VEz
   zc4apphVoKO7NLYsQolDcec6Pcx/+tlr6pDmm4fdSQ9wKkVmE/TQlHKmz
   VzwbOAHT4MvfXfhanHl2tZZcQFMSERSJH5sRqlcsa/ZCJHjtYJxfkgfRd
   WwRnMTMyj81scXAEbEg6leh1rXE3gk0l3ZbDed45NygBYThMzRWYzYOWF
   7B6j8HsId5hwL1im8aaatUMwl9gL3M70lW6TNIRZK2JhDf4wEhs0zM7Ci
   O7xmyLyNnNAFzBakjVTaKffXd3lH/emMuvKYUi0rbIrHcziTciAkDJzT4
   A==;
X-CSE-ConnectionGUID: dXYw4JgRQkG54hGWrsUplw==
X-CSE-MsgGUID: TmCHg9WzSD2sO8P7IX+zFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22366269"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="22366269"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 00:53:10 -0700
X-CSE-ConnectionGUID: KkicVjpFRPeRloMYCal/mA==
X-CSE-MsgGUID: aZr/EikoTjyPjZYU2cGo3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="60070010"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 18 Aug 2024 00:53:03 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfaij-00086W-1K;
	Sun, 18 Aug 2024 07:53:01 +0000
Date: Sun, 18 Aug 2024 15:52:09 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com
Subject: Re: [PATCH v11 14/14] cxl/memfeature: Add CXL memory device PPR
 control feature
Message-ID: <202408181550.8ttlDbQA-lkp@intel.com>
References: <20240816164238.1902-15-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816164238.1902-15-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge cxl/next linus/master v6.11-rc3 next-20240816]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/EDAC-Add-support-for-EDAC-device-feature-s-control/20240817-004442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240816164238.1902-15-shiju.jose%40huawei.com
patch subject: [PATCH v11 14/14] cxl/memfeature: Add CXL memory device PPR control feature
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240818/202408181550.8ttlDbQA-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408181550.8ttlDbQA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408181550.8ttlDbQA-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cxl/core/memfeature.c:717:21: warning: 'cxl_hppr_uuid' defined but not used [-Wunused-const-variable=]
     717 | static const uuid_t cxl_hppr_uuid =
         |                     ^~~~~~~~~~~~~


vim +/cxl_hppr_uuid +717 drivers/cxl/core/memfeature.c

   711	
   712	/* CXL memory soft PPR & hard PPR control definitions */
   713	static const uuid_t cxl_sppr_uuid =
   714		UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,     \
   715			  0x75, 0x68, 0xbb);
   716	
 > 717	static const uuid_t cxl_hppr_uuid =
   718		UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,     \
   719			  0xfb, 0x0e, 0x24);
   720	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

