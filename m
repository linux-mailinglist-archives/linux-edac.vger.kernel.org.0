Return-Path: <linux-edac+bounces-3176-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82100A3E9B8
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC23AEB83
	for <lists+linux-edac@lfdr.de>; Fri, 21 Feb 2025 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023F3BB48;
	Fri, 21 Feb 2025 01:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VHhFly81"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500CF1E1022;
	Fri, 21 Feb 2025 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100503; cv=none; b=GOgfh1VBx3Kfos+PYlGmcHlrU9qf8qbFmE7pCrJ96sdilJl+Rp6U6D5GwJSBGUJ3yfVjorSjeLTJXD7Wq+Qk1pIm9jjitEUpPsdIdQ/EKi0ahv6sc7t5Ti90nod9X2aSjw3O8JO4sNMlaTP9d5/zqPZEAzhatFcfJKn4jP2XFv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100503; c=relaxed/simple;
	bh=uS+vVKASRtfhM7BFzojGL9JyOPAaQOa3nWrF6yHAjW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5mzNq8Tryh2cNP5ILp4i4JTym5PCP75Cf2bdGYUbfEIcTQgcehuXYOp15dZKV0Ge5SCh8rneIxyUJpyUPbOfc6gJ0gNOVoq0PqF+c8tsgOgQ35rS2FRVJaSrBNVzQ0zbftpF+F6ps+7ciuG/CDLiqyTdVqNTHJS5NWZH39h+3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VHhFly81; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740100502; x=1771636502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uS+vVKASRtfhM7BFzojGL9JyOPAaQOa3nWrF6yHAjW0=;
  b=VHhFly81rA27+dTpIk1Ojz+NzLL4IOxMW0pVpgsXzU7cGToD+PrFnR3e
   an46Il5riG+L0kJZaZUE1hNxgiAvrKC/LzBROd/YKGgF3sFesANS8eKzQ
   UVOe8SS47aQ4SEzgY2hhPcU9R6LIR3gCMwsXOEH6IAlBzVte+jBAzu95k
   S8CzDU4QAjM6ED0PkXsHz0bO54vdAwct+Vy1o9ha+YrJXvXtLbMcumv2E
   D1+e7O5jkPw02YMmlVuypb1YAz8bAgEWjAWbcIcJ73eINhAyePcvx+vJK
   dWt0wUKkzG9aI4XGmhN5BnwsG7A7djMaYQ3gvSrYH3x92z5iJagnc6dqE
   A==;
X-CSE-ConnectionGUID: qvHjpcoQRJetKsavtvU+6g==
X-CSE-MsgGUID: bqGd+BQLQW+HmDWLwM1s/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40622376"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="40622376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:15:01 -0800
X-CSE-ConnectionGUID: FCKVSBxnRUivOl25w4aL0Q==
X-CSE-MsgGUID: xGXvWeKLTMCko+amGvIScQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146109952"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:15:00 -0800
Date: Thu, 20 Feb 2025 17:14:58 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, Ramses <ramses@well-founded.dev>,
	John <therealgraysky@proton.me>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] EDAC/igen6: Fix the flood of invalid error reports
Message-ID: <Z7fTkuQeYANX4QtY@agluck-desk3>
References: <20250212083354.31919-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212083354.31919-1-qiuxu.zhuo@intel.com>

On Wed, Feb 12, 2025 at 04:33:54PM +0800, Qiuxu Zhuo wrote:
> The ECC_ERROR_LOG register of certain SoCs may contain the invalid value
> ~0, which results in a flood of invalid error reports in polling mode.
> 
> Fix the flood of invalid error reports by skipping the invalid ECC error
> log value ~0.
> 
> Fixes: e14232afa944 ("EDAC/igen6: Add polling support")
> Reported-by: Ramses <ramses@well-founded.dev>
> Closes: https://lore.kernel.org/all/OISL8Rv--F-9@well-founded.dev/
> Tested-by: Ramses <ramses@well-founded.dev>
> Reported-by: John <therealgraysky@proton.me>
> Closes: https://lore.kernel.org/all/p5YcxOE6M3Ncxpn2-Ia_wCt61EM4LwIiN3LroQvT_-G2jMrFDSOW5k2A9D8UUzD2toGpQBN1eI0sL5dSKnkO8iteZegLoQEj-DwQaMhGx4A=@proton.me/
> Tested-by: John <therealgraysky@proton.me>
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Applied to RAS tree edac-drivers branch

Thanks

-Tony

