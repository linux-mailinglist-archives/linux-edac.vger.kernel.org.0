Return-Path: <linux-edac+bounces-2650-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1519E6188
	for <lists+linux-edac@lfdr.de>; Fri,  6 Dec 2024 00:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7672A1885048
	for <lists+linux-edac@lfdr.de>; Thu,  5 Dec 2024 23:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECC41CCEED;
	Thu,  5 Dec 2024 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gx3MfDgW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF781B87CF;
	Thu,  5 Dec 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443087; cv=none; b=PxzBHxFtmxhHNdBFgy42YKwrSAjMMPA3l9u41rDQsvFihmT2FyC8FPGxcy7G8IvLsktdu9cMyX8Z/Eb32uH8UJrIw5YkXCeghpDUZi7dPzKokRPfPSRpEvYQH5/rfGZFg0Qwrziieq9yrJlMkNLQTRYBKwJPmQ4J/DEuAdK5PRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443087; c=relaxed/simple;
	bh=oejPmZfiU+yzXoUlUAyLfIeavFDw3xEbiKLSwA4lQo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwjUlaHW522bBkfInSCh4oyEM1VdVXRRvw6MLZjQwZt/RKN18Wuf8JQgjNDdYMrGmLAUPCNRSAvWhbPz6XjLEYgfow8NBO5Qfmkn/Af+G2A4CbQcQ9h05aMyqz9aq7sU7Mu22oCRB33ZJfAKreCaoFM0pAWJLdiobj3LTMCNnTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gx3MfDgW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733443086; x=1764979086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oejPmZfiU+yzXoUlUAyLfIeavFDw3xEbiKLSwA4lQo4=;
  b=Gx3MfDgWFntBqUpujJ8EzRphjdcxADAYRs4uxs/3l1g3JRhXBoPX8Rqi
   f75TqU6AlkWPCR2h4DeoWqv6jtK9hWPfBmpJnHuyTRYVDe55+z10p/8R5
   dZiPpma/OScyxMR3OetXmSRwy1PMvD8XY7cPuwxv/c1Y0HtyY+/zzB7wD
   05R9HXPYOuR1G/Jm+w5fzOp/G8OSFJLJKETNrWHiphjvUh5BKR0irtfai
   Ue0Norr/gHNEJeXDRS5e5Ycz3q/ZEl4jlsaXwyRK5whGQDUvQFIlXhehL
   +DRN63eFE4pTbQgDbTDYfB8LpAriLk0OQPhNyfbegJF+9lCaPRUkVRSb/
   g==;
X-CSE-ConnectionGUID: 0t1Ba/QlSBqo7g8ZkKx5qA==
X-CSE-MsgGUID: SCKRNA1LTyKhbsQG5ZUn2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="44450046"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="44450046"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 15:57:57 -0800
X-CSE-ConnectionGUID: WtLJ5Hg+SciRMkACH3pS1A==
X-CSE-MsgGUID: g2nWHwQKTniFFJkqnjXNXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="99322997"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.70])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 15:57:57 -0800
Date: Thu, 5 Dec 2024 15:57:55 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Kyle Meyer <kyle.meyer@hpe.com>
Cc: bp@alien8.de, james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/{i10nm,skx,skx_common}: Support multiple clumps
Message-ID: <Z1I-A0Rhc8AHhvtw@agluck-desk3>
References: <20241205165954.7957-1-kyle.meyer@hpe.com>
 <Z1H7U9-O2LdAoa5r@agluck-desk3>
 <Z1IHkBlm_0p-0-c3@hpe.com>
 <Z1Iuk-_VdmZibOes@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Iuk-_VdmZibOes@agluck-desk3>

> +int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
> +{
> +#ifdef CONFIG_NUMA
> +	return skx_get_pkg_id(d, id);
> +#else
> +	u32 reg;
> +
> +	if (pci_read_config_dword(d->util_all, off, &reg)) {
> +		skx_printk(KERN_ERR, "Failed to read src id\n");
> +		return -ENODEV;
> +	}
> +
> +	*id = GET_BITFIELD(reg, 12, 14);
> +	return 0;
> +#endif

Doh ... I alwasy forget about IS_ENABLED(). This can be written:


int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
{
	u32 reg;

	if (IS_ENABLED(CONFIG_NUMA))
		return skx_get_pkg_id(d, id);

	if (pci_read_config_dword(d->util_all, off, &reg)) {
		skx_printk(KERN_ERR, "Failed to read src id\n");
		return -ENODEV;
	}

	*id = GET_BITFIELD(reg, 12, 14);
	return 0;
}

-Tony

