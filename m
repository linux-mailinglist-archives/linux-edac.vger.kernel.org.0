Return-Path: <linux-edac+bounces-1675-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BF495524A
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 23:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26DD1F23EE0
	for <lists+linux-edac@lfdr.de>; Fri, 16 Aug 2024 21:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299261C461E;
	Fri, 16 Aug 2024 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H9Fp/UKO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506031BE85D;
	Fri, 16 Aug 2024 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843285; cv=none; b=kJFfA1AO7vPDjL1d0KC6/Lelbv1/ZQ6pZGZ7g6ATA0jskWX/f/lSHjKfn3kg3chqQyix3Vxx/ltamhpoqjfGnc8krZbb02dPFtcl7dMe/T1RaxMYISUrAdG6FEDJiMgGzMYn6i8PHewcENHNs2CN7WPsFZnkzQ70CU29W3gksL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843285; c=relaxed/simple;
	bh=OvdHQaSBwswUa7jJWiJZvCv6lCjzqU5nVA6GDmhGLCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3vWRMt8Df5sJhqHMIbFDIjraFWkwuxBSKFjsq2eRE7hIHFMFTtZK6RSZsdU/FyYg1E5tszOHSMhwDftP2wojkXZlS7yDDYnteQ3192Tsjjozl60YLL4014FCoTKNXXgIBLJWCkgeJSTR08exarM53N9JS6UIA/Dbed/qEEi3Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H9Fp/UKO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723843283; x=1755379283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OvdHQaSBwswUa7jJWiJZvCv6lCjzqU5nVA6GDmhGLCo=;
  b=H9Fp/UKOz3U80pEpwlSQggQwcHKVj6za+u8yUL8EvuxxHuiflSm/baUP
   2bVIzwzPTQLuHuK4z01hPWliK8XTABlAByvL/oTUuHQhYxTmYlsN6PmR6
   /xcFlhQgFGvICh6HgJUupPWmTwy7p/ltCrk47OJuzQdpoz5z9yua8Buhy
   Y4TRuKmbhxULgVmvHwyu7NYlH7d4SSe+OVmE5MD8DYIaD/t2egmiCWFps
   FolLw0Re1LR7msOhJSUKXRDJGVR1wOk45u1qzBt0FBpt8ep9i9ENASOov
   GJsX6iYXNPqfFCBYS/1RVY9SQSaYjoJPChp/ogBRHMOnNAHoTn1i49jTA
   A==;
X-CSE-ConnectionGUID: pCwBlBHtSoi/YIYrKK+WoQ==
X-CSE-MsgGUID: Asqbz+vBR3WiV/4s5nwftQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32822707"
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="32822707"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 14:21:22 -0700
X-CSE-ConnectionGUID: MAEQjEyMRUq0RkDf2N1vdQ==
X-CSE-MsgGUID: V5hw5/drR/ae1quFDpk9cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,152,1719903600"; 
   d="scan'208";a="64617698"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 16 Aug 2024 14:21:16 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sf4Nl-0006w7-1e;
	Fri, 16 Aug 2024 21:21:13 +0000
Date: Sat, 17 Aug 2024 05:21:12 +0800
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
Subject: Re: [PATCH v11 07/14] cxl/memfeature: Add CXL memory device patrol
 scrub control feature
Message-ID: <202408170751.2MCUO5cJ-lkp@intel.com>
References: <20240816164238.1902-8-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816164238.1902-8-shiju.jose@huawei.com>

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
patch link:    https://lore.kernel.org/r/20240816164238.1902-8-shiju.jose%40huawei.com
patch subject: [PATCH v11 07/14] cxl/memfeature: Add CXL memory device patrol scrub control feature
reproduce: (https://download.01.org/0day-ci/archive/20240817/202408170751.2MCUO5cJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408170751.2MCUO5cJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: Documentation/devicetree/bindings/power/wakeup-source.txt references a file that doesn't exist: Documentation/devicetree/bindings/input/qcom,pm8xxx-keypad.txt
   Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml references a file that doesn't exist: Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
>> Warning: Documentation/edac/edac-scrub.rst references a file that doesn't exist: Documentation/ABI/testing/sysfs-edac-scrub-control
   Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/display/exynos/
   Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
   Using alabaster theme

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

