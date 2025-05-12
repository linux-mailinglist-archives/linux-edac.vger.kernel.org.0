Return-Path: <linux-edac+bounces-3887-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22155AB3CBA
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 17:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A468016A5C4
	for <lists+linux-edac@lfdr.de>; Mon, 12 May 2025 15:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36623D2B3;
	Mon, 12 May 2025 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFdrvjJw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478D223C518;
	Mon, 12 May 2025 15:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747065193; cv=none; b=ftj08zaRj0wNp07tF7ZVjiHbUuzs+ZxrCMmQ1X2Gt2cvXMWAfj8kGE9aV462uSiMbiVfxOJiXWRVG2df3GcNZqTUEUOLuuX02hcms250Wf9x1xoatur+/zuESW0UJOr66MX60J03CbG3vJ3zuFEAVKXhzPSg9JwhYLXb2SYV6s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747065193; c=relaxed/simple;
	bh=ruXvesyscK6Zomaq+OiPd916z2rinqKUU300GjloMCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsM1tgTDOHC1BSvzGPD1uJnnzvHt9CZWhv1JCZAOWb2x8hpZVad2Plxgb2ZG+GcaiCncnKi80E/D4yad2h+DD0ctb9An/He1p2+6aqym44P4KS0LCC+WerrDxh69gDx84m+My5SxcZPzthP2760uFGmTUan4ez2CZ1QTOnJ3TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFdrvjJw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747065191; x=1778601191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ruXvesyscK6Zomaq+OiPd916z2rinqKUU300GjloMCU=;
  b=hFdrvjJwxdbeHESKmK/uS6ssFuy1oWhk/z0UzHkjgZ836DqSGlvCmrmq
   6WYDc2nVncPIFBiT3KU+ZTg+YKhe//h/26hTnp8m2kR5LhKjHpjU7pd5h
   tIq5Jdegh3Dcw5nKZEnluHTVU2V9U/1/tJpk5RJUlLdpZP+B//aHxVET7
   Y87pziUTZKJFq1tpTrmlYlhVqTO4WmeLC17WRpsLluG6ZsxTbLGy30E/v
   IYZY6Inzw5nHFCJJsn8N97XtPWsvVaNb6Rza+gPEOGwvk7IuTPjmIqJ8T
   e82hDbTe37dGN8GppO20nQVYQ0Bd0y6/CLeQYCgK9f44A0KDxH8pdZ6Z+
   A==;
X-CSE-ConnectionGUID: aFnk25ikSFi/8wCfTiiFng==
X-CSE-MsgGUID: vezQiCOGQs2UX+BMyYD/6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="74263416"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="74263416"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 08:53:10 -0700
X-CSE-ConnectionGUID: hbTsKnoWRFG+q//qsg1MZw==
X-CSE-MsgGUID: 34VyF7LYTr24wRpfrUavow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="142183080"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 08:53:10 -0700
Date: Mon, 12 May 2025 08:53:08 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 17/17] x86/mce: Restore poll settings after storm
 subsides
Message-ID: <aCIZZIsee7roLlNZ@agluck-desk3>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-17-8ffd9eb4aa56@amd.com>
 <20250512074616.GSaCGnSJbBpToh2VM6@fat_crate.local>
 <20250512154315.GC2355@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512154315.GC2355@yaz-khff2.amd.com>

On Mon, May 12, 2025 at 11:43:15AM -0400, Yazen Ghannam wrote:
> On Mon, May 12, 2025 at 09:46:16AM +0200, Borislav Petkov wrote:
> > On Tue, Apr 15, 2025 at 02:55:12PM +0000, Yazen Ghannam wrote:
> > > Users can disable MCA polling by setting the "ignore_ce" parameter or by
> > > setting "check_interval=0". This tells the kernel to *not* start the MCE
> > > timer on a CPU.
> > > 
> > > During a CMCI storm, the MCE timer will be started with a fixed
> > > interval.

I think you just need some more words at the start of this second
paragraph to avoid confusion when reading together with the previous
one.

Perhaps:

If the user did not disable CMCI, then storms can occur. When these
happen the MCE timer will be started ...

-Tony

