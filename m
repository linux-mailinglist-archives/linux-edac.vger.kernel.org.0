Return-Path: <linux-edac+bounces-3093-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBC0A37576
	for <lists+linux-edac@lfdr.de>; Sun, 16 Feb 2025 17:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A661884B24
	for <lists+linux-edac@lfdr.de>; Sun, 16 Feb 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DE1990D9;
	Sun, 16 Feb 2025 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PEFfnEHC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D89194A53;
	Sun, 16 Feb 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722275; cv=none; b=COddczwegI6+GhWnmFS+smlztb7ZXUi406kURvk4eJwxfNw2Xo3MhcBgNtlL2kHOk2OuyVqdRJkPz59g3rjSTHZD4vkcuJ+9PS/cUF7rLeWjkKa05L7x7Ea/JbBLI3ccYMbtNlRpxFEWlMv9uQJTZdJg6+azTDMhEU8LaPvHtn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722275; c=relaxed/simple;
	bh=5d9qWiM6oV4TkIef8p61OFJAOWXEpIu/WUmR93U/7UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RX/pJqYKVAQ+eh57fhQVBKw25gKJf8J99dLQ7zvrt1M0NEqeovjchJaKqbrGm9YcjhX3n8A54YtjTtUgqilnmrl6oGnllfLqm/RH1zDEZpvc5Ug7o3vH040hj86jMUvXDhqw/3K1bQg8BB0psaf+Ixx5NgC4b0mkrzrJHwnitJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PEFfnEHC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1837540E0184;
	Sun, 16 Feb 2025 16:11:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZSwyIVpKrW68; Sun, 16 Feb 2025 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739722260; bh=luSirJF7K4cUJRWwOshzBSweonnX9rGzh1rKpdTw8nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PEFfnEHCQf9kVZ4A92FOyFG0qb0pT3WIMIbS/3X9apO0vTLZmtGU++iig5lkG8a2c
	 MC/yWKSMHKbkHiv0oxS3riWDhzjp9we/iCR9sYABuHf3zHUwc71c9l0OOq9Eetxclc
	 Uv7yoF60c7gItrOxPkDgPBNEvBEaK4Qbu4+KQrgxWXIZQVIgCMwM0ARI0AMrH3QxqN
	 R1449Vs4HB9y6XYHPTqYPldg9xV5wq2vlTvfbNlyrVZrFl74aKeQbfNh7TZH+vXDpe
	 zq9Fn6MNKKtbVrz9Rm73AIvIzd9WbpVuSrwbo1eZxLWbr18m2pl3ez7F7rkI652VcH
	 eXElsuJ211dXQI/SMbWW4RxlkRKHFaYRnKSrq56UH73MexL3SFeGIBpakFboaoiuCl
	 g116LA+th/+y3MyF258lu/c++qO4t8jHz16T/O9XOiOtd32MWOyem47VfAHZ+JSSgA
	 E63tGx6eUUoMnI6zEPGh7cZ5vLaS2835OJXg6cRCLOpZwzjWyeW59MzkTSPy9cFL8b
	 /tuw4EWqnXG0l7weabuFprp1Z0uxsuAybnZ4t+3f0IxxErdY4Qm+PojBt3rJYWWrCy
	 FfSB6hS9EjrOOs7DrZNUtdDWmLYn5tPP2n20b8DuF/RRJuKiu29U8fklrwP5xhphFu
	 GjypBwoAXYTrUbdQ2zKAi5JA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3AA040E015F;
	Sun, 16 Feb 2025 16:10:55 +0000 (UTC)
Date: Sun, 16 Feb 2025 17:10:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2 1/3] x86/mce/inject: Remove call to mce_notify_irq()
Message-ID: <20250216161050.GBZ7IOCofLUUelomR4@fat_crate.local>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-2-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210154707.114219-2-nik.borisov@suse.com>

On Mon, Feb 10, 2025 at 05:47:04PM +0200, Nikolay Borisov wrote:
> The call is actually a noop because when the MCE is raised the early
> notifier is the only call site that correctly calls mce_notify_irq()
> because it also sets mce_need_notify. Remove this call and as a result
> make mce_notify_irq() static
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/include/asm/mce.h       |  2 --
>  arch/x86/kernel/cpu/mce/core.c   | 44 ++++++++++++++++----------------
>  arch/x86/kernel/cpu/mce/inject.c |  1 -
>  3 files changed, 22 insertions(+), 25 deletions(-)

So what you're looking at are the remnants of the old soft-inject of MCE
errors. And it seems that we lost some of that functionality along the way and
no one has noticed because, well, it seems no one uses it anymore.

In order to understand how this thing was supposed to work, checkout

ea149b36c7f5 ("x86, mce: add basic error injection infrastructure")

and follow what raise_mce() does and pay attention to notify_user which is
what mce_need_notify was called back then.

Remember to have fun :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

