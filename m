Return-Path: <linux-edac+bounces-3316-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDCA5778C
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 02:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822AE1887205
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 01:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32378F43;
	Sat,  8 Mar 2025 01:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FEbc5Shj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217A4C9F;
	Sat,  8 Mar 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741398503; cv=none; b=G3I6pAJPjUEuc9pV59KTros4SGrxlE844QYixRUbwj8x9uH7KR44Qqr1YXwsVN/vasOaqt6ajmJnETzjU8RMrKFFyVzbN6bRvN9G4s/zmSSqOYZPGhAvfBbTrCOagEfzHxwG1qi3/zo94GlCyPKPpd/libtwRCMSptgq0WEm3qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741398503; c=relaxed/simple;
	bh=33/GF+zRlq2xnIN/f2zSmMFCuYusedV0G5v+qkiM8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVuOhfRsx3zBSxqoYd7FJJSq0VbCGC2pKE3GNEEfltalCZB+ANb3eqoEewZrtHnUgjQvrZZOQa1SRtaBoJXtpeEa3O+asl7U93vsfwFGTu4wd/Zd5Zou/Lm/WAQ2CJuLhvoG3RskuPiV8z0X2K1Lw+jS1sx0rHkumtYc2FJBguo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FEbc5Shj; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741398498; x=1772934498;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=33/GF+zRlq2xnIN/f2zSmMFCuYusedV0G5v+qkiM8iY=;
  b=FEbc5ShjG5xVu4YYCbzpd6KG9mAZmHAYrK+aeTHkxBL/9LUb78LS8rc0
   nPHLVCQGFlG6axLNNUfhDP9uLulNXliecUiFhAX70GpfKqdgjavTWOz5M
   KH8AQbEl/cq9HAYDtZyQIEPjGa9x+5scClUNiWxlSf1VhAaEp8quWEaYh
   CbqvOVoqJQg3/7q1YRdQLL+J9lVqeWRRMqINuPKTRJyx4dh11gmpYFLRL
   V5ZaPFardbK3z0h2JZDN3pke/3QA0nZZ6b72GTCtohlMZuBWQrerMX7GP
   mwAEXDvQs2EDWV3/zHdgrNUpBT6uYuPqsOMJE8ZoZXIU0I/968Iea6UeW
   g==;
X-CSE-ConnectionGUID: EpEMZIABSb+n05NAFcNXqw==
X-CSE-MsgGUID: Gg7iI1ceQjqIgPtZpAbSgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="30037723"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="30037723"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 17:48:17 -0800
X-CSE-ConnectionGUID: o+MtEFLDSxy5hVpewTMf6w==
X-CSE-MsgGUID: 1Zigs2F7RKmK0p2WooquOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="119966640"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 17:48:15 -0800
Date: Fri, 7 Mar 2025 17:48:13 -0800
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
Subject: Re: [PATCH 3/8] cxl/memfeature: Add CXL memory device ECS control
 feature
Message-ID: <Z8uh3aYDJ7-VbOyG@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-4-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-4-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:10PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>

snip

Next 2 macros have line continuation chars at 81 and 89.
Please pull into column 80 or less.

> 
> +#define CXL_ECS_GET_ATTR(attrib)						\
> +static int cxl_ecs_get_##attrib(struct device *dev, void *drv_data,		\
> +				int fru_id, u32 *val)				\
> +{										\
> +	struct cxl_ecs_context *ctx = drv_data;					\
> +	struct cxl_ecs_params params;						\
> +	int ret;								\
> +										\
> +	ret = cxl_mem_ecs_get_attrs(dev, ctx, fru_id, &params);			\
> +	if (ret)								\
> +		return ret;							\
> +										\
> +	*val = params.attrib;							\
> +										\
> +	return 0;								\
> +}
> +
> +CXL_ECS_GET_ATTR(log_entry_type)
> +CXL_ECS_GET_ATTR(count_mode)
> +CXL_ECS_GET_ATTR(threshold)
> +
> +#define CXL_ECS_SET_ATTR(attrib, param_type)						\
> +static int cxl_ecs_set_##attrib(struct device *dev, void *drv_data,			\
> +				int fru_id, u32 val)					\
> +{											\
> +	struct cxl_ecs_context *ctx = drv_data;						\
> +	struct cxl_ecs_params params = {						\
> +		.attrib = val,								\
> +	};										\
> +											\
> +	return cxl_mem_ecs_set_attrs(dev, ctx, fru_id, &params, (param_type));		\
> +}

snip


