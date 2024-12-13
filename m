Return-Path: <linux-edac+bounces-2712-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C79F15B1
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 20:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F61280A14
	for <lists+linux-edac@lfdr.de>; Fri, 13 Dec 2024 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FBE1EB9F6;
	Fri, 13 Dec 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="muk+wy23"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FB143759;
	Fri, 13 Dec 2024 19:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734117615; cv=none; b=AIJwfs85ze/R/tIsXtNY2v2rylYCbulTV2Cz13ibCxb/7MpuAxgL1YAXBe29XHU/MlIBZ5uursQIfTIUvH1bEmXn7gRk5uDsbUbeEdH4ADfnrNFzzkwXoUpMk8omJKWsUUJo+6ZFaj1S45OyhZFzyD8bYLUsFLrkThQ+fe4F1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734117615; c=relaxed/simple;
	bh=3c84IUkt6glDkOB8WUfsrG0h2gPK8RhuScV3B4H56ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULDBw21OZN0rX+qu1cf9ntYjhSOeNVGYzhgKX3vJ6HOh7f0fErqrzLQQs6w7TTqrauYJ2YNo5RqlFT8JNGRez+anQaQjb+2PiS8ffshoMvVDo8EWIGMSYLxS13DGezcxbq+eqxZVVoL9jShGRnLqlgz6x4OH6wzYP7CmScYdac4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=muk+wy23; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734117612; x=1765653612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3c84IUkt6glDkOB8WUfsrG0h2gPK8RhuScV3B4H56ec=;
  b=muk+wy23wV0djaR2TvsSJxrfr+LM90INMLGLS4goMkAvYjsH6wOCk1IB
   k4JpDeexACbQp3NESbCInGuS5IFNQL8E+NDE7xA/wtiVp3+2MGT/SKHgK
   ZX8DkiNfNSWdPw0KYOBUa41vjAZY/9/byDtHoe4SBzjICIO/VNC/jJRPr
   UUxFq5qzGF9BHNpCG9QOxpf/9/UVCKVOJJktnTZEY9MklRGhxUpBn7lmS
   5vYGh2XZdegORoX5ak93nh4Zz9WKhhCyYtWOApjOoUWCvMCnHaBPuHHre
   j4PIwT//4bcXLUO1enulQGRUiw+XtK381swuFae/9ur8uu4XbipGN1iym
   w==;
X-CSE-ConnectionGUID: +r50rPhzSTCUvTNACdIb+w==
X-CSE-MsgGUID: k2ScqTBZQI6++ZQWgUo0kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="37426535"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="37426535"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:20:12 -0800
X-CSE-ConnectionGUID: T0/wGWnkTVuZMGcZ2ut1sg==
X-CSE-MsgGUID: gxKlCyJHQa2beiyQ0Ltc+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101583187"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:20:12 -0800
Date: Fri, 13 Dec 2024 11:20:10 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	qiuxu.zhuo@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/{i10nm,skx,skx_common}: Support UV systems
Message-ID: <Z1yI6pEkamCOx7U9@agluck-desk3>
References: <20241213012549.43099-1-kyle.meyer@hpe.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213012549.43099-1-kyle.meyer@hpe.com>

On Thu, Dec 12, 2024 at 07:25:49PM -0600, Kyle Meyer wrote:
> The 3-bit source IDs in PCI configuration space registers, used to map
> devices to sockets, are limited to 8 unique IDs, and each ID is local to
> a UPI/QPI domain.
> 
> Source IDs cannot be used to map devices to sockets on UV systems
> because they can exceed 8 sockets and have multiple UPI/QPI domains with
> identical, repeating source IDs.
> 
> Use NUMA information to get package IDs instead of source IDs on UV
> systems, and use package/source IDs to name IMC information structures.
> 
> Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>

Applied to RAS tree for v6.14 merge.

Thanks

-Tony

