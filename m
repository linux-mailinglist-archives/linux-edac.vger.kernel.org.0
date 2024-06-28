Return-Path: <linux-edac+bounces-1426-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDD091B6B1
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 08:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500F51C220A9
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jun 2024 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC352F9E;
	Fri, 28 Jun 2024 06:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9wZy2zx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D84D131;
	Fri, 28 Jun 2024 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554715; cv=none; b=lZWUN8WR5cefxOItfPCGUk26dRERzfxdoCKl8VzunOug9KXdLdNqdRVB1BXQB5KifwzmbEOKIrRtcUqA5/SjyevD8H/pLjNnGTzrdkXOmlYwJeH5QTnD1UfNFjh842Hxoo8QdW8KUuTWj6VShohD64oscMg1IsOPeo6rlK4Wqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554715; c=relaxed/simple;
	bh=Ml7yiCc6B6Q2lb4ESoCfB21M9mzM7wrU0gwo3FO2VwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtJep8Znquk5QaYvsqIecSegrQoaUyLO+E2qFmC2V5eMSkYzdcsXT+wtvOdlbVCdv52Dsg5x7JURtM2Lm3poqsdU9F95QBJHwGkLhQS9mS3flbvpVHdbj/Co4dvQ4TkrP7cURYJJBhXMZIrt+obsv3jfi4BkKIEUl02zRNgMfus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9wZy2zx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719554713; x=1751090713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ml7yiCc6B6Q2lb4ESoCfB21M9mzM7wrU0gwo3FO2VwQ=;
  b=K9wZy2zx9JH/W7kMt81PCuoCVF0hUq6rRrf078EIwlzsO9v0dy+qn1w4
   /eP/TiIg0nWsfOHnjpc1eI80fxLJMhPQzyG+s8p4DNYBIvnh3B+l9DgZ7
   3gCUdoKCBJpc5PzvI+S4rfcshuzaLNL+czLOYQbGZdY+4t52o9Bmb+wl8
   dbKOoLbtujeex06BAhEBoyK6cBUFK3Z0j4WyDzwv0W2ueXdSIut7kD72A
   XECeA+bV7mg0usq8s6qt3yfUFMA1PDYriKehrvK//DAUrzMZ8nq6IStRx
   evcHwhdOM7f/T/TxaaA/W/CHYplISubGrPbkvnVGi8eXExMuGCQd8rcoU
   Q==;
X-CSE-ConnectionGUID: qsf8V5WATESHr3Ns+jBSdg==
X-CSE-MsgGUID: +Crt0v+mQdqR8WQTF1Z9zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="39240989"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="39240989"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 23:05:12 -0700
X-CSE-ConnectionGUID: cc/TEU9lRMecm42fe/RaAQ==
X-CSE-MsgGUID: 4PV93ZqaQZaKQQnzgOrDFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45043857"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 27 Jun 2024 23:05:08 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN4jJ-000Gri-2J;
	Fri, 28 Jun 2024 06:05:05 +0000
Date: Fri, 28 Jun 2024 14:04:19 +0800
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
Message-ID: <202406281337.j4rbN9nr-lkp@intel.com>
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
config: x86_64-randconfig-161-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281337.j4rbN9nr-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281337.j4rbN9nr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281337.j4rbN9nr-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/apei/ghes.c:575:9: error: use of undeclared identifier 'queued'
     575 |         return queued;
         |                ^
   1 error generated.


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
cf870c70a19444 Naveen N. Rao   2013-07-10  576  }
cf870c70a19444 Naveen N. Rao   2013-07-10  577  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

