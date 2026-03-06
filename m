Return-Path: <linux-edac+bounces-5779-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LqfCYT6qmmcZAEAu9opvQ
	(envelope-from <linux-edac+bounces-5779-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 17:02:12 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB4F22476E
	for <lists+linux-edac@lfdr.de>; Fri, 06 Mar 2026 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A9AD6309ED28
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2026 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C4346FAB;
	Fri,  6 Mar 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="e9METsTW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767653115AF
	for <linux-edac@vger.kernel.org>; Fri,  6 Mar 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812205; cv=none; b=YCuRCT4Oq1fIZbhP4MutpztqfXJH4kF+6sjgN3m8OgVcO7fUIoQl4/7qREOcOHdQmteSKydy8m7Ed7sQK5AAgoySte2EIpmtbYrwsXEy7a0tLISWFPZXhDGax+iDicpN5GEdTf1alNTnci5s0mKzu+FawPI08CHfjoHJDvkUeJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812205; c=relaxed/simple;
	bh=n0xZcsfIekDj0JbXaulr4vpj7qvseqHwvKvLVwbtAO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YpFoz0/OdahJmZvkrBJ05jDYbIp9FVsuPYCRh0TElSVrVnD+L8fBe9JYzn5+oZl4ncH8ArxVJjZDOQdExB8R+DzT1oGQi5Jx277+AsY4oSO14hLWRK49xPUQnMLpP2U00fYK1laX8g+rGtR//Tjt7lmIPif73fik7SPbRoKlIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=e9METsTW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 99C7B40E00DA;
	Fri,  6 Mar 2026 15:50:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WMzTSBzjmQDV; Fri,  6 Mar 2026 15:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772812198; bh=QPZqgnIt3NwuBhZgtxCgZ9kt9tQTGeB28SpVpSVlIcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e9METsTWMW0ISkWU4bQLzTdHN1/X0EmRUdKgJRiU9p3THmb/StaIoi6DlLyN81zmO
	 5OLdiNl14JSmK8A4hsOpwS/qpU/jEqNwT5MaCw8FEoVlO3NGzV7e2AztbKq2KSaVHu
	 c1RM0drBUDp5vJTvKvwNJxJLucbMytrct++KqYpy5BFCDDCVLlum/7/vZcWnQQBbRh
	 XOdLUzd9uQ7Tb9/JqCxSsufHx1Ns76/yJfDkSumlFjIA2WUZG04CWNRXo+BAcpaC8g
	 O5mlaQP7XPFAMMgp920CSmbF1TjAquqnrmRyapY+OjCHQr7AWIiwpOcQDDoWzsGarH
	 7++DAchPz8mPRevr2B0qJmvsnV+FkK58GG+vXNCu/73wV/sd1GundNTd1tx0DbcN5N
	 l+Vs9MO8RK3RgDdQ6KWG1r9OeLHSpsh9iPqnxEflJ7Bp0MNLV6/vskHLugn8X2yxIl
	 KxyYImqRSLBLG7zUur7Vw2+q1as2Bqr/FgQb2OAJxQ8Frg9xKsvlqdyWKClR2gW5hl
	 MVpWtwPHww++ijgvtN2X6sSfQv3JljUVH19pcOYgbyV6jSvCXeNjfxmKsl1YoSRgXg
	 P9b7SGeLdjqFNE0X+To7gsSnnui4j8Ba92uovRd45amBnUq4HBw/lZeCPdYy9PLfWg
	 J7gx2JYWqHPEumQgo1/3OjSg=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 34E7A40E0163;
	Fri,  6 Mar 2026 15:49:53 +0000 (UTC)
Date: Fri, 6 Mar 2026 16:49:47 +0100
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>, Yazen.Ghannam@amd.com
Cc: Tony Luck <tony.luck@intel.com>, superm1@kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Decrease message about unknown DF revision
 to debug
Message-ID: <20260306154947.GGaar3mxJ1JkcC0OgV@fat_crate.local>
References: <20260305154528.1171999-1-mario.limonciello@amd.com>
 <20260306145003.GDaarpm6p8A-pFBCCf@fat_crate.local>
 <a9a4aeb8-a044-476d-845d-0368f90624f2@amd.com>
 <20260306153223.GFaarzhwApsh3Jdqdy@fat_crate.local>
 <47075497-6bb8-4da3-b8b3-63901d9f3b05@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47075497-6bb8-4da3-b8b3-63901d9f3b05@amd.com>
X-Rspamd-Queue-Id: 6AB4F22476E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5779-lists,linux-edac=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fat_crate.local:mid,alien8.de:dkim]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 09:40:06AM -0600, Mario Limonciello wrote:
> But don't you need to use UMC to discover that?  Chicken and egg type of
> issue.

Probably...

And we already do that in amd64_edac. So perhaps we could export an API or so.
Yazen might have an idea...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

