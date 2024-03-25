Return-Path: <linux-edac+bounces-797-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E850F88AC18
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 18:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A016A2E8046
	for <lists+linux-edac@lfdr.de>; Mon, 25 Mar 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6126A3DAC06;
	Mon, 25 Mar 2024 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="y4Gs7Wc+"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703228EB
	for <linux-edac@vger.kernel.org>; Mon, 25 Mar 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711385412; cv=none; b=FiDSXeLhzE9uSuFTSdXhFgT12MYOX8dL6SeJ0vagF9gT7E7qLeMcDurB/BgxvS5zjkbAUN0tRwtAP4AsrSmqn4jUMItBkGR/dTJPv7NrZ3EsabngfIIAgOoDFn9HqGMcR5k5v7zEO5eD8pA3+sEj07fjOoQvGBQKLG25jyYIGiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711385412; c=relaxed/simple;
	bh=NM2DjWasKO3U2cYlnqsBRoZqYihxwWdozHhOdR1/G/w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oj0xhwKcP5EgM/CQlARxPHMYQsYG3AJ63r0YETg3dB4HP5nNc6OypRJen7wvRvgKME642+wQT013pZoGhhqLPA8vstmlhx3d+hLRKpqmvCMWyXY//MH8NW2EBjMg+ksYimH0o9m63t3Kk3TnN0ej1RRnlYZnPdgD3u2Te4I/GEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=y4Gs7Wc+; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1711385401; x=1711644601;
	bh=NM2DjWasKO3U2cYlnqsBRoZqYihxwWdozHhOdR1/G/w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=y4Gs7Wc+pCJJvBKQVTtv+A3tgCzEqf0v1/zr1gS1oQrrXD1CmKc6awkzxxGk9r+Vw
	 g7q+08I+Fwj4CjGFpRu42349kfDZYKpsrhRgZb2ds8K3sG92Rme/ul6nVCPxR+iZba
	 l50//Q+nkDsDlgsnB5ZLYVLprGsHGZ1Ocuz61kQptvZwdMKoiFX/ubp6D4Tn44N5SQ
	 9WexVA1ploVB/8vIHkoWscaBFE0PwCV2UssmJr15vZyoeYtwzFODt+ZogxgnQnlxBt
	 m1ZziBCOEz71XO96grpA8PjtrLSfhF4xXnLU/6IjiW1ykAfK3kKRCuKgZCCwHpYdVD
	 SH7SHYx22LknA==
Date: Mon, 25 Mar 2024 16:49:54 +0000
To: Borislav Petkov <bp@alien8.de>
From: A <akira.2020@protonmail.com>
Cc: "tony.luck@intel.com" <tony.luck@intel.com>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Subject: Re: kernel 6.9-rc1 fails to compile if debugfs is disabled
Message-ID: <HCNla3hB7hRLtei6e9hDKTtNA8rpNlHjh6qeb6ysaiRniyNYBQFsbIqVPuHfIdOpkRAmL91XOFES7iumuKZcbUqZnOo59I6Sok1Irc3NcjU=@protonmail.com>
In-Reply-To: <20240325160818.GDZgGhcpLu3uks_K9z@fat_crate.local>
References: <N0Pv2Kh3nXKRyRNwwsJbgOoQ2_TE7fBqHtMUpI4-ijf4qosbq3o_HNCgL02-pr7hgQd6zLqXpJF_MmChCOrzABfX7s6D5lWI3KXk_B2iFB0=@protonmail.com> <20240325160818.GDZgGhcpLu3uks_K9z@fat_crate.local>
Feedback-ID: 7267082:user:proton
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable






On Monday, March 25th, 2024 at 16:08, Borislav Petkov <bp@alien8.de> wrote:

>=20
>=20
> On Mon, Mar 25, 2024 at 03:10:25PM +0000, A wrote:
>=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D218640
> >=20
> > kernel 6.9-rc1 fails to compile if debugfs is disabled (CONFIG_DEBUG_FS=
):
>=20
>=20
> This should fix it:
>=20
> ---
> diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
> index fc4f4bb94a4c..41697e326fa6 100644
> --- a/drivers/ras/Kconfig
> +++ b/drivers/ras/Kconfig
> @@ -37,7 +37,7 @@ source "drivers/ras/amd/atl/Kconfig"
> config RAS_FMPM
> tristate "FRU Memory Poison Manager"
> default m
> - depends on AMD_ATL && ACPI_APEI
> + depends on AMD_ATL && ACPI_APEI && DEBUG_FS
> help
> Support saving and restoring memory error information across reboot
> using ACPI ERST as persistent storage. Error information is saved with
>=20
>=20
> --
> Regards/Gruss,
> Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette

thanks, this works

kind regards,
anthony s.k.

