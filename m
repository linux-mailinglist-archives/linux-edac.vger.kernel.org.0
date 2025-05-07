Return-Path: <linux-edac+bounces-3851-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E90EAADC12
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 12:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1F71C2098A
	for <lists+linux-edac@lfdr.de>; Wed,  7 May 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4120CCDB;
	Wed,  7 May 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwcLj89V"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4438F9C;
	Wed,  7 May 2025 10:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612072; cv=none; b=aRh7COTRdPp4hVJwv/gaa6jAFSmGWAZyH/4WMx0hxsFwFVoeczmoc0ZkAV4+vUBjfTbqkG/6lvxbnVmXUwWq/lm0exyTNC/TZ+u1Dn4sKoKQ/9WpKZTDxAzhi+Y8YAPbtX8b55EbNdMhJqqASsOq/M7GG4SM2A4dLRbokd7RXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612072; c=relaxed/simple;
	bh=GMl2/nllLTvuFU2hTjd7xVW+BOWo5nIf+NLQjpJAYv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OF/TUvACTPGSRgJmuuMvGmVjPYQR6FLYdHFg5oqfvhOlWp+C+6QBGmuZ2ShaeGTHb3xonhRTbJCG75o9x4aAqQcD4WGymz2PXvLK6AbDYpdQH0kYhpKE+gpaX7zMwDbC/U5C3J0Lri0kxpCuOsIZ57soC0XczM+iMOi34Uzb1SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwcLj89V; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746612071; x=1778148071;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GMl2/nllLTvuFU2hTjd7xVW+BOWo5nIf+NLQjpJAYv0=;
  b=cwcLj89VGaMTlT3mplvxMj0XbRrt8F03UaOPNv46VrUYRBzgdyftRMM2
   ps+Tu3buFypokf/ylvqssXKnOol+fjRD3sOQfxJKXyHzJoFr2UH8SpxMX
   dC1COFcEtOSSmynfP5BmhKxTbz6+t+Xk03nWWpIn6PPgWNYP6tLL4G9LP
   ouh70/nOf7zbBomy3Xq2SUq6k63mTwfgO+03gtH+R9GlKDJd5/ISAdv0O
   vrgohrmOD39r43+XpINM7WMMLLqJaVzf0wQxqgq7b4kSyOXrsSN2wcZDJ
   GqqhS7jx/05jBKqmxi4lGo8kHXIV45Zs1j3ykh7KII9mTWHPvwlF21GI1
   w==;
X-CSE-ConnectionGUID: oUsehqm6T/6SURxkI+TwaQ==
X-CSE-MsgGUID: If8hppK9SoGIPftqzSt8xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="58527561"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="58527561"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 03:01:10 -0700
X-CSE-ConnectionGUID: QXf8ZYXiSlSxK6s2i3mBtw==
X-CSE-MsgGUID: vUnijq95T02E8uoSlp/6Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="159199367"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 May 2025 03:01:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uCbaH-0007YN-37;
	Wed, 07 May 2025 10:01:01 +0000
Date: Wed, 7 May 2025 18:00:14 +0800
From: kernel test robot <lkp@intel.com>
To: shiju.jose@huawei.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bp@alien8.de, rafael@kernel.org,
	tony.luck@intel.com, lenb@kernel.org, leo.duran@amd.com,
	Yazen.Ghannam@amd.com, mchehab@kernel.org,
	jonathan.cameron@huawei.com, linux-mm@kvack.org,
	linuxarm@huawei.com, rientjes@google.com, jiaqiyan@google.com,
	Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com
Subject: Re: [PATCH v4 2/3] ACPI:RAS2: Add ACPI RAS2 driver
Message-ID: <202505071717.QhRmXFUq-lkp@intel.com>
References: <20250423163511.1412-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423163511.1412-3-shiju.jose@huawei.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on linus/master v6.15-rc5]
[cannot apply to rafael-pm/bleeding-edge next-20250506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/ACPI-ACPI-6-5-RAS2-Rename-RAS2-table-structure-and-field-names/20250424-003740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20250423163511.1412-3-shiju.jose%40huawei.com
patch subject: [PATCH v4 2/3] ACPI:RAS2: Add ACPI RAS2 driver
config: riscv-randconfig-r112-20250426 (https://download.01.org/0day-ci/archive/20250507/202505071717.QhRmXFUq-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 8.5.0
reproduce: (https://download.01.org/0day-ci/archive/20250507/202505071717.QhRmXFUq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505071717.QhRmXFUq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/ras2.c:143:61: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct acpi_ras2_shmem *gen_comm_base @@     got struct acpi_ras2_shmem [noderef] __iomem *comm_addr @@
   drivers/acpi/ras2.c:143:61: sparse:     expected struct acpi_ras2_shmem *gen_comm_base
   drivers/acpi/ras2.c:143:61: sparse:     got struct acpi_ras2_shmem [noderef] __iomem *comm_addr
>> drivers/acpi/ras2.c:193:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/acpi/ras2.c:193:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/ras2.c:193:9: sparse:     got unsigned short *
   drivers/acpi/ras2.c:196:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned short * @@
   drivers/acpi/ras2.c:196:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/acpi/ras2.c:196:9: sparse:     got unsigned short *

vim +143 drivers/acpi/ras2.c

   132	
   133	/**
   134	 * ras2_send_pcc_cmd() - Send RAS2 command via PCC channel
   135	 * @ras2_ctx:	pointer to the RAS2 context structure
   136	 * @cmd:	command to send
   137	 *
   138	 * Returns: 0 on success, an error otherwise
   139	 */
   140	int ras2_send_pcc_cmd(struct ras2_mem_ctx *ras2_ctx, u16 cmd)
   141	{
   142		struct ras2_pcc_subspace *pcc_subspace = ras2_ctx->pcc_subspace;
 > 143		struct acpi_ras2_shmem *gen_comm_base = pcc_subspace->comm_addr;
   144		struct mbox_chan *pcc_channel;
   145		unsigned int time_delta;
   146		int rc;
   147	
   148		rc = ras2_check_pcc_chan(pcc_subspace);
   149		if (rc < 0)
   150			return rc;
   151	
   152		pcc_channel = pcc_subspace->pcc_chan->mchan;
   153	
   154		/*
   155		 * Handle the Minimum Request Turnaround Time(MRTT).
   156		 * "The minimum amount of time that OSPM must wait after the completion
   157		 * of a command before issuing the next command, in microseconds."
   158		 */
   159		if (pcc_subspace->pcc_mrtt) {
   160			time_delta = ktime_us_delta(ktime_get(),
   161						    pcc_subspace->last_cmd_cmpl_time);
   162			if (pcc_subspace->pcc_mrtt > time_delta)
   163				udelay(pcc_subspace->pcc_mrtt - time_delta);
   164		}
   165	
   166		/*
   167		 * Handle the non-zero Maximum Periodic Access Rate(MPAR).
   168		 * "The maximum number of periodic requests that the subspace channel can
   169		 * support, reported in commands per minute. 0 indicates no limitation."
   170		 *
   171		 * This parameter should be ideally zero or large enough so that it can
   172		 * handle maximum number of requests that all the cores in the system can
   173		 * collectively generate. If it is not, we will follow the spec and just
   174		 * not send the request to the platform after hitting the MPAR limit in
   175		 * any 60s window.
   176		 */
   177		if (pcc_subspace->pcc_mpar) {
   178			if (pcc_subspace->mpar_count == 0) {
   179				time_delta = ktime_ms_delta(ktime_get(),
   180							    pcc_subspace->last_mpar_reset);
   181				if (time_delta < 60 * MSEC_PER_SEC) {
   182					dev_dbg(ras2_ctx->dev,
   183						"PCC cmd not sent due to MPAR limit");
   184					return -EIO;
   185				}
   186				pcc_subspace->last_mpar_reset = ktime_get();
   187				pcc_subspace->mpar_count = pcc_subspace->pcc_mpar;
   188			}
   189			pcc_subspace->mpar_count--;
   190		}
   191	
   192		/* Write to the shared comm region */
 > 193		writew_relaxed(cmd, &gen_comm_base->command);
   194	
   195		/* Flip CMD COMPLETE bit */
   196		writew_relaxed(0, &gen_comm_base->status);
   197	
   198		/* Ring doorbell */
   199		rc = mbox_send_message(pcc_channel, &cmd);
   200		if (rc < 0) {
   201			dev_warn(ras2_ctx->dev,
   202				 "Err sending PCC mbox message. cmd:%d, rc:%d\n", cmd, rc);
   203			return rc;
   204		}
   205	
   206		/*
   207		 * If Minimum Request Turnaround Time is non-zero, we need
   208		 * to record the completion time of both READ and WRITE
   209		 * command for proper handling of MRTT, so we need to check
   210		 * for pcc_mrtt in addition to CMD_READ.
   211		 */
   212		if (cmd == PCC_CMD_EXEC_RAS2 || pcc_subspace->pcc_mrtt) {
   213			rc = ras2_check_pcc_chan(pcc_subspace);
   214			if (pcc_subspace->pcc_mrtt)
   215				pcc_subspace->last_cmd_cmpl_time = ktime_get();
   216		}
   217	
   218		if (pcc_channel->mbox->txdone_irq)
   219			mbox_chan_txdone(pcc_channel, rc);
   220		else
   221			mbox_client_txdone(pcc_channel, rc);
   222	
   223		return rc >= 0 ? 0 : rc;
   224	}
   225	EXPORT_SYMBOL_GPL(ras2_send_pcc_cmd);
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

