Return-Path: <linux-edac+bounces-3581-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F231FA92445
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 19:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C72D461D3E
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073B2561DD;
	Thu, 17 Apr 2025 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXgs7SPF"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6FB2561A2;
	Thu, 17 Apr 2025 17:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911899; cv=none; b=juzyy/BzGS1ve2E5YHMppBmVj2kl2u69NqWDxNacpxHKxpUSAw7S8NTsTRKm08mGzqPx0r/1L3Do87XE9oYgGK/XBK5M3Tkqp9MLBeAtjiK6TbcoJk813UvqkVW91IqYR6sdvfipCvbCZkIIb3vBSk5XD6i9N+1OfUVRQH/dE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911899; c=relaxed/simple;
	bh=aIYvomeDpv4/GkLIzCKwmgf1FVlN32aREId3Ji9lS+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uz+74E0sQUUEskYi1eph2RCdFzfwGXIbLpf10BAbOEI2MOa9zQTTwv/f8Otq8PWt6S9AP/VMwxhpFVWhp79zWGQ55QdlmW02yAvpHjlVLBkLVDly/ExKgz/X3+6aUiSKGyKa1v9ycr7aIy6rgVuShoN96FTPgsrc/osSJdKaRpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXgs7SPF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744911898; x=1776447898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aIYvomeDpv4/GkLIzCKwmgf1FVlN32aREId3Ji9lS+U=;
  b=bXgs7SPFXcKd3C7wPufhLet+FYk8bwo7iN1kNBDKpgxG6RMTqqWjcToZ
   9uTkLneBwAE7ABWagQiXLfxRBEeoW15JPSKUqqiiS9RHGo97CYG+M7ZW+
   VqetcrgRfrvDmY/CeX7hk7sNyRA4iQ3lqfZFVNXRq5XasfS4xVeTNX/sY
   lBfTOW1NJBfF+3K0ekP5H2P7x/3fIGpGqNsySXA7yOOwITbmrJ/2sD1HW
   AE5Z8kGtlvPeQbeNTEuc550IFG9AC1mS03Bju+UBevA7FsRvzCLYaIbtF
   FfstYXvAIX7Wa7thTqaP5dpHbePU6N7ysqUcbBjUXrvXnA/afNMGoyKnM
   g==;
X-CSE-ConnectionGUID: I3OFErp8TfyCLRyhUN3mRw==
X-CSE-MsgGUID: 1zZE0XAxTDuSp/2Z2KrLmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11406"; a="49206219"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="49206219"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:44:57 -0700
X-CSE-ConnectionGUID: NOa0S1DnQb+xAiIBQ/Pssg==
X-CSE-MsgGUID: Jxpni2hFQWOQbtaip7bNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="154064530"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 10:44:56 -0700
Date: Thu, 17 Apr 2025 10:44:55 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Feng Xu <feng.f.xu@intel.com>, Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	Shawn Fan <shawn.fan@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] EDAC/{skx_common,i10nm}: Refactor
 show_retry_rd_err_log()
Message-ID: <aAE-F4nGjuKX-m3e@agluck-desk3>
References: <20250417150724.1170168-1-qiuxu.zhuo@intel.com>
 <20250417150724.1170168-7-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417150724.1170168-7-qiuxu.zhuo@intel.com>

On Thu, Apr 17, 2025 at 11:07:23PM +0800, Qiuxu Zhuo wrote:
> +	/* CORRERRCNT register parts. */
> +	int cecnt_num;
> +	u32 cecnt_offsets[NUM_CECNT_REG];
> +	u8 cecnt_widths[NUM_CECNT_REG];

YOu have added this "cecnt_widths" field and code to print in different
formats fo value == 4 ("%.8llx") and not 4 ("%.16llx"). But no CPU
(including Granite Rapids added by next patch) has any values other
than "4".

Is there a mistake in the struct reg_rrl defintions where you intended
to have some "8" values somewhere?

Or is this just for symmetry with the ".widths" you have for the
RRL register (which do have varying widths).

-Tony

