Return-Path: <linux-edac+bounces-5685-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOcPH0c7e2mNCgIAu9opvQ
	(envelope-from <linux-edac+bounces-5685-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 11:49:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21BCAF1A9
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 11:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CDBD300D4C3
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 10:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B6E381716;
	Thu, 29 Jan 2026 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Nfx1d53L"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585053816ED
	for <linux-edac@vger.kernel.org>; Thu, 29 Jan 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769683745; cv=none; b=JYaZ5xvRWN1WpSa8SZbLz4PnKzrdB44zPnfiBltjpuZr/NsovAJdX232ucq5frbYVc6fdoiqpMxozXDeFVL1bh9iP5v7O+chGvOkCUKMXDHOw87TbLv0bcfNTtt6qPgXIXQjuCjA9zjoMt6o9mEcUcvwwj18Zl4Dq6mM2LDjqyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769683745; c=relaxed/simple;
	bh=fK5wn4UJsTj/bTSA9rJLSSygAPCNrI5ccFfXzlsiKhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H49MMhvc9x97Y4Y9GHoeq1g0hIM4+u2DR57k+m5qei2JCcDCjZI2HFc1F0XB//ld/Mrc+8RzpX94JqHI9SOE6vU+qc0mG6AZ7O8memV4W9SpcNlHlFdF+F4DZEu/qEXt8ElY4C0svkRPNh5iibfNZzh4d4YrCCjP7N/gNTFvgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Nfx1d53L; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 59B9340E01A3;
	Thu, 29 Jan 2026 10:48:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ypmq1tTjwxHE; Thu, 29 Jan 2026 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769683735; bh=6JLKzcVVKCbeEQpqz6ovXBpTfKNJ/AteBgJ0E/IApAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nfx1d53LsNZXxrqETw4w/RB8TtTZ5sx25U6zVyXDwAELbucKs16PQPnFPHTwTOY0u
	 hri6kZFu+7gSI3SjebyixNNFpq0asLdUMmtPy8hskAuJA1lfisLv7CllkvsBaXSN6t
	 KmC7Rp4eKsuOdJGt8OTgLOpF+KH6fBoD9sfw8uiPULai2pajlUhNV5sjq38MFOEmhP
	 t4b0mvjgjk7GrH32hF+lmr/i6o5zlU/Oc7OuJj5xF65WpfEp7YKZ3ZKBfMfcW3iFc1
	 RgvKaT4b9l5qdCqHUze0edudbAC1vx1QLf1B+tfbmMGuaZ1Z2xoCxyfCfWGvHjKa77
	 rggjXJCf8LaXNMNTseqBWsK2eGI58ClyvpdMYvcwDnBOUDYsTmXmG4qAJh72s0lSAN
	 c8ftIGwu/WHVZqRfgW9Dc946ZO8JDol2FpmcAqIOCKxGwOgjT8QMYI8J+XmgVhuV7U
	 oYhWC3DYPP0PzZohMTbXd66zsz4tr1zDuo7Bzb7+jn/xwPu28ayyJLN7vLKv0nBr+R
	 hgExohXWgyz+PrA8xv8n06N3oc48M9HyreEAE/6mIOS5yJUg1AQCZZPQKve7FgnJjA
	 sYl+mkitP4SFNGS6kphSdlkkwHDZNuYNmwzt145oGNTvAkMnYTNjRDztPnIBolO9aj
	 Nte9KnsucDl7fxF1t5Ap6Spg=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E191340E0028;
	Thu, 29 Jan 2026 10:48:45 +0000 (UTC)
Date: Thu, 29 Jan 2026 11:48:38 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Tony Luck <tony.luck@intel.com>
Cc: linux-edac@vger.kernel.org, Tim Small <tim@buttersideup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] edac: i82443bxgx: remove driver that has been marked
 broken since 2007
Message-ID: <20260129104838.GAaXs7BumfNkuhVovO@fat_crate.local>
References: <20260129082937.48740-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260129082937.48740-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5685-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: A21BCAF1A9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 12:29:27AM -0800, Ethan Nelson-Moore wrote:
> The history of this driver is pretty amusing. It was marked broken in
> 2007 in commit 28f96eeafc89 ("drivers/edac-new-i82443bxgz-mc-driver:
> mark as broken"). It was then fixed in 2008 in commit 53a2fe5804e8
> ("edac: make i82443bxgx_edac coexist with intel_agp"), but the
> dependency on BROKEN was never removed. Given that this was never fixed
> in the last ~18 years, it is obvious there is no demand for this
> driver. Remove it and move the former maintainer to the CREDITS file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  CREDITS                        |   4 +
>  MAINTAINERS                    |   6 -
>  drivers/edac/Kconfig           |   8 -
>  drivers/edac/Makefile          |   1 -
>  drivers/edac/i82443bxgx_edac.c | 462 ---------------------------------
>  5 files changed, 4 insertions(+), 477 deletions(-)
>  delete mode 100644 drivers/edac/i82443bxgx_edac.c

I couldn't care less about supporting a chipset in Pentium II or III.

Tony?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

