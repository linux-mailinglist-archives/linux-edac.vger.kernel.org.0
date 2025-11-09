Return-Path: <linux-edac+bounces-5421-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F09C44543
	for <lists+linux-edac@lfdr.de>; Sun, 09 Nov 2025 19:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7DECF4E0252
	for <lists+linux-edac@lfdr.de>; Sun,  9 Nov 2025 18:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2F233711;
	Sun,  9 Nov 2025 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="isp5K9TA"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0A223DE9;
	Sun,  9 Nov 2025 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762714659; cv=none; b=A7IXVWwDkvIJA/wcMhTrV57DrGVwaGJF9rL2GFGMUcjAI4j9P9hPFZWr8cKh+i5vK3B2vxA44nqZUd4FcL2hxpxGaGOZ+bcyurb9s34eMjIaZFAt+vzB19ilWsLGsCQHrgnH4gXMqUnpejgbVQNpmN/ZxHdBFlJl/7DVv/AuQxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762714659; c=relaxed/simple;
	bh=tWdohiBW0vQ+YoJpOAtqYYW5Re4gHHEuO78Su+UvrPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5i6+waCkmkYkAE6FJCeDq0XjmllM9wyHl1AYphBkPPR1YLfWj5Iju+YKfzxDehhXL1iVcqqmmNZg30kdD1bXpKGFi3AmHbJ4yV/rEHIjiiCne3vf8hc6xWs6UEkWzj52BUM5D7wWYEV4RZglm2Sv8hxO5kJXRZ6+3S/3aeV32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=isp5K9TA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 847FF40E01CD;
	Sun,  9 Nov 2025 18:57:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4OG3Ls-r7R1f; Sun,  9 Nov 2025 18:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762714649; bh=ywCxFm7Sew2/mTsMZVTicDfTh30bFB66ZcjbRAbJPYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isp5K9TAJxXzW1f4BdCBjiK21u1lZZM3Drmdb27md6kAVmh2MEFPT5ZpaLUNDKXy3
	 ntrok8SmTRj2P6BNHJRtdIKCXxX+X4HRekpvoZNfIbPie/70Guoyp8rfwi1JQQF6tC
	 v8LT9qo15JXJrqupqaocTuwqRvje+uoGzNrZn3jRwZhISSc0Sv8AW4DxwtUGxRZlzU
	 oYeJXtjDJwXtqEQeGtMAXBKKQQrDRZMmfd+H3vWY5m+V+/Q7Opr4I61CINf1RXEh63
	 iCIlAp2B8sR3/y69uAIneTwrJkpbHlPyRAlGzqzp6t0uGvXeRYORYoFeTR+euVvXaP
	 v81yJet4ZT7G8NwpJtGWrvrsLO3wSVN8WiQGGQBZSsGaT1pCYA6sE/g21OpN9cusF2
	 bubB0hJSPwP+4PMYfu9ZyROSzWPLKsAwuyqVc7Wba+TLRJmKVdTnsDC3xHWxBO1PQw
	 2qqNGb2p2Em1+w9IGBGR1nUhACAm1bR0Sci8eeHF9L1W7qjSUCIpZVqJWCI1JwDV1S
	 LMxyRI3hm2S88EdiRM9W++6hQC7Cq2r2IuwM5eF8k5+yB3a1yXGn9y2cDAqAkE69c3
	 pWwissrwZzcDHb9J9cSfmgiKvnayMe3Y0TlQI7wtEwpHK85Kvh9KSCXxJ9FY9BFVqj
	 Gj6ypwmk5DUr4a7IaFpKI7GQ=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 4CFA440E015A;
	Sun,  9 Nov 2025 18:57:24 +0000 (UTC)
Date: Sun, 9 Nov 2025 19:57:17 +0100
From: Borislav Petkov <bp@alien8.de>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Handle OCRAM ECC enable after warm reset
Message-ID: <20251109185717.GBaRDkDUVYCHa_M7aP@fat_crate.local>
References: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103140920.1060643-1-niravkumarlaxmidas.rabara@altera.com>

On Mon, Nov 03, 2025 at 10:09:20PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The OCRAM ECC is always enabled either by the BootROM or by the Secure
> Device Manager (SDM) during a power-on reset on SoCFPGA.
> 
> However, during a warm reset, the OCRAM content is retained to preserve
> data, while the control and status registers are reset to their default
> values. As a result, ECC must be explicitly re-enabled after a warm reset.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
>  drivers/edac/altera_edac.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Does this need to go stable?

Fixes: tag?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

