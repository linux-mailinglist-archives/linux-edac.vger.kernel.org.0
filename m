Return-Path: <linux-edac+bounces-4146-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA99ADB658
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4BA1888C24
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 16:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F255B2857FA;
	Mon, 16 Jun 2025 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NtXLLVUT"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B687214A94;
	Mon, 16 Jun 2025 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090329; cv=none; b=Q0TuEw8zX1hJQ2PYD3nRQYxVJ21UkySyuCWkzGOUQpmf8V6Tgcs6EvjLOGCiqL7VBwwgpwiY7nL6mDKDyRmV0LhQc9SqHtN63AD0Ltzy+S0drWy4JcYoxnEp8wSUHsJedjxVbAHKUDt5O6HLib/UFWGxgGOjjwBlp3pVLSpOsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090329; c=relaxed/simple;
	bh=ZHkEjR1EUaWEl4hOQe4bNI42ap2UwML8zt3XEQ/z8gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4Jiop4oZtNyc6SDocBcGAXBQ9X7GSAbqDGf66AQTLU5gemkiXg0PdIzXQCaSQx1wk47NPBMRxSPFhDWxxeBFEookK/Y0crPGzf9Xn57IqFq7uYK1a7UlpDepnSzyMJhAmgwGTUjkOh/4BnwaAr197ohcr/DMNYRTXXX/dYKXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NtXLLVUT; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750090328; x=1781626328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZHkEjR1EUaWEl4hOQe4bNI42ap2UwML8zt3XEQ/z8gU=;
  b=NtXLLVUTai6u5e6fm+OVcISC554b6r+0t7T/ZYqIrID08jYMcGkSjkI4
   3QZTufwbPiC/Rlhazr6zZssdnQYjWlJIqxV2CSHGQvmXOjSMg9BCiRPx1
   6lbfaoKIu+eHD8DXBxhLgGzjqJpnX8p77pjz8vDSR/hLq7VbBfdiskJ5U
   0e1/nZh2pXIRjks6LFNPuye3qzyMlxz8CQlA+cGoZttFYqaUVoN1cFM0A
   V6e4AnWsCpulmzjdj0/SicQ92w3yVO87aSYtmzqrGTM/QybUFvC5tdNr1
   dWpe+fsFVh7gXjA2hii6FKLskbgOzVPlZGACCscmZptebQmjn3QdaGAAL
   g==;
X-CSE-ConnectionGUID: ydfzqjDqRE+ixgG9B+4hDQ==
X-CSE-MsgGUID: 1u23oXItQWyAJb0IXyHwjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="51467090"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="51467090"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:12:07 -0700
X-CSE-ConnectionGUID: uwMKB0QzQdKaOkDKRqVdSg==
X-CSE-MsgGUID: STzIZZlFRKWtY4AirqBzyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="185773744"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:12:07 -0700
Date: Mon, 16 Jun 2025 09:12:05 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: George Gaidarov <gdgaidarov+lkml@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	James Morse <james.morse@arm.com>, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 2/2] EDAC/ie31200: Document which CPUs correspond to each
 Raptor Lake-S device ID
Message-ID: <aFBCVSH-85fvV3Ln@agluck-desk3>
References: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
 <20250529162933.1228735-2-gdgaidarov+lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529162933.1228735-2-gdgaidarov+lkml@gmail.com>

On Thu, May 29, 2025 at 04:29:33PM +0000, George Gaidarov wrote:
> Based on table 103 ("Host Device ID (DID0)") in [1], document which CPUs
> correspond to each Raptor Lake-S device ID for better readability.
> 
> [1] https://www.intel.com/content/www/us/en/content-details/743844/13th-generation-intel-core-intel-core-14th-generation-intel-core-processor-series-1-and-series-2-and-intel-xeon-e-2400-processor-datasheet-volume-1-of-2.html
> 

George,

Ditto. Merged as for part 1.

Thanks

-Tony

