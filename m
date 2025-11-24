Return-Path: <linux-edac+bounces-5519-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BF8C80144
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 12:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A56C34E4602
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 11:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61952FD66D;
	Mon, 24 Nov 2025 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="E/haRFR9"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412922FD664;
	Mon, 24 Nov 2025 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763982339; cv=none; b=a6s6Iv+KcVZmdXTibXRMEDMKFynZxVbTfCl/Ie4vya15veOXXtE9kDr8XVuqkKyyqwuFCcLOBbn16B2Q5VoXmjMjgAZHYKIrLpPfVA6MmMba0a6QfGk9AWtKBuVddmmy63UsdmHSdK296ewN/QfxKmQgRUAEXWAfKJhw+fzH1Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763982339; c=relaxed/simple;
	bh=FUCrFs1knWBySwng67cPKnpD5ew/25w/avRvJcQ+hGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKFoik//Q2iL0fHXdKbLMEtgghRZ7RbMIFDOcD2EAkwu9v5YH3fS119ts0phmy22G8vQuS/e7q1ESozsp/A5tCmnbn3RQ6RIzRcOgFEhXtrztJJvdr5CPfLZRcyBwBkdTcGZ18WQPW396flJW00DM883e8S9V1feZz/PlPZ4w20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=E/haRFR9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B5A6340E024F;
	Mon, 24 Nov 2025 11:05:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ephWFZ5pTRG0; Mon, 24 Nov 2025 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1763982332; bh=tEyFkwc42j/i2mJxTykBu26rcP5vnqmiPGaEi5LMvqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E/haRFR9eUjFZYrJw3Hy6JSDaSyZ8m6YlI/T0keQO7AiLxake3P+p5cq4AAAaAmbJ
	 F9k0/POEFhdKPErNY0bmLs3WDYSDW+LxeVmKP+WvdBwbTnqBZRyjgDFWpunxztYwuM
	 KZUDfS6xVDQyiCcZaaOmHjJ4Gu4wFqzgYZWDm3ALYs0jbRRC+uRCk+/YlC3MB16AiX
	 lekmprSuWwiXqgDIDgvbSrwWeycksx4biPs1Jlf1f5fnPmnRisLHhGcWXuSOYhNezK
	 1fIKBlPYXsEAW96m4Xzx1Gz972Mc7yymdzX8g31f+uaFOgKDq+ILHmdFDUDkPYkX9W
	 X8j7eNdPl+N66+2K69ckBAh5+rVp8IpLBS8lyWFyi7zvy+PVkCc+Ze1LGuPGMpWvty
	 a1AKUygsp7ckHykROD+eNmDKE15mEO65oQko/36OihdnFbLnHT3TFmV11MdWPPBw3w
	 rjtNGhT7WBE2Sh6Q9psQCaY8k27asPeX0jz3PbolIcOkG6p27gLc07apeaAUWkKtGj
	 FX0RGsj16kMuhqM/HqvE9zwQD5z7DuCoQdnRflol0muRmRsnI3M2aa4eu6ehTBPVvU
	 yIHd0+DKNh0FLSMkiTT9q+l1C3RALuOlATblBs/+XtOPWVMFyNwyJdsebCx2C5632f
	 /3EdrxTVzgp5D80nUnNM8vrg=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 5D18F40E016C;
	Mon, 24 Nov 2025 11:05:27 +0000 (UTC)
Date: Mon, 24 Nov 2025 12:05:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com
Subject: Re: [PATCH v2] RAS/AMD/ATL: Remove bitwise_xor_bits
Message-ID: <20251124110526.GAaSQ79mo0yx1h1Xxm@fat_crate.local>
References: <20251124084011.1575166-1-nik.borisov@suse.com>
 <aSQeD-RSZxeuPj_h@google.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSQeD-RSZxeuPj_h@google.com>

On Mon, Nov 24, 2025 at 04:57:51PM +0800, Kuan-Wei Chiu wrote:
> > Both LLVM/GCC support a __builtin_parity function which is functionally
> > equivalent to the custom bitwise_xor_bits() one. Let's simplify the code by
> > relying on the built-in. No functional changes.
> 
> IIRC in some cases,

Which are those cases?

Do you have a trigger scenario?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

