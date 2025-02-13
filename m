Return-Path: <linux-edac+bounces-3081-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E4A35157
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 23:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F20189068D
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358B7245AF6;
	Thu, 13 Feb 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh8iDXWO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C8928A2BF;
	Thu, 13 Feb 2025 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739486103; cv=none; b=HMZYeC8y8oaJyFT7ySjjRYq+Aby5zLsmyx8uTrk21kc3iLAOa2ZuawFw/nuF+iLtDGidU81x+mEFDGeZcOrhj2SvaJb7TYNlnk2UwsXtboV0g/S+CLRXokzxkFYXkQnveXYpBGlShZFv726O82kyqhrmGDNLR5DyjNu3i0VJ4tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739486103; c=relaxed/simple;
	bh=u/jkcxHZhiz7r8wbxIWtuv44RSzMYTJArQkiug7ltmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ry73y5o9mXWcNGia2ChjCqKuNTIfNFCmV49SQ189Y8jnkteQ/jjs1zSZO9vjZKcBT+cizMCvW26TP41Sd2GdeNfVAGUtWyBT2RRN/izsuwjD4IvsvrWrntOkNeMfMr2I+BkiPlaWXC4vI8T5VP7OjYVsWKAs8VXZUyqEBpUXW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh8iDXWO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739486102; x=1771022102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/jkcxHZhiz7r8wbxIWtuv44RSzMYTJArQkiug7ltmU=;
  b=Rh8iDXWO7M+4NcAqCJgkkMVtEGfKSjF5V1f6cWj8a/bO0nX690t5jsAI
   XRb+JV3vyHDc68iMZEKpI8y06zp+WjQqwK6qTqphOiRoEAdYltsakvyRa
   cbGDwQxXw7wGj88A3nJU/NSaHHW4k/dxYwaA9G24uTHUkg1r1o1CxZcAQ
   0WSsDxTAJJSIQwHPtxuouO32KgDzhs7TUqC6YvV7KXauXaHmGa8WIS9Sj
   PJMOWB/rUO9OMqtF2zazn1bjrSbe5WBb72VkXq6vxD69a67ozO6W6sADK
   AV6gBvB8AEcUYeyIKQ9WLNL+7KkRxpCl690r8/ofmeDanP8speePHrkTs
   A==;
X-CSE-ConnectionGUID: Xam9Fzn+QVeX5ypuv8d3rw==
X-CSE-MsgGUID: IbfBowJjS/qUvDohdaZHyg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="57619445"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="57619445"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:35:02 -0800
X-CSE-ConnectionGUID: tIO99+DxSuehY6pGk2cJFQ==
X-CSE-MsgGUID: Gm6QK6pkSPKMX/UvY63O8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="113929081"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:35:00 -0800
Date: Thu, 13 Feb 2025 14:34:59 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 15/16] x86/mce/amd: Support SMCA Corrected Error
 Interrupt
Message-ID: <Z65zk9rbOvUivAfA@agluck-desk3>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-wip-mca-updates-v2-15-3636547fe05f@amd.com>

On Thu, Feb 13, 2025 at 04:46:04PM +0000, Yazen Ghannam wrote:
> @@ -306,6 +306,11 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
>  			high |= BIT(5);
>  		}
>  
> +		if ((low & BIT(10)) && data->thr_intr_en) {
> +			__set_bit(bank, data->thr_intr_banks);
> +			high |= BIT(8);

Maybe someday add some #define names for these BITs?

> +		}
> +
>  		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
>  
>  		wrmsr(smca_config, low, high);

-Tony

