Return-Path: <linux-edac+bounces-2723-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5EE9F37B2
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5797188CC8F
	for <lists+linux-edac@lfdr.de>; Mon, 16 Dec 2024 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B8206F33;
	Mon, 16 Dec 2024 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RMyaWbXz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655B206292;
	Mon, 16 Dec 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370580; cv=none; b=lagGrXjVWcDlU1Z6t+PDQx3J6bn/L4t+gYXEYjfl2YAkQVTV3jowb6EOuBhnyXlbsQqP8m+nZjU2oiAcIrZJEEBClENcNBXdgFS6DO7dG6eeyfBud4c7HnTg1yCwyfmo0fOliWLx9AC7DbNcJ4bq6ZnLNodZYnehn7IOdMyl4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370580; c=relaxed/simple;
	bh=HQlX5QcN3LULNLsRgFueaLQVJ4Y59POfGgRmYEiR20w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIW0zNM3JSe9QvzLOTYvY26Rx7fuCKbKs7m0D4f9MFkOP2+40B2TvGRNcnRog3B1bm4JrbluSkrjTThKo1IVsnQJD5LOIjD9RaInsbnCvPvjfT7OWQ1Ff4s5MBCV3eG2R5uA27vgqo4HWATPPuSFIbHRjq4dBaOkG4CpCRXBrDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RMyaWbXz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E063E40E0288;
	Mon, 16 Dec 2024 17:36:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7ppOtJOUUgS3; Mon, 16 Dec 2024 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734370572; bh=fy2fgVOuE6HjcQ3MoRX4MOKm4dF0bd+wZODMxhqTZEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMyaWbXzDeKGe5R4LKOY5PcIeohO55pvhY2+fT8i2F8nxNrqGaw32iK1fWF8mbscC
	 nT/5CsvkNj1afpNWTEXPpW0+DVq38gBXc4FEEOCmLj6xF4UuxxQ6eBAFSMEdqPuzEa
	 cO2QnVZJVdepMb+5cRYD6zVUzv1X9Q+XL0n0vo5V6LD1RXI79gpo1L5rpW+IxAH5ki
	 fnaHojzeAOLdKpP/ezurlGCKWqTlnwp/69OAtyvwsYnZdzUATWEp+O0Ypt1fIc4B09
	 re27fpfKCouka069R/YKVSL8A25bjeY/al6ahW77ovbBHYDgd0J+EvogO0jWBOebhv
	 1YMmU1jqMI6xd/8K+ULZueYfeS36bLZLOV5J05Y2Vlpw8gus6NIEUk1ZtKYtcES9JU
	 dQ39CX8aZZQ1xWi9BXv/tvp1Ul3WZRl6CKpl4uRGVZQRhxZOMBUiLomByuVA3DdXdD
	 WbwZQBhJepfxer48DpqjQYA/mRC64b6WQJWfCppfs/lyawwCR/QUPesWbAo7NJsW7M
	 8eoRt5oSNq/J3WtIPoVdVb7jaFM2XDH+EY3ZHUUeBWEEeZVzzUop3XJlWOrBBqngSv
	 fdTLoSuE7ge2tElu6gwpbz6baukzUraVV3395pkBLaUI6AdHkHcM9S52GTVl+LNmrs
	 8dUwskvH1ULi1qY9AN33nvTo=
Received: from zn.tnic (p200300ea971f937d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:937d:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5966940E0289;
	Mon, 16 Dec 2024 17:36:06 +0000 (UTC)
Date: Mon, 16 Dec 2024 18:36:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: Karan Sanghavi <karansanghvi98@gmail.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v3] RAS/AMD/ATL: Fix unintended sign extension issue from
 coverity
Message-ID: <20241216173605.GEZ2BlBVnuOZRsPT95@fat_crate.local>
References: <20241127-coverity1593397signextension-v3-1-60dd0c4287ff@gmail.com>
 <20241211160113.GB1923270@yaz-khff2.amd.com>
 <20241215181557.GBZ18c3QJw8-7HWeSD@fat_crate.local>
 <20241216154358.GA460991@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216154358.GA460991@yaz-khff2.amd.com>

On Mon, Dec 16, 2024 at 10:43:58AM -0500, Yazen Ghannam wrote:
> Right, the warning is highlighting the implicit sign-extension, and it
> doesn't seem to be a functional bug.
> 
> The 'temp' variable in this function is there to avoid these types of
> warnings. But the 'pc' case was missed.
> 
> What do you recommend? Should we adjust the code to be more explicit and
> avoid the warning? Or just ignore it?

If there's no way for this to happen in the current code, then I'd suggest
to ignore it. Tools are not always right.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

