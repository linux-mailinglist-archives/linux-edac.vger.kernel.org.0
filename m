Return-Path: <linux-edac+bounces-3318-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49CA577AC
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF823AE29D
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 02:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A3B46426;
	Sat,  8 Mar 2025 02:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bsjybrFN"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133DAD4B;
	Sat,  8 Mar 2025 02:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741401351; cv=none; b=OHr77vsFbxXLfuwUOUMCfVMCocTR6/rhXtSQwTi/vY2ZOWpSxy5RKgzM2emHWajvDthIyOQElKsjwdbeJoLT9ktGfvambWw2ePlA4/7PFpRpDDZ1rlLBeVbmUNBpc3Xi4iW8le/D30u13bkbP8OUYNrNDDydmracqFCf03S7niY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741401351; c=relaxed/simple;
	bh=MhauIabnB7If6c1T4+kj4R3KybC9TZDd7Mdqu6pz4jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzF8gpB4zlwZwBUlBVEtLoVD6CGjj1B5h/cO/Ll4cIyQoxYJs9gjiB6iktFDtqD+whpTsoiqv2Z7YDjWn/6RkLeXBW9iL5bomd/tIC6DZDAGnvY15LYf2J4q2bF7lR1ALEtfhoQJR0eK3ssDR/oGKsTUE4+Au3r8r039TlrMyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bsjybrFN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741401348; x=1772937348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MhauIabnB7If6c1T4+kj4R3KybC9TZDd7Mdqu6pz4jE=;
  b=bsjybrFNvyTvF+iNphYa0pzO/0t73hT6iL1spZRX9lQHub8vQm0J6Ter
   Zdd4qXz6s5eeo3GGbFIZFQAJvDt608GnpQx7delAg/VAame9MYQ0iFDC0
   IHLICdjWyeZIlFN7k3Nv8SkPfSgxqQMYGFQlxZcLsWTKKBOz90+NZjm3Z
   N6RzFMdbfawloV9Je3nOcCCyzKwXVI3rpe98//Ugb/an+cfmv3nNzQDpW
   fG9CQIEx/3opue6/s+lx3Sc2RvrVYfH19Dxh4v6nI79easbnuqAXpsgO4
   5Swi/762SGCJNg3iCTP+dxS/Aazl6obd2fwcI421Dwux3TPzgpC2lN8ca
   w==;
X-CSE-ConnectionGUID: iGo4hDNEQtSBjkzgdSGyeg==
X-CSE-MsgGUID: fMtDLd69RM+HL9vXSTcHcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42377810"
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="42377810"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 18:35:47 -0800
X-CSE-ConnectionGUID: mUfabHK+Ti+imaNYgWhdlA==
X-CSE-MsgGUID: W3A3JNBlRQOWWIHN5QUNzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,231,1736841600"; 
   d="scan'208";a="119475451"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 18:35:45 -0800
Date: Fri, 7 Mar 2025 18:35:43 -0800
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
Subject: Re: [PATCH 8/8] cxl/memfeature: Add CXL memory device memory sparing
 control feature
Message-ID: <Z8us_6E2bnDie0pk@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-9-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-9-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:15PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>

snip
> 
> diff --git a/drivers/cxl/core/memfeatures.c b/drivers/cxl/core/memfeatures.c
> index 8d5a57a0c154..14d3960504a2 100644
> --- a/drivers/cxl/core/memfeatures.c
> +++ b/drivers/cxl/core/memfeatures.c

Hi Shiju,

This new file memfeatures.c would benefit from clang-format-ing,
starting in the earlier patch that introduced it, and repeating
through this last patch. (I got a lot of diffs when I ran
clang-format.)

-- Alison

snip

> 

