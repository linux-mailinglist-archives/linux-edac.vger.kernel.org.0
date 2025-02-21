Return-Path: <linux-edac+bounces-3175-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F096A3E9B4
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 02:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E1F189FA23
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 01:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C863594F;
	Fri, 21 Feb 2025 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7xZtQVy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7845835955;
	Fri, 21 Feb 2025 01:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100402; cv=none; b=qBRtWd32f5CbzClqdbRJ/KD2c4eBfpSm1hBZS6KgLXjW01RsTZoWYYBoQZ2QxOMbu6fkARK25Ur6AW7fuziHxISDsdgxWJnllDXnMfO1qKBz63DunpS+IVSQeEnGTv9w9PkoVswo2/7iwBIBIAOJLpBeonH/YHYSofNNKE8IpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100402; c=relaxed/simple;
	bh=jjZ7QvSZhxTWaR5FrqIsY+HT33Lbia43rSfXJDIid0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnTI6KPtSvL7G1ucx4P8ES9oqBOm2KZMmj3uR0/KWN0z9b9jOKRqO7EIsypLMLnaLPbkr8H0iYeVMUNweM6FaeSPD2tNyx2o0N5K047lOgnwUtv7Img1VH3A2nkWauYGyFLkOOjhI6YNkIGGTwYwyPm3FWCJsYWeH9lzc7kd2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7xZtQVy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740100399; x=1771636399;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=jjZ7QvSZhxTWaR5FrqIsY+HT33Lbia43rSfXJDIid0Q=;
  b=D7xZtQVy07m1EE4OPQhbAtQO2h5+wcyw9IB3hiOCZThRU7oxizQiPraN
   qsQRdGu0aRmRN38E/w2W9I9sMiABTLlSUOE+Kv6zK1bZy3Eodmt83fDj8
   m0AIjcjPQEO+V5UrD6vPK813G77qYuDhcgEMszyq+EGWlEIHNxOMvTJs9
   gdVooqml4ghTew1npAYTOGIk7o6RO6xriId5HDuc4b7W96ClE7IvBsr2f
   wWzuVZaf7MGsYqAWqT0eJgdfZMF4KI8jDjQVWnlwsSKV59g+hytQ6/+/b
   kM0QVhd/rFfRB/A4b8hssNa06P4/KPpwMKwbDsK9C4KrKDwEf8GsFWjbr
   Q==;
X-CSE-ConnectionGUID: 5vydiMcESA2LwWwC3PbNgA==
X-CSE-MsgGUID: CrvBZqJwS0GlcyY6AbGXXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="52309320"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="52309320"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:13:19 -0800
X-CSE-ConnectionGUID: IXnwNfsQRtC1lOCzHrnutw==
X-CSE-MsgGUID: 0RwNr8tMQg2pRGfKIPF2Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="120159119"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:13:19 -0800
Date: Thu, 20 Feb 2025 17:13:17 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Jason Baron <jbaron@akamai.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Arnd Bergmann <arnd@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, James Ye <jye836@gmail.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC/ie31200: work around false positive build warning
Message-ID: <Z7fTLWH5G_UgVZIQ@agluck-desk3>
References: <20250122065031.1321015-1-arnd@kernel.org>
 <CY8PR11MB7134E3B1BE3DC6448EEF36A289E12@CY8PR11MB7134.namprd11.prod.outlook.com>
 <5a6ad008-61c6-4f65-82b3-a4e538cbb9e8@akamai.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a6ad008-61c6-4f65-82b3-a4e538cbb9e8@akamai.com>

> > It looks like gcc-14 isn't smart enough to recognize that this is a false positive build warning :-).
> > Actually, the dim_info[][] array is always initialized by populate_dimm_info().
> > 
> > > see why the compiler gets confused by the two loops.
> > > 
> > > Instead, rework the two nested loops to only read the addr_decode registers
> > > and then keep only one instance of the dimm info structure.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Seems fine with the comment adjustment.
> 
> Thanks.
> 
> Acked-by: Jason Baron <jbaron@akamai.com>

Applied (with comment adjustment) to RAS tree edac-drivers branch

Thanks

-Tony

