Return-Path: <linux-edac+bounces-1676-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF09A955BBE
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 09:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF85281440
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 07:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFE014F90;
	Sun, 18 Aug 2024 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwq/ntlL"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32A11CBD;
	Sun, 18 Aug 2024 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723965133; cv=none; b=rxNRl3fyhgqYbqgz++b4H1gC4tGaF4nBHoh0vOSHgVdAnbB+3X8TtncNlFbk31jw8z22aYsMhIyR2Va3lDh3uK3CmTkdGywdWJjHF1ivjnO+MUnpqXnEUPOMeHopebqgksDhkGAPdJjcDt5PZxI7UVl6K06aOG8L+ARQn1lnxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723965133; c=relaxed/simple;
	bh=3v8UlkRh1iRwxBPgNEZQJ8RnyX/t0heq6u2dovh+q6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbch5ttSOF2q2eTB+uo+82BgcXRd+gmuKCvPfD8a2JgAnCVdHyGW96zKQCB3X3+eLjAE0FFpZxSE0ImNDrHkgGyyK8zS7QDHPtCXwQRgFaCZXDEMKnALbBsNWDVAyg9lVUTBpDy/qYR4uyU4WuR499OQf4AQfB7YzGqyO8WAEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwq/ntlL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723965131; x=1755501131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3v8UlkRh1iRwxBPgNEZQJ8RnyX/t0heq6u2dovh+q6Q=;
  b=mwq/ntlL+fAhgg1nd/97yA2AkqqzxYYsaI6/vU6KrD6PT7cNQ7z0lFbt
   E87OxnI1spXNv8qtVejLfS4pb66WHTs5K6PjtwlJV4MqZf8M1t6ikKP27
   apJ1a3rC7/+2Tuj+k5NR/HZ+GbYAPrg2DysEKwpeT0Fr87TES2ZZfcSL5
   RqMTdQhBigwI/eHXTC0m0Nvnw/FGKldrqLvDKHBGK+PO3b6+iQozHNXap
   5yjEjME0hW7ne0K2MMxXG6zcssoDe18DsDawoIubCmpa5R+wlke/ltWP1
   3cUnZy1lpNJIIrNCOzKs0WOBWrkQXZpDQwilapqXhY3UgtG7SKKcSNj4T
   A==;
X-CSE-ConnectionGUID: W4SGjMc+RYKt2BRiiNTbUg==
X-CSE-MsgGUID: qNtZFX4dT+OS/c/2PMIEtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11167"; a="22364808"
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="22364808"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 00:12:10 -0700
X-CSE-ConnectionGUID: 2rhuFNx/QMaezaya1vqJxQ==
X-CSE-MsgGUID: ot1K6YpISzK/7X1phX+Cjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,156,1719903600"; 
   d="scan'208";a="59773962"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 18 Aug 2024 00:12:03 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfa52-000852-2f;
	Sun, 18 Aug 2024 07:12:00 +0000
Date: Sun, 18 Aug 2024 15:11:13 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, bp@alien8.de,
	tony.luck@intel.com, rafael@kernel.org, lenb@kernel.org,
	mchehab@kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, david@redhat.com, Vilas.Sridharan@amd.com,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com
Subject: Re: [PATCH v11 01/14] EDAC: Add support for EDAC device feature's
 control
Message-ID: <202408181416.PD0B8fMf-lkp@intel.com>
References: <20240816164238.1902-2-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816164238.1902-2-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge cxl/next linus/master cxl/pending v6.11-rc3 next-20240816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/EDAC-Add-support-for-EDAC-device-feature-s-control/20240817-004442
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240816164238.1902-2-shiju.jose%40huawei.com
patch subject: [PATCH v11 01/14] EDAC: Add support for EDAC device feature's control
config: i386-buildonly-randconfig-003-20240818 (https://download.01.org/0day-ci/archive/20240818/202408181416.PD0B8fMf-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240818/202408181416.PD0B8fMf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408181416.PD0B8fMf-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/edac_device.c:608: warning: Function parameter or struct member 'ras_feat' not described in 'edac_dev_feat_init'
>> drivers/edac/edac_device.c:608: warning: expecting prototype for edac_dev_feature_init(). Prototype was for edac_dev_feat_init() instead


vim +608 drivers/edac/edac_device.c

   593	
   594	/**
   595	 * edac_dev_feature_init - Init a ras feature
   596	 * @parent: client device.
   597	 * @dev_data: pointer to struct edac_dev_data.
   598	 * @feat: pointer to struct edac_dev_feature.
   599	 * @attr_groups: pointer to attribute group's container.
   600	 *
   601	 * Returns number of scrub feature's attribute groups on success,
   602	 * error otherwise.
   603	 */
   604	static int edac_dev_feat_init(struct device *parent,
   605				      struct edac_dev_data *dev_data,
   606				      const struct edac_dev_feature *ras_feat,
   607				      const struct attribute_group **attr_groups)
 > 608	{
   609		int num;
   610	
   611		switch (ras_feat->feat) {
   612		case RAS_FEAT_SCRUB:
   613			dev_data->scrub_ops = ras_feat->scrub_ops;
   614			dev_data->private = ras_feat->scrub_ctx;
   615			return 1;
   616		case RAS_FEAT_ECS:
   617			num = ras_feat->ecs_info.num_media_frus;
   618			dev_data->ecs_ops = ras_feat->ecs_ops;
   619			dev_data->private = ras_feat->ecs_ctx;
   620			return num;
   621		case RAS_FEAT_PPR:
   622			dev_data->ppr_ops = ras_feat->ppr_ops;
   623			dev_data->private = ras_feat->ppr_ctx;
   624			return 1;
   625		default:
   626			return -EINVAL;
   627		}
   628	}
   629	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

