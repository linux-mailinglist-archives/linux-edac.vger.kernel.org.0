Return-Path: <linux-edac+bounces-3317-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13950A5779A
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 03:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E553B3FBC
	for <lists+linux-edac@lfdr.de>; Sat,  8 Mar 2025 02:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D888C146A72;
	Sat,  8 Mar 2025 02:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P0iwvmpu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D74C74;
	Sat,  8 Mar 2025 02:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741399767; cv=none; b=AK/xgog0tSWgOXBbQI+iRsAD0ztZ7NhmZGr7FyPfFaqrRke1WyVWAg7NUE73ofJHtIL+hQ+1MIW72C+rFyctCFX4x4hhS+izlQaqFXWRKdUHhoOKLjQxepORZOx8BpymHBaip0PjWx2+/hPewVzIMjcPjPe7e5HZOiCj71qm6bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741399767; c=relaxed/simple;
	bh=RrmYg2+41IboMImIfWfQLPjGz1QCPIHMrK5PBY1dNxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvEFBOeDWiq6sCfzKVTcaiQ2EOrjil59sh+uT6UyeakFILYAoej94CKJLjg3d6XctdPaiCvcJa4ZRaOgSQn1uWS0mnjgpRc2F4ez9g/HjykZeTWMeP3TkKUFR9PxMCORkuwgY/IFJQ2zoDtz4dFRW+s3pYrRy1N/PHW7e1hq+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P0iwvmpu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741399766; x=1772935766;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RrmYg2+41IboMImIfWfQLPjGz1QCPIHMrK5PBY1dNxM=;
  b=P0iwvmpu/5R8B+PczqWpqTaBDycL8SscLa6ynA+5gPeaz3Y9Mv3IDZ6U
   87d1u/If5h3bq8UkfKoS190a3ulFknm66kyvDCsHn4+A5fD3uVzWcMwA9
   mMsfvhyyQaeKBpdnTcS3U3zPZiYXQnPptpXDPyzV53DZTkXW+woWg1uPy
   1iTU4fU/yoCInMT+P9xylxfN9hKs+HQKfxAeTeOXImvVyADnwRNVrZW/Y
   M59rjBz5xtbt2CpTzPXpiG7QjEMTtspA9YTfgYFElU2SbdnYxKDPgUwbj
   aqRrYkTzhlmjZIWFGXyXkHo5WOQBlgS5Kw7fVwEDNqDZCSFR4iEmD0ik9
   w==;
X-CSE-ConnectionGUID: /J+H1p75R32fDh31BYkSwg==
X-CSE-MsgGUID: RhdotCvsQb+05RaNR3Rd8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="53855464"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="53855464"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 18:09:25 -0800
X-CSE-ConnectionGUID: NXYAootqRy2/FAZaBcm9og==
X-CSE-MsgGUID: IZrcTHB8QtWn/ujyp6UZ7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="124706884"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.159])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 18:09:22 -0800
Date: Fri, 7 Mar 2025 18:09:20 -0800
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
Subject: Re: [PATCH 6/8] cxl: Support for finding memory operation attributes
 from the current boot
Message-ID: <Z8um0DcVyKra2vYa@aschofie-mobl2.lan>
References: <20250227223816.2036-1-shiju.jose@huawei.com>
 <20250227223816.2036-7-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227223816.2036-7-shiju.jose@huawei.com>

On Thu, Feb 27, 2025 at 10:38:13PM +0000, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
>
snip

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> new file mode 100644
> index 000000000000..65994eec1037
> --- /dev/null
> +++ b/drivers/cxl/core/ras.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * CXL RAS driver.
> + *
> + * Copyright (c) 2025 HiSilicon Limited.
> + *
> + */

Please use the same 2-line header format as other .c files in this
directory.

Why is this GPL-2.0-or-later when all others are GPL-2.0-only?



