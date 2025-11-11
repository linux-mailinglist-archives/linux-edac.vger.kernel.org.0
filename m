Return-Path: <linux-edac+bounces-5433-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ED0C4E45A
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 15:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F061881C14
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C9316199;
	Tue, 11 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b3P90+u6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F824BBEE;
	Tue, 11 Nov 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869445; cv=none; b=G5d3/FeVrXX5MuMsQRmu+EffVQsrFNptni43exlJ5oYpA7PGGsHZh+eHR3VIqdCVBZw6AkEC9BeY0BBOubTNS4aavep23mKaW4FkBVUz0du+oZtahI4wcVvjUROBqGJTxdGaeAqrJ2b7W1rWVaeHFOnzG3sO/CYP4k6PsypK3Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869445; c=relaxed/simple;
	bh=82zFOf69YrAPAZPT1fW3BRGUdwoc3ddlAzglfA10f0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGz2nMYbWQXdB6V+xK101BHDfwFuAeYA8zLcOHWFkifCnq2RHpKvgkpqKMGxJWH4x/JaQm+hBJR6EXtB8ht8i9nKo9lZIL93B3wPjcE2G3W+peFz2N2m5OpFJvkzUx65nXtokmIQ74K0PzT1eYhR/3rkoaSAHjLJiRVtZS2sFX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b3P90+u6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B3CE040E01A8;
	Tue, 11 Nov 2025 13:57:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dBl5j7drqK4S; Tue, 11 Nov 2025 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762869435; bh=yFYPj00/CHOoaV91us5enSo+LFVq2ShlbypiB6fj3Vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b3P90+u6VmkFQjWirrw8CqYASk8qrWh9OOtzN0x5Hy7ZegQE3B4uIgbhFgxp+xAm7
	 NWtLGSqglCVGMbcBBtfoqv48NXsbaN7ZaAACAh470EpMN7o7Vn4aa8OBYpviA5MVwj
	 KkL5hB6HYVOC7ZMblztGVKTlTrkSjHOvmgN/LIkuSweKb3Ky6gwba4797mD3Xme5UO
	 VsBqUUMFaGUM7SKJ68VJ5N6YTzCppB3pxkM065ruuoWrBc3/QqJBS1h0HyPCZigJQZ
	 n6ZJXr2w9pCXtfl2Z69b3a9KGwLKQoZmlCvhSL8xQPaihmtJoigKX2Ql1SQJKXctIJ
	 slweN4MXqJjwm3BqgwAt9FH7VYbauP3mMVywtIvv7aM9A//Z9Kj5+ilSOS7Gagcad4
	 n/TjRJe9XMDg/3ogOQC0Eg8WevR6o562dVg07sFnPAh/5562wYjT2Vpbi15eFsNYnq
	 nuuNopOciCG595zFOUSFtMkIGJCs6nr6KctCuPa2WNW6UuqgglFAEKVEdCjx2kPlL6
	 FoXzTnRd+MpJDFan0Vaa76uVQ4Sm606Tf0m9Gamn4P9NNF600VuXp4+zjgm1Kk0F59
	 KgDJpzyQ8EcZce8CEYy/kGafGkzz9adNAmZMB7OY3x6e0XQywmpw4HZqXJLaaZ99wh
	 PS6pclUmgtPwxtYjfDRlY0Z0=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4428440E00DA;
	Tue, 11 Nov 2025 13:57:09 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:57:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/altera: Handle OCRAM ECC enable after warm reset
Message-ID: <20251111135701.GAaRNArTV0h_lS8MfL@fat_crate.local>
References: <20251111080801.1279401-1-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111080801.1279401-1-niravkumarlaxmidas.rabara@altera.com>

On Tue, Nov 11, 2025 at 04:08:01PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The OCRAM ECC is always enabled either by the BootROM or by the Secure
> Device Manager (SDM) during a power-on reset on SoCFPGA.
> 
> However, during a warm reset, the OCRAM content is retained to preserve
> data, while the control and status registers are reset to their default
> values. As a result, ECC must be explicitly re-enabled after a warm reset.
> 
> Fixes: 17e47dc6db4f ("EDAC/altera: Add Stratix10 OCRAM ECC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
> 
> v2 changes:
>  - Add Fixes and Cc tags
>  - Retains Acked-by from v1 patch
> 
> v1 link:
> https://lore.kernel.org/all/20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com/
> 
>  drivers/edac/altera_edac.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

