Return-Path: <linux-edac+bounces-5687-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNZ0NyaTe2nOGAIAu9opvQ
	(envelope-from <linux-edac+bounces-5687-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 18:04:38 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F91BB29D0
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 18:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAFB3007CAA
	for <lists+linux-edac@lfdr.de>; Thu, 29 Jan 2026 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6F32D63E8;
	Thu, 29 Jan 2026 17:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IkUcKoQz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E403009C1
	for <linux-edac@vger.kernel.org>; Thu, 29 Jan 2026 17:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706040; cv=none; b=tyLmJMMhedo//FCR2U22tA7XhUfHcIkqJsKmqHsMafes07+dFIzN4TqVUsrS7MMcbNyk04U/prGwpmKRKcWy9IR0JnaqFzwrQNVUqIbr6pqFfCgjzHWPlOXSBayJpWqu2eJ5BZ1VAFCKePADJaL+LZ8jJNYAWkhMD3zCxmPqJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706040; c=relaxed/simple;
	bh=KKUgMjlHBOXZ0NBbyd/0FpNcrKyfzJ21kA/5GsyDqv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/DnjKUPFEFbT/prAo/A+9yPxLUuw2IKfQmUMH3shd8hklIWLIYR2up/wwNVAtAl8sRQxbdTILFMqNvgfa6t8DTq0CkUqAvq2nQ1UUFHs5rARsn26qMeX8A6ElxabYN2BN4ET/0h+AKa/JKWWv7NGJGTWLbEjKTPcS5IzleVtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IkUcKoQz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8601140E01A2;
	Thu, 29 Jan 2026 17:00:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 54jsIDTikuNu; Thu, 29 Jan 2026 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1769706028; bh=mAFrvf5+uKXy+/eT0RbldaeBXVut9sMak8wc9g/wiSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IkUcKoQzhsRnozCAba+bB/H6Q1QaMn7NJgpMpwUy1IiU0tnSUBtYhVYCJYvSw8EJ9
	 9ygvHQkBlK2ETEqPOjYATzZtFmoGILAseRK9nf5beZuZLR548EPOaBj9A8QKS6WJvM
	 ONcrBMczrSeO3MbB6WNAHLdKwCrR6nSMVcIYEZ/C0OP+Um2ikFU9/ZQzvtuPQvTWuL
	 w2l2e4uptZzL6tOW0V1ZJhnwkg4OFGDSk2e/3aqkUBmDMO+TKNWJw5Ihb1VEbPGYJY
	 GyaA2TS65me2GvoZLqfq+yTQ/kkyBQA4nvOzyLiDTp9cAnnPXlyxOlH0eO7ikZx3z5
	 un1wyfGURUtNaa7WNLTN8ZKK+wTC5RcEdC7AvQPf1jpyip0P5Fm4pP3gj3qUgxU4hU
	 ZO+SKEWxtb7vEg4TObNRvWKQFFHCIyDcO6vP1Jg3CgrCe9tSMbFS9n6V7GIStCmWpz
	 86QbiFubjr/QXhTvh9TtmkfB3HCIrFfwAWaLFY8oxoBNsnN0dHQldn+bkpA6zMHF7v
	 HsuXNNsGDNcc7FFowKu2en5ERLQJnbyVlO3cMWjz0r0SGHnbe5suPXpvma477FLfI1
	 LUKK6Sxoe+7HgewHj2xS3LTMgo0lXr750DOMWOkCNQ7heDsnPMr0YCpUJvLeQkUq19
	 mRJ7WCkUM1EHX/bGl3IjXU+4=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id A17F640E0028;
	Thu, 29 Jan 2026 17:00:19 +0000 (UTC)
Date: Thu, 29 Jan 2026 18:00:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	Tim Small <tim@buttersideup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Martin =?utf-8?Q?Kepplinger-Novakovi=C4=87?= <martink@posteo.de>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] edac: i82443bxgx: remove driver that has been marked
 broken since 2007
Message-ID: <20260129170013.GDaXuSHTDNdAN_n7ba@fat_crate.local>
References: <20260129082937.48740-1-enelsonmoore@gmail.com>
 <20260129104838.GAaXs7BumfNkuhVovO@fat_crate.local>
 <SJ1PR11MB608338017FD8E4D07F689A21FC9EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608338017FD8E4D07F689A21FC9EA@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,buttersideup.com,linux-foundation.org,kernel.org,posteo.de,ucw.cz];
	TAGGED_FROM(0.00)[bounces-5687-lists,linux-edac=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[alien8.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 4F91BB29D0
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:54:22PM +0000, Luck, Tony wrote:
> > I couldn't care less about supporting a chipset in Pentium II or III.
> >
> > Tony?
> 
> Nor me.
> 
> Very old systems (prior to Sandybridge Xeon) had EDAC drivers written by
> community (mostly HPC folks - they called it "project bluesmoke").
> 
> Intel began taking an interest starting with sb_edac.c

Right.

And regarding this particular driver, I haven't heard of anyone using it. So
lemme remove it. If someone complains we can always resurrect it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

