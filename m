Return-Path: <linux-edac+bounces-2183-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575B39AB4A0
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85DD71C22546
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 17:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ECB126C00;
	Tue, 22 Oct 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q9ef2jN9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA3256D;
	Tue, 22 Oct 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616604; cv=none; b=gCinzwTryx1E/Qbi7DxlDu3CEmQ1lwKb8RVt5StAGUxXSgukIE2jKECr3zk4muJN8tRh4zOXdtXNpEwmq4e08Qdkvu6GFr51DJL13WyYubxCs1IPcUoyr3JE6u3jHksIFvJ8vBAiRfunhDbuDjAs95e0B3viTXO0Kpou12OU9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616604; c=relaxed/simple;
	bh=48ceQE87rmV3uOiD9dvWI67NHf4mh/d8CQCgLH7LkTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4SpM8ZkWfu2aa0gursKLFbjdzBvHeqzdU6mTHiuVGpNls6ZfXZcF/VOx2z3vNOhE8nX6MvEiqW+hHjms1C1jkEQkVgKbuJ9u9Kgkrr2HU4OS1GJ8qWUlzsGiUVDYodRh4zy5SCa0gw2De4r/ks0CtLGuYrX0DfRDVZckrnANZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q9ef2jN9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 923E040E015F;
	Tue, 22 Oct 2024 17:03:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uXYWye9f5smU; Tue, 22 Oct 2024 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729616595; bh=xSDNfr4pRCD8cBUjcFOrM0JXRl9/mMkSbY9Aw6Cavq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9ef2jN9C9GOH2Gp+juq7uZGPzYCxzljD9813514WE1nO++GfFlax2khDe6bYlyaI
	 ofZCIFLjRzyrFcljfpSd3leuLNEV8qZPnocS85sSLPiX41rksivZvdfCyESUEZLgY+
	 cKNR3+J0HRzb6cmLD4k6m/qecd9Taia5hiSMT1M7BYZxzAaKMbVAjJCDWWPvr+i9k2
	 qRjVWvSv9rpk6VPR8Feez0G6a40l3d1raxo+G5z5SDNiUKbEZvCJvHFPJi3CoDH0Xq
	 mmUDEApc9M3XpSTJUNVlXsbuwrGbfLcoeRmS7pzVOLa0UPvrFdg9l2CC9dU92gEOHz
	 OSfroRSZ2INA9hotc1A6SLqEXNuVhxNGlwGFTkQCxDagrKxacQ/OEh1NMGxEaXx6Q/
	 ZglIA1XG0bVEvxtKCayOPSahFJklobas8RGunn6eQr5Dyi108t1ENvPH2Lq0LHviZn
	 /QGt6iPuT4A3JshSVLcK8/NYBNjpWWMoUMrMtjnXk78OW2qWAWzBY3KQpZroiepaR+
	 TaRYtn512ZWCq6Xeve5gyDWNWpZYs4VfCo8X62n1+wyCnse057jzPQ/8K8ltVEBz+B
	 nuB6EPOq8HeykNz1D93x1H84S00w+nivkkRHddliuNpFXMAiQjjPIf6WvJCERiDkmL
	 vifkh3OOJHvD54LPEYmQaXRM=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 969B540E0263;
	Tue, 22 Oct 2024 17:03:09 +0000 (UTC)
Date: Tue, 22 Oct 2024 19:03:03 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Add debug prints for DF register reads
Message-ID: <20241022170303.GLZxfax_-72ZCX1I_q@fat_crate.local>
References: <20241021152158.2525669-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241021152158.2525669-1-yazen.ghannam@amd.com>

On Mon, Oct 21, 2024 at 03:21:58PM +0000, Yazen Ghannam wrote:
> The ATL will fail early if the DF register access fails due to missing
> PCI IDs in the amd_nb code. There aren't any clear indicators on why the
> ATL will fail to load in this case.
> 
> Add a couple of debug print statements to highlight reasons for failure.
> 
> A common scenario is missing support for new hardware. If the ATL fails
> to load on a system, and there is interest to support it, then dynamic
> debugging can be enabled to help find the cause for failure. If there is
> no interest in supporting ATL on a new system, then these failures will
> be silent.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/ras/amd/atl/access.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

