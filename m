Return-Path: <linux-edac+bounces-5738-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIy9JNVanGlHEwQAu9opvQ
	(envelope-from <linux-edac+bounces-5738-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 14:49:09 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6DD177440
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 14:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 603E4302E573
	for <lists+linux-edac@lfdr.de>; Mon, 23 Feb 2026 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9085B25333F;
	Mon, 23 Feb 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="MeR8i9+3"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CEF24886A;
	Mon, 23 Feb 2026 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854482; cv=none; b=gwvmapvBr62xKAANl10+p0+4rnLSUlXSy8/0wAqg+/A7pBXKFZS1TDkAZ7jE5bRwcCFZEseu7kE3IMoq++L+OIh3dZo/f7HTTOWZOozNO9+hqwpiA/GZSMCJmNyl5V6eo7ad0j8AXZOsQ+oT7KEmt3IuzzVt0LRwHC+uvz3Gd/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854482; c=relaxed/simple;
	bh=wWb32SCJaiesM2O/f9r1h0guJ2cAGAnOBVBZ/rXZ1ow=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=dSGeKV3unCvMu9kr/+avkBZOeMFpfJxonhhrysY6R0sSTaCek+nChdK+dIQTWwJorGx6ROo7k1Dxtx2GTKcWC/+pdH4+GOl48LSZcpIDILTDPqCOlDEYUkMtUE1il78v7UA6owqG4Y31fACN3ohZbP/HXCEx56KgSg+2xsxpWiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=MeR8i9+3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 921FD40E0163;
	Mon, 23 Feb 2026 13:47:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id skjfe4enjd0T; Mon, 23 Feb 2026 13:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1771854471; bh=7fNl+nZ3EhTUrCt5Gbf8k1K++CMfWmH8zwa07zvv3uA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=MeR8i9+3MjzYwizbW7k2MdE8d1Jcv1mpuD03BrRxiuox7PJcnpT7yAeBt4mqwr5bw
	 oaf8coh79ktdDi8x9pNNfdRDRq0+jjnj+Nnmm2MOsuiKLgvPTaOHLHKhaV4IF3hDgt
	 tuoswmEjbyS4mXB8VTCgcGTvYRrkUaM1WSOCTP9mHOMoTMGBR9p7SXF9qDpNv4a2ka
	 buQQOp2KSHt40TUtZmIcDml/0V9d9qNGtpDWgB+8dbs2jYU+MwnYzKbY5RIxf00qYO
	 RiP57bdhGOxb9u2/XaTvBkk60IYsKMVZgQb4gAk/fvXvHNM70X3xa0DOCscncP69TO
	 sch7OSOT55crwxMDJ1Hau3zZCSDlbc1HwKBn9/h9buwEZRS4I0enShTB1Bl2UnCUSb
	 P6MfoKeuekSlqjy6qgXbMT2zgneTwp0pYkgL1EmYp8utLUwfQYFKXOKtboDr1EMBFV
	 PWZhlJNnO0ccyT6YoZAGBXqAUrMBMSwRwJXj3oNmWr+iJ/zZ5mzV6SBx00hn2+V6Uo
	 S1h+LjAWBNSg/dGNVjhk/ijQhnCQJwAyX9rT2rvASBwgaN72965vtIm8SxjThH8lHO
	 7ZlQLez8IPUt+qnl69BvlHpbX6rPmQ7UW4LDo7OSPFBb4TuBmpLMMlbBTLqJD43FeN
	 agsgNeCu7I+Tz2S8Ni15QZlo=
Received: from ehlo.thunderbird.net (unknown [IPv6:2409:8a45:3d30:176e:5c88:3e64:cb48:e6dc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96B7040E02F9;
	Mon, 23 Feb 2026 13:47:45 +0000 (UTC)
Date: Mon, 23 Feb 2026 13:47:29 +0000
From: Borislav Petkov <bp@alien8.de>
To: Eric-Terminal <ericterminal@gmail.com>
CC: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yufan Chen <ericterminal@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_EDAC/versalnet=3A_Fix_resource_?=
 =?US-ASCII?Q?leaks_and_NULL_derefs_in_init=5Fversalnet=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260222103918.90670-1-ericterminal@gmail.com>
References: <FE3C5380-E82B-4EC8-B1C0-16026CEEF8A2@alien8.de> <20260222103918.90670-1-ericterminal@gmail.com>
Message-ID: <6C330635-430F-408A-8AAE-F79DA2573417@alien8.de>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5738-lists,linux-edac=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alien8.de:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-edac@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-edac];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,alien8.de:mid,alien8.de:dkim]
X-Rspamd-Queue-Id: 3C6DD177440
X-Rspamd-Action: no action

On February 22, 2026 10:39:18 AM UTC, Eric-Terminal <ericterminal@gmail=2Ec=
om> wrote:
>From: Yufan Chen <ericterminal@gmail=2Ecom>
>
>init_versalnet() has several bugs in its error handling:
>
> - kzalloc() and kmalloc() return values are used without NULL checks,
>   causing a NULL pointer dereference when allocation fails=2E
>
> - The cleanup loop uses while (i--) which skips the current failing
>   index, leaking the resources already allocated for that slot=2E
>
> - edac_mc_del_mc() is called unconditionally during unwind, even for
>   controllers that were never registered with edac_mc_add_mc()=2E
>
> - sprintf() is used instead of snprintf() on a fixed-size buffer=2E
>
>Fix by adding NULL checks for dev and name allocations, replacing
>while (i--) with for (j =3D i; j >=3D 0; j--) to include the failing
>index, tracking successful edac_mc_add_mc() calls with a bool array,
>and switching to snprintf()=2E
>
>Signed-off-by: Yufan Chen <ericterminal@gmail=2Ecom>
>---
> drivers/edac/versalnet_edac=2Ec | 29 ++++++++++++++++++++++++-----

So that particular area of stinking goo is being dealt with here:

<https://lore=2Ekernel=2Eorg/all/20251104093932=2E3838876-1-shubhrajyoti=
=2Edatta@amd=2Ecom/T/#u>

And I'd usually say you can take the current diffs, productize them and se=
nd them after testing=2E=20

However, testing is the problem here - I highly doubt you have access to t=
he hardware and Shubhrajyoti is probably one of small number of people who =
can test it=2E

Except that he's not really moving here - this particular issue has been o=
utstanding for at least three months=2E

I'll ping him when I get back from vacation to see whether there's still i=
nterest in this driver or I can remove it for lack of support=2E

Oh well=2E

--=20
Small device=2E Typos and formatting crap

