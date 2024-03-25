Return-Path: <linux-edac+bounces-796-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0235588AB71
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 18:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805072A5185
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 17:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436612BEBE;
	Mon, 25 Mar 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B5wfkvw6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4383DAC07
	for <linux-edac@vger.kernel.org>; Mon, 25 Mar 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711382923; cv=none; b=ebZyEinG18UL7rhPI/alEQiPQyGrXk6z00o3TM0MUfDiSqByt0noYTH2j2swUd5+7HHx0nuG1tAABOSTiLUtrO/2zU16ZonLkp1zc49tDKuzBoOHA9OtSkJW9kB34c2nvl4K0jhkG2ny5DRNhJ7otmOOc8971Kg82bsj1mqHpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711382923; c=relaxed/simple;
	bh=PYvqjJQxGy39yH/MT1j6FzDuj+AAeO5xx4RSCg8cqlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4pjyg2o0Bylun6hQ1wmGnvwED1m7wJ0Bxi17M3H2LoLP+1EmpmGAwEdp7/AuwsdDk4DmLQwaYfx4Vq7oXYNMe4rhRnwGfY4crlRcWVvkvTcltE/VqCFks3Ika0QiMMuXMcLa8LeD4di17P1rvXH49HK/OIgkaYCoCCxcXvvEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B5wfkvw6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 34D4C40E02A5;
	Mon, 25 Mar 2024 16:08:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id crsagB8me1iw; Mon, 25 Mar 2024 16:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711382908; bh=/Y5fX4+b4LYkI5nrV5QUpuPrGMTbxR+xzJnLZhMHclY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5wfkvw6mPpj7jwVmwJYM3DukMRCURmeHnN/jwYNDjsd0hHT3PWhX0Prgo3iuMmyq
	 ilXwITpFISsXkk1eO3NEPCdIpgpxrHcdatmFgoIUMOxEyI/kbAc58NbipmBxVQSYDu
	 6I6cJ9RCZq2nvFu5T+xi/mUTUKEVYoG8cW3bhl6xiQ5DEYWfyPXpt0mq28AY/zt1bY
	 xB5B8dYaJeX9khqv1iUHaovMWE2XVhlNFWUAv8JD83hNILAC8BIVrL68Wkw7/clKXI
	 veW1sulJtN0VD4/wD7zy3VW9yVoqjRFWica64ibpOI22dbyHUfM6mR9/sVKBc5c+p3
	 DWtFWBBlzkmvx3TTqs9mJqoMKz4m6huqyJ3febfSF6T/eboxdzG1TqOS21Pt/6K2l9
	 ern21rpVxOQEJrSubrPEzn3DR4rEsytTInE08KUQWf68q/A2KiFeVtA0pbxWpkZAmw
	 px90zirqVTN/o9xQZfOs0YzORm3lAa7bgwlNX1D8OGu8QOdxrcPXAqOqZ5JDNNyB9A
	 hO7xCQa41Lvxa4poO8JYzd70WztnSW6uLhOpX/ZkfSY7Z7pbNa6ISKTdoJsKK9VOn1
	 PRMky/pHHMdvKAVbz+mY0PlicCR20XKQPlXtbA4QddE929EbBeDfa7b96IxnDEO38d
	 vllONxRkSb9lnwsuMuV9B3G8=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4F52740E016C;
	Mon, 25 Mar 2024 16:08:25 +0000 (UTC)
Date: Mon, 25 Mar 2024 17:08:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: A <akira.2020@protonmail.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <20240325160818.GDZgGhcpLu3uks_K9z@fat_crate.local>
References: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com>

On Mon, Mar 25, 2024 at 03:10:25PM +0000, A wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=218640
> 
> kernel 6.9-rc1 fails to compile if debugfs is disabled (CONFIG_DEBUG_FS):

This should fix it:

---
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..41697e326fa6 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -37,7 +37,7 @@ source "drivers/ras/amd/atl/Kconfig"
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
-	depends on AMD_ATL && ACPI_APEI
+	depends on AMD_ATL && ACPI_APEI && DEBUG_FS
 	help
 	  Support saving and restoring memory error information across reboot
 	  using ACPI ERST as persistent storage. Error information is saved with


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

