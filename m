Return-Path: <linux-edac+bounces-3200-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9D3A4406C
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 14:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4CD03ABAA9
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2025 13:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB866268FF4;
	Tue, 25 Feb 2025 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R+P5YuYy"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D24268FE0;
	Tue, 25 Feb 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489140; cv=none; b=mqpAjUqzY+yYvOiyYyKhR43iF+UN4lLNkbzJxZlyN1R6goFi5614HLHIoTl2ar8EV6i4G8SSZadhnyTuZQFyHqfluLc+RVfbFTSSS/UKW25T0q/mqT1pnorSDQJg9cRQ6VbMEusKrJhN3/TplFAAR0KsQ658m2Z5/zMSjpqqXTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489140; c=relaxed/simple;
	bh=IvLxYoqof+h1zVJG/BNtTm2YaSAll3uDPKebnBkZeA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjsWvDrm3cDUxD3OL3Whg5u2OJFN/Dnr5IKWDKnCDHPoFnBPBFOnjlSjibFWgL1Iysn5UZdQViZC0wpe3KQV1snrIAI8bqtuqCQePxvHopit8wSgt7dg+GX7G36eBuF5d0TDuMlVoE2ruED7CFwPuO9D43f8PrBv9o8KNW/mai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R+P5YuYy; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BE0BB40E01AE;
	Tue, 25 Feb 2025 13:12:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id c4bYqnj3_9Ty; Tue, 25 Feb 2025 13:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740489130; bh=aiTNWBEfHf+ez36sasAzHhMIQIMyctxZwHgo6gKB6Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+P5YuYy+OZ/H0lPGjVJHQxWsJs04IfzWC+ISVcf3ZN9KSB6OvDodmMfex4Yy1x2u
	 r6faDzQZKIU3Iu2tTqVpaQKKGaCuhok+p1Hq5YRGt+YdutTwG6HmBcIxb4x9F7dlgB
	 2gfbgmisBe1wtaiLS/qvowXP3wNnvPzbtKJZZnN0HQo8vvowQM5/3SpS9Q87y9orve
	 ikFk8PaPmjBKIY2iMAPyW/YxM8zC74sDdsp1xuRx+SkN3SSHXJuuzq8RRWs43ktXGp
	 AxC8j6B1EwTkKEYIvViQ2NXIwNmZbGfyLRAoQjluKomqXv6HYdEQ1WUmyZ8pHkghUo
	 gI2YB7UQvqgt4xMUl4us6aAF1YdzoiFWYglTeswsdEhJWjJq46AXgdDTjQPd53da/k
	 5zNH9Ram6tMTb93FdSAzpUGYI3q1dnrqwuQG9iXweUhJxXrs9Ngq9LIc4VzqeCDoYx
	 +Ul8FNkMblB3xcPK90Mw+t5RsurnHqla6Lhyj+GT+qPZzbzrrBfhjpTE6fm7RKTPFX
	 Tqz2Qs/caOiTNY06+7z1lgSiJgJ7K0OoxZRHuYwBWtmHydBVMRcLKGX+no07gVrMra
	 1CWrloNwXOKyBh0dNoPy1v/AG98jabIY0XDVrDpVLx68C3Bly9mqRmHn/i79z8DXOU
	 qfOiIi/2qI0blmaahfLhHqrU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E989240E0177;
	Tue, 25 Feb 2025 13:12:04 +0000 (UTC)
Date: Tue, 25 Feb 2025 14:12:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v2 3/3] x86/mce: Make mce_notify_irq() depend on
 CONFIG_X86_MCELOG_LEGACY
Message-ID: <20250225131203.GLZ73Bo6OgcD302H5e@fat_crate.local>
References: <20250210154707.114219-1-nik.borisov@suse.com>
 <20250210154707.114219-4-nik.borisov@suse.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250210154707.114219-4-nik.borisov@suse.com>

On Mon, Feb 10, 2025 at 05:47:06PM +0200, Nikolay Borisov wrote:
> mce_notify_irq() really depends on the legacy mcelog being enabled as
> otherwise mce_work_trigger() will never schedule the trigger work as
> mce_helper can't be set unless CONFIG_X86_MCELOG_LEGACY is defined.
> 
> Signed-off-by: Nikolay Borisov <nik.borisov@suse.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index d55b1903fde6..8b8553e144ce 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -591,11 +591,13 @@ EXPORT_SYMBOL_GPL(mce_is_correctable);
>   */
>  static int mce_notify_irq(void)
>  {
> +#ifdef CONFIG_X86_MCELOG_LEGACY

You can't do that - I see mce_notify_irq() in mce_timer_fn().

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

