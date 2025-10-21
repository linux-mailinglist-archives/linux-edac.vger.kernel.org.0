Return-Path: <linux-edac+bounces-5140-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5684BF5DC5
	for <lists+linux-edac@lfdr.de>; Tue, 21 Oct 2025 12:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A425481EA1
	for <lists+linux-edac@lfdr.de>; Tue, 21 Oct 2025 10:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C316D302175;
	Tue, 21 Oct 2025 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bG6/rDWu"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3B2F0C69;
	Tue, 21 Oct 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043479; cv=none; b=QhSLODbv6mUH9yNCibpTjLSCP60Iy47kQz/4+5RFd2Q9cokwPicVF/ZOcY4Q4A4WiPNa6P4ybPi5HYkE2MjsY94d2YR/4XhqWeV5ciYWaCl0Q6wS5TMOT9P0aR/5PI4gXwRA3hr0eH/+7BtkJwxP5SZP1VzgX2m2kM3eZ2uR/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043479; c=relaxed/simple;
	bh=KRKKmkFJi2z1BcckbU+ZR4KrZLtsUoH7gxbrKeKbito=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIZnWBkqo8WcRhmjMH2YPkKjuMxEfnl0+o+FfaE1GJC8oqqztL1ubsquJgi3/oZ7NXlSWXMwsUq85ytoJO5s/NpzGrsRDkcd+rElYpwEAhq0iba71rTL8Ul3dOQxRFDO281KqJf8mK9PNb3UlVKw4abDJYHJkqbnZ0v+hITunlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bG6/rDWu; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF5B940E01A5;
	Tue, 21 Oct 2025 10:44:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XS7uMntxds9i; Tue, 21 Oct 2025 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761043471; bh=vcAcaY8tAMdjeGDuJadY1T+wi0rEYZwZPsznqnpzds4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bG6/rDWuk82NAIW2mYY4n1ciCS7ue6hUFpbCnlifz/Xrbv2/n4DAlBEAHrSmm4JVC
	 TBMeIJi6W29TKxBQNnzIdHUBVJ50HkUNKqdAGZRcTuXsVvWe7SPzoGh3xuEn+oBK5o
	 HVjphkWJPScAWwNVOud2iAy34JCeoFEQlsJt6OfuPrrBXIByZPaEzUmMnZYyPuVSQU
	 HX/P2Cr60e0cqp36pDF4XbhquY8nlJ4K7OXYuHnhhPi+PYjYq5cgwTHYHLwgOgmgRm
	 PQ1MDiQULX2Ef0k+ODuj3jKPVW3myIhBqmiFkowPBm+8WkC7rXD2tr58JUORUSS+Mp
	 uf4qU8rImTBbSK85TCmv7vuaPddzqjEOfMKj2agRON164KOYn3AAJ2nPM+3JVlNHdw
	 h1aucL5XC9pC33/s7ISyA+HHtI93ZjwM+Vt/qPn9U4JUhtRc2fXGXlIEM+CBgOn2Gb
	 dG75zcAqKS9lkN2/BGeDb+6jWhZoTovwBGWn4YVSLHEi5EbnXuBZu1I+YYk2m30Xvs
	 jj3i8/9045Ef9WoFd+ZOGNvk2n7Ayocc5yRlCpDVMokNbeEOBFOWXF2LzuKVXKu7Sd
	 1bNiHtvvytCuq9jUd7GVjPtIGsVHQN33oRSxaIN2D0M9UhnEfYrXBNcKZIDbtzfVQH
	 HAdmn+I4Pqnlt1FpDdSpiUSA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 41AB440E00DE;
	Tue, 21 Oct 2025 10:44:27 +0000 (UTC)
Date: Tue, 21 Oct 2025 12:44:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] EDAC/amd64: Remove NUM_CONTROLLERS macro
Message-ID: <20251021104426.GJaPdkCgb5JjXqvSZz@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013173632.1449366-3-avadhut.naik@amd.com>

On Mon, Oct 13, 2025 at 05:30:41PM +0000, Avadhut Naik wrote:
> Currently, the NUM_CONTROLLERS macro is only used to statically allocate
> the csels array of struct chip_select in struct amd64_pvt.

"... is used to limit the amount of memory controllers available per node."

You don't need to explain the code - think big picture.

> The size of this array, however, will never exceed the number of UMCs on
> the SOC.

Not on the SOC - the thing is per node instance.

> Since, max_mcs variable in struct amd64_pvt already stores the
> number of UMCs on the SOC, the macro can be removed and the static array

Please describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

> can be dynamically allocated instead.
> 
> The max_mcs variable and the csels array are used for legacy systems too.
> These systems have a max of 2 controllers (DCTs). Since the default value

DCTs are DRAM controllers. Do not confuse the reader.

> of max_mcs, set in per_family_init(), is 2, these legacy system are also
> covered by this change.

...

> @@ -347,8 +346,8 @@ struct amd64_pvt {
>  	u32 dbam0;		/* DRAM Base Address Mapping reg for DCT0 */
>  	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
>  
> -	/* one for each DCT/UMC */
> -	struct chip_select csels[NUM_CONTROLLERS];
> +	/* Allocate one for each DCT/UMC */

You're not allocating here anything. Just explain what this variable
represents - IOW, the comment was fine.

> +	struct chip_select *csels;
>  
>  	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
>  	struct dram_range ranges[DRAM_RANGES];
> -- 
> 2.43.0
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

