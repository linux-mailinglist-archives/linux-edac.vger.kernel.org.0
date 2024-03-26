Return-Path: <linux-edac+bounces-815-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEC888CC22
	for <lists+linux-edac@lfdr.de>; Tue, 26 Mar 2024 19:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDD5325D91
	for <lists+linux-edac@lfdr.de>; Tue, 26 Mar 2024 18:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619712B169;
	Tue, 26 Mar 2024 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="E3WDpjok"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B259812AAC0
	for <linux-edac@vger.kernel.org>; Tue, 26 Mar 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478255; cv=none; b=oLBNVdriO7+P+vmhEqV/ivK9TL8aRuAZhxqYVdGONnEdjk5eU8g8LJ6UoxcJ1xE91ymNFmsa8Biq6q+YMNA4LoavK+Syy+MYUubhMJwNs2ixGdpQ66kJC32gEb8UbpQ79SHyIOsqovJFZkFVJ25nPffwjJwFafDd6jaRsLptCXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478255; c=relaxed/simple;
	bh=kaDDHC4h4SosNloXoLKzePcx7KMwmxaPXEmK5W3RAAI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R69M+sGLHSu4s3ExD3AJKS3HAAWyOCgOToWF0nFfsi8c+ZTcp8O7OQeHHPW4lJ6cIL7mXsY+25hO2k18AKlTxTskQQDsAWjwr2q/kJfvo8FqbPFRO5HPD+Vxmrmqnsmv1mjAo7V3sxP/A63uyG8VoQMEvf720CWag/bpXNU6roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=E3WDpjok; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711478251; x=1711737451;
	bh=0qErYvtF/gQBmiOgK4XRZnQpYFpD0CnkieuT9dGjYfo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=E3WDpjokKZ1zR2PysQ4p2BGMisQB77FFztI6xulxrd12DSvq1RrjtihNnIx137UAU
	 4GQXHHu3bJSXWpJyrWJ65ZQ0Zwd1DSnBBb/Q5SnYtqjHFWxR8POStpWLbKOFxGTV+d
	 2DAMcHw0PTUnKbP9LjDdK1X26Th0G5Sv05JrHQXYoZ0h1iStrgqSoilniSHitwMZmG
	 p61aVlunRfK4TrKy1A/oFy8wF/LFFe0F8Gv0HvSIx/hTc51XqRnkv4y/d/yUxpyJQN
	 44d/JvGyk4ffgW833+B6xJqiSXIaLLgeOfHQb2KDjKrj7g0UxQZVmPfjARUh2hTGgQ
	 nf5Vsn/tL/2OQ==
Date: Tue, 26 Mar 2024 18:37:25 +0000
To: Yazen Ghannam <yazen.ghannam@amd.com>, "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
From: A <akira.2020@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Message-ID: <tcsBk3Aptyd1jl1fHPAjd-OSYS1s-scsu-L24w59jkOzzblk20pNrYU5d_1j_rllZWVp5pxgzxfx4dkxT4zvnAfWw-bCIcDx0Q9TRU_Aja8=@protonmail.com>
In-Reply-To: <656a7134-4984-4577-93eb-60c0c28adf93@amd.com>
References: <20240325183755.776-1-bp@alien8.de> <eede2586-f143-4107-a065-2860ed413d0a@amd.com> <i2PhAcMufioQc2nhVgO9T23CcF8UsgJo8CWPOl_7lV3iF00GdywfpQa2Hu-yPX3bD4o5wpfUtIsRBIhFH1j3k9aNoUJfgGALNWUUjMokpFc=@protonmail.com> <656a7134-4984-4577-93eb-60c0c28adf93@amd.com>
Feedback-ID: 7267082:user:proton
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, March 26th, 2024 at 14:29, Yazen Ghannam <yazen.ghannam@amd.com=
> wrote:

>=20
>=20
> On 3/26/24 10:20, A wrote:
> [...]
>=20
> > > diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
> > > index 4749ccdeeba1..ab95831e7710 100644
> > > --- a/drivers/ras/debugfs.h
> > > +++ b/drivers/ras/debugfs.h
> > > @@ -4,6 +4,10 @@
> > >=20
> > > #include <linux/debugfs.h>
> > >=20
> > > +#if IS_ENABLED(DEBUG_FS)
> > > struct dentry *ras_get_debugfs_root(void);
> > > +#else
> > > +static inline struct dentry ras_get_debugfs_root(void) { return NULL=
; }
> > > +#endif / DEBUG_FS /
> > >=20
> > > #endif / RAS_DEBUGFS_H */
> >=20
> > this also works, just tested
> >=20
> > this time round, `make oldconfig` asks if i want to build RAS_FMPM, i b=
uilt it as module, compilation succeeds.
>=20
>=20
> Thanks for testing!
>=20
> Would you mind including your "Tested-by" tag? I can include this when I
> send a proper patch.
>=20
> Thanks,
> Yazen

sure, tested-by:  anthony s. knowles <akira.2020@protonmail.com>

kind regards,
a.s.k

