Return-Path: <linux-edac+bounces-5751-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Jv/Al1FoGmrhAQAu9opvQ
	(envelope-from <linux-edac+bounces-5751-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 14:06:37 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 614971A6152
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 14:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6E273130909
	for <lists+linux-edac@lfdr.de>; Thu, 26 Feb 2026 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F6128750A;
	Thu, 26 Feb 2026 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f7uNfm0R"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8DE2DB7B2;
	Thu, 26 Feb 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110803; cv=none; b=qBsWtX+Dtzjku6skuLOW2qsMq5H649FDuGXDpfZvWL2E/g4Nnndf8RM0XmENWmYGLMpri54+5z9vxRMXvEj1XOBblI8zlVLRK2vJHHctKslM4P54wRues5LsT5m9yKUVqHJBi1+XkgfusimzImnKcm7uIwWPwusAG6z/Sj36pAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110803; c=relaxed/simple;
	bh=PLLhErnOZKBVKebPkXrPyPLPytpNd/qHJi7wsRwpwKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrvYyrAlpvp+I4M2vVUr0w3MOHgDBgM/QuubQowoNrGAVva13Ptag/dkZH69GH4RNcgdAkkBPjyTtVDUefKMS3bXLASYslszCFpjos1xjzUKS3+iJH41Hk1AZXSuAcZZ2c5Ri4oq6NR1y1OijVl71irqXnlYh8rsC/aZEZtYye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f7uNfm0R; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F75840E00DE;
	Thu, 26 Feb 2026 12:59:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ROAGViOvo8Ii; Thu, 26 Feb 2026 12:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772110784; bh=0GGPnxoJS1zoxgPTKrHC3ekSBsrxijIQo3lW3eFnXBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7uNfm0RYmCyR4an4pMhy+Qz7ObYXIvGS8/Y9kyyb/+2Ui2MIMhVpAPV6wzQNwdJC
	 mJf6rW8nDJuHh8iafwrw5LM3WUPb+PriZKHG4bOSB39cs3gdoW7QTC7vIZduDUed4Z
	 OpAs9sW3TUFW0ejbxgqN/jLsxczWpW2hfLKjTnAqbXGvroaU93IV82zfyOdPwHFqHW
	 hH+LautpuODP2wY5oEmON+Nsv42sihqumDtQJhPYsQi2zUfnnKO3OCN1IawA62KLKc
	 l2wAiOzHrhFEWb4zWwcFNXOVlWW2o5Cu0FlZv0Y9AKhldSiRzinf1A94XtsUJtYCRD
	 VrqQn4qQWBquslT6zdn+4CDBRavXpUjgn39R/nZpsaEkzzbvGhpfkDZj3FF+8RCtjB
	 IcteejBefA1CF3OgTM9HKpdD8SR/6x2CjTKGFdVJyJTr26Qo39b94XfKG2sBiTY0SS
	 H2ncVpb72VoYHqb8pysmHMU4yvtpsu/Cbpoz+i0ftSVrHj9yd1VDOyOVkof4E3VRG2
	 Nt3USA4pYuywAIMyLncmRZQqthEIq+oiNhU79dyyj5O/puZWd0cgS0nXTmH8JWuvQe
	 i5gP7rTO5bdZ0F1+Znk8AOMfXx7vLo8ZPUfQm/Ksaeixcf9krZkXnWkX4Xuno57va8
	 AmXfUiOOOhTv0qYnZW4Q/iQ4=
Received: from zn.tnic (p57969063.dip0.t-ipconnect.de [87.150.144.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A394340E0184;
	Thu, 26 Feb 2026 12:59:39 +0000 (UTC)
Date: Thu, 26 Feb 2026 13:59:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric-Terminal <ericterminal@gmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] EDAC/versalnet: Fix resource leaks and NULL derefs in
 init_versalnet()
Message-ID: <20260226125932.GAaaBDtCAp5ueJVTib@fat_crate.local>
References: <DS2PR12MB9821250527F466180B16ACE38172A@DS2PR12MB9821.namprd12.prod.outlook.com>
 <20260226112907.76971-1-ericterminal@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260226112907.76971-1-ericterminal@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5751-lists,linux-edac=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,alien8.de:dkim]
X-Rspamd-Queue-Id: 614971A6152
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 07:29:07PM +0800, Eric-Terminal wrote:
> From: Yufan Chen <ericterminal@gmail.com>
> 
> init_versalnet() has several bugs in its error handling. kzalloc() and
> kmalloc() return values are used without NULL checks, causing a NULL
> pointer dereference when allocation fails. The cleanup loop uses
> while (i--) which skips the current failing index, leaking the
> resources already allocated for that slot. edac_mc_del_mc() is called
> unconditionally during unwind, even for controllers that were never
> registered with edac_mc_add_mc(). Also, sprintf() is used instead of
> snprintf() on a fixed-size buffer.
> 
> Fix by adding NULL checks for dev and name allocations, replacing
> while (i--) with for (j = i; j >= 0; j--) to include the failing
> index, tracking successful edac_mc_add_mc() calls with a bool array,
> and switching to snprintf().
> 
> Signed-off-by: Yufan Chen <ericterminal@gmail.com>
> Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> v2: Correct Signed-off-by name and add Reviewed-by tag. Fix commit message formatting.
> 
>  drivers/edac/versalnet_edac.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)

No, thanks, we'll do the proper cleanup here:

https://lore.kernel.org/all/20251104093932.3838876-1-shubhrajyoti.datta@amd.com/T/#u

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

