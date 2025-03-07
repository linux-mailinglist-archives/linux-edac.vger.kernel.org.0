Return-Path: <linux-edac+bounces-3315-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D7DA5761E
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 00:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DA663B3F05
	for <lists+linux-edac@lfdr.de>; Fri,  7 Mar 2025 23:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467F212D8D;
	Fri,  7 Mar 2025 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNgPkdAn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9381FECB6;
	Fri,  7 Mar 2025 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390348; cv=none; b=r6lyoXAybHjsDhE3BjAxAddIUFYZZphGkty7BJDbAe+Qlp2TX5P7TZWjN6ux+3MY2i+kZ/Rce4EpOP6jDeM3mYrxhcOXHPKpxN5rO0ktcLfXbHaTTyqNKg8+g/WzAtMw5FwE00ez+0zQ8UIxYOQBvIe9z/dHgJm01MDAiBeDcnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390348; c=relaxed/simple;
	bh=9uegT5rClggSiNvb9L16+SIxJzylbDheZMGszd0JPAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuV6wQtBeAnR4Q27+y8Pr9rypqfLEAvrb/s8FjoqkYbmiRNLOMhQ4EIJRz3ji+G4a7EQ645CO2mv8nR/EDGSyttB6MDsNCPX4k2d7lw0+PNTsv6il0GgiIo09L0Wv2FFVR+X0/ZkpEXIoJ3J4Wovygyor/7LTGOOapmELIJeeY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hNgPkdAn; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741390346; x=1772926346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9uegT5rClggSiNvb9L16+SIxJzylbDheZMGszd0JPAg=;
  b=hNgPkdAnJl6+5TDduUoxhU6p2iAHuAuQ6zJe6zSxfvxfNfb2DIG7BZCu
   iWhquRTG1EZG2Bh1jn73xhd6waPbIEx12OFZ3/JWdQiiL24DspNSIfAF4
   +YJQaAGk46A4P9HxZf9mgLspbJoi3KWfDr2LLbEaP1mitnjfKzruF6/Es
   YT2zGMUKfY1LQ13XThCRwebzcJcRSD6mc8MNkm3N3YerrmxsUor76EGm+
   DRbq4TOtnSN0nek1nrpD17YRqquB0Z9TwLY6URho1nDe15fGJxLHqAr6B
   iMCTIlYd35SivIEDI/kOkDn9biGtJsfu0VnUlHkGNUOzyoIrBW8CoDT7D
   A==;
X-CSE-ConnectionGUID: s11NYce6SuOmJ7NEABg1QQ==
X-CSE-MsgGUID: evXaAPTuQQWBPggDVeFmPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42678649"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42678649"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:32:25 -0800
X-CSE-ConnectionGUID: JIGCjZvrQSanygRLNBfyHg==
X-CSE-MsgGUID: gIjzKmhgTLK+QXB0T03IxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119278955"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 15:32:22 -0800
Date: Fri, 7 Mar 2025 15:32:20 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, dave@stgolabs.net, dave.jiang@intel.com,
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
Subject: Re: [PATCH 8/8] cxl/memfeature: Add CXL memory device memory sparing
 control feature
Message-ID: <Z8uCBJDbAHI_u3LC@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-9-shiju.jose@huawei.com>
 <20250307091137.00006a0a@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307091137.00006a0a@huawei.com>

On Fri, Mar 07, 2025 at 09:11:37AM +0800, Jonathan Cameron wrote:
> On Thu, 27 Feb 2025 22:38:15 +0000
> <shiju.jose@huawei.com> wrote:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> > 
snip

> Similar comment to earlier on maybe using single line comments
> in more places rather than multiline.  Perhaps worth doing
> that if you are respinning for other reasons.

Following on Jonathan's feedback, a couple of things-

- Within the CXL subsystem (maybe it's kernel wide) there is a
style or custom, that comments that only need to occupy a single
line only use a single line. This set should follow that. When code
is styled uniformally it is easier to read.

- This next thing I recognize because I have a bad habit of doing
it myself. Narrating! Some of these (should be single line) comments
are needlessly narrating the code. A comment is useful if it explains
something not obvious, but when we have descriptive function names and
variables, less commentary is needed.

see below...

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > +static int cxl_mem_do_sparing_op(struct device *dev,
> > +				 struct cxl_mem_sparing_context *cxl_sparing_ctx,
> > +				 struct cxl_memdev_sparing_params *rd_params)
> > +{
> > +	struct cxl_memdev *cxlmd = cxl_sparing_ctx->cxlmd;
> > +	struct cxl_memdev_sparing_in_payload sparing_pi;
> > +	struct cxl_event_dram *rec = NULL;
> > +	u16 validity_flags = 0;
> > +
> > +	if (!rd_params->cap_safe_when_in_use) {
> > +		/*
> > +		 * Memory to repair must be offline
> > +		 */
> > +		if (cxl_are_decoders_committed(cxlmd))
> > +			return -EBUSY;
> > +		/*
> > +		 * offline, so good for repair
> > +		 */
> More places as below where a single line comment would be fine
> and make a reader scroll a bit less.

This got cut off, but I think the code can tell the story without
narration. (per my other patch feedback maybe you will rename this
something like is_memdev_memory_offline())?

snip

> > +	/*
> > +	 * Read CXL device's sparing capabilities.
> a below.
> > +	 */
> > +	ret = cxl_mem_sparing_get_attrs(cxl_sparing_ctx, &rd_params);

Great name, no clarifying comment needed.

I'm not looking through them all. I'll leave that to you. But I
appreciate you looking and updating to single line and removing
the comment entirely where needless. It helps keep the code base
uniform in style which makes reading it easier.

Thanks Shiju :)


> > +	if (ret)
> > +		return ret;
> > +
> > +	/*
> > +	 * Set default value for persist_mode.
> > +	 */
> 
> If respining some of these comments don't need to be multiline.
> 
> 

