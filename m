Return-Path: <linux-edac+bounces-4331-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00BAFBA52
	for <lists+linux-edac@lfdr.de>; Mon,  7 Jul 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B9C42131D
	for <lists+linux-edac@lfdr.de>; Mon,  7 Jul 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288F2206B8;
	Mon,  7 Jul 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzpMLjN1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A5288A2;
	Mon,  7 Jul 2025 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911430; cv=none; b=nq3SYZUnUe1FERpZr7NKPDAfu9g8myD/QQfWYGOCQo5kNOzEYCJRl4/4zBupw+eAx4SvgZRgrW1Nq5zCtldYvu/7xDINUTNDw6xSrJPEXDz53nUy5ZediZBIoUW4xn1D9ZGHFYwhf0QalDavYM3f5sH8ftJTP8muBf9LBbrzdKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911430; c=relaxed/simple;
	bh=aJ7JldmUgMHyfMjWgIQRPx9WBvTGcpM5qbU4suhhjWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nyy7LwfVFq+s19XVKCEPg4gbqmH64XV1Ovgt6C2iMOBmtmysTFwcksVoQn18WDj1onLFtapPA4tOzY+11J/L6c0X3zENvdKJw1j+Vv0fN0XEKe/f/8Vaw9Rak/ICjbjIU+JNpaFOoyjV3f3LzfVtzz8NMFMY5myIM9g7mFm4TTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzpMLjN1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751911429; x=1783447429;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aJ7JldmUgMHyfMjWgIQRPx9WBvTGcpM5qbU4suhhjWE=;
  b=YzpMLjN1L2UAG3TGzoh+nqa9FvKB7Lre2ERrxp+B8BBd+SpPSzBxhoq9
   oxyTaW79+NbKlLhStCvSfxpjIOLthKVuwOngcHrSMvuTPlpX1gi5xJX0K
   8tIyA+L1wvm9g1QA4rC7Jg1PYntzAZJYf1qTMSprWCcICXoINoRVyLmHz
   zKf5tvGVCjqzqqFWlK5OGHczt0JZbosjWJ3NQGPSXdToxTudqIklhmv0G
   a4VtQZizalHVB+aIuEmsqOOOs2fW5Q7ct//0CAhUnJi9wpCTDUKBOTlfm
   QXOAGygsNBrh4iaX3/jFqLrqlsdDKipokbe7hSCpOi1xhSpUj4XA9Gz1g
   Q==;
X-CSE-ConnectionGUID: c546ZXnUSIm+RNqEEG4njw==
X-CSE-MsgGUID: tKu0OIV5SkWL2S7mTgyh3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54277670"
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="54277670"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:03:48 -0700
X-CSE-ConnectionGUID: 38aihURwSsmtgjRemK20DQ==
X-CSE-MsgGUID: LRAtAHBkT426tvLsCLXmQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,295,1744095600"; 
   d="scan'208";a="155377034"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2025 11:03:48 -0700
Date: Mon, 7 Jul 2025 11:03:47 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Lili Li <lili.li@intel.com>,
	Laurens SEGHERS <laurens@rale.com>,
	VikasX Chougule <vikasx.chougule@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] EDAC: Add three Intel CPUs for EDAC support
Message-ID: <aGwMA0jZWbQeBIuZ@agluck-desk3>
References: <20250704151609.7833-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704151609.7833-1-qiuxu.zhuo@intel.com>

On Fri, Jul 04, 2025 at 11:16:06PM +0800, Qiuxu Zhuo wrote:
> Add EDAC support for three Intel CPUs: 
> 
>   - Patch 1: Wildcat Lake SoCs with In-Band ECC.
>   - Patch 2: Granite Rapids-D for micro-server and edge computing applications.
>   - Patch 3: Raptor Lake HX series SoCs with Out-of-Band ECC.
> 
> This patch series is on top of RAS edac-drivers branch.
> 
> Lili Li (1):
>   EDAC/igen6: Add Intel Wildcat Lake SoCs support
> 
> Qiuxu Zhuo (2):
>   EDAC/i10nm: Add Intel Granite Rapids-D support
>   EDAC/ie31200: Add Intel Raptor Lake-HX SoCs support
> 
>  drivers/edac/i10nm_base.c   | 12 +++++++++++-
>  drivers/edac/ie31200_edac.c |  4 ++++
>  drivers/edac/igen6_edac.c   | 15 +++++++++++++++
>  3 files changed, 30 insertions(+), 1 deletion(-)

Added all three to RAS tree, branch edac-drivers.

Thanks

-Tony

