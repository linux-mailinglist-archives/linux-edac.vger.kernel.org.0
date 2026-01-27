Return-Path: <linux-edac+bounces-5681-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM0rFGIMeWnyugEAu9opvQ
	(envelope-from <linux-edac+bounces-5681-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 20:05:06 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF39099962
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 20:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57FB9303C89C
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jan 2026 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AEC32AADC;
	Tue, 27 Jan 2026 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PeneBB5K"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1E324B1E;
	Tue, 27 Jan 2026 18:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769540218; cv=none; b=ezhMpWPF0uSez+erYVDFF9kxYjQZuINwonaENOlVk7XmM+7BkiQM1+qmHPFMZsRjCiGh5OJzSFOTUjm+Hb5GFKgDWipdKUHBETboqmC9sT5Ksg6LtgKIE43ffyh0IWun6uP9hcOyYEndTL9EQxAMKvOUu5MreS0r0C+QPUdwoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769540218; c=relaxed/simple;
	bh=Ch0LIB4X3I+61DsXgHOBKVGaZxOxxpivi8bEXcVQRqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLhCz/sjxBHhq5uSAsF7ofShWk+slMq5Hkocvp02LCLYI7NI28GUvk8w8QTx7ImMBjBLQmuNTL78nC0jg0nVv9Pzxi5KbcH9rXqSc5ecM8C0zqmXbURGzxSfHXLoR8N4aeZ4CE4eO4u9u9chbTSX0AfwztOyzZHz7y0a2AoOgGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PeneBB5K; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769540217; x=1801076217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ch0LIB4X3I+61DsXgHOBKVGaZxOxxpivi8bEXcVQRqI=;
  b=PeneBB5K61qZ6UsrDgFrzFsILjKlQBhFVzefPAq0/HWBP5aqXn/PAfcW
   uLiLOqBx0KficCZkvJnMTol4m9hq1I1p91i8vtK+qXASHFvd2F3Qk/e94
   /BJ31y4c72md5KoMj/anFrYXGZ7vT8r0ibXp0PUZXLh6OJiRjitS+GMUs
   +2FrK+Q8jVem2oKtK+gEkwCGXPdIXF/djhPiCGTf4035uWXlvxc2UTw/h
   M4n0Z6zPaJGHLKOJV4phe8Tu1VeR1GSXkkcziF1MNzpKo58avXIBoT6r7
   EnTk4aZAIsAI+rfSyZVJxBLKKX+u9WM9EsfVnMCt85pGt1qKc+A+HJMrY
   Q==;
X-CSE-ConnectionGUID: 3f01NgDtRdCiCJYklNZ28A==
X-CSE-MsgGUID: J4vS+HKHS6u2dsJ0KUptcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="81377730"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="81377730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 10:56:56 -0800
X-CSE-ConnectionGUID: 943+XywOTBeCmu+rfv8XIg==
X-CSE-MsgGUID: 27YhhHwpQZ6G6ZLX+E50Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208409714"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 27 Jan 2026 10:56:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkoF6-00000000YrA-2dUf;
	Tue, 27 Jan 2026 18:56:48 +0000
Date: Wed, 28 Jan 2026 02:56:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ruidong Tian <tianruidong@linux.alibaba.com>, catalin.marinas@arm.com,
	will@kernel.org, lpieralisi@kernel.org, guohanjun@huawei.com,
	sudeep.holla@arm.com, rafael@kernel.org, robin.murphy@arm.com,
	mark.rutland@arm.com, tony.luck@intel.com, bp@alien8.de,
	tglx@linutronix.de
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, lenb@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org, mchehab@kernel.org,
	xueshuai@linux.alibaba.com, zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: Re: [PATCH v6 15/16] ras: AEST: support vendor node CMN700
Message-ID: <202601280228.CbJgYMRG-lkp@intel.com>
References: <20260122094656.73399-16-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122094656.73399-16-tianruidong@linux.alibaba.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5681-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,01.org:url]
X-Rspamd-Queue-Id: EF39099962
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
patch link:    https://lore.kernel.org/r/20260122094656.73399-16-tianruidong%40linux.alibaba.com
patch subject: [PATCH v6 15/16] ras: AEST: support vendor node CMN700
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20260128/202601280228.CbJgYMRG-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280228.CbJgYMRG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280228.CbJgYMRG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/ras/aest/aest-cmn.c:209:19: warning: variable 'hnd_base' set but not used [-Wunused-but-set-variable]
     209 |         u64 errgsr_addr, hnd_base;
         |                          ^
   1 warning generated.


vim +/hnd_base +209 drivers/ras/aest/aest-cmn.c

   203	
   204	static int aest_cmn_reorgnize_node(struct aest_device *adev,
   205					   struct acpi_aest_node *anode, u64 base)
   206	{
   207		struct aest_node *cmn_node;
   208		u64 hnd_offset, cmn_node_offset, reg, logic_id, type, node_id;
 > 209		u64 errgsr_addr, hnd_base;
   210		struct aest_record *record;
   211		int ret, node_index;
   212		struct cmn_vendor_data *vendor_data;
   213	
   214		if (anode->interface_hdr->type !=
   215		    ACPI_AEST_NODE_SINGLE_RECORD_MEMORY_MAPPED) {
   216			aest_dev_err(adev, "CMN just use single memory mapping\n");
   217			return -ENODEV;
   218		}
   219	
   220		hnd_offset = *((u64 *)anode->vendor->vendor_specific_data);
   221		cmn_node_offset = *((u64 *)&anode->vendor->vendor_specific_data[8]);
   222	
   223		reg = readq_relaxed((void *)base + cmn_node_offset + CMN_NODE_INFO);
   224	
   225		logic_id = FIELD_GET(CMN_NI_LOGICAL_ID, reg);
   226		type = FIELD_GET(CMN_NI_NODE_TYPE, reg);
   227		node_id = FIELD_GET(CMN_NI_NODE_ID, reg);
   228	
   229		hnd_base = base + hnd_offset;
   230		node_index = cmn_config->node_id_map[type];
   231		errgsr_addr = base + cmn_config->errgsr_offset(hnd_offset, node_index);
   232	
   233		// node not register, create it
   234		cmn_node = &adev->nodes[node_index];
   235		if (!cmn_node->errgsr) {
   236			ret = aest_cmn_init_node(adev, cmn_node, anode, type,
   237						 errgsr_addr);
   238			if (ret)
   239				return -ENOMEM;
   240		}
   241	
   242		aest_dev_dbg(adev, "node type %llx, id %llx, offset %llx\n", type,
   243			     logic_id, cmn_node_offset);
   244	
   245		if (!test_bit(0, anode->record_implemented))
   246			clear_bit(logic_id, cmn_node->record_implemented);
   247	
   248		if (!test_bit(0, anode->status_reporting))
   249			clear_bit(logic_id, cmn_node->status_reporting);
   250	
   251		record = &cmn_node->records[logic_id];
   252		record->name =
   253			devm_kasprintf(adev->dev, GFP_KERNEL, "record%lld", logic_id);
   254		if (!record->name)
   255			return -ENOMEM;
   256		record->regs_base = devm_ioremap(
   257			adev->dev, (resource_size_t)anode->interface_hdr->address,
   258			sizeof(struct ras_ext_regs));
   259		if (!record->regs_base)
   260			return -ENOMEM;
   261		record->addressing_mode = test_bit(0, anode->addressing_mode);
   262		record->node = cmn_node;
   263		record->index = logic_id;
   264		record->access = &aest_access[anode->interface_hdr->type];
   265	
   266		vendor_data = devm_kzalloc(adev->dev, sizeof(struct cmn_vendor_data),
   267					   GFP_KERNEL);
   268		vendor_data->node_type = type;
   269		vendor_data->node_id = node_id;
   270		vendor_data->logic_id = logic_id;
   271	
   272		record->vendor_data = vendor_data;
   273		record->vendor_data_size = sizeof(struct cmn_vendor_data);
   274	
   275		aest_record_dbg(record, "base %llx\n", anode->interface_hdr->address);
   276	
   277		return 0;
   278	}
   279	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

