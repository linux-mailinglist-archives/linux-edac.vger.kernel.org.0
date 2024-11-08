Return-Path: <linux-edac+bounces-2477-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1DC9C2724
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 22:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3186D1F22211
	for <lists+linux-edac@lfdr.de>; Fri,  8 Nov 2024 21:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC0D1D0F4F;
	Fri,  8 Nov 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXkGgN3b"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071F29CF4;
	Fri,  8 Nov 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102256; cv=none; b=RySMF7S6mgAblHw+RVtdWu2h/kPdxVZ/lXtPu2DvNTt4fHg/D71bomKjssIP6EYbZVq/x/NziWNnGXcP2kuZdQC5kKBLpfs87H4DLDIbItfKwC6HgIxELEOTV14krmqTb+OEkJzrpJhKjfdt9MnfGT8xvh2XLA2cSln//L395Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102256; c=relaxed/simple;
	bh=VB+gY+PFxC4e1ZtPRzr2NzXsymkWcC8sVnNla/bXKII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs0d/Jx/7MU84bPqXLdYI14FlrlK9AQR+y2J3YJNX9UXo/b/piJW2NCtyifj7qL0w0HlBqkd/8kuSm2I8ukjoa3qsglOtmerKZMj+qgaXHRSgMe5vivXLJSTZSe3QK8Pktm2gH6g0CbYznYtNdYUZI5DtY4qxw9S1M3XZN/swU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXkGgN3b; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731102255; x=1762638255;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VB+gY+PFxC4e1ZtPRzr2NzXsymkWcC8sVnNla/bXKII=;
  b=DXkGgN3b/B7ylrAzE/2Tr/liwQDH+E0V0IFb2cnG1qmDcRe8tWvGKLdI
   TKUkw+V3C1dqX5wNayIg0SyH3DdI7tORpRZW2qBQK4/xhBbIx425Z5DqP
   vq8EKzo9ezLSKNFp9GhUpPo/VQ7f+TBFpIfQNAk/rqLQQezSCsdz9e+CC
   vBvUbmeE2/MDqioex3N6A3mUH9HlWV2dr6Skq3MTcBPM59RvGmMyeMD8I
   fcUXmW8Mvx1wzWcUoHJYfYAvdX+LO4lxjmENMzjQIlNNe1VaoGLx1w6bQ
   0unYtfRyIvs+4h9W3Su2tP5dv70sDk+n26FsN1jSab26pJCm/pZOeS4Yv
   g==;
X-CSE-ConnectionGUID: MBuAJYKoT1mFyIKoVyfVkA==
X-CSE-MsgGUID: Nf7Fu2OVQtCe/AtP6k8NiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="41623529"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="41623529"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 13:44:13 -0800
X-CSE-ConnectionGUID: X6qWQIdfRkWvXHg6LE3qyQ==
X-CSE-MsgGUID: l4c12TMDTuuLKNMdHduHbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90367888"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 13:44:13 -0800
Date: Fri, 8 Nov 2024 13:44:12 -0800
From: Tony Luck <tony.luck@intel.com>
To: Orange Kao <orange@aiven.io>
Cc: qiuxu.zhuo@intel.com, bp@alien8.de, james.morse@arm.com,
	orange@kaosy.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH 0/3] EDAC/igen6: Add polling support and allow setting
 edac_op_state
Message-ID: <Zy6GLJwyZCuGwdni@agluck-desk3>
References: <20241106114024.941659-1-orange@aiven.io>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106114024.941659-1-orange@aiven.io>

On Wed, Nov 06, 2024 at 11:35:44AM +0000, Orange Kao wrote:
> Thank you Qiuxu and Boris.
> 
> Here is the updated patch. I would like to propose that we keep the 
> edac_op_state as a module parameter. Because it would allow users (regardless of
> CPU SKU) to test different options on their machine without compiling their own
> kernel. I hope this could lower the entry barrier and make it easier for them to
> test IBECC.
> 
> Patch 1: Initialize edac_op_state according to the configuration data
> Patch 2: Add polling support

Applied patches 1 & 2 to RAS tree. Thanks

> Patch 3: Allow setting edac_op_state

As discussed on mailing list, not taking this one as there
is no real use case.

-Tony

