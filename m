Return-Path: <linux-edac+bounces-5622-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEDD17CDD
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 10:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FAB93012777
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jan 2026 09:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4592E3803FC;
	Tue, 13 Jan 2026 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DtYjjcQm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE813148AF;
	Tue, 13 Jan 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297976; cv=none; b=XLgJGz/h/SV6p0KI0rkP1A9gzOVLD3ZNri/waRrKQnxLGI+ga2bz4bpkVtodaLhthMvPvAnH/asqJgwCUq8m970uwhO8Ek4hFskXBOaG6S9IAiB++r2wPlMldrS6g1fh+TX4LJFKtc8of3tm4pNClJd2jCVEQ25H2Rx2HXryzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297976; c=relaxed/simple;
	bh=3geair7Y4nYakgZfKk3sgXaRMqdOY/G5SXqAjlQ2ll8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6Ydsz/ajTlxlqyGhJLal2l6cbSIMvvpCJN3f7nGmQbJByfLLnbN+GRto3pfzEjnPFCc0TFZ9dsZJy2cILWy7AJ9v09C9MRnieXyFpulMSvgRgYIevwSILJl9S6In3Gca99sdpB1g7vcnRpa3EJ86hUb4wDK9kt+ngUVtI123To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DtYjjcQm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 38DA940E0028;
	Tue, 13 Jan 2026 09:52:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TdNX_hMmyS0C; Tue, 13 Jan 2026 09:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1768297968; bh=XDJ5Le0buf87ZIT+WPOU3lsjdfxwJXZFP9W+cJdYHjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtYjjcQmkPY+gFeKKvRC+vW954JlJ3TxnNBHNqFDJtiuDCCZF9k8dRDxrn/Am1cKM
	 OXCfunGtX9tpyxDiU94U52WI8iHY12Nwbo2LJj5b8tW/JPr+M5/SnhrBud24egfd5x
	 Oi91xVcwTfgWWXMYPCcyfUqoELMbzj5sQYLlGVPxWn0Ea5OENLUTV1rjGNxOye/uDK
	 xdmTb094VFe0z8IG52NQFYlghnPeexjYlUUHblnXsSe3RwIZ4i3L6wFD7n8dKGCCaX
	 NPZwMOPISXg0a3gw+6tCMU6KQEgBDOVP7DEwdXcLquxVdEutBYE8DGPjMzVo+GNzNT
	 PIjm6A57NiyeOGFriN3NHknFKGc9DrQDjvnP3ivztIjeilmR288u3cO6SeFanJa3aG
	 XucM7cjaF7Ib1RUgqZt2XtmVo+osA1Hze4HvkfO0FqIvgGymtHX7dYzfEppOMVVLEe
	 sXISrHjf1cvIIbC9t3PeEaIsK/fzJIxpabgSCtiM+ufqeGKtrltnP+3UpMQuettm4v
	 Qjlsflgu1IBf9lpYjm7tGJzcfKMv2MB7ADwD2xOg9VQ2tcvE/IuzEaEqU/QYAnD31t
	 Sz7a8f8fdIcEcuIqUldVPWgMD/qsUAZJYXnD9OAWbZjSH1ETUDq6W4kP7zLofBAXQG
	 r9cnHAvKwL1oEMp49N5bRgmE=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 8C4C540E01A9;
	Tue, 13 Jan 2026 09:52:35 +0000 (UTC)
Date: Tue, 13 Jan 2026 10:52:33 +0100
From: Borislav Petkov <bp@alien8.de>
To: lirongqing <lirongqing@baidu.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [v2 PATCH] x86/mce: Fix timer interval adjustment after logging
 a MCE event
Message-ID: <20260113095233.GBaWYV4eSjNx9YaGbC@fat_crate.local>
References: <20260113070506.2273-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113070506.2273-1-lirongqing@baidu.com>

On Tue, Jan 13, 2026 at 02:05:06AM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Since commit 011d82611172 ("RAS: Add a Corrected Errors Collector"),
> mce_timer_fn() has incorrectly determined whether to adjust the
> timer interval. The issue arises because mce_notify_irq() now always
> returns false when called from the timer path, since the polling code
> never sets bit 0 of mce_need_notify. This prevents proper adjustment of
> the timer interval based on whether MCE events were logged.
> 
> The mce_notify_irq() is called from two contexts:
> 1. Early notifier block - correctly sets mce_need_notify
> 2. Timer function - never sets mce_need_notify, making it a noop
>    (though logged errors are still processed through mce_log()->
>     x86_mce_decoder_chain -> early notifier).
> 
> Fix this by modifying machine_check_poll() to return a boolean indicating
> whether any MCE was logged, and updating mc_poll_banks() and related
> functions to propagate this return value. Then, mce_timer_fn() can use
> this direct return value instead of relying on mce_notify_irq() for
> timer interval decisions.
> 
> This ensures the timer interval is correctly reduced when MCE events are
> logged and increased when no events occur.
> 
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
> Diff with v1: rewrite commit message
> 
>  arch/x86/include/asm/mce.h         |  2 +-
>  arch/x86/kernel/cpu/mce/core.c     | 17 +++++++++++------
>  arch/x86/kernel/cpu/mce/intel.c    |  8 ++++++--
>  arch/x86/kernel/cpu/mce/internal.h |  2 +-
>  4 files changed, 19 insertions(+), 10 deletions(-)

We're discussing the issue here:

https://lore.kernel.org/r/268e2f0512db435685af987a2ba6893c@baidu.com

Why are you sending another patch before we haven't agreed on whether there's
an issue in the first place?!

NAK!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

