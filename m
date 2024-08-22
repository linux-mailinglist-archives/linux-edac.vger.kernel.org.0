Return-Path: <linux-edac+bounces-1722-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 919FC95ABC3
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 05:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115CC1F25728
	for <lists+linux-edac@lfdr.de>; Thu, 22 Aug 2024 03:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FF1B28A;
	Thu, 22 Aug 2024 03:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ik5pq85f"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61751B7FD;
	Thu, 22 Aug 2024 03:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724296462; cv=none; b=CVSHqOCSknyej9APwACreL9HipDT0Ei6DEyvs3upXvwage1yq78GcJzEOSmIqaU5/ji+tKFvQzX2T1Xcm4hE4QnC6jTqbzoQF6g8ZvMzWo3xKBgg2MvirpOLetiQJrBuKGEGystrWh8G4EL/cWLS2xShJVeMwKt8WSFcOuR1d3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724296462; c=relaxed/simple;
	bh=kX/eJEnUnP1fnuKVgl95jcVQXrBQNB/ruJcrqp1XQaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3giMB8otAKz4cCPt8gDj5GjMgGST+DbjLfeuDsMpdyXjQsE7Ka0Vd51WN3xntc0HCx0712nPwqdlCy44EdXAd8NxfRIkxA4iKQvv37qaiBbyaqlsmCyRpPkYYJbRCYKbXeVypyPvqXyRpSkg+wfwSEcxLt/f605W96meQkNomI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ik5pq85f; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724296461; x=1755832461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kX/eJEnUnP1fnuKVgl95jcVQXrBQNB/ruJcrqp1XQaE=;
  b=ik5pq85ffQ8M5AVtaoUQXnbgG2ZXy1iMZez6XMHE3Mr+dlBd5zrZRdo+
   +8IBzXRZ+5t5Mcia1U7lpA9RpjASyYjOmPpQ8QSrGAinoA0V+CpelPsAu
   fVDRMX2gxCJSEtqHRXEqRMwhW6ZS6OpgRXZOSu3vcUxr/kMtFEo+wvhPK
   sRYbTGISj/sDTSeYbXAL52He6SRBEelmIUJkgaQMybkNtpx65sc5nvWan
   neHXc1Dg0EC/eTw2lEbcwWlKW7C41Ix4WO1hOvGGTNYXA5TyvcSCA1WFB
   J+r03DuhgKkqhaFwjmYlQc0jWux4OsCpWjj7s/+JfCvIJOd0JHr3sQbnt
   w==;
X-CSE-ConnectionGUID: p7l+5v9CRPa4aQhr61TrlA==
X-CSE-MsgGUID: RNlgjxBmQLC1eshioy2l+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22839559"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22839559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 20:14:21 -0700
X-CSE-ConnectionGUID: b2O2YlYAQqiMBXbgghkKjg==
X-CSE-MsgGUID: 74af8rXIRTKQt0wXFjqxhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="98800083"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 21 Aug 2024 20:14:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgyH8-000CDc-0D;
	Thu, 22 Aug 2024 03:14:14 +0000
Date: Thu, 22 Aug 2024 11:14:13 +0800
From: kernel test robot <lkp@intel.com>
To: Zhao Qunqin <zhaoqunqin@loongson.cn>, chenhuacai@kernel.org,
	kernel@xen0n.name, bp@alien8.de, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: Paul Gazzillo <paul@pgazz.com>,
	Necip Fazil Yildiran <fazilyildiran@gmail.com>,
	oe-kbuild-all@lists.linux.dev, loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	devicetree@vger.kernel.org, zhaoqunqin <zhaoqunqin@loongson.cn>
Subject: Re: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory
 controller
Message-ID: <202408221024.FpH0yAEh-lkp@intel.com>
References: <20240821064728.8642-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821064728.8642-2-zhaoqunqin@loongson.cn>

Hi Zhao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ras/edac-for-next]
[also build test WARNING on robh/for-next linus/master v6.11-rc4 next-20240821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zhao-Qunqin/Loongarch-EDAC-driver-for-loongson-memory-controller/20240821-145127
base:   https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
patch link:    https://lore.kernel.org/r/20240821064728.8642-2-zhaoqunqin%40loongson.cn
patch subject: [PATCH v1 1/2] Loongarch: EDAC driver for loongson memory controller
config: loongarch-kismet-CONFIG_EDAC-CONFIG_LOONGARCH-0-0 (https://download.01.org/0day-ci/archive/20240822/202408221024.FpH0yAEh-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20240822/202408221024.FpH0yAEh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408221024.FpH0yAEh-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for EDAC when selected by LOONGARCH
   WARNING: unmet direct dependencies detected for EDAC
     Depends on [n]: HAS_IOMEM [=y] && EDAC_SUPPORT [=y] && RAS [=n]
     Selected by [y]:
     - LOONGARCH [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

