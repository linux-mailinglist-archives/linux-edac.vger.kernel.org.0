Return-Path: <linux-edac+bounces-5680-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KvHORi2eGlzsQEAu9opvQ
	(envelope-from <linux-edac+bounces-5680-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 13:56:56 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557DA94912
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C837330479D7
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 12:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D223557F5;
	Tue, 27 Jan 2026 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SES5YQjN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BD53557F3;
	Tue, 27 Jan 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518354; cv=none; b=bDcliDO3TOwq0pol9RhO1jsoeBw0fvoqmpvsdmrsf8SwHEbKTGinlkIMAYiigDgLVfI2+Gz68RJ8Wxyl5wTdS246d/f2sGdpTlyh8j7AbCpmvraezFef/hpPvOYsqNgllc0uY9vuJ2se4IdzkWSOkzRh4RGo94t7VvgGB9nQkHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518354; c=relaxed/simple;
	bh=vgbQx0vDwWYjR3sK+ZddrCDH4qHiveEQokdGsfxcS2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4nJ/cYJK4gCNtOBysP8YsUT0n0ydOZVzwxKJTYUSHISB2DyvcXE/QJ2Tz8ij/0koEImIK5pDNH6CAu/MQ2fbnrMFhWz32GJR6pwjx9uo/QosAOPrPKLBOszs8PjauaAXkBAAZNnenorY6XlK//0w7iWF1glISbhgKdpeSMG8w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SES5YQjN; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769518352; x=1801054352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgbQx0vDwWYjR3sK+ZddrCDH4qHiveEQokdGsfxcS2g=;
  b=SES5YQjNcyUd8k/laP9GFC14cP68poR/dc6b6XTEnFsdEraYHJ23evy/
   6DO5aEgWGrfliAqgJxweNzstlIFiPUKtz21Cm14DlV3KdhIs+DNl1QjLY
   HUGPeWxwKVpLtmL28GGY3gIR2iqaLOUDMNCqrJiBWMnJpKAGTtmC+2XBA
   SvQLbu0CesrmolT3nfD7csmfJ5d7k+q+wYMYhYG9IdTHwzBz50/URyppV
   jVc3qzwgHzRF+U7t5ZSV4NU7dHaIO2eVBPrAMDJhz9zhnX0nFm92To6Jr
   yLvxRLpLwCLS3xqQu9RIWox4JvKwS+mH72tmLvQ4auIGeEfDy22eZB1eW
   Q==;
X-CSE-ConnectionGUID: VJ3/AMv7Q+WeToXBwSOX8g==
X-CSE-MsgGUID: tbfwidlfTBy/sAoaVEZY8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69911720"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69911720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 04:52:31 -0800
X-CSE-ConnectionGUID: wIcgciS6QfOH3oFLtMWbAA==
X-CSE-MsgGUID: Xwu+uTG+Su+JHQ8O8Uf/EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="230922383"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 27 Jan 2026 04:52:26 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkiYR-00000000YUG-3ffS;
	Tue, 27 Jan 2026 12:52:23 +0000
Date: Tue, 27 Jan 2026 20:52:04 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, rafael@kernel.org, robin.murphy@arm.com,
	mark.rutland@arm.com, tony.luck@intel.com, bp@alien8.de,
	tglx@linutronix.de, peterz@infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org, mchehab@kernel.org,
	xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v6 13/16] ras: AEST: Introduce AEST inject interface to
 test AEST driver
Message-ID: <202601272009.SKq0aXMN-lkp@intel.com>
References: <20260122094656.73399-14-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122094656.73399-14-tianruidong@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5680-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,intel.com:email,intel.com:dkim,intel.com:mid,git-scm.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 557DA94912
X-Rspamd-Action: no action

Hi Ruidong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v6.19-rc7 next-20260126]
[cannot apply to tip/smp/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ruidong-Tian/ACPI-AEST-Parse-the-AEST-table/20260122-180219
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20260122094656.73399-14-tianruidong%40linux.alibaba.com
patch subject: [PATCH v6 13/16] ras: AEST: Introduce AEST inject interface to test AEST driver
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260127/202601272009.SKq0aXMN-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260127/202601272009.SKq0aXMN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601272009.SKq0aXMN-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ras/aest/aest-sysfs.c:194:45: warning: more '%' conversions than data arguments [-Wformat-insufficient-args]
     194 |                 snprintf(name, sizeof(name), "processor%u%u", cpu);
         |                                                          ~^
   1 warning generated.


vim +194 drivers/ras/aest/aest-sysfs.c

   182	
   183	static void
   184	aest_oncore_dev_init_debugfs(struct aest_device *adev)
   185	{
   186		int cpu, i;
   187		struct aest_node *node;
   188		struct aest_device *percpu_dev;
   189		char name[16];
   190	
   191		for_each_possible_cpu(cpu) {
   192			percpu_dev = this_cpu_ptr(adev->adev_oncore);
   193	
 > 194			snprintf(name, sizeof(name), "processor%u%u", cpu);
   195			percpu_dev->debugfs = debugfs_create_dir(name, adev->debugfs);
   196	
   197			for (i = 0; i < adev->node_cnt; i++) {
   198				node = &adev->nodes[i];
   199	
   200				node->debugfs = debugfs_create_dir(node->name,
   201								percpu_dev->debugfs);
   202				aest_node_init_debugfs(node);
   203			}
   204		}
   205	}
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

