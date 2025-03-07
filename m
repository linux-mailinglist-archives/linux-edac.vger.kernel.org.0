Return-Path: <linux-edac+bounces-3307-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62137A5728B
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 20:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF511891116
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 19:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6842566EC;
	Fri,  7 Mar 2025 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+TaZrMh"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6461A4F3C;
	Fri,  7 Mar 2025 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741377204; cv=none; b=noU3pF+q6Ax2vnIqyf2dTJ6zOF9e/ozZTqCkROHx8Dgncx8YjAAs+wM6OWVqPN2cZw7S7/ZkgR4VNw3BjxQAUKdk31XIBYnkCzHamCOp75o1E+sjROeBtMDe3VzlTgHEAy8JD4cxa1Q7uzr9U33fc0L6ZD9s68qwAcL/gphezpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741377204; c=relaxed/simple;
	bh=jW13cb5LfXx1elX2HCWSeQ4XXS/LTqhw13X2BO7S/yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jnh0ecQrvKjheGtosCXZqKTrLNB8lZ8oC8wSk0SGwNw5MomIHK8uzhCvnHzjK0cMtgOetyHNF/hkY4xBcTFwiz9Ec75eBqpB4SPVnvg2u+2LyI80x0ca45TyWG473vZkwl4SupWtV5E7PGasbwg5UsQW8a9xaxIFzG7ESWEe184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+TaZrMh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741377203; x=1772913203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jW13cb5LfXx1elX2HCWSeQ4XXS/LTqhw13X2BO7S/yM=;
  b=N+TaZrMhFn/uJ51M/UAPMDzC/Zul7pAp7yBy1ikQcJUkycQeIjPEfUWd
   8K0YtDzdxo4ESXLlfasyLS687EGLQewSmGRiHjt98lXNPYTKRc0h8oK98
   lnC34WYQeiiv9rtN/KtqIx5o369J7l4ODvKl+kPTO+z1oRVy9JFplgNN0
   zSndKBwuWIeGRmJ8q1Gh9lUIrqtW07rJlGPxn58QuSCoL+CbuKtowRiok
   3VVYYR26l38aHXXK2/LaS1JIWwhpVUmmv5xjWTrSm58Jkvz77oLawMDNC
   8RfdtlsyXvMJCn3yUXI956RVCR81Ojs4U6r/jSUYjC0Vnpg6W6swopcwD
   Q==;
X-CSE-ConnectionGUID: hRdI6WlESoWa7MnNxKOgFg==
X-CSE-MsgGUID: 5hwMx20RRcCkfKtreUVApQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="46362199"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="46362199"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:53:22 -0800
X-CSE-ConnectionGUID: 2GvcInyMSbeO20ibsiAMuA==
X-CSE-MsgGUID: fLxSYKcnScOnnm+4wTrZrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="124430688"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 11:53:21 -0800
Date: Fri, 7 Mar 2025 11:53:18 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, david@redhat.com,
	Vilas.Sridharan@amd.com, linux-edac@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, bp@alien8.de, tony.luck@intel.com,
	rafael@kernel.org, lenb@kernel.org, mchehab@kernel.org,
	leo.duran@amd.com, Yazen.Ghannam@amd.com, rientjes@google.com,
	jiaqiyan@google.com, Jon.Grimm@amd.com, dave.hansen@linux.intel.com,
	naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com,
	somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com,
	duenwen@google.com, gthelen@google.com,
	wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
	wbs@os.amperecomputing.com, nifan.cxl@gmail.com,
	tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
	roberto.sassu@huawei.com, kangkang.shen@futurewei.com,
	wanghuiqiang@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH 2/8] cxl/memfeature: Add CXL memory device patrol scrub
 control feature
Message-ID: <Z8tOrqOnkv-ZUsEy@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-3-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-3-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:09PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>

snip

> 
> +static int cxl_ps_get_attrs(struct cxl_patrol_scrub_context *cxl_ps_ctx,
> +			    struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_mailbox *cxl_mbox;
> +	struct cxl_memdev *cxlmd;
> +	u16 min_scrub_cycle = 0;
> +	int i, ret;
> +
> +	if (cxl_ps_ctx->cxlr) {
> +		struct cxl_region *cxlr = cxl_ps_ctx->cxlr;
> +		struct cxl_region_params *p = &cxlr->params;
> +
> +		ret = cxl_hold_region_and_dpa();
> +		if (ret)
> +			return ret;
> +		for (i = p->interleave_ways - 1; i >= 0; i--) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +

Hi Shiju,

Although not functionally wrong, the above for loop caught my eye.

p->nr_targets is a better loop initializer when walking p->targets[]
(at this point nr_targets better equal interleave ways but lets use
the count intended for the array being walked)

Is there a reason to walk in reverse? This seems clearer:
for (i = 0; i < p->nr_targets; i++)

The same for loop header repeats below in:
cxl_ps_set_attrs()
cxl_region_scrub_init()
If you change for one, change for all.

snip

> +static int cxl_memdev_scrub_init(struct cxl_memdev *cxlmd,
> +				 struct edac_dev_feature *ras_feature, u8 scrub_inst)
> +{
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +	struct cxl_feat_entry *feat_entry;
> +
> +	feat_entry = cxl_get_feature_entry(cxlmd->cxlds, &CXL_FEAT_PATROL_SCRUB_UUID);
> +	if (IS_ERR(feat_entry))
> +		return -EOPNOTSUPP;
> +

Along w patch 1 comment, perhaps just check for (!feat_entry) here 
and in a couple of other places below.

snip

> 

