Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC049AAD8
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jan 2022 05:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3415829AbiAYDqe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 22:46:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:15988 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1314190AbiAYCu1 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Jan 2022 21:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643079027; x=1674615027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQEKrxu8mZSdmInIO8R3Ao2+sKCwBgclP+u7CtUFXMo=;
  b=Xt2C9bNQTChDT8rcGD+DV3ZrK4czsyAkvAaXCDFKCckAU3KI6e5t2hxn
   poqluX25dA2+/+dwbGXCOHizctXXd94RF3YWcPrXz5l2ibbDT1gfVmuBy
   gNLL1M8A/nCbnTgCrYHoXZ+t2gddo95beIEYJFR7vxwILmojys31bCkcc
   gYLsZABVq+xBLZgjkUc5MY4VVxr4RUM8X9uuzWa6C7aOb8O2PGSfhsUdT
   jo9Vha9UzHbrwO9VRVTlyyVICBH3nycIjhYB6oZY5ceYfMw7ECWWxBi0w
   +BSnkDpQcjg+d/97MWLBUx9MPUWWLtJHqI7oJbkFcdhi9+jQG4gbz6mAQ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332556566"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="332556566"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 18:36:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="476945379"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2022 18:36:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCBgx-000JEd-4r; Tue, 25 Jan 2022 02:36:19 +0000
Date:   Tue, 25 Jan 2022 10:35:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     lostway@zju.edu.cn, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, bp@alien8.de, tony.luck@intel.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] RAS: Report ARM processor information to userspace
Message-ID: <202201250944.dyy7niOd-lkp@intel.com>
References: <20220124093034.33095-1-lostway@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124093034.33095-1-lostway@zju.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on rafael-pm/linux-next linus/master v5.17-rc1 next-20220124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/lostway-zju-edu-cn/RAS-Report-ARM-processor-information-to-userspace/20220124-174203
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
config: x86_64-randconfig-m001-20220124 (https://download.01.org/0day-ci/archive/20220125/202201250944.dyy7niOd-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/ras/ras.c:51 log_arm_hw_error() warn: unsigned 'vsei_len' is never less than zero.

vim +/vsei_len +51 drivers/ras/ras.c

    23	
    24	void log_arm_hw_error(struct cper_sec_proc_arm *err, const u8 sev)
    25	{
    26		u32 pei_len;
    27		u32 ctx_len = 0;
    28		u32 vsei_len;
    29		u8 *pei_err;
    30		u8 *ctx_err;
    31		u8 *ven_err_data;
    32		struct cper_arm_err_info *err_info;
    33		struct cper_arm_ctx_info *ctx_info;
    34		int n, sz;
    35		int cpu;
    36	
    37		pei_len = sizeof(struct cper_arm_err_info) * err->err_info_num;
    38		pei_err = (u8 *)err + sizeof(struct cper_sec_proc_arm);
    39	
    40		err_info = (struct cper_arm_err_info *)(err + 1);
    41		ctx_info = (struct cper_arm_ctx_info *)(err_info + err->err_info_num);
    42		ctx_err = (u8 *)ctx_info;
    43		for (n = 0; n < err->context_info_num; n++) {
    44			sz = sizeof(struct cper_arm_ctx_info) + ctx_info->size;
    45			ctx_info = (struct cper_arm_ctx_info *)((long)ctx_info + sz);
    46			ctx_len += sz;
    47		}
    48	
    49		vsei_len = err->section_length - (sizeof(struct cper_sec_proc_arm) +
    50							pei_len + ctx_len);
  > 51		if (vsei_len < 0) {
    52			pr_warn(FW_BUG
    53				"section length: %d\n", err->section_length);
    54			pr_warn(FW_BUG
    55				"section length is too small\n");
    56			pr_warn(FW_BUG
    57				"firmware-generated error record is incorrect\n");
    58			vsei_len = 0;
    59		}
    60		ven_err_data = (u8 *)ctx_info;
    61	
    62		cpu = GET_LOGICAL_INDEX(err->mpidr);
    63		/* when return value is invalid, set cpu index to -1 */
    64		if (cpu < 0)
    65			cpu = -1;
    66	
    67		trace_arm_event(err, pei_err, pei_len, ctx_err, ctx_len,
    68				ven_err_data, vsei_len, sev, cpu);
    69	}
    70	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
