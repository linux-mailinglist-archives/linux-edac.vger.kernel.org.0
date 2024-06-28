Return-Path: <linux-edac+bounces-1423-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8FD91B5CB
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 06:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BD9F28438F
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 04:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7962533CF1;
	Fri, 28 Jun 2024 04:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7htaq3d"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA1D22612;
	Fri, 28 Jun 2024 04:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550029; cv=none; b=YP7d5JrOApMI0sJBtsSadsmiFEHCWR8TV3LwSnd1Fh9bl0O0grKhZOH0Ti9iVDRHOoMtoDsQ/F/bn3Jt2GF+ovX4UI7YIM/4MhuiUTUtCPRcE4YtrJlxR7UTaAMLlzN4x5BWeTJPoVcLqhtj7uwjr54JTj7RcMRcjM+lyWU1Qy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550029; c=relaxed/simple;
	bh=hhSOyJfbZRZhIjSoV5AnADdHQZS1XJORgVzByzcsybE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StXbEOL/QT75t4LuaPmBypJx4+OEBjXkC7uqhgWGpdtuMWbZsQUQdX/HXOISjEsjpvl+RvnKhMZG7O2gmMsi1mu6xL1fYiCTIhdgKldx5plqYme7ETgmzwtsWur+o/An72bS8duVFRhIBn09Bux7j9RbSnlvt/ikWBMqhD//VKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7htaq3d; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719550027; x=1751086027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhSOyJfbZRZhIjSoV5AnADdHQZS1XJORgVzByzcsybE=;
  b=F7htaq3d082niNVfoeAVgjzk0fchFSd5q0HH2QaP+r5kJ6kW2gDjfRpR
   uO0e97xg+WR0ICipk9A6KFvSwsYHasaC+DOKgR29kt133mgnL3CIqRink
   q3CeTa//4CavZWEL8Gu4Gw9SiFvs+EUZ2m2+dO9TJ8A/BYUkSgvhiqVkl
   1JsBWQ7LKq7dqoEfwnJvVclUdFmEFjBK4SYBd9IjYjTDQv3md9p/JatvV
   X4we4RthwqdNK96glJK7EiS9h1XozrqCjYVAu8r6YZWcuewUb53QFwpKF
   46856jRG1B+4OHlqUN7gtbhLN6qzYBoRv+J3iRGsQjtsOnzfj3dS+cajD
   g==;
X-CSE-ConnectionGUID: gbLliY+eSru6S8c9WWLaxA==
X-CSE-MsgGUID: FyPUZP6CTZWOT6W681WI0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16537255"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16537255"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:47:06 -0700
X-CSE-ConnectionGUID: cCW7NoNoRpib26TeZ6KruA==
X-CSE-MsgGUID: hLb0L9vtSdmkdnpJYFiLHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45254075"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jun 2024 21:47:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN3Vj-000Gnw-2k;
	Fri, 28 Jun 2024 04:46:59 +0000
Date: Fri, 28 Jun 2024 12:46:04 +0800
From: kernel test robot <lkp@intel.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
	Daniel Ferguson <danielf@os.amperecomputing.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	James Morse <james.morse@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>, Shengwei Luo <luoshengwei@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH 1/2] RAS: ACPI: APEI: add conditional compilation to ARM
 error report functions
Message-ID: <202406281232.xTKmzO76-lkp@intel.com>
References: <95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab+huawei@kernel.org>

Hi Mauro,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge linus/master v6.10-rc5 next-20240627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mauro-Carvalho-Chehab/RAS-ACPI-APEI-add-conditional-compilation-to-ARM-error-report-functions/20240627-225843
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/95baa46a5e1c88f08e328dbbfbbd01602e092234.1719471257.git.mchehab%2Bhuawei%40kernel.org
patch subject: [PATCH 1/2] RAS: ACPI: APEI: add conditional compilation to ARM error report functions
config: x86_64-buildonly-randconfig-003-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281232.xTKmzO76-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281232.xTKmzO76-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281232.xTKmzO76-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/acpi/apei/ghes.c: In function 'ghes_handle_arm_hw_error':
>> drivers/acpi/apei/ghes.c:575:16: error: 'queued' undeclared (first use in this function)
     575 |         return queued;
         |                ^~~~~~
   drivers/acpi/apei/ghes.c:575:16: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/acpi/apei/ghes.c:576:1: warning: control reaches end of non-void function [-Wreturn-type]
     576 | }
         | ^


vim +/queued +575 drivers/acpi/apei/ghes.c

7f17b4a121d0d5 James Morse     2020-05-01  530  
a70297d2213253 Shuai Xue       2023-12-18  531  static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
a70297d2213253 Shuai Xue       2023-12-18  532  				     int sev, bool sync)
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  533  {
4a485d7f807462 Daniel Ferguson 2024-06-27  534  #if defined(CONFIG_ARM) || defined (CONFIG_ARM64)
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  535  	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
a70297d2213253 Shuai Xue       2023-12-18  536  	int flags = sync ? MF_ACTION_REQUIRED : 0;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  537  	bool queued = false;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  538  	int sec_sev, i;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  539  	char *p;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  540  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  541  	log_arm_hw_error(err);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  542  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  543  	sec_sev = ghes_severity(gdata->error_severity);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  544  	if (sev != GHES_SEV_RECOVERABLE || sec_sev != GHES_SEV_RECOVERABLE)
7f17b4a121d0d5 James Morse     2020-05-01  545  		return false;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  546  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  547  	p = (char *)(err + 1);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  548  	for (i = 0; i < err->err_info_num; i++) {
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  549  		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  550  		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  551  		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  552  		const char *error_type = "unknown error";
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  553  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  554  		/*
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  555  		 * The field (err_info->error_info & BIT(26)) is fixed to set to
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  556  		 * 1 in some old firmware of HiSilicon Kunpeng920. We assume that
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  557  		 * firmware won't mix corrected errors in an uncorrected section,
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  558  		 * and don't filter out 'corrected' error here.
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  559  		 */
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  560  		if (is_cache && has_pa) {
a70297d2213253 Shuai Xue       2023-12-18  561  			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  562  			p += err_info->length;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  563  			continue;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  564  		}
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  565  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  566  		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  567  			error_type = cper_proc_error_type_strs[err_info->type];
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  568  
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  569  		pr_warn_ratelimited(FW_WARN GHES_PFX
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  570  				    "Unhandled processor error type: %s\n",
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  571  				    error_type);
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  572  		p += err_info->length;
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11  573  	}
4a485d7f807462 Daniel Ferguson 2024-06-27  574  #endif
ccb5ecdc2ddeaf Xiaofei Tan     2021-06-11 @575  	return queued;
cf870c70a19444 Naveen N. Rao   2013-07-10 @576  }
cf870c70a19444 Naveen N. Rao   2013-07-10  577  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

