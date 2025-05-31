Return-Path: <linux-edac+bounces-4055-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BD9AC9CFE
	for <lists+linux-edac@lfdr.de>; Sun,  1 Jun 2025 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E94189D8B5
	for <lists+linux-edac@lfdr.de>; Sat, 31 May 2025 22:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0A919F471;
	Sat, 31 May 2025 22:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RLDifOnz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2D7080C
	for <linux-edac@vger.kernel.org>; Sat, 31 May 2025 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748728818; cv=none; b=hrGmN2C+/IMpX0gZFd36z7+JJVEZ7dXqwdYPuv0gJdpiqOwic+Z/9XBLeOrW76kAjsrz72KTtlIwBeO0TesO2PvrZe7wJDpbRcnIiWdkZw8xWVe/xGBV4mXqyoOx+gNKz5Wzs4OlVMjF+I45ccsdy6o6S1D0gDuOsT/0YO78aLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748728818; c=relaxed/simple;
	bh=Wc3PaTQ/Q3ogBVQlXvnN7HAYOJqS5fOVvJVDjhzI7QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezX23GDiCHOAXABRw7PTC5z2SfkD4FHzQ9/PLzMRUm6SdpSeeyyP+eyzyN/wobz8can++PD2X71SdRMltb1NINbN4GTCRBqtdjmrn59PVY5CllvsGUNxHbjqB21m7DGBjmjX8vkz35GrUGmuoU0oxldiKVgNGsJV12tvChniQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RLDifOnz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748728817; x=1780264817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wc3PaTQ/Q3ogBVQlXvnN7HAYOJqS5fOVvJVDjhzI7QY=;
  b=RLDifOnzg7P35pxSfU34MzvPqbber0Sqtt3YBVH5OyAYKLtrQmhcZqJj
   ibb2KVOPo4Hje4s5nICeqLKcvSnr9GJ51+qAvMjAmltLFff+M5J9OFsiw
   ESqs92cMxz/S6Mq04th3PMNijcUrgDq+xKXS0K+roW1ac5B2z/rCLBOJL
   6JLb2SloJoPJiU5E7Rrdv5h8+fCoLarVz6ig03q6OHZs2XgTOzRMXgt8z
   fDWmTeQaCzq3eGdDF9l6SCkAJO9r+P1grBD6YMSnD/xnEzF6d3HL2jCZY
   y92cPqdffetuhNIesX8f9ccKO1RDoeah7H/yvf5Ont5ANoR9Tf9CW3s99
   w==;
X-CSE-ConnectionGUID: 3QW6Bv7QTcCtZS56t3Y9qA==
X-CSE-MsgGUID: BuWKF9HOQC+vFFvEbnDJxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50936762"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="50936762"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 15:00:16 -0700
X-CSE-ConnectionGUID: ANH0/ZSaRXWFSxR2yvHiAQ==
X-CSE-MsgGUID: paAMC7nzRjWPfQXoCJk07Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="149344750"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 15:00:16 -0700
Date: Sat, 31 May 2025 15:00:14 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>,
	Xiongfeng Wang <wangxiongfeng2@huawei.com>, x86@kernel.org,
	linux-edac@vger.kernel.org, wanghai38@huawei.com,
	bobo.shaobowang@huawei.com
Subject: Re: [RFC PATCH] x86/mce/inject: Add sanity check in inject_mce()
Message-ID: <aDt77p9GYCIRIOMa@agluck-desk3>
References: <20250529033256.31554-1-wangxiongfeng2@huawei.com>
 <20250529094534.GAaDgsvhdl-BrzlM0J@fat_crate.local>
 <aDq6cecrsKYrwra2@gmail.com>
 <20250531091746.GAaDrJOuUlQyfRjgv3@fat_crate.local>
 <aDtEyl5A36zRyV7B@gmail.com>
 <20250531190724.GCaDtTbBgz3dFE-BDJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531190724.GCaDtTbBgz3dFE-BDJ@fat_crate.local>

On Sat, May 31, 2025 at 09:07:24PM +0200, Borislav Petkov wrote:
> On Sat, May 31, 2025 at 08:04:58PM +0200, Ingo Molnar wrote:
> > What tool?
> 
> mce-inject. The module.
> 
> > Or if you mean the MCE-injection interface, that's not supposed to 
> > trigger avoidable crashes either, it's an injection facility for 
> > testing purposes:
> 
> That's an injection facility to TEST THE MCE PANIC PATHS too. YES, IT VERY MUCH
> SHOULD TRIGGER CRASHES! That is actually a feature!
> 
> I have fixed bugs in the MCE handler exactly because an MCE signature gets
> injected unfettered.
> 
> > It's really simple really:
> > 
> > - If the kernel unnecessarily locks up on the receipt of a 
> >   hardware-generated MCE then that's a kernel bug that
> >   should be fixed.
> 
> This is not a hw generated MCE - this is a user-generated MCE signature.
> I think you're confusing things here.
> 
> > - If the kernel unnecessarily locks up on the receipt of a 
> >   software-generated MCE then that's a kernel bug that
> >   should be fixed.
> 
> No, it isn't. I can inject a MCE which will lock up the whole machine. And
> that's a valid MCE which can also be raised by hw.
> 
> > TL;DR, this is not an acceptable kernel response:
> 
> It is very much a valid kernel response. The MCE injection module allows for
> testing the MCE panic path with all that is involved in it, including the
> machine dying.
> 
> Yes, because MCE is special and it can and *should* cause panics.
> 
> So for patches like this one which is masssaging the MCE - and which is also
> wrong for other reasons - not every Intel uarch supports local MCEs:
> 
> NAK!

I'm solidly with Boris on this one. I don't want mce-inject to sanity
check, or second guess and "fix" the signature that I requested. I want
it to do what I asked it to do.

1) Sometimes I want to force a crash from a particular signature because
I want to check that Linux accurately logs the signature of the error
that I injected.

2) Sometimes I want to inject "impossible" signatures that can't happen
on any CPU today, but I know will be a recoverable error on a future
processor. That's how much of the early machine check recovery code was
developed and tested.

-Tony

