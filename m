Return-Path: <linux-edac+bounces-2678-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDE99E9F5C
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 20:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69049188353F
	for <lists+linux-edac@lfdr.de>; Mon,  9 Dec 2024 19:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746019343B;
	Mon,  9 Dec 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMT1UCzr"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62AE140E5F;
	Mon,  9 Dec 2024 19:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772169; cv=none; b=tfQA4m12RiOAflgAV4xtx+gnDpYXC4bP5TvnASd9xmJeWUmt5Xg8YmzkZ1U/ekYB3xBOzRwOVl+4K15UNw9Fh2fm4eOyVPIeb34qLf0mMRZX/mjxoDlYMWOEpVFG+Rc+Y/HHtsBrxJTf7BsRA1iCjod+jcrAyqqZUNxVKPjKG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772169; c=relaxed/simple;
	bh=C0gBHd/YEru+HA07RGqBl/D5dp3U0EbP0FzqcTx+lNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtqB7e46d6A9fyPhdpEhqK4poJcVGnfb/79w2dpIxU8ZOsBi0v9wb2W4zTm1N7xslF/JBJb+w3tqC7X/7ZTj2w/R2j+va8/xazzPiz8aWxyDSOt00QFgFGxvpTeF4IQ/T8uhT/20rNVSEMM8abYHtdkovutOH4LYQxYHDQ3l9WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMT1UCzr; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733772167; x=1765308167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C0gBHd/YEru+HA07RGqBl/D5dp3U0EbP0FzqcTx+lNc=;
  b=JMT1UCzrqzTWjApO7jChO8SeEpqHPmlHGh/1N0D0u0CqFAiZyXzDwhIT
   6O+vHIS8bKu7BXtFyyDRfhoxstvgyQSZDQB32BhkY+Oi8FznjMNusixIz
   RjsHTFLcrS1csfFx+24N6QPtOoF0p/PtnZ+Q1OLVJNTycG0nFnq1ADBs/
   W15P8Jcnf4A/8dZkcdyvXyLGHNBODom/8rDDbztQM4MXGbNk+puzE32Fw
   c4zfLLdHj3EpSa0GxDTwJu4k96peLZkJkD/jdcKSOafz/0adWSVj9CO8Z
   dmwJv700WYXnWpj7Byq6D+bzHV9+ssKXtfN4XGlxJBtChf0Vf94K0bdHL
   A==;
X-CSE-ConnectionGUID: Rz8LK8jfQOWvn3pzd9sLOQ==
X-CSE-MsgGUID: TaJ+XbH3TnecauATRe98eQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34235669"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34235669"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:22:47 -0800
X-CSE-ConnectionGUID: 5eWYcxSOQ8afoHaRD+RIIw==
X-CSE-MsgGUID: IHDo5b/VQmefBgjn7pjZWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100205286"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 11:22:47 -0800
Date: Mon, 9 Dec 2024 11:22:45 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EDAC/i10nm: Add Intel Clearwater Forest server
 support
Message-ID: <Z1dDhYLE4rcK0tIm@agluck-desk3>
References: <20241203022038.72873-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203022038.72873-1-qiuxu.zhuo@intel.com>

On Tue, Dec 03, 2024 at 10:20:38AM +0800, Qiuxu Zhuo wrote:
> Clearwater Forest is the successor to Sierra Forest. Add Clearwater
> Forest CPU model ID for EDAC support.
> 
> Tested-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to RAS tree for v6.14 merge. Thanks.

-Tony

