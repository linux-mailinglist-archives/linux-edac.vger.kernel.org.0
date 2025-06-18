Return-Path: <linux-edac+bounces-4172-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91243ADF0B0
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 17:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3CB1631C7
	for <lists+linux-edac@lfdr.de>; Wed, 18 Jun 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CD02EA149;
	Wed, 18 Jun 2025 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ne4DG8N1"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E72C1A3179;
	Wed, 18 Jun 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259167; cv=none; b=SbBttmNZKPO3bK4osceRjwikMyc5aDN18+TKtm1teUJa5+aVmzajoZ/n7eidmA6ZKblh4k4wybPZ+gelQXJdxlKmDT0wMKtH2O0EpiGC1L1UzsNAYV3HYCDqLGQ98eI5aVta7gRUs6z9HMXK4OVZWRKbf+UjprMYDKoBTNe0hD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259167; c=relaxed/simple;
	bh=uapEyWYgiWJmlIq+Y3Q/Ao1A4WvpMVp8alphcwzsvD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+pMt+ycGnnfuwJ9FO2u2yAR4r1ywbh4zc3kp5SxgsJcdCD+c241GnmI2DdZnOO5UHe4npkki1o9t+Bq7EJ4sVOByXF3P+tyi5QnklKwl5T0pH0qjanoXB0ExHO953nGzDAMSQbRiF2t43nOSJCf17x2HLjgxgLJm+2kAwFO4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ne4DG8N1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750259165; x=1781795165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uapEyWYgiWJmlIq+Y3Q/Ao1A4WvpMVp8alphcwzsvD8=;
  b=Ne4DG8N1YYysGgdzHGwoFuRMctcTAG4ODSWCMJCmFh8DtZqT2IrJ2fPc
   SIdroZbqDuijOB09oMEIcoc+hD2kEpN4oDCO3SsOVafJzDOXThlaxk/JQ
   OngBxWoKPD6cqFORmm6XTsOnHTOhUWdxmz5dpSN8FX5XS8sAQ8VitraIv
   l9/hvkL6L4088bBx7f7tOw0ps7Ur4G2+4Agl0/2soxxKgM3/zG3vNCveZ
   b2jgOYrhkucO1UHPP6lawIgcVFpefQVO74ZIxX+HOV82o9oibwFvMYkNL
   lski4BO8GdxM9PT+oFrqAjF63QzLplN0wSCtoYkUwmMhf45TnkJRmYlAh
   A==;
X-CSE-ConnectionGUID: 809XKJl0TVeerKtWN7OMCw==
X-CSE-MsgGUID: mJlYsezVSXuTbqnNNbaxxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52569471"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52569471"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:06:04 -0700
X-CSE-ConnectionGUID: uR7su9DxQ8qBDx80WPtraw==
X-CSE-MsgGUID: xvukXqsdRqud5/oe2h3N0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="155489834"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:06:04 -0700
Date: Wed, 18 Jun 2025 08:06:01 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, marmarek@invisiblethingslab.com,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EDAC/igen6: Fix NULL pointer dereference
Message-ID: <aFLV2YMOzXe4iP-I@agluck-desk3>
References: <aFFN7RlXkaK_loQb@mail-itl>
 <20250618031855.1435420-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618031855.1435420-1-qiuxu.zhuo@intel.com>

On Wed, Jun 18, 2025 at 11:18:55AM +0800, Qiuxu Zhuo wrote:
> A kernel panic was reported with the following kernel log:
> 
>   EDAC igen6: Expected 2 mcs, but only 1 detected.
>   BUG: unable to handle page fault for address: 000000000000d570
>   ...
>   Hardware name: Notebook V54x_6x_TU/V54x_6x_TU, BIOS Dasharo (coreboot+UEFI) v0.9.0 07/17/2024
>   RIP: e030:ecclog_handler+0x7e/0xf0 [igen6_edac]
>   ...
>   igen6_probe+0x2a0/0x343 [igen6_edac]
>   ...
>   igen6_init+0xc5/0xff0 [igen6_edac]
>   ...
> 
> This issue occurred because one memory controller was fused off by

Maybe "disabled by BIOS" rather than "fused off by BIOS".

> the BIOS but the igen6_edac driver still checked all the memory
> controllers, including this absent one, to identify the source of
> the error. Accessing the null MMIO for the absent memory controller
> resulted in the oops above.
> 
> Fix this issue by reverting the configuration structure to non-const
> and updating the field 'res_cfg->num_imc' to reflect the number of
> detected memory controllers.
> 
> Fixes: 20e190b1c1fd ("EDAC/igen6: Skip absent memory controllers")
> Reported-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> Closes: https://lore.kernel.org/all/aFFN7RlXkaK_loQb@mail-itl/
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[snip]

> @@ -1350,9 +1350,11 @@ static int igen6_register_mcis(struct pci_dev *pdev, u64 mchbar)
>  		return -ENODEV;
>  	}
>  
> -	if (lmc < res_cfg->num_imc)
> +	if (lmc < res_cfg->num_imc) {
>  		igen6_printk(KERN_WARNING, "Expected %d mcs, but only %d detected.",
>  			     res_cfg->num_imc, lmc);

KERN_WARNING seems overly dramatic. BIOS likely had good reasons to
disable the memory controller (e.g. it isn't connected to any DIMM
slots on the motherboard for this system). So there's nothing actually
wrong that needs to be fixed.

KERN_INFO is enough. Perhaps KERN_DEBUG?

-Tony

