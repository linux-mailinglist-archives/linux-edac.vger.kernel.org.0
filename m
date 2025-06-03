Return-Path: <linux-edac+bounces-4065-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A06ACC2A4
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jun 2025 11:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98BDC1892223
	for <lists+linux-edac@lfdr.de>; Tue,  3 Jun 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C729280CE7;
	Tue,  3 Jun 2025 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OtHV+BUx"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29B727FB29;
	Tue,  3 Jun 2025 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748941559; cv=none; b=YLfnqs5M5cS5fNwltT2c/iRO8IYJp1VcWC3y1eSHjRMRAs161zBjDRlTKKCrRK9peIiK86Jm6Ny/tbGteftrCO07rv7OL3ORT3aPBMliCuOZX8qd841RCrvNO7mXlgmaNnbLFLJ5Oc4LDqzqGMXvrp/QCGSqg8BID1Ix3CXjhGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748941559; c=relaxed/simple;
	bh=DR7AQjMWleAsYDwxcMyXNFCZmaObbc7AOpQv2aK2wPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFArH28vbxSGdsjtSuk9GzesekonbOp6+wQ64DhC+/tea0JlM9M7Sb/ihTlqICuCNfclmt1s/s+TLb4+Me69YkoRepTW04fEj5jUZFb53+zp2ztz98z5iLZhEXrcaX+pAmWc+DQO8VPjmKRddTayJ24nCyUtTFb+f1YtafbeJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OtHV+BUx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F3C940E01B3;
	Tue,  3 Jun 2025 09:05:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K0iu0KJE_bea; Tue,  3 Jun 2025 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1748941548; bh=+QaxPVYGiWt7mB9m4DsoMvxZpkgJLcaRJ1KKz+wbYdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtHV+BUx7HNlS6dpAM95SE7mQGT3JdPGXqWH9wtCmvdAG5a1RhJms6YNo31fyxMUu
	 rP3bLzG2FjNXsiATg3WpZBEnYdAl9FpTY+nPbbCB8FphKglfKV19oW6zn5ja8AhWYV
	 5l6ODc2SeqvOXVtQ9qnzpdwvNnZvoIHdR2KrrSz5rnsrlZKni7kLND2Jn+x+NXIFxs
	 8ZYTPfuPZFPdsdYQoh1a71DpZG8v/4T0WhiOEX3MiurVswt8syEoBYfUaF5/j0Ko9Y
	 4NCGy3NxeuUXg5HpcLNljXAbRR0axrsOsqhidwrF+FaMEMIfbU2sugPTSbKrwVxwZ2
	 I1ktLXpthcIkkAQWcrrq8LnHYtDdILR/4UJWExCzphWQFrd4kceO2ZEygQbOq0dn0G
	 vJu7Iuvn6vyP9PEzfU8cQhMVVL36Wc8AvX0WukfhOKj3TZsveK0GRbxCbQFI9YoNbz
	 XjrbxWsz+WNPrrO7E5jPgZc9N2wP5reYeAurbNbkTKVtSUY1dr6+ET3e3oscFOiiwT
	 QOXkN4StUOJFviC0ADcjz7qncNkKBHKPbTDtyYHSO9CilwRiYQHUVxDvqFXaOFcWIk
	 EJHDDXyoEWiQlIXAmv8Soks8UqyLfu9J4VbkcKn6i+brb/plhjQufJ7XjXezAaikpB
	 0+OIy00SRzXfKUgUmlg21waw=
Received: from zn.tnic (p57969c58.dip0.t-ipconnect.de [87.150.156.88])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9A1640E0163;
	Tue,  3 Jun 2025 09:05:37 +0000 (UTC)
Date: Tue, 3 Jun 2025 11:05:36 +0200
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com,
	Michal Simek <michal.simek@amd.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Message-ID: <20250603090536.GCaD664IbJB5IoR06g@fat_crate.local>
References: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>

On Wed, May 28, 2025 at 12:26:50PM +0530, Shubhrajyoti Datta wrote:
> Subject: Re: [PATCH] EDAC/synopsys: Clear the ecc counters at init

s/ecc/ECC/g

> Clear ECC error and counter registers at init to ensure a clean state
> by clearing all ECC error and counter registers before registering
> the controller with the EDAC framework.
> 
> This avoids reporting stale errors that may have occurred during
> boot or prior configuration.

Run this commit message through AI and ask it to shorten it and write it in
imperative tone.

> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
>  drivers/edac/synopsys_edac.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 5ed32a3299c4..ebd2d6e771a1 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -755,7 +755,7 @@ static bool zynq_get_ecc_state(void __iomem *base)
>  static bool zynqmp_get_ecc_state(void __iomem *base)
>  {
>  	enum dev_type dt;
> -	u32 ecctype;
> +	u32 ecctype, clearval;
>  
>  	dt = zynqmp_get_dtype(base);
>  	if (dt == DEV_UNKNOWN)
> @@ -763,8 +763,13 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
>  
>  	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
>  	if ((ecctype == SCRUB_MODE_SECDED) &&
> -	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
> +	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8))) {
> +		clearval = readl(base + ECC_CLR_OFST) |
> +				ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
> +				ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> +		writel(clearval, base + ECC_CLR_OFST);

A getter function clears registers and commit message talks about "at init"?!?!

This looks like a hack.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

