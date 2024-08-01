Return-Path: <linux-edac+bounces-1604-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE777944BAF
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 14:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BEBBB23AA5
	for <lists+linux-edac@lfdr.de>; Thu,  1 Aug 2024 12:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990018A6B0;
	Thu,  1 Aug 2024 12:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OsO1PX+T"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702BA158A2C;
	Thu,  1 Aug 2024 12:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722516595; cv=none; b=AXOucdzwtIn13D84c4xGmNvi480EuaYTIke3EeIcFY/0R/Nc3We4LtFP1A8MLbrkkPuqTh1OWPhWgosZs0EomgoTNd39M8ERKgBgLHB6aR2ZIA8ypOusxAqyStx5sG2C+V/9rffIfFj6j7jzhvwOwEtfjVE2LJcGigmUEUNtyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722516595; c=relaxed/simple;
	bh=RWQBIe+xnVoeZ9aYDA6LAf37L+tJ1auBW0Qc1C3LMEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG+518zn5dHHiDZMbbgUF+gaDVCmRmGb5qQBtGATUjuAOb/0aK1f7B1F7zlk4+tiJdPdLrQFdQnRIe9XBIJTxh3KXjSinOBuG+tUY+XMairkNBrWD/z8VoHhNMXuVwlfjpUBdwdIIgG85lccYI5FnRMqEiuixf9wzaQK51cU2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OsO1PX+T reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3B82E40E0263;
	Thu,  1 Aug 2024 12:49:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wbMWD6ErtCFa; Thu,  1 Aug 2024 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1722516579; bh=zBGTII34GS3yMqdHYLabA9kg+jbzaHk0f06t8Adhu7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OsO1PX+TfzuDbNZMq4D7bnm1X/fCgYM4iyvUaM6GyAMXwo2typOoZlpZZU5Q4HeLi
	 1zxBr6/xz3vffERFSxgH0DxaSK5tys5zB++aKYrqkV1j6DLl9Nr39oN1kPyMoe52CP
	 w3B3/xHAm7XG8IvdPyNVedsO7/95oRSRRzNfW+xiSQG3cfzD6A1WBSxXjELJAfdlA3
	 GkZAZJf5m3JKNW/3M8p18S10SYNhZ0mbw1RqprdAtNDQd+iubZe5PmpYTvDX93wzAc
	 KbC7qZQad/TVrXX+ivRiOJmd3Qdsu/gpMDkR8QObSowwpahmOmkiKquJcdAmPha2p3
	 sPilXm7UNOnsCXo/5WZZtBNwW/jQI8bhWITCucBZSIC3komaYeDmjNDonNvACFRkv0
	 vZ5YeNx76ChiCzMuIsg/jEm0kKtWYXeN3xuLhdR5hTwrapaFmlrznqCQdLclxS1Gh0
	 caDHv0dOzoDzRclDN+wtai+WySwEGkTdkN9NONOgVk0SAWQ7REfgvRTkVzMOwKlNgV
	 uFw5GYv0wmEQjjs9jgagaWeRJdSiBBDDTqJHbog9dLaKhA10zbPU7Cj0zKnxsU+csm
	 jWimYOWlD94pH17oKmbothkLzahpdrrksAf6gN4tSGoi2vnvbsyjn5S272NClEeDHd
	 F/3GrrKJzWO9fYlTE30CQ/Sg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20FA740E026B;
	Thu,  1 Aug 2024 12:49:32 +0000 (UTC)
Date: Thu, 1 Aug 2024 14:49:26 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, yazen.ghannam@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PRM handler direct call interface
Message-ID: <20240801124926.GBZquEVgG3y2PhefHT@fat_crate.local>
References: <20240730151731.15363-1-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730151731.15363-1-john.allen@amd.com>
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 03:17:29PM +0000, John Allen wrote:
> Platform Runtime Mechanism (PRM) introduces a means for the AML
> interpreter and OS drivers to invoke runtime handlers from platform
> firmware in order to remove the need for certain classes of SMIs.
> Further details can be seen in the PRM specification[1].
>=20
> Future AMD platforms will implement a PRM module in firmware that will
> include handlers for performing various types of address translation.
> The address translation PRM module is documented in chapter 22 of the
> publicly available "AMD Family 1Ah Models 00h=E2=80=930Fh and Models 10=
h=E2=80=931Fh
> ACPI v6.5 Porting Guide"[2].
>=20
> While the kernel currently has support for calling PRM handlers from th=
e
> AML interpreter, it does not support calling PRM handlers directly from
> OS drivers. This series implements the direct call interface and uses i=
t
> for translating normalized addresses to system physical addresses.
>=20
> Thanks,
> John
>=20
> [1]:
> https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mec=
hanism%20-%20with%20legal%20notice.pdf
> [2]:
> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/pr=
ogrammer-references/58088-0.75-pub.pdf
>=20
> Tree: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> Base commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
>=20
> John Allen (2):
>   ACPI: PRM: Add PRM handler direct call support
>   RAS/AMD/ATL: Translate normalized to system physical addresses using
>     PRM
>=20
>  drivers/acpi/prmt.c            | 24 ++++++++++++++
>  drivers/ras/amd/atl/Kconfig    |  4 +++
>  drivers/ras/amd/atl/Makefile   |  2 ++
>  drivers/ras/amd/atl/internal.h | 10 ++++++
>  drivers/ras/amd/atl/prm.c      | 57 ++++++++++++++++++++++++++++++++++
>  drivers/ras/amd/atl/umc.c      |  5 +++
>  include/linux/prmt.h           |  5 +++
>  7 files changed, 107 insertions(+)
>  create mode 100644 drivers/ras/amd/atl/prm.c
>=20
> --=20

Applied, thanks.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

