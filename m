Return-Path: <linux-edac+bounces-5690-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAOpDFTMfGlHOwIAu9opvQ
	(envelope-from <linux-edac+bounces-5690-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 16:20:52 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFB9BBF82
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 16:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8AD9E30078AB
	for <lists+linux-edac@lfdr.de>; Fri, 30 Jan 2026 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BB2E2663;
	Fri, 30 Jan 2026 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ipdEIwTv"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CF322C60
	for <linux-edac@vger.kernel.org>; Fri, 30 Jan 2026 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786397; cv=none; b=XMQ045rywKO376+ZrlisY5txAspp3jG0S5uHZ9IDOMUUOIgHl3CpbmigJ0cpOyC9vFbomh+yM+cyavOywx/NQFSo2duNKOSSZWOi6yRdfpo6R5NIMyr4CAlfy2u8gSW4asLi3YGcJ1IMD9EbGtpxsRSr9/cAoH0LDHirOdI/+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786397; c=relaxed/simple;
	bh=+oV2bkMO8RGQAUlOrYcIxBPO0P/qT6mFFu85bETnnnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lyHMKGZ0E9Q2q1snStvq57+Rw/MuRvyUjQ9xGSZMvOfV6uB9VEmM+ET0jSEojVYd8hSHGrclvBCoKlcm8Xi0K8Klf97/SI5CZ5ptL/0J8whF1cZuLqounqslurJlt4zy7+gwQgGNWh2CbsK/16/8uxMO4VyyQ8w9Mirj1LphvKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ipdEIwTv; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A9B8F40E01A3;
	Fri, 30 Jan 2026 15:19:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KBoQpkdtPdkH; Fri, 30 Jan 2026 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769786388; bh=2ez6up6cEH8Xx2XDg8XF1pwCjtuY54uIEkbBWML9xAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipdEIwTvtjxIT6IMKNP69mhNckDtTw57YIU1HXMYfBIeguvupxkr+2s8rZ4Fqjr95
	 cK5l254Tn6uJ9UM2Z9PBlXut9KwdiAUcCxfbo3Mho6uXmwWH5kT45Ta2DS1GgNv+XU
	 PDURJ0ThS2k6Ewxfvk43Oi3DvGVdcefO587A7RD9nUnVivVvEJHd2CPu8v8wJ4UUs/
	 Zc8oOGZrJ3JdIJQcGO4H62dRm1pqZCe+yqDk2w3gPyZV9KBGDx5IewWb96zw0FWkfl
	 kbEj3tN+8wxDW+f0RNYDcTglQTDrrIuqVOVwW1PT+/0md7njMbdrG+EYHzY0nMdFYJ
	 rG6TpCKYD0BAkwUeVr3RoQspsjXefPwFweiXH/mfPkHpTRhJSygs3TVYuf/7BmGGbJ
	 nscEXKsekZVwVU2MtPcp7Ybb92cx+1oWQgTMnAoGwVfi6mzJg6Qf95oJ/LH640eJa3
	 cHrrgxCn62kIZ6Jg6V/1kmL7yvmchrtuifhPI7Es/gEuhT/t1mcmwzmMn0QdgkIZzM
	 AyEukNXDP2kJHxYK6m2n/t3bdCCatV99iZk7MzKhD6VbTrFsN5DRtYPp7ROqsZlLrW
	 TZM260m7ucB3pai3FfeYC4ZN4KEkAuCjUJPaqul1l89rWFQ4C/e6lV3uXQiqB2Xyau
	 BskxsJfxit5zxAELhI7qZt9A=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E08EB40E0028;
	Fri, 30 Jan 2026 15:19:38 +0000 (UTC)
Date: Fri, 30 Jan 2026 16:19:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-edac@vger.kernel.org, Tim Small <tim@buttersideup.com>,
	Tony Luck <tony.luck@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] edac: r82600: remove unused driver
Message-ID: <20260130151932.GBaXzMBCAELS8xuCdv@fat_crate.local>
References: <20260130052633.13119-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130052633.13119-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-5690-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEFB9BBF82
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:26:23PM -0800, Ethan Nelson-Moore wrote:
> This driver supports the Radisys 82600 embedded chipset, which was used
> with Pentium III-era CPUs. It is highly unlikely that it is still used.
> Besides its own documentation, the only information I was able to find
> about the R82600, after looking through many pages of Google results,
> was that it was used in a Nokia 2G GSM base station. Remove its driver
> and add an entry for it to CREDITS.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
> NOTE: this patch depends on my previous patch to remove i82443bxgx,
> because it modifies the CREDITS entry that patch introduces.
> 
>  CREDITS                    |   1 +
>  MAINTAINERS                |   6 -
>  drivers/edac/Kconfig       |   7 -
>  drivers/edac/Makefile      |   1 -
>  drivers/edac/r82600_edac.c | 426 -------------------------------------
>  5 files changed, 1 insertion(+), 440 deletions(-)
>  delete mode 100644 drivers/edac/r82600_edac.c

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

