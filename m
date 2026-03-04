Return-Path: <linux-edac+bounces-5767-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDbhGbhlqGl3uQAAu9opvQ
	(envelope-from <linux-edac+bounces-5767-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 18:02:48 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5880B204C62
	for <lists+linux-edac@lfdr.de>; Wed, 04 Mar 2026 18:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37083311298B
	for <lists+linux-edac@lfdr.de>; Wed,  4 Mar 2026 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A4364E84;
	Wed,  4 Mar 2026 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KTmZGXWW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4235DA75;
	Wed,  4 Mar 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772642406; cv=none; b=VZgdFjvTyiLStboo1RB2Avr5kKz+CSKEd4f60LE4SsLqqpUYKgtC+WCBJvEG4eaMVxgEXgStKC6eRfwukkzn0CGbkOw2lia6tZuKAa0McIDLm3I1TEIYouFDfvoBJTJ2kUwvx6G8CED7hcQLx+b4X12rUHOEuOswoWa8hR6o15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772642406; c=relaxed/simple;
	bh=z0SIaCB6qZBz+FXVLl2sete+Tren4TR4PTwSMIkKvz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnMGU3YECuV10TTZ4lJhi1RHni5OW5GyNFn0lNE/mTQrbZYZMf0qPBlixoL6sUxeQo+gjBu4fGlTQWMa+dQEIfIOKXEstONxldITQjfTtzM6BQjcSn2JVkEdrindPIXYGBUqwocIxD42DrQ43LpAq+T8rO5JDrMC6JyzQR8yC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KTmZGXWW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2180040E00DE;
	Wed,  4 Mar 2026 16:40:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 97WSBOdxqLHR; Wed,  4 Mar 2026 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772642399; bh=aPFJZDhkGpC0TVrdXBScOc48zjBM/5ZPbMP/Kx34iyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTmZGXWWTc+uCzAaiYhEZlqN9HRzJAjcp3gD7l996HPGzsm1DfZi0KxYxZ1e/xUnU
	 mtpDqu0nVJ7kczfYQREOhooYYVFweGlS+qGGu7cQsdhdmndll0wQteCfW2HCtsR3L/
	 SjXLaGDmjZCq2gpkNFhK9SBsPuz6F4fokLsy0L4JRxlpH/8osnB2I91fgqMedmh2rY
	 hj+Q1ZUeqd3Xvf/aOpmtsu0tret5lE1wVk0Rqm8aVELUqFS/1i5FYGZ1h066PBuzPp
	 SnFeRyQT7pOmW9+rRS2vey0X1fJLJBatla1PTqm6pmKaVufohivAqdzmSfkbWtVo0b
	 NUFGJvV7d/UylArE4Kl7b1HiEIh0U78wOzjIHY/2tqzUzuF8O17qs/09XvVawwmPWK
	 n4QOTYPuEUTH4sH3ZlJJAW2ntK2UWagRWDOQIR8kuHBIp22qd3TTLAIe5HX3joTAcS
	 cIk+RAnRS0dL87wN0oQANPlhuQKOxNf4ZSh3TmTIvCV3KIzUHhQ7Wd28Y7ByzsoZ2Z
	 DpwKeZn69aGGaz/eXyWYCNsXs5UYuh49K4uNITL9uhkxZhDEiEbcw2rKa+SchLUrPL
	 dSO5kyMp6dBkYDP+iK7D2kavDSlhgysWTCKQKcapC2L/IwPCHvKqSxjQPtW0C0W2dZ
	 oH1hVz0cZcSmZwfFMrIxltWc=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id C939140E0198;
	Wed,  4 Mar 2026 16:39:54 +0000 (UTC)
Date: Wed, 4 Mar 2026 17:39:53 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org
Subject: Re: [PATCH] x86/mce/amd, EDAC/mce_amd: Add new SMCA bank types
Message-ID: <20260304163953.GAaahgWQIZ5QuxLDP5@fat_crate.local>
References: <20260202172158.2455749-1-yazen.ghannam@amd.com>
 <20260228150447.GCaaMED_7sbC3OvDsL@fat_crate.local>
 <20260302142255.GA145106@yaz-khff2.amd.com>
 <20260303153814.GAaacAZrUnFNBhPq1K@fat_crate.local>
 <20260304150402.GA807247@yaz-khff2.amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304150402.GA807247@yaz-khff2.amd.com>
X-Rspamd-Queue-Id: 5880B204C62
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5767-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,alien8.de:dkim]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 10:04:02AM -0500, Yazen Ghannam wrote:
> We can re-sort them. Still want to have them alphabetically?

I'm not sure how yet - all I'm trying to say is that random order is kinda
suboptimal when having to look at the code.

Alphabetically probably sounds ok because you have 0xb0 ones, for example,
which belong to different banks which makes me think that the hwid in
HWID_MCATYPE(hwid, mcatype) is perhaps arbitrary and not very important. 

And perhaps we can work better with alphabetically sorted IP names...

Rite?

> I can re-sort in a pre-patch before adding the new ones.

Yeah, makes sense.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

