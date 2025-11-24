Return-Path: <linux-edac+bounces-5526-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA519C81CB8
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CE404E6ABA
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 17:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0FA3148AF;
	Mon, 24 Nov 2025 17:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="g8bdEn/o"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE6A59;
	Mon, 24 Nov 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764003807; cv=none; b=Oi4b71nWDyvaIxH2pTH+TxM/2h+NDSQiIhdJQnq0LGSeX4nvLSC4ix6ZUpXVul7Jdsz7/Kgd6WaQZsBHW7+dXrAT2JsC/UroxBCxLPmDBh3zuS4QxKKl51ozj8x0wg8i95VxsgCZ9I4iEJ1sJ0zoBSAnSsQEZm21rlUW3JK3Qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764003807; c=relaxed/simple;
	bh=DtPsP3lf6L+vpIayCpYzgL1eja1m1Ktg5IIyKz1vTyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV2dzPG+QzKO9JLQcCnWrhekJ4SdFq1FxQhYkeb07RQXPkQNxCCFH6sawTSa+WgyNf6qa/JCXnWqx6KNZqUwSZBDG0JTxp4Aai7cGlJhtaR1lLAyjztuHciFZ3t7NYiuKh08VxXLUEXcNBBJUKmGNKmHr9M6Fw88/aPrk4w8t0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=g8bdEn/o; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D3DF740E015B;
	Mon, 24 Nov 2025 17:03:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id lf92_QexcAAz; Mon, 24 Nov 2025 17:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1764003788; bh=++OsLMQwwbW/OME6AaTfM93xXSlvTj6780xC7XL5Q6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8bdEn/o0/BKAKF+8qXM33xjL2J/VMGRSdvPuN032OQllDpD1mMrunlKRKImrNhGo
	 nN8ezQ74u9ivPkZK2KgfsXKZ86odC7AVR8ODV81b81xUqqCFPUQ8LP8PRkp43518ns
	 aM2VO/KAQ9dNwdCyeFkhdLhLkHKJI6f1XmjUJTtL3QbrtMmRrXWsrUhstLb3TaNDUX
	 0UBhaJfuBQcp6kxZNq5hRCAeGWTB9UagbGLnzrBBlPdChfglhVLJF9YgykMTdbQ7CX
	 3EEoTwcZuZM6SlrwRbLqbrR720LDP2VppHxgVnQg8v/KqsHPelZwNojFfiaFhKuSTE
	 voYJQ6H6L9JM8AOFboti848baQBPkn93k+GkPwYVaGkiz5ycz4BlkDO8RHuq0Xcl6S
	 vCMiV3yj8k+PAJNWWzEizN4+aOAx0BHgb9qNsZOnTk1sFHFfocoasY9DuRNEItfJO3
	 bo6D5zV9EOvwVev4U/IwoSUud4e9udB4AaMaR0i+ru3gyifnpTBOt5c667t0ZHvbNb
	 xEK/PmiVbTlwbHrQLBbVh+lHvttI/EuXkaOeu9OdwTjYuUfrwRS0l1asIGHtSHiTBF
	 DWt9BfJ+8EikQ2MOccdVC1HxQZhzY/zvisRZ4nA3DPMt9em80T8Dw/WiBQtnogtZ/Z
	 pEYgdz/+dgMfJsp1kYmW830o=
Received: from zn.tnic (p57969402.dip0.t-ipconnect.de [87.150.148.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 25B2140E00DE;
	Mon, 24 Nov 2025 17:03:04 +0000 (UTC)
Date: Mon, 24 Nov 2025 18:02:57 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yazen.Ghannam@amd.com
Subject: Re: [PATCH] RAS/AMD/ATL: Replace bitwise_xor_bits() with hweight16()
Message-ID: <20251124170257.GHaSSPwe1nDUQgI5MQ@fat_crate.local>
References: <20251124142517.1708451-1-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251124142517.1708451-1-nik.borisov@suse.com>

On Mon, Nov 24, 2025 at 04:25:17PM +0200, Nikolay Borisov wrote:
> Doing hweight16 and checking whether the lsb is set is functionally
> equivalent to what bitwise_xor_bits() does. In addition it results in
> better generated code as before gcc would inline the function 4 times.
> With hweight, the resulting code boils down to 2 instructions -  popcnt
> and andl as all cpus we care about has popcnt. No functional changes.
> 
> An alternative would have been to use the __builtin_parity() function provided
> by both Clang/GCC, however under some circumstances the compiler can choose not
> to inline it but generate a library call which is unsupported in the kernel.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  drivers/ras/amd/atl/umc.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

