Return-Path: <linux-edac+bounces-5760-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFyaFtePpWmoDgYAu9opvQ
	(envelope-from <linux-edac+bounces-5760-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 14:25:43 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F9A1D9B4A
	for <lists+linux-edac@lfdr.de>; Mon, 02 Mar 2026 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BA353020A6B
	for <lists+linux-edac@lfdr.de>; Mon,  2 Mar 2026 13:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402323EF0B6;
	Mon,  2 Mar 2026 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jrBZyqtn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37422D8379;
	Mon,  2 Mar 2026 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457899; cv=none; b=uo7RJGehjOYq7naP2WAnQDFQxwH/6CSwhE1Mj0oZemsGVO3mnVtUdKAJPIHHcga9qhoyHeFQL3Nmd+no4PrYKPppB2v4ZHJfQfxoqWDBa/yX2BETClT/j2P5sQo717xt07oi7CJsgGZQR3qAwRmu3dC4NIvFF2TwmYxaTEPvUkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457899; c=relaxed/simple;
	bh=5En8gVIXTXZQtFBJA9rWagl/u71r7j6n2Lvv85d3MeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kY1U1hE1UHCEHpjg+f2XxbJgGE9TsfoBOPJ16Tu64XXFme1W2vZJp5Jhv6cuQqV74Q6FAz2BuNVNrtY3TXkvuglL4aVxxdJzc2pzByflPE+yHCjGJDq11TkYGlhS/Rw2qvnonXAdUrkT85iBpJrzQYg0YHXC41mTEIwemVZF8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jrBZyqtn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4186440E0174;
	Mon,  2 Mar 2026 13:24:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bdy1eoeFR95b; Mon,  2 Mar 2026 13:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1772457873; bh=uP9HZdxywopOaJAAlbcuaZlLimvI2OR6DFthchSQe4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrBZyqtnx+taR8mcoLNcYMBYzY1gOZtri5c7yU/yzMhGHj/aPth/9TqK1rx7F9FP2
	 sYc0cMYXxaQJypiH70yWUpUPzoGe8//2wMmlW9DpVtlYcbnKmyFXdLN/qxWKzOSu5b
	 o71/jJFmhf/ASWPZRixmuPi7+6DJf2p7j8mhBdK4FMilUEx+IwWFgtJKCcgcKm2FyI
	 tduBoYBHqt9qaUdtg1V29dksDH3W60nITepJ7ppo3vmdDwUCx/IsKoQvExNfvPoqDp
	 GGu0tyHpT0HbVdl/QgCeTL3dEqmWvULpJG9vI+kOes+f1S/ysclvR14smNaGxv4Ulp
	 UhWu903bCsY1Xr/P8jeXnf9hwLm6108wL9FIz7Y9VEXnP4rQyWyraasFC2hOLyzJnN
	 IRcdRBwaK/2eBIlu0TPRcaXg4nm/bBBTLyIIr6o9cG6kmyv727rknnu8KDHZwtKcBC
	 aGHSy6k3ayHb8Z/8OenHk/T6IjTXVVjiXyJepvpsdXIIkplie82xNNHSSbDmtRBF6F
	 BrTeGD37EcP9YyZBnnbfVCoVTpM0st1KK1QS3CBk2Qex8RiDpylF68kZ6I2AXykzEL
	 JZqVub8x+wvfTc9kFqhgOmI5XpOGfkGgwDABP1QyTVCV1VJXCF6LMlgQ8OQPeS8qar
	 n6KaSuTEwyAFRl0XTEM+g6rM=
Received: from zn.tnic (pd9530d5e.dip0.t-ipconnect.de [217.83.13.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 7AA6E40E016B;
	Mon,  2 Mar 2026 13:24:25 +0000 (UTC)
Date: Mon, 2 Mar 2026 14:24:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"shubhrajyoti.datta@gmail.com" <shubhrajyoti.datta@gmail.com>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v2] EDAC/versalnet: Refactor memory controller
 initialization and cleanup
Message-ID: <20260302132416.GAaaWPgJW6Gw-9Ndkx@fat_crate.local>
References: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>
 <20251109155844.GUaRC6NHP2x4oO2Dk0@fat_crate.local>
 <LV5PR12MB9828F14FA3E06001BB0878E78172A@LV5PR12MB9828.namprd12.prod.outlook.com>
 <20260228090950.GAaaKw3oLZpmWxoa5T@fat_crate.local>
 <LV5PR12MB9828C950356380F839ACA481817EA@LV5PR12MB9828.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <LV5PR12MB9828C950356380F839ACA481817EA@LV5PR12MB9828.namprd12.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5760-lists,linux-edac=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com,arm.com,kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	DKIM_TRACE(0.00)[alien8.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-edac];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fat_crate.local:mid]
X-Rspamd-Queue-Id: 02F9A1D9B4A
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:13:03AM +0000, Datta, Shubhrajyoti wrote:
> I have tested the patch below .

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

