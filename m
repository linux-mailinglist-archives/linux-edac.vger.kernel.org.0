Return-Path: <linux-edac+bounces-3299-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEF4A55EC6
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 04:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D22A1898D46
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 03:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E35199E9A;
	Fri,  7 Mar 2025 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ww3fP9E9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776A918F2C3;
	Fri,  7 Mar 2025 03:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318825; cv=none; b=Gch0Cu97EfmD8NboQM16V15fVYsmhZKJhpgTiqlXRFcdcDlTo8Rss/y4j39MqEozMEZyMOSC02zGJgLsfqM/RVKtZaoOuIwQZ+ikU6nrbFLW3DCQylYjLY+uzYrzyoFHlHxT8URQWBUIo5UZbxAw08dwDThBZiN2dnMlxbVAB6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318825; c=relaxed/simple;
	bh=iyS2daxFBTxrqZIFfDH3tFbe9as5X14QyKFI7+aIKb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCKkYxjXJ5kdtrT46neCPSM2hb+vo3OeLHrD179wMIrVIEX5U4itHdvaVxSGAuXAtbTFqYtiDhaqWH/eTo89nHXF1HCG+VHhWnNXX3ekT9KCtaBfJbJ7HEhJ2WR8TVeYbpjnqqcsVXZjLYNgltISxjqDgK4QgUHeriSsZcL6XRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ww3fP9E9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741318823; x=1772854823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iyS2daxFBTxrqZIFfDH3tFbe9as5X14QyKFI7+aIKb0=;
  b=Ww3fP9E9mqizuzfjuIg1Wal5BSk2UL9imiVRiGatUA2St7jyPZcvI4yY
   UhLgoVqSDG9o/71TkN7EIw9pFIjqlH5hrTzS1q2AWHk0S9Fs2EyHYz4pG
   SSKrdoSvFK0IxVK60vdm7M9j2KteI2bdkNW86OvpIt3hfdZ+x6n4bY/3f
   ptuEvI9UQsTStCJdU/NRo8f9yrNejwLvDhBmlTV1/JIvZPiJq9hSsMoEz
   iZWFGEgpKRiU+fC4ZMqU1fTZMW5TNn4t0/JMm/ug2zMKlm7TP5xQGH08/
   SVtJlW0HtKb4pxAC32kLIW8nI0merVerOR2WsNEx7/BkHthXoTxqZCtXd
   w==;
X-CSE-ConnectionGUID: rmr9spKWRia11YqJQXpJlQ==
X-CSE-MsgGUID: yl4oYuURTb6iJt2YRQMVBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="53757026"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="53757026"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 19:40:22 -0800
X-CSE-ConnectionGUID: BtDtKb4QTOOuzJ7JXGGdUw==
X-CSE-MsgGUID: doplWBhgTcKiYh8pnoHrMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="124139557"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 06 Mar 2025 19:40:16 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqOZE-000OES-2Q;
	Fri, 07 Mar 2025 03:40:10 +0000
Date: Fri, 7 Mar 2025 11:39:03 +0800
From: kernel test robot <lkp@intel.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>, tony.luck@intel.com,
	bp@alien8.de, peterz@infradead.org, catalin.marinas@arm.com,
	yazen.ghannam@amd.com, akpm@linux-foundation.org,
	linmiaohe@huawei.com, nao.horiguchi@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	jpoimboe@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com
Subject: Re: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine
 copy-from-user context
Message-ID: <202503071115.uNkoVksh-lkp@intel.com>
References: <20250306021031.5538-2-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306021031.5538-2-xueshuai@linux.alibaba.com>

Hi Shuai,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Shuai-Xue/x86-mce-Use-is_copy_from_user-to-determine-copy-from-user-context/20250306-101505
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/20250306021031.5538-2-xueshuai%40linux.alibaba.com
patch subject: [PATCH v3 1/3] x86/mce: Use is_copy_from_user() to determine copy-from-user context
config: i386-buildonly-randconfig-005-20250307 (https://download.01.org/0day-ci/archive/20250307/202503071115.uNkoVksh-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250307/202503071115.uNkoVksh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503071115.uNkoVksh-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/kernel/cpu/mce/severity.c: In function 'error_context':
>> arch/x86/kernel/cpu/mce/severity.c:305:39: error: expected ';' before '}' token
     305 |                 return IN_KERNEL_RECOV
         |                                       ^
         |                                       ;
     306 |         }
         |         ~                              


vim +305 arch/x86/kernel/cpu/mce/severity.c

   274	
   275	/*
   276	 * If mcgstatus indicated that ip/cs on the stack were
   277	 * no good, then "m->cs" will be zero and we will have
   278	 * to assume the worst case (IN_KERNEL) as we actually
   279	 * have no idea what we were executing when the machine
   280	 * check hit.
   281	 * If we do have a good "m->cs" (or a faked one in the
   282	 * case we were executing in VM86 mode) we can use it to
   283	 * distinguish an exception taken in user from from one
   284	 * taken in the kernel.
   285	 */
   286	static noinstr int error_context(struct mce *m, struct pt_regs *regs)
   287	{
   288		int fixup_type;
   289		bool copy_user;
   290	
   291		if ((m->cs & 3) == 3)
   292			return IN_USER;
   293	
   294		if (!mc_recoverable(m->mcgstatus))
   295			return IN_KERNEL;
   296	
   297		/* Allow instrumentation around external facilities usage. */
   298		instrumentation_begin();
   299		fixup_type = ex_get_fixup_type(m->ip);
   300		copy_user  = is_copy_from_user(regs);
   301		instrumentation_end();
   302	
   303		if (copy_user) {
   304			m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_COPYIN;
 > 305			return IN_KERNEL_RECOV
   306		}
   307	
   308		switch (fixup_type) {
   309		case EX_TYPE_FAULT_MCE_SAFE:
   310		case EX_TYPE_DEFAULT_MCE_SAFE:
   311			m->kflags |= MCE_IN_KERNEL_RECOV;
   312			return IN_KERNEL_RECOV;
   313	
   314		default:
   315			return IN_KERNEL;
   316		}
   317	}
   318	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

