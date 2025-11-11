Return-Path: <linux-edac+bounces-5434-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D08E8C4E454
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 013FC4E9BB5
	for <lists+linux-edac@lfdr.de>; Tue, 11 Nov 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DCA35A936;
	Tue, 11 Nov 2025 14:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bn0JuxZ5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C83AA195;
	Tue, 11 Nov 2025 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869609; cv=none; b=r/ZNnzzPtXN6qA/q2zXlSOfsqVxU8/QviZeZbhqdib0wbuQswRCEIjTJ7aWHHhCMJVw6Xm+sPDzYqV+/bLgwMTcALXCkHKacAi25m8BOR+p1XOwYPT3qSIQoLoyh4O3+ppVFpTP0ma+m/JEqldHouXOkd2uKulxqeLx/nDwHcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869609; c=relaxed/simple;
	bh=cF3UDCrQejavFDcic3XHyemHWcv82tiOF5VKo1Nlqfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJT54/RaTOsfj77Bu5cpJdVVdcQp6jakiP+iNQt/rpYIY7nu7AVg6+FVkUwplKgRZK6vstCKPRFT0aii56hwOElcuEAq5lrILHKuV7MPZzLrIPr5LSPSgB63uy2ErO149Ss/1afheO75hj/PLZBcLn7eXi6o7lexOmtoDdDEQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bn0JuxZ5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A44BB40E01A8;
	Tue, 11 Nov 2025 14:00:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gFB325oj--ej; Tue, 11 Nov 2025 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1762869599; bh=DVda1F0A/H/TQAbUvsduEWnI3b2Zm6i5TYT5FnHqBDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bn0JuxZ5crAkQ77fFPdkbaERlWl4ClYYZCINWvdeOGU+/l8JIutiaLNfOkJjh7U3+
	 4mf9LoJuELBn3bal34Ecs7yj7QmCzpMbSF7TboUFrilVwZCfoZkK6jBpg8tj9RGbO0
	 WX7LDvEr0QPTVvBoyUtYuHmeRD0XQzp4obrlbtz6gBRBqQv9u57xkM+TIsgTTKfOcU
	 BlJYSRLwFzmMxBtXjH6RO34tjkfY8AbNETCprlFe3I8/xbqiWxMl8zKjgfXw04i9dd
	 0sC0we9H6Cdi61vz9iuS6fgVf9Xat998iqLZOPu2FkjE/cKgtTy1upxLokHrJ6mHPX
	 59R5eg9CnXI/U3eNIY137hdanYLP0gj+qpRglr4gjT+YK1rTx3znXyv+/wBuq/XA/j
	 IHWOoJXVgX18ZVcRiNpew1zDkyb/IOE3Aqibc1pcgmA96ujbn57Jn7SRAgi3pAaZSF
	 ueTKIX1Yz2HFSoors6S7qGGcVtQo0tnDer03f1ZowunlOOgR+BifpIYJUv1k88b6Sh
	 ITdY7QyNsccNzj8JPg+LIsOXeud/JSd4MLDnE2WtrbisdMpo7fLo61ePi0pr36WCbz
	 i5WqCR3+N3ARju2cqMhFBm19W0xONK6RlFxDj4LJIlCuteFVXO8XE8Lu/KHFb0HTcw
	 wUPzKkkjwVfJBAaqvQzrSDsA=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 59ACC40E016E;
	Tue, 11 Nov 2025 13:59:53 +0000 (UTC)
Date: Tue, 11 Nov 2025 14:59:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: niravkumarlaxmidas.rabara@altera.com
Cc: dinguyen@kernel.org, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/altera: Use INTTEST register for Ethernet and
 USB SBE injection
Message-ID: <20251111135952.GBaRNBWEoHvOQKcEF8@fat_crate.local>
References: <20251111081333.1279635-1-niravkumarlaxmidas.rabara@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251111081333.1279635-1-niravkumarlaxmidas.rabara@altera.com>

On Tue, Nov 11, 2025 at 04:13:33PM +0800, niravkumarlaxmidas.rabara@altera.com wrote:
> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> 
> The current single-bit error injection mechanism flips bits directly in
> ECC RAM by performing write and read operations. When the ECC RAM is
> actively used by the Ethernet or USB controller, this approach sometimes
> trigger a false double-bit error.
> 
> Switch both Ethernet and USB EDAC devices to use the INTTEST register
> (altr_edac_a10_device_inject_fops) for single-bit error injection,
> similar to the existing double-bit error injection method.
> 
> Fixes: 064acbd4f4ab ("EDAC, altera: Add Stratix10 peripheral support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---
> 
> v2 changes:
>  - Add missing Cc tag
> 
> v1 link:
> https://lore.kernel.org/all/20251101051723.917688-1-niravkumarlaxmidas.rabara@altera.com/
> 
>  drivers/edac/altera_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

