Return-Path: <linux-edac+bounces-3080-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D8A3514F
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 23:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D59F23A28A1
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 22:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283D2135D1;
	Thu, 13 Feb 2025 22:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DpNeBKWz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F028A2BF;
	Thu, 13 Feb 2025 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485951; cv=none; b=HlycdKIw1D1AoRNjlLiCNsqjlNF32L14lpRF+t4m8rKHXHqX96Sxqj7YkyA9QqjvKSpgZTLo2phDok7Mxc6O/Eo4M5qx7v7aEExZVQtSzYw60jNB8IcuC8pXZSvdICkJK3GdwzvEMULDmKzX5EKcQ/sSI+Y6g5Omwd6bBorW7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485951; c=relaxed/simple;
	bh=ClKK8pK76nA2cO1GR4j5G4YWIdO763ukS/L4obDgrLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF8zK3m4/kaYlLVxf8KU7lo4zOlMsvMHRSYEUSbiglQq6751h8PfhN78zhlcaBcT1uwNNTVWrRLnWM6t6yH6mfTUDxyr4xZyMcluZN3JwJOh9oeHdWhb0Vp4RHHrHVBAGmTix88dcWG1n36QwqGUojtsnisBBM9VXkClrgj97RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DpNeBKWz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739485950; x=1771021950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ClKK8pK76nA2cO1GR4j5G4YWIdO763ukS/L4obDgrLY=;
  b=DpNeBKWzvzPmgBQYLSwAA0Oo868diAoYTIzhr+5nc1QPDHFG/wadPj10
   /1psOb5E41IZWqCQLzIP1r1pB4Ixn5ah3irJrsG+r6np6EmQTN3xjwBnw
   vlStK8va4+QxHg57CyIbKmO9c2p0Slrmk0mA5HSbyqVM52MfFzRvy7RAT
   NnZB3PhjAutM/sVjI/xEGfCczJPOjbfuYxbBu2pJNKFulIcDCUZZCBQTQ
   auR6s7ao0KV6ufCQbtC0aZ6FdzFJepfAQpuSR0mukJI0uCCpa0tG9bglW
   Mll4GUZUxE7KOcYnwNEm1lLDaaKimEns6Mo4mVJV9JeXlvMXeus6iHHQR
   A==;
X-CSE-ConnectionGUID: uTT1COZqS96GOhGL0miS/g==
X-CSE-MsgGUID: k3/xC1HUSI2YfYaBdie1kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43984113"
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="43984113"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:32:29 -0800
X-CSE-ConnectionGUID: fxUlZAlHT+iGDCq0t/teUQ==
X-CSE-MsgGUID: 327b0TjWSS2zrazCVTA0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,284,1732608000"; 
   d="scan'208";a="118293777"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 14:32:28 -0800
Date: Thu, 13 Feb 2025 14:32:27 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Message-ID: <Z65y-1IQKmCLOhXu@agluck-desk3>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
 <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>

On Thu, Feb 13, 2025 at 04:45:54PM +0000, Yazen Ghannam wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
> that function to what it does now - prepares banks. Do this so that
> generic and vendor banks init goes first so that settings done during
> that init can take effect before the first bank polling takes place.
> 
> Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
> as it already loops over the banks.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>     Link:
>     https://lore.kernel.org/r/20221206173607.1185907-2-yazen.ghannam@amd.com
>     
>     v1->v2:
>     * New in v2, but based on old patch (see link).
>     * Kept old tags for reference.
> 
>  arch/x86/include/asm/mce.h     |  3 +-
>  arch/x86/kernel/cpu/mce/core.c | 63 ++++++++++++------------------------------
>  2 files changed, 19 insertions(+), 47 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 2701aca04aec..36ff81c1b3b1 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -290,8 +290,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
>  enum mcp_flags {
>  	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
>  	MCP_UC		= BIT(1),	/* log uncorrected errors */
> -	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */

MCP_DONTLOG is removed in this patch. But no mention of this change in
the commit description.

-Tony

