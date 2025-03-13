Return-Path: <linux-edac+bounces-3359-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B1A5FDCD
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 18:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31CF422311
	for <lists+linux-edac@lfdr.de>; Thu, 13 Mar 2025 17:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093414A605;
	Thu, 13 Mar 2025 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FlmKRVHz"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A614386D
	for <linux-edac@vger.kernel.org>; Thu, 13 Mar 2025 17:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887094; cv=none; b=nCXdxFZM3GHDMKH3Xe2EsL5R4PF6IsXt0HZkQMOjYB2QpeeJymFBznE+3Nkdkj/8S8GDDnwgUIbP5KdUq+Fa35InXUDf52DQuiYo30Lr0YHlM9a4pDUwWaShrn/RmBgyVegkjm/Pj621IXspkix1AISG1p0G2C8LRd+ndS75mxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887094; c=relaxed/simple;
	bh=uC5UhA3EhjyebTWg+xMERUpw6vyQlg1cuh88vK8/GQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7gW00LfyZFpJ14J4/+CqasnsS52u7MUtymHC056aAZ7uB69R+RUwAA0mIiPDiBCeq1FbFxOonx0VM5/21hZZKiJB1qkNiAPz+9jxKDSUY1GfwE1VrrdwqJVkLv7ftWgqC1qAB8Ve0vXKhl+WJu454aCVCFbQrNpR6c37kQJlbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FlmKRVHz reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8326940E022E;
	Thu, 13 Mar 2025 17:31:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qtVe_wXk3w3c; Thu, 13 Mar 2025 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741887079; bh=tE0XRucOGqhgfCvtXcGBqZ1BBguT0dFtVWd2HgKZ3M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FlmKRVHzBfrN5Y2UHF7QinNcUpHafZ3CNv9UAoPsUKiBMrKswyYtPi7/qk17GJJ6s
	 TJDQ39prjoPaBFs2GdEoUXbEHzr9HmN5+lfWmUp+bQvCC90IAnTrKum7s722E7cnln
	 ZLWKKCMdZlRmO4OrrGI6jFZkw8BrIwLrWpDPCDyf2g3ce6Hzqc8shKUFRhe8zadk5e
	 C2Dewp0/qOv5vLiSNzYF9OSjYAgq6F6eT6R7lRcQemiXqgbUqM0WkQ8p/dTKfkjFmd
	 xcIlmlWqJgBoykYRjAEobzT9N0bSXVzWkrSx2NLW8Rq8yglxA/hhAjrNstLs8ZQIKs
	 CB4+9wty/VdkZ3jT1k04pYyC2PP6BjLcMiIyLQd058wCzBX8xLnjmq/eLey6f7drQ3
	 t8+TpnC2zKxJWqk7dNteBycoiGIrRMiQFzOAgoBk2A0fE4KIzG5AlIVe9X/ER2syNe
	 CWkVfrzinEsvsfDRbaVv7hUYuFhLdKadYliBwewIW6NKfbKSLBxqFmg/Nj7sOlxAA3
	 GxLVO/JRGW4hOkptz2fI64rFlD/aJWK76fht30lbPvHJRWGHKbJRmNnYaCCiTfGvT4
	 sm6Q8+YV9iYpAcWIg1z1xa2LvXesILEMK0d7hrQstRZQv2rH13lYIF75JwbcjzaxeT
	 Hj6yJuJq3hwpWmsKPmNyiZP8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 18A9440E0219;
	Thu, 13 Mar 2025 17:31:16 +0000 (UTC)
Date: Thu, 13 Mar 2025 18:31:09 +0100
From: Borislav Petkov <bp@alien8.de>
To: reox <mailinglist@reox.at>
Cc: linux-edac@vger.kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: Memory controller not showing half of the memory?
Message-ID: <20250313173109.GDZ9MWXTRUHbFh4UJ3@fat_crate.local>
References: <27dc093f-ce27-4c71-9e81-786150a040b6@reox.at>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <27dc093f-ce27-4c71-9e81-786150a040b6@reox.at>
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 06:21:28PM +0100, reox wrote:
> Hello,
>=20
> I hope it is okay to ask such a question on this mailinglist, however t=
here
> is surprisingly little information on this topic (or I'm not deep enoug=
h in
> the matter to understand everything correctly...).
>=20
> I have a server with a ASRockRack B665D4U-1L board. I'm running Debian =
with
> bookworm-backports kernel 6.12.9-1~bpo12+1.
> In the syslog I see the following output of EDAC:
> # dmesg | grep -i EDAC
> [    1.340448] EDAC MC: Ver: 3.0.0
> [    4.705255] EDAC MC0: Giving out device to module amd64_edac control=
ler
> F19h_M70h: DEV 0000:00:18.3 (INTERRUPT)
> [    4.705262] EDAC amd64: F19h_M70h detected (node 0).
> [    4.705266] EDAC MC: UMC0 chip selects:
> [    4.705267] EDAC amd64: MC: 0:     0MB 1:     0MB
> [    4.705270] EDAC amd64: MC: 2:  8192MB 3:  8192MB
> [    4.705273] EDAC MC: UMC1 chip selects:
> [    4.705274] EDAC amd64: MC: 0:     0MB 1:     0MB
> [    4.705277] EDAC amd64: MC: 2:  8192MB 3:  8192MB
>=20
> However, compare this to the real amount of memory (2=C3=9732GB):
> # lshw -c memory  # shorted
>   *-memory
>        size: 64GiB
>        capabilities: ecc
>        configuration: errordetection=3Dmulti-bit-ecc
>      *-bank:0
>           description: [empty]
>      *-bank:1
>           description: DIMM Synchronous Unbuffered (Unregistered) 4800 =
MHz
> (0.2 ns)
>           product: HMCG88MEBEA081N
>           vendor: SK Hynix
>           size: 32GiB
>      *-bank:2
>           description: [empty]
>      *-bank:3
>           description: DIMM Synchronous Unbuffered (Unregistered) 4800 =
MHz
> (0.2 ns)
>           product: HMCG88MEBEA081N
>           vendor: SK Hynix
>           size: 32GiB
>=20
> I'm a bit confused here... Does EDAC simply miss half of the memory? Is=
 this
> output correct? Or the memory controller not fully implemented / bugged=
 in
> that kernel version (with the bookworm kernel it does not load EDAC at =
all)?
						^^^^^^^^^^^^^^^^^^^^^^^^^^^^

What does that mean, exactly?

Are you force-loading the module?

You could send a full dmesg...

> Unfortunately I cannot easily run a dev version of the kernel on that
> machine - otherwise I would have probably already done that.
>=20
> Thanks in advance!
> Best,
> Sebastian
>=20

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

