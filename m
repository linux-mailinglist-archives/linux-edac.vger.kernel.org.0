Return-Path: <linux-edac+bounces-1678-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41CE955EB2
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 21:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AC91C20C5D
	for <lists+linux-edac@lfdr.de>; Sun, 18 Aug 2024 19:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6714D6EB;
	Sun, 18 Aug 2024 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GZDiQ2Rj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234EC8FF;
	Sun, 18 Aug 2024 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724009066; cv=none; b=DHe2MuXgBjdI4Fy58gCAmIrElO5TgD2nIhkrYGH7dD+j6xgPOcql/4LuPCvYiV/1uD09wLchH/J7nPj7GdHxDG0OOPUo1XbEN3QVQytozO3oas59GngS1uphUX6+EJOFj+Hxa5DrzBCueJnO6O5gKwJarGiBnNb2ywUY2D33BVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724009066; c=relaxed/simple;
	bh=uDIlPlP6pOZko2F3eOUc/KS8ctBQF6b3E/mzu/L+Jfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwaf+mM0G/lB0Q1xFln9fNNBexIBRe7x95ZmvOGjq8P8c+cs9PixLMxC9GtTu7hIEsXoOGTWDoPyRC3sXV37N8ha575CvKx/x0Q4bWjXVZbBDD+GTOhC18tvaf/zDgZRQy1IiqYQPmHxllZkOOSB3RMCOxZ+9Xr82kER1rVmLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GZDiQ2Rj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724009064; x=1755545064;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDIlPlP6pOZko2F3eOUc/KS8ctBQF6b3E/mzu/L+Jfs=;
  b=GZDiQ2RjTaAKpSRyoXi0lJkE2joUqfkR0k8q2/WLMHLW+tPPAitUWcmG
   DzVhFc9Nk+V8g9fJyEnNAzkhYUKdIyRWP0Gvpgx4Ds4EzIh7aqdkV1FKE
   sq0BoHJUQq5slGD1kxbyBB40GJTHX+RKfNUOLpuLgUdrRI4dfIxTZhJTY
   oW+8yF82ogMtaUy0lCGIxPBF3NuaCNQLPV0w/utcHc7Gs6VP2T/xDJGNa
   GaOVjHjRPZM/HgQxq/q9wn6qw81Kdpjsbk+Qo0BKEpBgdhzHNp1id5mYM
   wiVES2c5cv6mwB+Or0O1v1dGpylDfLk921juLLq4Er2s1WDqDLZ2mL72+
   A==;
X-CSE-ConnectionGUID: 9NOQGG/bRkia3a9Nfq/Deg==
X-CSE-MsgGUID: ah2jg7aJSm+sZ0iXhg7tTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11168"; a="33393262"
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="33393262"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2024 12:24:24 -0700
X-CSE-ConnectionGUID: 0mSq64FMRWi+hrc1jcc9yg==
X-CSE-MsgGUID: VmyUEt/ATrSZkRad8kq8xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,157,1719903600"; 
   d="scan'208";a="64561022"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Aug 2024 12:24:17 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sflVf-0008QE-0A;
	Sun, 18 Aug 2024 19:24:15 +0000
Date: Mon, 19 Aug 2024 03:23:40 +0800
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
Subject: Re: [PATCH v11 04/14] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Message-ID: <202408190510.dFXq1LrX-lkp@intel.com>
References: <20240816164238.1902-5-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816164238.1902-5-shiju.jose@huawei.com>

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
patch link:    https://lore.kernel.org/r/20240816164238.1902-5-shiju.jose%40huawei.com
patch subject: [PATCH v11 04/14] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
config: alpha-randconfig-r131-20240818 (https://download.01.org/0day-ci/archive/20240819/202408190510.dFXq1LrX-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.3.0
reproduce: (https://download.01.org/0day-ci/archive/20240819/202408190510.dFXq1LrX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408190510.dFXq1LrX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1377:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected int nentries @@     got restricted __le16 [usertype] nr_entries @@
   drivers/cxl/core/mbox.c:1377:26: sparse:     expected int nentries
   drivers/cxl/core/mbox.c:1377:26: sparse:     got restricted __le16 [usertype] nr_entries

vim +1377 drivers/cxl/core/mbox.c

  1353	
  1354	int cxl_get_supported_feature_entry(struct cxl_memdev_state *mds, const uuid_t *feat_uuid,
  1355					    struct cxl_mbox_supp_feat_entry *feat_entry_out)
  1356	{
  1357		struct cxl_mbox_supp_feat_entry *feat_entry;
  1358		int feat_index, feats_out_size;
  1359		int nentries, count;
  1360		int ret;
  1361	
  1362		feat_index = 0;
  1363		feats_out_size = sizeof(struct cxl_mbox_get_supp_feats_out) +
  1364					sizeof(struct cxl_mbox_supp_feat_entry);
  1365		struct cxl_mbox_get_supp_feats_out *feats_out __free(kfree) =
  1366						kmalloc(feats_out_size, GFP_KERNEL);
  1367		if (!feats_out)
  1368			return -ENOMEM;
  1369	
  1370		while (true) {
  1371			memset(feats_out, 0, feats_out_size);
  1372			ret = cxl_get_supported_features(mds, feats_out_size,
  1373							 feat_index, feats_out);
  1374			if (ret)
  1375				return ret;
  1376	
> 1377			nentries = feats_out->nr_entries;
  1378			if (!nentries)
  1379				return -EOPNOTSUPP;
  1380	
  1381			/* Check CXL memdev supports the feature */
  1382			feat_entry = feats_out->feat_entries;
  1383			for (count = 0; count < nentries; count++, feat_entry++) {
  1384				if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
  1385					memcpy(feat_entry_out, feat_entry,
  1386					       sizeof(*feat_entry_out));
  1387					return 0;
  1388				}
  1389			}
  1390			feat_index += nentries;
  1391		}
  1392	}
  1393	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
  1394	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

