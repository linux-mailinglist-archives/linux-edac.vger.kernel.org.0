Return-Path: <linux-edac+bounces-4145-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10332ADB657
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 18:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3713B5247
	for <lists+linux-edac@lfdr.de>; Mon, 16 Jun 2025 16:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3502285CBF;
	Mon, 16 Jun 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DuFAyVY0"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421932206AA;
	Mon, 16 Jun 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090270; cv=none; b=CD74LLD+dtbp1E8H5OMoKpgwIKgxpmiZkPzuU/w5XtkwW+AGDdparQbMYHMy3az9fkZkfTEoOkRyqGNPCxxPHcbITO/Fd7cs3XaHkL0HQGO4IDQPHTAAXT5OvDPFSK3u3p88asDxNAYBIGCQg8tkdMl4vCKt+mR51MaPFM9rOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090270; c=relaxed/simple;
	bh=tIPOanycRXeGUG/qLXkxXMcG2ZUS1ng5H3LFlCMh0F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhAU5MlIhuB3wvKJU6kwiVAY9uFgAYy/kgRMeER82A+nWjlD5m7dtYS1JLejGFLrlJocaDxY5rjnT7tMF2laAR20mb61G3e4kGAR5cpPNF+Oq6jbQGaxll390EesJwDh9Z+dR7EseztYyJFWKhR/o6T5dd1ljZdcXZAmWNB9Amg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DuFAyVY0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750090269; x=1781626269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tIPOanycRXeGUG/qLXkxXMcG2ZUS1ng5H3LFlCMh0F0=;
  b=DuFAyVY0ZKGwnngDTAEm0ki2fqYYAPXRT+UUQbd9AAQqTSuVv92OOafq
   L19xv5d1SPKsFRK8HaPATPZ9NY8SKJUDb7GFaGbnboTr/AzmgS8Jc6C1j
   05jAkaADR+AASfmsyYKKkx0voCQlPof7UcMeYOHDGbIUB9XkzTarvrG1P
   2rM3iU6LgeB9FNBRPR0keH3TpJ7h90ckpNPJTipGI9389uwD+V/Bu+qyw
   +z8eHgBe5oU8DVB9sQ9vU2ZvBuO7wxrNLlOrRZLQigMx6T0kmrP8jQPRs
   ew9cgxI9G8B+vfOItgjvOXnMIsRoxw7ICKXsWED/jE48DHWhnKLjSmoL7
   A==;
X-CSE-ConnectionGUID: mdUozK+WTy6EmKo/Beb74w==
X-CSE-MsgGUID: RMYWrht/TIWrlarBRe0eTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52332028"
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="52332028"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:11:07 -0700
X-CSE-ConnectionGUID: ACIPburjT3GhT2CCHanwww==
X-CSE-MsgGUID: RUdiEX63QvqhGcy5gRx1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,241,1744095600"; 
   d="scan'208";a="148350687"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 09:11:07 -0700
Date: Mon, 16 Jun 2025 09:11:05 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: George Gaidarov <gdgaidarov+lkml@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, Jason Baron <jbaron@akamai.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	James Morse <james.morse@arm.com>, Robert Richter <rric@kernel.org>
Subject: Re: [PATCH 1/2] EDAC/ie31200: Enable support for Core i5-14600 and
 i7-14700
Message-ID: <aFBCGTJhve9DAG6O@agluck-desk3>
References: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529162933.1228735-1-gdgaidarov+lkml@gmail.com>

On Thu, May 29, 2025 at 04:29:32PM +0000, George Gaidarov wrote:
> Device ID '0xa740' is shared by i7-14700, i7-14700K, and i7-14700T.
> Device ID '0xa704' is shared by i5-14600, i5-14600K, and i5-14600T.
> 
> Tested locally on my i7-14700K.
> 

George,

Applied to the edac-drivers branch of the RAS tree[1]

Should be picked up by linux-next, and will be merged into v6.17

Thanks

-Tony

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git

