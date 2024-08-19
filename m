Return-Path: <linux-edac+bounces-1679-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBF195608F
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2024 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39BE9B21130
	for <lists+linux-edac@lfdr.de>; Mon, 19 Aug 2024 00:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491B816415;
	Mon, 19 Aug 2024 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b/wNtnIV"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D96EC2;
	Mon, 19 Aug 2024 00:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724027426; cv=none; b=UNAD6tvjDd5D5+6PT20pMxUz6F1hrfX7WwoXWsr0IaZqVRXvDMqheArrWyQd8RnS9e/Ui980jUbE+vuGUPfDAmNu4RrAKX1UfXgvm3TyVONZZ5iFxoetJSiEEaYEM9SOX6EkByjsO1I1I7P7CoGdSX1q8RnTGqsRIyvrTXf6MTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724027426; c=relaxed/simple;
	bh=E3JR5s7Wgc/eHnVwduUVdcqhj2KymdGNAdjHK99sMCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwfoieQFp7h9looH44lA92+y8fVLORi5Qcik0yjADn4QWZwdpBgnDHh8l+dgbeyPYimt6pZE01h92L7vZxcdeFw2+pY3AMrDx/jpD4/m/D7rqbfaXEZAFehpNOLoJkkbYjVR9JhWl15dB4jcHM1pwcAJYsCLqqDS8J+BNjFAYFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b/wNtnIV; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724027424; x=1755563424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E3JR5s7Wgc/eHnVwduUVdcqhj2KymdGNAdjHK99sMCQ=;
  b=b/wNtnIVtqI+Zn67LwekbieEQfELcuc+pZfA6Pu+SmIy7AzbUqFvwLXf
   e8onulvp2Isxqx5j+5P/ZBzpaeQW9yahkFqiVC4ttqEfktRHupxZjIzPQ
   pvGqqpBia7StHLy8aiowwxktpvhrf0EXvOP5L3ouE2Mykj/FfO3GN+YVh
   M/4596rYltoDnFLlzJcwIOVB8Nbau2knvvcfjkz2BSjPm95gpc2FVFgk/
   nmMa0BwxaKyFg77K1VShKhrmwV0gbwgolt25Db19c1bakigl9vwOZ7eW0
   5jebeAo7ZJCXQcC0EidVZt0qXaeGEUUmk60ktmQ8f/3xF+82eSUmvTO1f
   g==;
X-CSE-ConnectionGUID: BRT8dZtPQIayEiHyxfPaQA==
X-CSE-MsgGUID: E8Cv12vPSqeztuCZxnXc1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="39715683"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="39715683"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 17:30:24 -0700
X-CSE-ConnectionGUID: JXtd5NROQOy/bAxsJ/oRRg==
X-CSE-MsgGUID: Y/H0DJmxROuFevJNO9hMBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="65034467"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 18 Aug 2024 17:30:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfqHl-0008Wq-2j;
	Mon, 19 Aug 2024 00:30:13 +0000
Date: Mon, 19 Aug 2024 08:29:54 +0800
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
Subject: Re: [PATCH v11 01/14] EDAC: Add support for EDAC device feature's
 control
Message-ID: <202408190825.fBBO0NTN-lkp@intel.com>
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
config: i386-randconfig-062-20240818 (https://download.01.org/0day-ci/archive/20240819/202408190825.fBBO0NTN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240819/202408190825.fBBO0NTN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190825.fBBO0NTN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/edac/edac_device.c:584:26: sparse: sparse: symbol 'edac_dev_type' was not declared. Should it be static?
   drivers/edac/edac_device.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +/edac_dev_type +584 drivers/edac/edac_device.c

   583	
 > 584	const struct device_type edac_dev_type = {
   585		.name = "edac_dev",
   586		.release = edac_dev_release,
   587	};
   588	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

