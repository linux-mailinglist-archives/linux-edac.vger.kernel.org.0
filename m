Return-Path: <linux-edac+bounces-3310-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47122A57446
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9459F18964D8
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8FD1FFC44;
	Fri,  7 Mar 2025 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dT0Bm1Wy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B27E9;
	Fri,  7 Mar 2025 22:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384874; cv=none; b=kD6TdtJzgh9tAcFRvplR3frnV0z7CJwNh65vg31wcquBzYNpx5Tr8t29+MjRtGhOBvyUqo5aVyK66S7iaCpyCy3qwHlRNNJx09kB1wz/kY7WHs7tSbUQib+UjweLTwfW60J/j4B9gi21W6Bv03bi8o7Q/OVqJA9bd+2S0bFTx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384874; c=relaxed/simple;
	bh=8wclTX/Gee3E13d5b9MYB3LesJcY5QD7R9wGeN/+huQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs4S182z0j7g+CaiLLnBBeRiNYxH2V8TMtRxiM7nec6xIDV0i8YpqBKxiNwI0x2LZkoSiqtBUKPlIe7LhWzW05QJXeyGsL/Jx2WDMHXjoXu6CWhxl66ocF+SfxFmnxZRIhBOUJoce3uhonbRFasF8Y+RVZ08qKAIW1mfSgOpy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dT0Bm1Wy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741384874; x=1772920874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wclTX/Gee3E13d5b9MYB3LesJcY5QD7R9wGeN/+huQ=;
  b=dT0Bm1WyZ2m4/L3JieLtNtUIwCCq7arqV9UIAO5OPz3gbGGiqVeP/etl
   tgY9x8rcN9Da/C5b8b8DCmP/TRn0KTThAy8l091GNBedsltHvoXB2g61S
   VsebUh1Xvz6Y3D40L//5Gra+MWKkVH9mgyM7msP2op2cRaz64RywTokJL
   rr+MlSk8Nsqoc8pnbPJjNlICxFkLJd77IPaq5txHwQIxGsrJdFrTaEthD
   KKvuvK1DTYPQ3Pv7/FCJ9+cJ/YGIumtQChXF4QsqapZbiJ5rDj5o7hJV1
   U+G/yOHLQkImHiFzSxCJrpFNByWNnFV0cNuyVIs7fzuLkpgYxSiFtHkUs
   Q==;
X-CSE-ConnectionGUID: tbarm5DkTxOFQEm0tee1DA==
X-CSE-MsgGUID: dgZB1gZZQo2JG4wSKAbsig==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="52655623"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="52655623"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:01:13 -0800
X-CSE-ConnectionGUID: ZRS4FBdCTWWIJu+RcFO3fg==
X-CSE-MsgGUID: f8UFgJ7fQtqNmQicF/Hn2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119959202"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:01:10 -0800
Date: Fri, 7 Mar 2025 14:01:08 -0800
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
Subject: Re: [PATCH 5/8] cxl/region: Add helper function to determine memory
 is online
Message-ID: <Z8tspBrjZ7MoSVwh@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-6-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-6-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:12PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> Add helper function to determine a CXL memory is online.
> 
> Use case: certain memory operations are permitted when the memory
> is offline only, for eg. some memory repair operations.
> 

Hi Shiju,

This helper is basically wrapping the existing helper
cxl_num_decoders_committed(port) so that you can start from a cxlmd.
Other callers of cxl_num_decoders_committed() do similar work, ie 
find the port, confirm an endpoint, then call it. I don't think
it's done enough to warrant a helper for all callers. (but others
may disagree and ask for that)

This patchset does this work a few times, so a helper makes sense
here. The part I don't get is why it is placed in the region driver,
requiring it to be stubbed out when region driver is not present.

cxl_num_decoders_committed() is part of the cxl/core and is 
defined in port.c.

Long way of asking, would it work to just add a helper to 
core/memfeatures.c and use it within?

The name could use an update. cxl_are_decoders_committed(cxlmd) is
a stretch because a cxlmd does not have decoders. That naming made
sense for 'cxl_num_decoders_committed(port) because a port has
decoders, a memdev does not.

-- Alison


> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/core/core.h   |  9 +++++++++
>  drivers/cxl/core/region.c | 10 ++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 6c83f6f18122..386e36b18c19 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -32,8 +32,17 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port);
>  struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa);
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa);
> +bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd);
>  
>  #else
> +static inline bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd)
> +{
> +	/*
> +	 * If no driver, in absence of a way to check, assume decoders are committed.
> +	 */
> +	return true;
> +}
> +
>  static inline u64 cxl_dpa_to_hpa(struct cxl_region *cxlr,
>  				 const struct cxl_memdev *cxlmd, u64 dpa)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9e7b716296d7..3fd14cb0c470 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2864,6 +2864,16 @@ struct cxl_region *cxl_dpa_to_region(const struct cxl_memdev *cxlmd, u64 dpa)
>  	return ctx.cxlr;
>  }
>  
> +bool cxl_are_decoders_committed(const struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *port = cxlmd->endpoint;
> +
> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -- 
> 2.43.0
> 
> 

